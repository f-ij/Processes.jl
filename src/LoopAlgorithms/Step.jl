"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""

"""
Step each scheduled child of a composite plan with explicit loop runtime.

The `process` and `lifetime` values are forwarded so nested loop algorithms can
run without storing those transient values in the context.
"""
Base.@constprop :aggressive @inline @generated function _step!(ca::CA, context::C, wiring::W, process::P, lifetime::LT, typestable::S = Stable()) where {CA <: CompositeAlgorithm, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    algo_count = numalgos(CA)
    child_wiring_type = W.parameters[2]
    interval_values = CA.parameters[2]
    # Generate the same child-indexed execution as the old unrollreplace path,
    # but without the closure object on the hot non-generated loop path. The
    # schedule is known from the plan type, so `divides` specializes away for
    # interval-1 children.
    exprs = Any[]
    sizehint!(exprs, algo_count + 4)
    push!(exprs, :(local algos = @inline getalgos(ca)))
    push!(exprs, :(local this_inc = @inline inc(ca)))

    for i in 1:algo_count
        interval_value = interval_values[i]
        child_step_wiring_value = fieldtype(child_wiring_type, i)()
        interval_type = typeof(interval_value)
        push!(exprs, quote
            if @inline divides(this_inc, $interval_type())
                local algo = @inline getfield(algos, $i)
                local child_step_wiring = $(QuoteNode(child_step_wiring_value))
                context = @inline _step!(algo, context, child_step_wiring, process, lifetime, typestable)
            end
        end)
    end

    push!(exprs, :(@inline inc!(ca)))
    push!(exprs, :(return context))
    return Expr(:block, exprs...)
end

#= Unrollreplace composite entry-point experiment. Keep this commented while
   comparing against the generated implementation above.
Base.@constprop :aggressive @inline function _step!(ca::CA, context::C, wiring::W, process::P, lifetime::LT, typestable::S = Stable()) where {CA <: CompositeAlgorithm, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    this_inc = @inline inc(ca)

    context = @inline unrollreplace_withargs(
        context,
        @inline getalgos(ca);
        args = (this_inc, process, lifetime, typestable),
        zips = (intervals(ca), child_wiring(wiring)),
    ) do context, algo, this_inc, process, lifetime, typestable, interval, child_step_wiring
        if @inline divides(this_inc, interval)
            return @inline _step!(algo, context, child_step_wiring, process, lifetime, typestable)
        end
        return context
    end

    @inline inc!(ca)
    return context
end
=#

"""
Step one child inside a `Routine`.

Dispatch on `subroutine_lifetime` keeps the integer-repeat fast path separate
from child-local lifetime schedules such as `Until(...)`.
"""
@inline function _subroutine_step!(
    context::C,
    func::F,
    r::R,
    process::P,
    lifetime::LT,
    typestable::S,
    idx::Int,
    subroutine_lifetime::I,
    child_step_wiring::W,
) where {C,F,R<:Routine,P<:AbstractProcess,LT<:Lifetime,S<:Stability,I<:Integer,W}
    resume_point = @inline get_resume_point(r, idx)
    if resume_point <= subroutine_lifetime
        context = @inline _step!(func, context, child_step_wiring, process, lifetime, Unstable())
        @inline tick!(process)

        next_idx = resume_point + 1
        if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, context, resume_point)
            @inline set_resume_point!(r, idx, next_idx)
            return context
        end

        for lidx in next_idx:subroutine_lifetime
            if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, context, lidx)
                @inline set_resume_point!(r, idx, lidx)
                return context
            end
            context = @inline _step!(func, context, child_step_wiring, process, lifetime, typestable)
            @inline tick!(process)
        end
    end
    return context
end

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
) where {C,F,R<:Routine,P<:AbstractProcess,LT<:Lifetime,S<:Stability,SL<:Lifetime,W}
    resume_point = @inline get_resume_point(r, idx)
    this_repeat_count = @inline routine_repeat_count(subroutine_lifetime)
    if resume_point <= this_repeat_count
        context = @inline _step!(func, context, child_step_wiring, process, lifetime, Unstable())
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
            context = @inline _step!(func, context, child_step_wiring, process, lifetime, typestable)
            @inline tick!(process)
        end
    end
    return context
end

"""
Step each child routine in sequence with explicit loop runtime.

Each child is run once as `Unstable()` at its resume point, then repeated on the
stable path until its declared repeat count is reached or the lifetime stops.
"""
Base.@constprop :aggressive @inline @generated function _step!(r::R, context::C, wiring::W, process::P, lifetime::LT, typestable::S = Stable()) where {R <: Routine, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    algo_count = numalgos(R)
    child_wiring_type = W.parameters[2]

    exprs = Any[]
    sizehint!(exprs, algo_count + 4)
    push!(exprs, :(local algos = @inline getalgos(r)))
    push!(exprs, :(local repeats = @inline lifetimes(r)))

    for i in 1:algo_count
        child_step_wiring_value = fieldtype(child_wiring_type, i)()
        push!(exprs, quote
            local func = @inline getfield(algos, $i)
            local this_repeat = @inline getfield(repeats, $i)
            local child_step_wiring = $(QuoteNode(child_step_wiring_value))
            context = @inline _subroutine_step!(context, func, r, process, lifetime, typestable, $i, this_repeat, child_step_wiring)
        end)
    end

    push!(exprs, :(return context))
    return Expr(:block, exprs...)
end

#= Unrollreplace routine entry-point experiment. Keep this commented while
   comparing against the generated implementation above.
Base.@constprop :aggressive @inline function _step!(r::R, context::C, wiring::W, process::P, lifetime::LT, typestable::S = Stable()) where {R <: Routine, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    child_idxs = @inline ntuple(identity, Val(length(getalgos(r))))

    return @inline unrollreplace_withargs(
        context,
        @inline getalgos(r);
        args = (r, process, lifetime, typestable),
        zips = (child_idxs, lifetimes(r), child_wiring(wiring)),
    ) do context, func, r, process, lifetime, typestable, idx, this_repeat, child_step_wiring
        return @inline _subroutine_step!(context, func, r, process, lifetime, typestable, idx, this_repeat, child_step_wiring)
    end
end
=#
