"""
Old top-level generated loop backend.

`GeneratedOld()` revives the previous generated loop code path under a separate
loop type. It uses `step!_expr_old` and keeps a full `context` variable in the
generated loop body.
"""

"""GeneratedOld repeat loop that performs the historical bootstrap step."""
@inline @generated function loop(
    process::P,
    algo::F,
    context::C,
    lifetime::RL,
    inputs::I,
    ::Resuming{isresuming},
    ::GeneratedOld,
) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C<:AbstractContext, RL<:RepeatLifetime, I<:NamedTuple, isresuming}
    Plan = getplan(F)
    first_step_expr = step!_expr_old(Plan, C, :step_plan, :step_wiring, :unstable)
    for_step_expr = step!_expr_old(Plan, C, :step_plan, :step_wiring, :stable)

    bootstrap_expr = if isresuming
        quote
            @atomic process.paused = false
        end
    else
        quote
            $(first_step_expr)
            @inline inc!(process)
            @inline tick!(process)
        end
    end

    return quote
        @inline before_while(process)
        stored_context = context
        step_plan = @inline getplan(algo)
        step_wiring = @inline getwiring(step_plan)
        context = @inline _merge_runtime_inputs(context, inputs)
        $bootstrap_expr

        first_step_idx = @inline loopidx(process)
        final_idx = @inline repeats(lifetime)
        for _ in first_step_idx:final_idx
            $(for_step_expr)
            @inline inc!(process)
            @inline tick!(process)
            if @inline breakcondition(lifetime, process, context)
                break
            end
        end
        return @inline after_while(process, algo, context, stored_context)
    end
end

"""GeneratedOld indefinite loop that keeps the old context-threaded body."""
@inline @generated function loop(
    process::P,
    func::F,
    context::C,
    lifetime::LT,
    inputs::I,
    ::Resuming{isresuming},
    ::GeneratedOld,
) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C<:AbstractContext, LT<:IndefiniteLifetime, I<:NamedTuple, isresuming}
    Plan = getplan(F)
    unstable_step_expr = step!_expr_old(Plan, C, :step_plan, :step_wiring, :unstable)
    stable_step_expr = step!_expr_old(Plan, C, :step_plan, :step_wiring, :stable)
    bootstrap_expr = if isresuming
        quote
            @atomic process.paused = false
        end
    else
        quote
            $(unstable_step_expr)
            @inline inc!(process)
            @inline tick!(process)
        end
    end

    return quote
        @inline before_while(process)
        stored_context = context
        step_plan = @inline getplan(func)
        step_wiring = @inline getwiring(step_plan)
        context = @inline _merge_runtime_inputs(context, inputs)
        $bootstrap_expr

        while true
            $(stable_step_expr)
            @inline inc!(process)
            @inline tick!(process)
            if @inline breakcondition(lifetime, process, context)
                break
            end
        end
        return @inline after_while(process, func, context, stored_context)
    end
end
