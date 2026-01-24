const start_finished = Ref(false)

function before_while(p::AbstractProcess)
    start_finished[] = true
    p.threadid = Threads.threadid()
    @atomic p.paused = false
    _runtimelisteners = runtimelisteners(p)
    start(_runtimelisteners)
    start.(get_linked_processes(p)) # TODO OBSOLETE?
    set_starttime!(p)
end

function before_while(ip::InlineProcess)
    set_starttime!(ip)
end

function after_while(p::AbstractProcess, func::F, context) where {F}
    set_endtime!(p)
    _runtimelisteners = runtimelisteners(p)
    close(_runtimelisteners)
    close.(get_linked_processes(p)) # TODO OBSOLETE?
    if !run(p) || lifetime(p) isa Indefinite # If user interrupted, or lifetime is indefinite
        return context
    else
        # return cleanup(getfunc(p), context)
        return cleanup(func, context)
    end
end

function after_while(ip::InlineProcess, func::F, context) where {F}
    set_endtime!(ip)
    return cleanup(func, context)
end

cleanup(::Any, context) = (;)


"""
Run a single function in a loop indefinitely
"""
function processloop(p::AbstractProcess, func::F, context::C, ::Indefinite) where {F, C}
    @static if DEBUG_MODE
        println("Running process loop indefinitely from thread $(Threads.threadid())")
    end

    @inline before_while(p)
    if resuming(p)
        context = resume_step!(func, context)::C
    end

    while run(p)
        context = (@inline step!(func, context))::C
        # @inline step!(func, context)::C

        @inline inc!(p) 
        if isthreaded(p) || isasync(p)
            GC.safepoint()
        end
    end
    return @inline after_while(p, func, context)
end

resuming(::Any) = false

"""
Run a single function in a loop for a given number of times
"""
function processloop(p::AbstractProcess, func::F, context::C, r::Repeat) where {F, C}
    @static if DEBUG_MODE
        println("Running process loop for $repeats times from thread $(Threads.threadid())")
    end
    @inline before_while(p)
    start_idx = loopidx(p)
    
    if resuming(p)
        context = resume_step!(func, context)
        start_idx += 1
    end

    for _ in start_idx:repeats(r)
        if !run(p)
            break
        end
        context = @inline step!(func, context)::C
        @inline inc!(p)

        if isthreaded(p) || isasync(p)
            GC.safepoint()
        end
    end
    return @inline after_while(p, func, context)
end

