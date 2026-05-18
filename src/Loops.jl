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
    if p isa Process && ispaused(p)
        _store_runtime_context!(p, context)
        return context
    else
        cleaned_context = @inline _loop_cleanup_context(func, context)
        Processes.context(p, cleaned_context)
        return @inline _loop_final_result(func, cleaned_context)
    end
end

@inline function after_while(ip::InlineProcess, func::F, context::C) where {F, C}
    @inline set_endtime!(ip)
    cleaned_context = @inline _loop_cleanup_context(func, context)
    stored_context = _strip_runtime_inputs(cleaned_context)
    Processes.context(ip, stored_context)
    return @inline _loop_final_result(func, cleaned_context)
end

"""
Run a single function in a loop indefinitely
"""
@inline loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, LT} =
    loop(process, func, context, lt, inputs, resume, sys_looptype)

@inline _loop_step_algo(algo) = algo
@inline _loop_step_algo(algo::LoopAlgorithm) = getplan(algo)
@inline _loop_step_algo(algo::FinalizedAlgorithm) = _loop_step_algo(inneralgorithm(algo))
@inline _loop_step_wiring(algo) = ()
@inline _loop_step_wiring(algo::LoopAlgorithm) = _plan_step_wiring(getplan(algo))
@inline _loop_step_wiring(algo::FinalizedAlgorithm) = _loop_step_wiring(inneralgorithm(algo))
@inline _loop_step!(algo, context, stability, ::Tuple{}) = @inline step!(algo, context, stability)
@inline _loop_step!(algo, context, stability, step_wiring::Tuple) = @inline step!(algo, context, stability, step_wiring)

@inline function loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F, C, LT <: IndefiniteLifetime, isresuming}
    @inline before_while(process)

    step_func = @inline _loop_step_algo(func)
    step_wiring = @inline _loop_step_wiring(func)
    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    if isresuming
        @atomic process.paused = false
    else
        runtime_context = @inline _loop_step!(step_func, runtime_context, Unstable(), step_wiring)
        @inline tick!(process)
        @inline inc!(process)
    end

    while true
        nextcontext = @inline _loop_step!(step_func, runtime_context, Stable(), step_wiring)
        typeof(nextcontext) === typeof(runtime_context) || error("Steady-state loop steps must preserve context type. Got $(typeof(nextcontext)), expected $(typeof(runtime_context)).")
        runtime_context = nextcontext
        @inline tick!(process)
        @inline inc!(process) 
        if @inline breakcondition(lt, process, runtime_context)
            break
        end
    end

    return @inline after_while(process, func, runtime_context)
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
    
    step_algo = @inline _loop_step_algo(algo)
    step_wiring = @inline _loop_step_wiring(algo)
    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    stablecontext = if isresuming
        @atomic process.paused = false
        runtime_context
    else
        context = @inline _loop_step!(step_algo, runtime_context, Unstable(), step_wiring)
        @inline tick!(process)
        @inline inc!(process)
        context
    end
    
    start_idx = @inline loopidx(process)
    end_idx = @inline repeats(r)
    
    for _ in start_idx:end_idx
    
        nextcontext = @inline _loop_step!(step_algo, stablecontext, Stable(), step_wiring)
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
