"""
Generated process loop that inlines the step! expression when available.
"""
@inline @generated function loop(
    process::P,
    algo::F,
    context::C,
    lifetime::RL,
    inputs::I,
    ::Resuming{isresuming},
    ::Generated,
) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C<:AbstractContext, RL<:RepeatLifetime, I<:NamedTuple, isresuming}
    first_step_expr = step!_expr(F, C, :algo, :step_wiring, :unstable)
    for_step_expr = step!_expr(F, C, :algo, :step_wiring, :stable)

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
        # First we do ONE step which is allowed to change the context,
        # After this we're not allowed to

        @inline before_while(process)
        stored_context = context
        step_wiring = @inline getwiring(algo)
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


# """
# Execute exactly one generated step for repeat-based lifetimes.

# This is the bootstrap pass that allows late-growing contexts to specialize the
# steady-state loop on the post-bootstrap context type.
# """
# @inline @generated function generated_firststep(process::AbstractProcess, algo::F, context::C, ::RL) where {F, C, RL <: RepeatLifetime}
#     algo_name = gensym(:algo)
#     step_expr = step!_expr(F, C, algo_name)

#     return quote
#         $(algo_name) = algo
#         $(step_expr)
#         @inline inc!(process)
#         @inline tick!(process)
#         return context
#     end
# end

# """
# Run the remaining repeat-based iterations after the bootstrap pass.
# """
# @inline @generated function generated_forloop(process::AbstractProcess, algo::F, context::C, r::RL, start_idx) where {F, C, RL <: RepeatLifetime}
#     algo_name = gensym(:algo)
#     step_expr = step!_expr(F, C, algo_name)

#     return quote
#         # reps = UInt(repeats(r))
#         # reps = repeats(r)

#         for i in start_idx:repeats(r)
#             $(algo_name) = algo
#             $(step_expr)
#             @inline inc!(process)
#             @inline tick!(process)
#             if @inline breakcondition(r, process, context)
#                 break
#             end
#         end
#         return context
#     end
# end

# @inline function generated_processloop(process::AbstractProcess, algo::F, context::C, r::RL) where {F, C, RL <: RepeatLifetime}
#     @inline before_while(process)
#     context = @inline generated_firststep(process, algo, context, r)
#     if @inline breakcondition(r, process, context)
#         return @inline after_while(process, algo, context)
#     end
#     context = @inline generated_forloop(process, algo, context, r, @inline loopidx(process))
#     return @inline after_while(process, algo, context)
# end



"""
Generated process loop that inlines the step! expression when available.
"""
@generated function loop(
    process::P,
    func::F,
    context::C,
    lifetime::LT,
    inputs::I,
    ::Resuming{isresuming},
    ::Generated,
) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C<:AbstractContext, LT<:IndefiniteLifetime, I<:NamedTuple, isresuming}
    unstable_step_expr = step!_expr(F, C, :func, :step_wiring, :unstable)
    stable_step_expr = step!_expr(F, C, :func, :step_wiring, :stable)
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
        # println("Running generated process loop indefinitely from thread $(Threads.threadid())")
        @inline before_while(process)
        stored_context = context
        step_wiring = @inline getwiring(func)
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
