"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""

"""
    _runtime_composite_child_step!(state, child_step, ...)

Conditionally run one composite child against the parent-local working subset
and thread the updated local state forward.
"""
@inline function _runtime_composite_child_step!(
    state::State,
    child_step::ChildStep,
    input::I,
    registry::Reg,
    process::P,
    lifetime::LT,
    stability::S,
    this_inc::Int,
    algo,
    child_step_wiring,
    child_namespace::N,
    interval,
) where {State<:Tuple, ChildStep<:RuntimeChildStep, I<:NamedTuple, Reg<:AbstractRegistry, P<:AbstractProcess, LT<:Lifetime, S<:Stability, N<:Namespace}
    if @inline divides(this_inc, interval)
        return @inline _call_runtime_child_step(
            child_step,
            state[1],
            state[2],
            input,
            state[3],
            registry,
            algo,
            child_step_wiring,
            child_namespace,
            process,
            lifetime,
            stability,
        )
    end
    return state
end

"""
    _step!(ca, context, wiring, namespace, process, lifetime, stability)

Run the `NonGenerated()` composite path against one parent-local working subset,
then merge that subset back into the outer context once at parent exit.
"""
Base.@constprop :aggressive @inline function _step!(
    ca::CA,
    context::C,
    wiring::W,
    namespace::N,
    process::P,
    lifetime::LT,
    typestable::S = Stable(),
) where {CA<:CompositeAlgorithm, C<:ProcessContext, W<:PlanWiring, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability}
    bundle = @inline getruntime_bundle(ca)
    scope_names = runtime_scope_names(bundle)

    # Extract the parent-local working subset once so child kernels only see the
    # small subcontext tuple they actually need.
    local_subcontexts = @inline select_namedtuple_fields(get_subcontexts(context), Val(scope_names))
    local_runtime = @inline getglobals(context)
    local_widened = @inline narrow_namedtuple_fields(getwidened(context), Val(scope_names))
    state = (local_subcontexts, local_runtime, local_widened)

    state = @inline unrollreplace_withargs(
        _runtime_composite_child_step!,
        state,
        runtime_child_steps(bundle);
        args = (getruntimeinput(context), getregistry(context), process, lifetime, typestable, inc(ca)),
        zips = (getalgos(ca), child_wiring(wiring), getfield(ca, :namespaces), intervals(ca)),
    )

    @inline inc!(ca)
    return @inline merge_runtime_plan_scope(context, state[1], state[2], state[3])
end

"""
Step each scheduled child of a composite plan with explicit loop runtime.

The `process` and `lifetime` values are forwarded so nested loop algorithms can
run without storing those transient values in the context.
"""
Base.@constprop :aggressive @inline @generated function _step!(ca::CA, context::C, wiring::W, namespace::N, process::P, lifetime::LT, typestable::S = Stable()) where {CA <: CompositeAlgorithm, C <: AbstractContext, W <: PlanWiring, N <: Namespace, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    algo_count = numalgos(CA)
    child_wiring_type = W.parameters[2]
    interval_values = CA.parameters[2]
    child_namespace_tuple_type = CA.parameters[3]
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
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        interval_type = typeof(interval_value)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        push!(exprs, quote
            if @inline divides(this_inc, $interval_type())
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

"""
    _runtime_subroutine_step!(state, runtime_step, ...)

Run one routine child against the parent-local working subset while preserving
the current resume-point and break-condition semantics.
"""
@inline function _runtime_subroutine_step!(
    state::State,
    runtime_step::RS,
    func::F,
    r::R,
    process::P,
    lifetime::LT,
    typestable::S,
    idx::Int,
    subroutine_lifetime::SL,
    child_step_wiring::W,
    namespace::N,
    input::I,
    registry::Reg,
) where {State<:Tuple, RS<:RuntimeChildStep, F, R<:Routine, P<:AbstractProcess, LT<:Lifetime, S<:Stability, SL<:Lifetime, W, N<:Namespace, I<:NamedTuple, Reg<:AbstractRegistry}
    resume_point = @inline get_resume_point(r, idx)
    this_repeat_count = @inline routine_repeat_count(subroutine_lifetime)
    if resume_point <= this_repeat_count
        state = @inline _call_runtime_child_step(
            runtime_step,
            state[1],
            state[2],
            input,
            state[3],
            registry,
            func,
            child_step_wiring,
            namespace,
            process,
            lifetime,
            typestable,
        )
        @inline tick!(process)

        next_idx = resume_point + 1
        local_context = ProcessContext(state[1], registry, state[2], input, state[3])
        if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, local_context, resume_point)
            if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, local_context, resume_point))
                @inline set_resume_point!(r, idx, next_idx)
            end
            return state
        end

        for lidx in next_idx:this_repeat_count
            local_context = ProcessContext(state[1], registry, state[2], input, state[3])
            if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, local_context, lidx)
                if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, local_context, lidx))
                    @inline set_resume_point!(r, idx, lidx)
                end
                return state
            end
            state = @inline _call_runtime_child_step(
                runtime_step,
                state[1],
                state[2],
                input,
                state[3],
                registry,
                func,
                child_step_wiring,
                namespace,
                process,
                lifetime,
                typestable,
            )
            @inline tick!(process)
        end
    end
    return state
