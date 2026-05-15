const start_finished = Ref(false)

@inline _stored_loop_context(context) = context

function _stored_loop_context(context::ProcessContext)
    context = _strip_runtime_inputs(context)
    globals = getglobals(context)
    haskey(globals, :process) || return context

    globals = deletekeys(globals, :process)
    subcontexts = (; get_subcontexts(context)..., globals)
    return ProcessContext(subcontexts, getregistry(context))
end

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
        cleaned_context = @inline _loop_cleanup_context(func, context)
        Processes.context(p, cleaned_context)
        return @inline _loop_final_result(func, cleaned_context)
    end
end

@inline function after_while(ip::InlineProcess, func::F, context::C) where {F, C}
    @inline set_endtime!(ip)
    if lifetime(ip) isa Indefinite
        Processes.context(ip, _stored_loop_context(context))
        return context
    else
        cleaned_context = @inline _loop_cleanup_context(func, context)
        Processes.context(ip, _stored_loop_context(cleaned_context))
        return @inline _loop_final_result(func, cleaned_context)
    end
end


@inline loop(p::P, f::F, c::C, lt::LT) where {P, F, C, LT} = loop(p, f, c, lt, (;), sys_looptype)
@inline loop(p::P, f::F, c::C, lt::LT, inputs::NamedTuple) where {P, F, C, LT} =
    loop(p, f, _merge_runtime_inputs(c, inputs), lt, sys_looptype)
@inline loop(p::P, f::F, c::C, lt::LT, inputs::NamedTuple, looptype) where {P, F, C, LT} =
    loop(p, f, _merge_runtime_inputs(c, inputs), lt, looptype)
"""
Run a single function in a loop indefinitely
"""
@inline function loop(process::AbstractProcess, func::F, context::C, lt::LT, ::NonGenerated) where {F, C, LT <: IndefiniteLifetime}
    @inline before_while(process)

    context = @inline step!(func, context, Unstable())
    @inline tick!(process)
    @inline inc!(process)

    while true
        nextcontext = @inline step!(func, context, Stable())
        typeof(nextcontext) === typeof(context) || error("Steady-state loop steps must preserve context type. Got $(typeof(nextcontext)), expected $(typeof(context)).")
        context = nextcontext
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
Base.@constprop :aggressive function loop(process::AbstractProcess, algo::F, unstablecontext::C, r::R, ::NonGenerated) where {F, C, R <: RepeatLifetime}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
    @inline before_while(process)
    
    stablecontext = @inline step!(algo, unstablecontext, Unstable())
    @inline tick!(process)
    @inline inc!(process)
    
    start_idx = @inline loopidx(process)
    end_idx = @inline repeats(r)
    
    for _ in start_idx:end_idx
    
        nextcontext = @inline step!(algo, stablecontext, Stable())
        typeof(nextcontext) === typeof(stablecontext) || error("Steady-state loop steps must preserve context type. Got $(typeof(nextcontext)), expected $(typeof(stablecontext)).")
        stablecontext = nextcontext
        @inline tick!(process)
        @inline inc!(process)
        if @inline breakcondition(r, process, stablecontext)
            break
        end

    end
    return @inline after_while(process, algo, stablecontext)
end
