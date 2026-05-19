"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""

@inline _plan_step_wiring(::Any) = ()
@inline _plan_step_wiring(la::Union{CompositeAlgorithm, Routine}) = getfield(la, :step_wiring)
@inline _plan_step_wiring(la::LoopAlgorithm) = _plan_step_wiring(getplan(la))
@inline _plan_step_wiring(fa::FinalizedAlgorithm) = _plan_step_wiring(inneralgorithm(fa))

"""
Run `algo` with optional step wiring supplied before the stability marker.

An empty wiring tuple means there is no routing work to apply, so this method
falls back to the normal stability-only `step!` path. Non-empty wiring requires
a concrete routed method for the algorithm type.
"""
@inline function step!(algo::A, context::C, step_wiring::SW, typestable::S = Stable()) where {A, C<:AbstractContext, SW<:Tuple, S}
    if isempty(step_wiring)
        return @inline step!(algo, context, typestable)
    end
    error("No routed step! method for $(typeof(algo)) with wiring type $(typeof(step_wiring)).")
end

"""
Run `algo` with loop runtime supplied explicitly.

Plain algorithms with empty wiring do not need the loop runtime, so this method
falls back to the normal stability-only `step!` path. Loop algorithms specialize
this signature to pass `process` and `lifetime` through nested plans without
storing them in the `ProcessContext`.
"""
@inline function step!(algo::A, context::C, step_wiring::SW, process::P, lifetime::LT, typestable::S = Stable()) where {A, C<:AbstractContext, SW<:Tuple, P<:AbstractProcess, LT<:Lifetime, S}
    if isempty(step_wiring)
        return @inline step!(algo, context, typestable)
    end
    error("No routed step! method for $(typeof(algo)) with wiring type $(typeof(step_wiring)).")
end

@inline step!(child::LA, context::C, routing::StepRouting, typestable::S = Stable()) where {LA<:AbstractLoopAlgorithm, C<:AbstractContext, S} =
    error("Nested loop algorithm step! requires explicit process and lifetime. Call step!(child, context, routing, process, lifetime, stability).")

@inline step!(child::LA, context::C, routing::StepRouting, process::P, lifetime::LT, typestable::S = Stable()) where {LA<:AbstractLoopAlgorithm, C<:AbstractContext, P<:AbstractProcess, LT<:Lifetime, S} =
    @inline step!(child, context, routing_childwiring(routing), process, lifetime, typestable)

# Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C, typestable::S = Stable()) where {T,Is,C<:AbstractContext, S}
#     this_inc = inc(ca)
#     algos_and_intervals = @inline algo_and_interval_iterator(ca)
#
#     context = @inline unrollreplace(context, algos_and_intervals) do context, (func, interval)
#         if @inline divides(this_inc, interval)
#             context = @inline step!(func, context, S())
#         end
#         return context
#     end
#     @inline inc!(ca)
#     return context
# end

Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    error("CompositeAlgorithm step! requires explicit step wiring, process, and lifetime. Call step!(ca, context, step_wiring, process, lifetime, stability).")
end

"""
Reject direct composite stepping without explicit loop runtime.

Loop plans must not recover transient runtime from the context. Callers need to
pass `process` and `lifetime` explicitly.
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is, W, G, SW}, context::C, step_wiring::StepWiring, typestable::S = Stable()) where {T, Is, W, G, SW, C<:AbstractContext, StepWiring<:Tuple, S}
    error("CompositeAlgorithm step! requires explicit process and lifetime. Call step!(ca, context, step_wiring, process, lifetime, stability).")
end

"""
Routines unroll their subroutines and execute them in order.
"""
Base.@constprop :aggressive @inline function step!(r::Routine, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    error("Routine step! requires explicit step wiring, process, and lifetime. Call step!(r, context, step_wiring, process, lifetime, stability).")
end

"""
Step each scheduled child of a composite plan with explicit loop runtime.

The `process` and `lifetime` values are forwarded so nested loop algorithms can
run without storing those transient values in the context.
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is, W, G, SW}, context::C, step_wiring::StepWiring, process::P, lifetime::LT, typestable::S = Stable()) where {T, Is, W, G, SW, C<:AbstractContext, StepWiring<:Tuple, P<:AbstractProcess, LT<:Lifetime, S}
    this_inc = @inline inc(ca)

    context = @inline unrollreplace_withargs(
        context,
        getalgos(ca);
        args = (this_inc, process, lifetime, typestable),
        zips = (intervals(ca), step_wiring),
    ) do context, algo, this_inc, process, lifetime, typestable, interval, wiring
        if @inline divides(this_inc, interval)
            return @inline step!(algo, context, wiring, process, lifetime, typestable)
        end
        return context
    end

    @inline inc!(ca)
    return context
end

"""
Step each child routine in sequence using runtime stored in the context.

Loop plans must not recover transient runtime from the context. Callers need to
pass `process` and `lifetime` explicitly.
"""
Base.@constprop :aggressive @inline function step!(r::Routine{T, Repeats, MV, W, G, SW}, context::C, step_wiring::StepWiring, typestable::S = Stable()) where {T, Repeats, MV, W, G, SW, C<:AbstractContext, StepWiring<:Tuple, S}
    error("Routine step! requires explicit process and lifetime. Call step!(r, context, step_wiring, process, lifetime, stability).")
end

"""
Step each child routine in sequence with explicit loop runtime.

Each child is run once as `Unstable()` at its resume point, then repeated on the
stable path until its declared repeat count is reached or the lifetime stops.
"""
Base.@constprop :aggressive @inline function step!(r::Routine{T, Repeats, MV, W, G, SW}, context::C, step_wiring::StepWiring, process::P, lifetime::LT, typestable::S = Stable()) where {T, Repeats, MV, W, G, SW, C<:AbstractContext, StepWiring<:Tuple, P<:AbstractProcess, LT<:Lifetime, S}
    child_idxs = ntuple(identity, Val(length(getalgos(r))))

    return @inline unrollreplace_withargs(
        context,
        getalgos(r);
        args = (r, process, lifetime, typestable),
        zips = (child_idxs, repeats(r), step_wiring),
    ) do context, func, r, process, lifetime, typestable, idx, this_repeat, wiring
        start_idx = @inline get_resume_point(r, idx)
        if start_idx <= this_repeat
            context = @inline step!(func, context, wiring, process, lifetime, Unstable())
            @inline tick!(process)

            for lidx in (start_idx + 1):this_repeat
                if @inline breakcondition(lifetime, process, context)
                    @inline set_resume_point!(r, idx, lidx)
                    return context
                end
                context = @inline step!(func, context, wiring, process, lifetime, typestable)
                @inline tick!(process)
            end
        end
        return context
    end
end

