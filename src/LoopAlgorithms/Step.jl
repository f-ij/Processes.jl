"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""

"""
Step each scheduled child of a composite plan with explicit loop runtime.

The `process` and `lifetime` values are forwarded so nested loop algorithms can
run without storing those transient values in the context.
"""
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

#= Generated composite entry-point experiment. Keep this commented while
   comparing against the unrollreplace implementation above.
Base.@constprop :aggressive @inline @generated function _step!(ca::CA, context::C, wiring::W, process::P, lifetime::LT, typestable::S = Stable()) where {CA <: CompositeAlgorithm, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    algos = gensym(:algos)
    this_inc = gensym(:this_inc)
    interval_spec = CA.parameters[2]
    child_wiring_type = W.parameters[2]
    interval_values = if interval_spec isa Tuple
        interval_spec
    else
        ntuple(i -> interval(CA, i), numalgos(CA))
    end
    always_runs = map(interval -> interval isa Interval{1, :end, 0} || interval isa Interval{1, :start, 0}, interval_values)

    # Generate the same child-indexed execution as the old unrollreplace path,
    # but without the closure object on the hot non-generated loop path. The
    # schedule is known from the plan type, so interval-1 children become direct
    # calls instead of runtime `divides` branches.
    exprs = Any[
        :(local $algos = @inline getalgos(ca)),
    ]
    any(!, always_runs) && pushfirst!(exprs, :(local $this_inc = @inline inc(ca)))

    for i in 1:numalgos(CA)
        interval_value = interval_values[i]
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        if always_runs[i]
            push!(exprs, quote
                local algo = getfield($algos, $i)
                local child_step_wiring = $child_step_wiring_type()
                context = @inline _step!(algo, context, child_step_wiring, process, lifetime, typestable)
            end)
        else
            interval_type = typeof(interval_value)
            push!(exprs, quote
                if @inline divides($this_inc, $interval_type())
                    local algo = getfield($algos, $i)
                    local child_step_wiring = $child_step_wiring_type()
                    context = @inline _step!(algo, context, child_step_wiring, process, lifetime, typestable)
                end
            end)
        end
    end

    push!(exprs, :(@inline inc!(ca)))
    push!(exprs, :(return context))
    return Expr(:block, exprs...)
end
=#

"""
Step each child routine in sequence with explicit loop runtime.

Each child is run once as `Unstable()` at its resume point, then repeated on the
stable path until its declared repeat count is reached or the lifetime stops.
"""
Base.@constprop :aggressive @inline function _step!(r::R, context::C, wiring::W, process::P, lifetime::LT, typestable::S = Stable()) where {R <: Routine, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    child_idxs = @inline ntuple(identity, Val(length(getalgos(r))))

    return @inline unrollreplace_withargs(
        context,
        @inline getalgos(r);
        args = (r, process, lifetime, typestable),
        zips = (child_idxs, repeats(r), child_wiring(wiring)),
    ) do context, func, r, process, lifetime, typestable, idx, this_repeat, child_step_wiring
        resume_point = @inline get_resume_point(r, idx)
        if resume_point <= this_repeat
            context = @inline _step!(func, context, child_step_wiring, process, lifetime, Unstable())
            @inline tick!(process)

            for lidx in (resume_point + 1):this_repeat
                if @inline breakcondition(lifetime, process, context)
                    @inline set_resume_point!(r, idx, lidx)
                    return context
                end
                context = @inline _step!(func, context, child_step_wiring, process, lifetime, typestable)
                @inline tick!(process)
            end
        end
        return context
    end
end
