const start_finished = Ref(false)

@inline function before_while(p::AbstractProcess)
    start_finished[] = true
    p.threadid = Threads.threadid()
    @atomic p.paused = false
    _runtimelisteners = runtimelisteners(p)
    start(_runtimelisteners)
    start.(get_linked_processes(p)) # TODO OBSOLETE?
    set_starttime!(p)
end

@inline function before_while(ip::InlineProcess)
    @inline set_starttime!(ip)
end

@inline function after_while(p::AbstractProcess, func::F, context) where {F}
    @inline set_endtime!(p)
    _runtimelisteners = runtimelisteners(p)
    close(_runtimelisteners)
    close.(get_linked_processes(p)) # TODO OBSOLETE?
    if !run(p) || lifetime(p) isa Indefinite # If user interrupted, or lifetime is indefinite
        return context
    else
        # return cleanup(getalgo(p), context)
        return @inline cleanup(func, context)
    end
end

@inline function after_while(ip::InlineProcess, func::F, context) where {F}
    @inline set_endtime!(ip)
    return @inline cleanup(func, context)
end

cleanup(::Any, context) = (;)

resuming(::Any) = false


"""
Run a single function in a loop indefinitely
"""
@inline function processloop(process::AbstractProcess, func::F, context::C, ::Indefinite) where {F, C}
    # @static if DEBUG_MODE
        println("Running process loop indefinitely from thread $(Threads.threadid())")
    # end

    @inline before_while(process)
    if resuming(process)
        context = @inline resume_step!(func, context)
    end

    while run(process)
        context = @inline step!(func, context)
        @inline inc!(process) 
        # if isthreaded(p) || isasync(p)
        #     GC.safepoint()
        # end
    end
    return @inline after_while(process, func, context)
end

"""
Run a single function in a loop for a given number of times
"""
Base.@constprop :aggressive function processloop(process::AbstractProcess, func::F, context::C, r::Repeat) where {F, C}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @inline before_while(process)
    start_idx = loopidx(process)
    
    if resuming(process)
        context = @inline resume_step!(func, context)
        start_idx += 1
    end

    for _ in start_idx:repeats(r)
        if !run(process)
            break
        end
        context = @inline step!(func, context)
        @inline inc!(process)

        # if isthreaded(p) || isasync(p)
        #     GC.safepoint()
        # end
    end
    return @inline after_while(process, func, context)
end

"""
Generated process loop that inlines the step! expression when available.
"""
@inline @generated function generated_processloop(process::AbstractProcess, func::F, context::C, r::Repeat) where {F, C}
    # step_expr = try
    #     step!_expr(F, C)
    # catch
    #     :(context = @inline step!(func, context); context)
    # end
    # step_expr = step!_expr(F, C, :func)
    algo_name = gensym(:algo)
    step_expr = step!_expr(F, C, algo_name)

    return quote
        # println("Running generated process loop for $repeats times from thread $(Threads.threadid())")
        @inline before_while(process)
        start_idx = loopidx(process)
        
        if @inline resuming(process)
            context = @inline resume_step!(func, context)
            start_idx += 1
        end

        for _ in start_idx:repeats(r)
            if !run(process)
                break
            end
            $(algo_name) = func
            $(step_expr)
            @inline inc!(process)
        end
        return @inline after_while(process, func, context)
    end
end



"""
Generated process loop that inlines the step! expression when available.
"""
@generated function generated_processloop(process::AbstractProcess, func::F, context::C, ::Indefinite) where {F, C}
    step_expr = step!_expr(F, C, :func)
    return quote
        println("Running generated process loop indefinitely from thread $(Threads.threadid())")
        @inline before_while(process)
        if resuming(process)
            context = @inline resume_step!(func, context)
        end

        while run(process)
            $(step_expr)
            @inline inc!(process)
        end
        return @inline after_while(process, func, context)
    end
end
