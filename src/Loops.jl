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
    finalizer!(func, context, runtimecontext, process, lifetime)

Run cleanup and the final result projection inside the loop-owned runtime
boundary. The runtime context is intentionally not returned.
"""
@noinline function finalizer!(func::F, context::C, runtimecontext::RC, process::P, lifetime::LT) where {F,C<:ProcessContext,RC<:ProcessContext,P<:AbstractProcess,LT<:Lifetime}
    runtimecontext = @inline _merge_into_globals(runtimecontext, (; process, lifetime))
    state_context = withregistry(context, getregistry(func))
    visible_context = ExecutionContext(state_context, runtimecontext)
    cleanup_result = @inline cleanup(func, visible_context)
    cleaned_context = cleanup_result isa NamedTuple ? (@inline merge(visible_context, cleanup_result)) : cleanup_result
    cleaned_state = cleaned_context isa ExecutionContext ? getfield(cleaned_context, :context) : cleaned_context
    return (@inline hot_context(cleaned_state)), (@inline _loop_final_result(func, cleaned_context))
end

"""Build the loop-local runtime context for one execution."""
@inline function _initial_runtime_context(inputs::NamedTuple, process::P, lifetime::LT) where {P<:AbstractProcess,LT<:Lifetime}
    runtime = _empty_context()
    runtime = @inline _merge_into_globals(runtime, (; process, lifetime))
    return isempty(inputs) ? runtime : @inline with_subcontext(runtime, Val(:_input), SubContext(:_input, inputs))
end

"""Finish a loop result by reattaching the stored registry to hot state."""
@inline function _reattach_persistent_registry(hot_state::C, stored_context::SC) where {C<:ProcessContext,SC<:ProcessContext}
    return withregistry(hot_state, getregistry(stored_context))
end

"""Commit or return the state-only context produced by the noinline kernel."""
@inline function after_while(p::P, func::F, hot_state::C, returnvalue, stored_context::SC = hot_state) where {P<:Process,F,C<:ProcessContext,SC<:ProcessContext}
    @inline set_endtime!(p)
    persistent_context = @inline _reattach_persistent_registry(hot_state, stored_context)
    if ispaused(p)
        _store_runtime_context!(p, persistent_context)
        return persistent_context
    end
    commit_context!(p, persistent_context)
    return returnvalue
end

@inline function after_while(ip::IP, func::F, hot_state::C, returnvalue, stored_context::SC = hot_state) where {IP<:InlineProcess,F,C<:ProcessContext,SC<:ProcessContext}
    @inline set_endtime!(ip)
    persistent_context = @inline _reattach_persistent_registry(hot_state, stored_context)
    Processes.context(ip, persistent_context)
    return returnvalue
end

@inline function after_while(p::P, func::F, hot_state::C, returnvalue, stored_context::SC = hot_state) where {P<:LoopRunProcess,F,C<:ProcessContext,SC<:ProcessContext}
    @inline set_endtime!(p)
    return returnvalue
end

"""
Run a single function in a loop indefinitely
"""
@inline loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, LT} =
    loop(process, func, context, lt, inputs, resume, sys_looptype)

@inline function loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, LT <: IndefiniteLifetime, isresuming}
    @inline before_while(process)

    step_plan = @inline getplan(func)
    step_wiring = @inline getwiring(step_plan)
    hot_state, returnvalue = @noinline _indefinite_loop_kernel!(process, func, step_plan, step_wiring, context, lt, inputs, Val(isresuming))
    return @inline after_while(process, func, hot_state, returnvalue, context)
end

"""
Run a single function in a loop for a given number of times
"""
@inline loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, R <: RepeatLifetime} =
    loop(process, algo, context, r, inputs, resume, sys_looptype)

Base.@constprop :aggressive function loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C, R <: RepeatLifetime, isresuming}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
    @inline before_while(process)
    
    step_plan = @inline getplan(algo)
    step_wiring = @inline getwiring(step_plan)

    hot_state, returnvalue = @noinline _repeat_loop_kernel!(process, algo, step_plan, step_wiring, context, r, inputs, Val(isresuming))
    return @inline after_while(process, algo, hot_state, returnvalue, context)
end

"""
Run an indefinite loop with runtime state scoped inside this function.
"""
@noinline function _indefinite_loop_kernel!(
    process::P,
    func::F,
    step_plan::SP,
    step_wiring::W,
    stored_context::C,
    lifetime::LT,
    inputs::I,
    ::Val{isresuming},
) where {P<:AbstractProcess,F<:AbstractLoopAlgorithm,SP,W,C<:ProcessContext,LT<:IndefiniteLifetime,I<:NamedTuple,isresuming}
    context = @inline hot_context(stored_context)
    runtimecontext = @inline _initial_runtime_context(inputs, process, lifetime)
    if isresuming
        @atomic process.paused = false
    else
        context, runtimecontext = @inline _step!(step_plan, context, runtimecontext, step_wiring, Namespace{nothing}(), process, lifetime, Stable())
        @inline tick!(process)
        @inline inc!(process)
    end

    while true
        context, runtimecontext = @inline _step!(step_plan, context, runtimecontext, step_wiring, Namespace{nothing}(), process, lifetime, Stable())
        @inline tick!(process)
        @inline inc!(process)
        break_context = ExecutionContext(withregistry(context, getregistry(func)), runtimecontext)
        if @inline breakcondition(lifetime, process, break_context)
            break
        end
    end
    return @noinline finalizer!(func, context, runtimecontext, process, lifetime)
end

"""
Run a repeat loop with runtime state scoped inside this function.
"""
@noinline function _repeat_loop_kernel!(
    process::P,
    algo::F,
    step_plan::SP,
    step_wiring::W,
    stored_context::C,
    lifetime::R,
    inputs::I,
    ::Val{isresuming},
) where {P<:AbstractProcess,F<:AbstractLoopAlgorithm,SP,W,C<:ProcessContext,R<:RepeatLifetime,I<:NamedTuple,isresuming}
    context = @inline hot_context(stored_context)
    runtimecontext = @inline _initial_runtime_context(inputs, process, lifetime)
    if isresuming
        @atomic process.paused = false
    else
        context, runtimecontext = @inline _step!(step_plan, context, runtimecontext, step_wiring, Namespace{nothing}(), process, lifetime, Stable())
        @inline tick!(process)
        @inline inc!(process)
    end

    for _ in (@inline loopidx(process)):(@inline repeats(lifetime))
        context, runtimecontext = @inline _step!(step_plan, context, runtimecontext, step_wiring, Namespace{nothing}(), process, lifetime, Stable())
        @inline tick!(process)
        @inline inc!(process)
        break_context = ExecutionContext(withregistry(context, getregistry(algo)), runtimecontext)
        if @inline breakcondition(lifetime, process, break_context)
            break
        end
    end
    return @noinline finalizer!(algo, context, runtimecontext, process, lifetime)
end
