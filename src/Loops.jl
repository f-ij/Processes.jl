const start_finished = Ref(false)

@inline function before_while(p::P) where {P<:AbstractProcess}
    start_finished[] = true
    p.threadid = Threads.threadid()
    set_starttime!(p)
end

@inline function before_while(ip::IP) where {IP<:InlineProcess}
    @inline set_starttime!(ip)
end

"""
    finalizer!(func, context, runtimecontext, process, lifetime)

Run cleanup and the final result projection while the loop-local runtime context
is still visible. The runtime context is intentionally not returned.
"""
@inline function finalizer!(func::F, context::C, runtimecontext::RC, process::P, lifetime::LT) where {F,C<:ProcessContext,RC<:ProcessContext,P<:AbstractProcess,LT<:Lifetime}
    runtimecontext = @inline _merge_into_globals(runtimecontext, (; process, lifetime))
    cleaned_context, cleaned_runtimecontext = @inline cleanup(func, context, runtimecontext)
    final_context = @inline final_visible_context(cleaned_context, cleaned_runtimecontext)
    return cleaned_context, (@inline _loop_final_result(func, final_context, cleaned_runtimecontext))
end

"""Build the loop-local runtime context for one execution."""
@inline function _initial_runtime_context(inputs::NamedTuple, process::P, lifetime::LT) where {P<:AbstractProcess,LT<:Lifetime}
    runtime = @inline _merge_into_globals(_empty_context(), (; process, lifetime))
    return isempty(inputs) ? runtime : @inline with_subcontext(runtime, Val(:_input), SubContext(:_input, inputs))
end

"""Commit or return the persistent context produced by the loop."""
@inline function after_while(p::P, func::F, context::C, returnvalue, stored_context::SC = context) where {P<:Process,F,C<:ProcessContext,SC<:ProcessContext}
    @inline set_endtime!(p)
    if ispaused(p)
        _store_runtime_context!(p, context)
        return context
    end
    commit_context!(p, context)
    return returnvalue
end

@inline function after_while(ip::IP, func::F, context::C, returnvalue, stored_context::SC = context) where {IP<:InlineProcess,F,C<:ProcessContext,SC<:ProcessContext}
    @inline set_endtime!(ip)
    Processes.context(ip, context)
    return returnvalue
end

@inline function after_while(p::P, func::F, context::C, returnvalue, stored_context::SC = context) where {P<:LoopRunProcess,F,C<:ProcessContext,SC<:ProcessContext}
    @inline set_endtime!(p)
    return context
end

"""
Run a single function in a loop indefinitely.
"""
@inline loop(process::P, func::F, context::C, lt::LT, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, LT} =
    loop(process, func, context, lt, inputs, resume, sys_looptype)

@inline function loop(process::P, func::F, stored_context::C, lifetime::LT, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess,F<:AbstractLoopAlgorithm,C<:ProcessContext,LT<:IndefiniteLifetime,isresuming}
    @inline before_while(process)

    step_plan = @inline getplan(func)
    step_wiring = @inline getwiring(step_plan)
    context = stored_context
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
        if @inline breakcondition(lifetime, process, context)
            break
        end
    end

    context, returnvalue = @inline finalizer!(func, context, runtimecontext, process, lifetime)
    return @inline after_while(process, func, context, returnvalue, stored_context)
end

"""
Run a single function in a loop for a given number of times.
"""
@inline loop(process::P, algo::F, context::C, r::R, inputs::NamedTuple = (;), resume::Resuming = Resuming{false}()) where {P<:AbstractProcess, F, C, R <: RepeatLifetime} =
    loop(process, algo, context, r, inputs, resume, sys_looptype)

Base.@constprop :aggressive @inline function loop(process::P, algo::F, stored_context::C, lifetime::R, inputs::NamedTuple, ::Resuming{isresuming}, ::NonGenerated) where {P<:AbstractProcess,F<:AbstractLoopAlgorithm,C<:ProcessContext,R<:RepeatLifetime,isresuming}
    @DebugMode "Running process loop for $repeats times from thread $(Threads.threadid())"
    @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
    @inline before_while(process)
    
    step_plan = @inline getplan(algo)
    step_wiring = @inline getwiring(step_plan)
    context = stored_context
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
        if @inline breakcondition(lifetime, process, context)
            break
        end
    end

    context, returnvalue = @inline finalizer!(algo, context, runtimecontext, process, lifetime)
    return @inline after_while(process, algo, context, returnvalue, stored_context)
end
