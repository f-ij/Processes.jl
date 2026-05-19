const start_finished = Ref(false)

@inline function before_while(p::P) where P <: AbstractProcess
    start_finished[] = true
    p.threadid = Threads.threadid()
    set_starttime!(p)
end

@inline function before_while(ip::IP) where IP <: InlineProcess
    @inline set_starttime!(ip)
end

@inline function after_while(p::AbstractProcess, func::F, context::C, stored_context::SC = context) where {F, C, SC}
    @inline set_endtime!(p)
    cleaned_context = @inline _loop_cleanup_context(func, context)
    persistent_context = _strip_runtime_inputs(cleaned_context, stored_context)
    if p isa Process && ispaused(p)
        # Paused processes keep the live runtime context for resume, but the
        # task result remains the persistent context shape.
        _store_runtime_context!(p, context)
    else
        Processes.context(p, persistent_context)
    end
    return @inline _loop_final_result(func, persistent_context)
end

@inline function after_while(ip::InlineProcess, func::F, context::C, stored_context::SC = context) where {F, C, SC}
    @inline set_endtime!(ip)
    cleaned_context = @inline _loop_cleanup_context(func, context)
    persistent_context = _strip_runtime_inputs(cleaned_context, stored_context)
    Processes.context(ip, persistent_context)
    return @inline _loop_final_result(func, persistent_context)
end

"""
Run a single function in a loop indefinitely
"""
@inline loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, LT} =
    loop(process, func, context, lt, inputs, resume, sys_looptype)

@inline function loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F, C, LT <: IndefiniteLifetime, isresuming}
    @inline before_while(process)

    step_wiring = @inline _plan_step_wiring(func)
    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    if isresuming
        @atomic process.paused = false
    else
        runtime_context = @inline step!(func, runtime_context, step_wiring, process, lt, Unstable())
        @inline tick!(process)
        @inline inc!(process)
    end

    while true
        nextcontext = @inline step!(func, runtime_context, step_wiring, process, lt, Stable())
        # typeof(nextcontext) === typeof(runtime_context) || error("Steady-state loop steps must preserve context type. Got $(typeof(nextcontext)), expected $(typeof(runtime_context)).")
        runtime_context = nextcontext
        @inline tick!(process)
        @inline inc!(process) 
        if @inline breakcondition(lt, process, runtime_context)
            break
        end
    end

    return @inline after_while(process, func, runtime_context, context)
end

"""
Run a single function in a loop for a given number of times
"""
@inline loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, R <: RepeatLifetime} =
    loop(process, algo, context, r, inputs, resume, sys_looptype)

Base.@constprop :aggressive function loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F, C, R <: RepeatLifetime, isresuming}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
    @inline before_while(process)
    
    step_wiring = @inline _plan_step_wiring(algo)

    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    stablecontext = if isresuming
        @atomic process.paused = false
        runtime_context
    else
        stepped_context = @inline step!(algo, runtime_context, step_wiring, process, r, Unstable())
        @inline tick!(process)
        @inline inc!(process)
        stepped_context
    end
    
    start_idx = @inline loopidx(process)
    end_idx = @inline repeats(r)
    
    for _ in start_idx:end_idx
    
        nextcontext = @inline step!(algo, stablecontext, step_wiring, process, r, Stable())
        # typeof(nextcontext) === typeof(stablecontext) || error("Steady-state loop steps must preserve context type. Got $(typeof(nextcontext)), expected $(typeof(stablecontext)).")
        stablecontext = nextcontext
        @inline tick!(process)
        @inline inc!(process)
        if @inline breakcondition(r, process, stablecontext)
            break
        end

    end
    return @inline after_while(process, algo, stablecontext, context)
end