end

"""
    _runtime_routine_child_step!(state, runtime_step, ...)

Run one routine child entry from the runtime-generated child-step bundle.
"""
@inline function _runtime_routine_child_step!(
    state::State,
    runtime_step::RS,
    r::R,
    process::P,
    lifetime::LT,
    typestable::S,
    input::I,
    registry::Reg,
    func::F,
    idx::Int,
    subroutine_lifetime::SL,
    child_step_wiring::W,
    namespace::N,
) where {State<:Tuple, RS<:RuntimeChildStep, R<:Routine, P<:AbstractProcess, LT<:Lifetime, S<:Stability, I<:NamedTuple, Reg<:AbstractRegistry, F, SL<:Lifetime, W, N<:Namespace}
    return @inline _runtime_subroutine_step!(
        state,
        runtime_step,
        func,
        r,
        process,
        lifetime,
        typestable,
        idx,
        subroutine_lifetime,
        child_step_wiring,
        namespace,
        input,
        registry,
    )
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
) where {C,F,R<:Routine,P<:AbstractProcess,LT<:Lifetime,S<:Stability,SL<:Lifetime,W,N<:Namespace}
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
    _step!(r, context, wiring, namespace, process, lifetime, stability)

Run the `NonGenerated()` routine path against one parent-local working subset,
then merge that subset back into the outer context once at parent exit.
"""
Base.@constprop :aggressive @inline function _step!(
    r::R,
    context::C,
    wiring::W,
    namespace::N,
    process::P,
    lifetime::LT,
    typestable::S = Stable(),
) where {R<:Routine, C<:ProcessContext, W<:PlanWiring, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability}
    bundle = @inline getruntime_bundle(r)
    scope_names = runtime_scope_names(bundle)

    # Extract the routine-local working subset once so repeated child stepping
    # only patches the narrow subcontext tuple.
    local_subcontexts = @inline select_namedtuple_fields(get_subcontexts(context), Val(scope_names))
    local_runtime = @inline getglobals(context)
    local_widened = @inline narrow_namedtuple_fields(getwidened(context), Val(scope_names))
    state = (local_subcontexts, local_runtime, local_widened)

    child_count = length(getalgos(r))
    child_indices = ntuple(i -> i, child_count)
    state = @inline unrollreplace_withargs(
        _runtime_routine_child_step!,
        state,
        runtime_child_steps(bundle);
        args = (r, process, lifetime, typestable, getruntimeinput(context), getregistry(context)),
        zips = (getalgos(r), child_indices, lifetimes(r), child_wiring(wiring), getfield(r, :namespaces)),
    )

    return @inline merge_runtime_plan_scope(context, state[1], state[2], state[3])
end

"""
Step each child routine in sequence with explicit loop runtime.

Each child is run once at its resume point, then repeated until its declared
repeat count is reached or the lifetime stops.
"""
Base.@constprop :aggressive @inline @generated function _step!(r::R, context::C, wiring::W, namespace::N, process::P, lifetime::LT, typestable::S = Stable()) where {R <: Routine, C <: AbstractContext, W <: PlanWiring, N <: Namespace, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    algo_count = numalgos(R)
    child_wiring_type = W.parameters[2]
    repeat_values = R.parameters[2]
    child_namespace_tuple_type = R.parameters[3]

    exprs = Any[]
    sizehint!(exprs, algo_count + 4)
    push!(exprs, :(local algos = @inline getalgos(r)))

    for i in 1:algo_count
        repeat_value = repeat_values[i]
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        push!(exprs, quote
            local func = @inline getfield(algos, $i)
            local child_step_wiring = $child_step_wiring_type()
            local child_namespace = $child_namespace_type()
            context = @inline _subroutine_step!(context, func, r, process, lifetime, typestable, $i, $repeat_value, child_step_wiring, child_namespace)
        end)
    end

    push!(exprs, :(return context))
    return Expr(:block, exprs...)
end
