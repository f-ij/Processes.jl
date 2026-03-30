const start_finished = Ref(false)

@inline function before_while(p::P) where P <: AbstractProcess
    start_finished[] = true
    p.threadid = Threads.threadid()
    set_starttime!(p)
end

@inline function before_while(ip::IP) where IP <: InlineProcess
    @inline set_starttime!(ip)
end

@inline function after_while(p::AbstractProcess, func::F, context::C) where {F, C}
    @inline set_endtime!(p)
    if !shouldrun(p) || lifetime(p) isa Indefinite # If user interrupted, or lifetime is indefinite
        Processes.context(p, context)
        return context
    else
        Processes.context(p, @inline cleanup(func, context))
        return context
    end
end

@inline function after_while(ip::InlineProcess, func::F, context::C) where {F, C}
    @inline set_endtime!(ip)
    @inline cleanup(func, context)
end


@inline loop(p::P, f::F, c::C, lt::LT) where {P, F, C, LT} = loop(p, f, c, lt, sys_looptype)
"""
Run a single function in a loop indefinitely
"""
@inline function loop(process::AbstractProcess, func::F, context::C, lt::LT, ::NonGenerated) where {F, C, LT <: IndefiniteLifetime}
    @inline before_while(process)

    context = @inline step!(func, context, Unstable())
    @inline tick!(process)
    @inline inc!(process)

    while true
        context = @inline step!(func, context, Stable())
        @inline tick!(process)
        @inline inc!(process) 
        if @inline breakcondition(lt, process, context)
            break
        end
    end

    if @inline shouldrun(process)
        return context
    else
        return @inline after_while(process, func, context)
    end
end

"""
Run a single function in a loop for a given number of times
"""
Base.@constprop :aggressive function loop(process::AbstractProcess, algo::F, context::C, r::R, ::NonGenerated) where {F, C, R <: RepeatLifetime}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @inline before_while(process)
    
    context = @inline step!(algo, context, Unstable())
    @inline tick!(process)
    @inline inc!(process)
    
    start_idx = @inline loopidx(process)
    end_idx = @inline repeats(r)
    
    for _ in start_idx:end_idx
    
        context = @inline step!(algo, context, Stable())
        @inline tick!(process)
        @inline inc!(process)
        if @inline breakcondition(r, process, context)
            break
        end

    end
    if @inline shouldrun(process)
        return context
    else
        return @inline after_while(process, algo, context)
    end
end

