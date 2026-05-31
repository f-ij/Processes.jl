"""
Step each scheduled child of a composite plan through the whole-context path.

This is the `NonGenerated()` execution path: it keeps the immutable
`ProcessContext` as the optimization unit and lets each child use the normal
`SubContextView`/`merge` boundary.
"""
Base.@constprop :aggressive @inline @generated function _step!(ca::CA, context::C, wiring::W, namespace::N, process::P, lifetime::LT, typestable::S = Stable()) where {CA<:CompositeAlgorithm, C<:AbstractContext, W<:PlanWiring, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability}
    algo_count = numalgos(CA)
    child_wiring_type = W.parameters[2]
    child_namespace_tuple_type = CA.parameters[3]

    exprs = Any[]
    sizehint!(exprs, algo_count + 4)
    push!(exprs, :(local algos = @inline getalgos(ca)))
    push!(exprs, :(local this_inc = @inline inc(ca)))

    # Intervals are loaded from the plan value, not embedded from type data, so
    # future runtime-changeable interval types remain possible on this path.
    for i in 1:algo_count
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        push!(exprs, quote
            local this_interval = @inline interval(ca, $i)
            if @inline divides(this_inc, this_interval)
                local algo = @inline getfield(algos, $i)
                local child_step_wiring = $child_step_wiring_type()
                local child_namespace = $child_namespace_type()
                context = @inline _step!(algo, context, child_step_wiring, child_namespace, process, lifetime, typestable)
            end
        end)
    end

    push!(exprs, :(@inline inc!(ca)))
    push!(exprs, :(return context))
    return Expr(:block, exprs...)
end

"""Step one lifetime-scheduled child inside a `Routine`."""
@inline function _subroutine_step!(
    context::C,
    func::F,
    r::R,
    process::P,
    lifetime::LT,
    typestable::S,
    idx::Int,
    subroutine_lifetime::SL,
    child_step_wiring::W,
    namespace::N,
) where {C, F, R<:Routine, P<:AbstractProcess, LT<:Lifetime, S<:Stability, SL<:Lifetime, W, N<:Namespace}
    resume_point = @inline get_resume_point(r, idx)
    this_repeat_count = @inline routine_repeat_count(subroutine_lifetime)
    if resume_point <= this_repeat_count
        context = @inline _step!(func, context, child_step_wiring, namespace, process, lifetime, typestable)
        @inline tick!(process)

        next_idx = resume_point + 1
        if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, context, resume_point)
            if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, context, resume_point))
                @inline set_resume_point!(r, idx, next_idx)
            end
            return context
        end

        for lidx in next_idx:this_repeat_count
            if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, context, lidx)
                if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, context, lidx))
                    @inline set_resume_point!(r, idx, lidx)
                end
                return context
            end
            context = @inline _step!(func, context, child_step_wiring, namespace, process, lifetime, typestable)
            @inline tick!(process)
        end
    end
    return context
end

"""
Step each child routine in sequence through the whole-context path.

The child lifetime values are loaded from the routine value, matching the
runtime schedule model used by the generated and runtime-generated paths.
"""
Base.@constprop :aggressive @inline @generated function _step!(r::R, context::C, wiring::W, namespace::N, process::P, lifetime::LT, typestable::S = Stable()) where {R<:Routine, C<:AbstractContext, W<:PlanWiring, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability}
    algo_count = numalgos(R)
    child_wiring_type = W.parameters[2]
    child_namespace_tuple_type = R.parameters[3]

    exprs = Any[]
    sizehint!(exprs, algo_count + 4)
    push!(exprs, :(local algos = @inline getalgos(r)))

    for i in 1:algo_count
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        push!(exprs, quote
            local func = @inline getfield(algos, $i)
            local child_step_wiring = $child_step_wiring_type()
            local child_namespace = $child_namespace_type()
            local child_lifetime = @inline lifetimes(r, $i)
            context = @inline _subroutine_step!(context, func, r, process, lifetime, typestable, $i, child_lifetime, child_step_wiring, child_namespace)
        end)
    end

    push!(exprs, :(return context))
    return Expr(:block, exprs...)
end
