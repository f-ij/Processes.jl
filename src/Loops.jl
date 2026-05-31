const start_finished = Ref(false)

@inline function before_while(p::P) where P <: AbstractProcess
    start_finished[] = true
    p.threadid = Threads.threadid()
    set_starttime!(p)
end

@inline function before_while(ip::IP) where IP <: InlineProcess
    @inline set_starttime!(ip)
end

"""
Finalize one threaded/dynamic `Process` loop execution.

Paused runs keep their live context in the dynamic runtime slot. Finished runs
clean up runtime-only values and commit the persistent context back into the
typed lifecycle when the concrete shape still matches.
"""
@inline function after_while(p::P, func::F, context::C, stored_context::SC = context) where {P<:Process, F, C, SC}
    @inline set_endtime!(p)
    if ispaused(p)
        # Pause is not finalization. Store the live context before cleanup,
        # because type-preserving context merges may mutate it in place.
        _store_runtime_context!(p, context)
        persistent_context = _strip_runtime_inputs(context, stored_context)
        return persistent_context
    else
        cleaned_context = @inline cleanup(func, context)
        visible_context = materialize_widened_context(cleaned_context)
        persistent_context = _strip_runtime_inputs(visible_context, stored_context)
        commit_context!(p, persistent_context)
        return @inline _loop_final_result(func, visible_context)
    end
end

"""
Finalize one `InlineProcess` loop execution.

Inline processes always write their persistent context directly back into the
concrete inline context field.
"""
@inline function after_while(ip::IP, func::F, context::C, stored_context::SC = context) where {IP<:InlineProcess, F, C, SC}
    @inline set_endtime!(ip)
    cleaned_context = @inline cleanup(func, context)
    visible_context = materialize_widened_context(cleaned_context)
    persistent_context = _strip_runtime_inputs(cleaned_context, stored_context)
    Processes.context(ip, persistent_context)
    return @inline _loop_final_result(func, visible_context)
end

"""
Finalize one direct `run(::LoopAlgorithm; ...)` execution.

`LoopRunProcess` is only a transient loop driver, so it returns the visible
result without storing a persistent context on itself.
"""
@inline function after_while(p::P, func::F, context::C, stored_context::SC = context) where {P<:LoopRunProcess, F, C, SC}
    @inline set_endtime!(p)
    cleaned_context = @inline cleanup(func, context)
    visible_context = materialize_widened_context(cleaned_context)
    return @inline _loop_final_result(func, visible_context)
end

"""
Run a single function in a loop indefinitely
"""
@inline loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, LT} =
    loop(process, func, context, lt, inputs, resume, sys_looptype)

@inline function loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, LT<:IndefiniteLifetime, isresuming}
    @inline before_while(process)

    step_plan = @inline getplan(func)
    step_wiring = @inline getwiring(step_plan)
    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    if isresuming
        @atomic process.paused = false
    else
        runtime_context = @inline _step!(step_plan, runtime_context, step_wiring, Namespace{nothing}(), process, lt, Stable())
        @inline tick!(process)
        @inline inc!(process)
    end

    while true
        nextcontext = @inline _step!(step_plan, runtime_context, step_wiring, Namespace{nothing}(), process, lt, Stable())
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
Reject unsupported generated-loop schedules instead of crossing into another
loop backend.

`Generated()` is intentionally separate from `RuntimeGenerated()`: the generated
backend expands the plan into the top-level loop body, while the runtime
generated backend calls resolve-time step functions.
"""
@inline function loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple, resume::Resuming, ::Generated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, LT<:Lifetime}
    error("Generated() only supports Repeat and Indefinite lifetimes for now. Got $(typeof(lt)). Use RuntimeGenerated() explicitly for this schedule.")
end

Base.@constprop :aggressive function loop(process::P, algo::F, context::C, lt::LT, inputs::NamedTuple, ::Resuming{isresuming}, ::RuntimeGenerated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, LT <: IndefiniteLifetime, isresuming}
    @inline before_while(process)

    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    if isresuming
        @atomic process.paused = false
    end

    generated_context_step = @inline get_step(algo)
    while true
        runtime_context = @inline generated_context_step(algo, runtime_context, process, lt)
        @inline tick!(process)
        @inline inc!(process)
        if @inline breakcondition(lt, process, runtime_context)
            break
        end
    end

    return @inline after_while(process, algo, runtime_context, context)
end

"""
Run a single function in a loop for a given number of times
"""
@inline loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, R <: RepeatLifetime} =
    loop(process, algo, context, r, inputs, resume, sys_looptype)

Base.@constprop :aggressive function loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, R<:RepeatLifetime, isresuming}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
    @inline before_while(process)

    step_plan = @inline getplan(algo)
    step_wiring = @inline getwiring(step_plan)

    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    stablecontext = if isresuming
        @atomic process.paused = false
        runtime_context
    else
        stepped_context = @inline _step!(step_plan, runtime_context, step_wiring, Namespace{nothing}(), process, r, Stable())
        @inline tick!(process)
        @inline inc!(process)
        stepped_context
    end

    start_idx = @inline loopidx(process)
    end_idx = @inline repeats(r)

    for _ in start_idx:end_idx
        nextcontext = @inline _step!(step_plan, stablecontext, step_wiring, Namespace{nothing}(), process, r, Stable())
        stablecontext = nextcontext
        @inline tick!(process)
        @inline inc!(process)
        if @inline breakcondition(r, process, stablecontext)
            break
        end
    end

    return @inline after_while(process, algo, stablecontext, context)
end

Base.@constprop :aggressive function loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple, ::Resuming{isresuming}, ::RuntimeGenerated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, R <: RepeatLifetime, isresuming}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
    @inline before_while(process)
    
    runtime_context = @inline _merge_runtime_inputs(context, inputs)
    if isresuming
        @atomic process.paused = false
    end
    
    generated_context_step = @inline get_step(algo)
    start_idx = @inline loopidx(process)
    end_idx = @inline repeats(r)

    for _ in start_idx:end_idx
        runtime_context = @inline generated_context_step(algo, runtime_context, process, r)
        @inline tick!(process)
        @inline inc!(process)
        if @inline breakcondition(r, process, runtime_context)
            break
        end

    end

    return @inline after_while(process, algo, runtime_context, context)
end
