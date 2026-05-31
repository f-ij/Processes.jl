"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""

"""
Split `ProcessContext` state threaded through the `NonGenerated()` step path.

Subcontexts are returned separately so parent plans can merge only the child
branches they actually forwarded, while runtime/input/widened state keeps the
existing positional flow.
"""
struct NonGeneratedStepContextParts{SubContexts, Registry, Runtime, Input, Widened}
    subcontexts::SubContexts
    registry::Registry
    runtime::Runtime
    input::Input
    widened::Widened
end

"""Split a scoped context into the parts used by `_step_nongen!`."""
@inline function NonGeneratedStepContextParts(context::C) where {C<:AbstractScopedContext}
    return NonGeneratedStepContextParts(
        get_subcontexts(context),
        getregistry(context),
        getglobals(context),
        getruntimeinput(context),
        getwidened(context),
    )
end

"""Rebuild a transient scoped context from split non-generated step state."""
@inline function _nongen_scoped_context(
    subcontexts::SC,
    registry::Reg,
    runtime::R,
    input::I,
    widened::W,
) where {SC<:NamedTuple, Reg<:AbstractRegistry, R<:NamedTuple, I<:NamedTuple, W}
    return OnDemandContext(subcontexts, registry, runtime, input, widened)
end

"""Rebuild a transient scoped context from split non-generated step parts."""
@inline function _nongen_scoped_context(parts::NG) where {NG<:NonGeneratedStepContextParts}
    return _nongen_scoped_context(
        getfield(parts, :subcontexts),
        getfield(parts, :registry),
        getfield(parts, :runtime),
        getfield(parts, :input),
        getfield(parts, :widened),
    )
end

"""Rebuild a full `ProcessContext` from split non-generated loop state."""
@inline function _nongen_process_context(
    subcontexts::SC,
    registry::Reg,
    runtime::R,
    input::I,
    widened::W,
) where {SC<:NamedTuple, Reg<:AbstractRegistry, R<:NamedTuple, I<:NamedTuple, W}
    return ProcessContext(subcontexts, registry, runtime, input, widened)
end

"""Rebuild a temporary `ProcessContext` from split non-generated step parts."""
@inline function _nongen_process_context(parts::NG) where {NG<:NonGeneratedStepContextParts}
    return _nongen_process_context(
        getfield(parts, :subcontexts),
        getfield(parts, :registry),
        getfield(parts, :runtime),
        getfield(parts, :input),
        getfield(parts, :widened),
    )
end

"""
Collect one child branch's visible subcontexts as positional arguments.

The returned tuple preserves the exact `Names` order so child `_step_nongen!`
methods can reconstruct their local named tuple without receiving a whole
parent context or named-tuple kwargs payload.
"""
@inline @generated function _collect_step_subcontexts(subcontexts::SC, ::Val{Names}) where {SC<:NamedTuple, Names}
    source_names = fieldnames(SC)
    value_exprs = Expr[]
    for name in Names
        name in source_names || error("Trying to forward unknown subcontext $(QuoteNode(name)) from available bindings $(source_names).")
        push!(value_exprs, :(getproperty(subcontexts, $(QuoteNode(name)))))
    end
    return Expr(:tuple, value_exprs...)
end

"""Merge a child branch's returned subcontexts back into the parent bindings."""
@inline @generated function _merge_step_subcontexts(current::Current, updates::Updates) where {Current<:NamedTuple, Updates<:NamedTuple}
    update_names = fieldnames(Updates)
    isempty(update_names) && return :(current)

    current_names = fieldnames(Current)
    merge_exprs = Any[:(merged = current)]
    for name in update_names
        name in current_names || error("Trying to merge unknown subcontext $(QuoteNode(name)) into forwarded step bindings $(current_names).")
        push!(
            merge_exprs,
            :(merged = @inline replace_namedtuple_field(
                merged,
                Val($(QuoteNode(name))),
                getproperty(updates, $(QuoteNode(name))),
            )),
        )
    end
    push!(merge_exprs, :(return merged))
    return Expr(:block, merge_exprs...)
end

"""
Step a concrete child from positional forwarded subcontexts.

The loop engine keeps the recursive plan path context-free. Only here, at the
leaf algorithm API boundary, do we rebuild an `OnDemandContext` so the existing
view-based two-argument `step!(algo, context)` methods keep working unchanged.
"""
@inline function _step_nongen!(
    algo::A,
    registry::Reg,
    runtime::R,
    input::I,
    widened::Widened,
    wiring::W,
    namespace::Namespace{Name},
    process::P,
    lifetime::LT,
    stability::S,
    ::Val{Names},
    subcontexts...,
) where {A<:ProcessAlgorithm, Reg<:AbstractRegistry, R<:NamedTuple, I<:NamedTuple, Widened, W<:Union{Wiring, PlanWiring}, Name, P<:AbstractProcess, LT<:Lifetime, S<:Stability, Names}
    step_context = OnDemandContext(NamedTuple{Names}(subcontexts), registry, runtime, input, widened)
    stepped_context = @inline _step!(algo, step_context, wiring, namespace, process, lifetime, stability)
    return NonGeneratedStepContextParts(stepped_context)
end

"""
Step one routine child on the split-context `NonGenerated()` path.

This mirrors `_subroutine_step!`, but forwards only the child-visible
subcontexts across each repeated child call.
"""
@inline function _subroutine_step_nongen!(
    subcontexts::SC,
    registry::Reg,
    runtime::R,
    input::I,
    widened::Widened,
    func::F,
    r::Routine,
    process::P,
    lifetime::LT,
    typestable::S,
    idx::Int,
    subroutine_lifetime::SL,
    child_step_wiring::W,
    namespace::N,
    ::Val{ChildUsed},
) where {SC<:NamedTuple, Reg<:AbstractRegistry, R<:NamedTuple, I<:NamedTuple, Widened, F, P<:AbstractProcess, LT<:Lifetime, S<:Stability, SL<:Lifetime, W, N<:Namespace, ChildUsed}
    resume_point = @inline get_resume_point(r, idx)
    this_repeat_count = @inline routine_repeat_count(subroutine_lifetime)
    current_subcontexts = subcontexts
    current_runtime = runtime
    current_input = input
    current_widened = widened

    if resume_point <= this_repeat_count
        child_parts = @inline _step_nongen!(
            func,
            registry,
            current_runtime,
            current_input,
            current_widened,
            child_step_wiring,
            namespace,
            process,
            lifetime,
            typestable,
            Val(ChildUsed),
            (@inline _collect_step_subcontexts(current_subcontexts, Val(ChildUsed)))...,
        )
        current_subcontexts = @inline _merge_step_subcontexts(current_subcontexts, getfield(child_parts, :subcontexts))
        current_runtime = getfield(child_parts, :runtime)
        current_input = getfield(child_parts, :input)
        current_widened = getfield(child_parts, :widened)
        @inline tick!(process)

        next_idx = resume_point + 1
        current_context = @inline _nongen_scoped_context(current_subcontexts, registry, current_runtime, current_input, current_widened)
        if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, current_context, resume_point)
            if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, current_context, resume_point))
                @inline set_resume_point!(r, idx, next_idx)
            end
            return NonGeneratedStepContextParts(current_subcontexts, registry, current_runtime, current_input, current_widened)
        end

        for lidx in next_idx:this_repeat_count
            current_context = @inline _nongen_scoped_context(current_subcontexts, registry, current_runtime, current_input, current_widened)
            if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, current_context, lidx)
                if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, current_context, lidx))
                    @inline set_resume_point!(r, idx, lidx)
                end
                return NonGeneratedStepContextParts(current_subcontexts, registry, current_runtime, current_input, current_widened)
            end

            child_parts = @inline _step_nongen!(
                func,
                registry,
                current_runtime,
                current_input,
                current_widened,
                child_step_wiring,
                namespace,
                process,
                lifetime,
                typestable,
                Val(ChildUsed),
                (@inline _collect_step_subcontexts(current_subcontexts, Val(ChildUsed)))...,
            )
            current_subcontexts = @inline _merge_step_subcontexts(current_subcontexts, getfield(child_parts, :subcontexts))
            current_runtime = getfield(child_parts, :runtime)
            current_input = getfield(child_parts, :input)
            current_widened = getfield(child_parts, :widened)
            @inline tick!(process)
        end
    end

    return NonGeneratedStepContextParts(current_subcontexts, registry, current_runtime, current_input, current_widened)
end

"""
Step each scheduled child of a composite plan on the split-context path.

Each child receives only the subcontexts declared by the resolved plan-usage
metadata plus its own local target subcontext.
"""
Base.@constprop :aggressive @inline @generated function _step_nongen!(
    ca::CA,
    registry::Reg,
    runtime::R,
    input::I,
    widened::Widened,
    wiring::W,
    namespace::N,
    process::P,
    lifetime::LT,
    typestable::S,
    ::Val{ScopeNames},
    subcontexts...,
) where {CA<:CompositeAlgorithm, Reg<:AbstractRegistry, R<:NamedTuple, I<:NamedTuple, Widened, W<:PlanWiring, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability, ScopeNames}
    algo_count = numalgos(CA)
    child_wiring_type = W.parameters[2]
    interval_values = CA.parameters[2]
    child_namespace_tuple_type = CA.parameters[3]
    child_usage = CA.parameters[5].parameters[2]

    exprs = Any[]
    sizehint!(exprs, algo_count + 8)
    push!(exprs, :(local current_subcontexts = NamedTuple{$ScopeNames}(subcontexts)))
    push!(exprs, :(local current_runtime = runtime))
    push!(exprs, :(local current_input = input))
    push!(exprs, :(local current_widened = widened))
    push!(exprs, :(local algos = @inline getalgos(ca)))
    push!(exprs, :(local this_inc = @inline inc(ca)))

    for i in 1:algo_count
        interval_value = interval_values[i]
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        interval_type = typeof(interval_value)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        child_usage_value = child_usage[i]
        push!(exprs, quote
            if @inline divides(this_inc, $interval_type())
                local algo = @inline getfield(algos, $i)
                local child_step_wiring = $child_step_wiring_type()
                local child_namespace = $child_namespace_type()
                local child_parts = @inline _step_nongen!(
                    algo,
                    registry,
                    current_runtime,
                    current_input,
                    current_widened,
                    child_step_wiring,
                    child_namespace,
                    process,
                    lifetime,
                    typestable,
                    Val($child_usage_value),
                    (@inline _collect_step_subcontexts(current_subcontexts, Val($child_usage_value)))...,
                )
                current_subcontexts = @inline _merge_step_subcontexts(current_subcontexts, getfield(child_parts, :subcontexts))
                current_runtime = getfield(child_parts, :runtime)
                current_input = getfield(child_parts, :input)
                current_widened = getfield(child_parts, :widened)
            end
        end)
    end

    push!(exprs, :(@inline inc!(ca)))
    push!(exprs, :(return NonGeneratedStepContextParts(current_subcontexts, registry, current_runtime, current_input, current_widened)))
    return Expr(:block, exprs...)
end

"""
Step each child routine in sequence on the split-context path.

Each child repeats according to its lifetime schedule while forwarding only the
subcontexts recorded in the resolved plan-usage metadata.
"""
Base.@constprop :aggressive @inline @generated function _step_nongen!(
    r::R,
    registry::Reg,
    runtime::RT,
    input::I,
    widened::Widened,
    wiring::W,
    namespace::N,
    process::P,
    lifetime::LT,
    typestable::S,
    ::Val{ScopeNames},
    subcontexts...,
) where {R<:Routine, Reg<:AbstractRegistry, RT<:NamedTuple, I<:NamedTuple, Widened, W<:PlanWiring, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability, ScopeNames}
    algo_count = numalgos(R)
    child_wiring_type = W.parameters[2]
    repeat_values = R.parameters[2]
    child_namespace_tuple_type = R.parameters[3]
    child_usage = R.parameters[6].parameters[2]

    exprs = Any[]
    sizehint!(exprs, algo_count + 7)
    push!(exprs, :(local current_subcontexts = NamedTuple{$ScopeNames}(subcontexts)))
    push!(exprs, :(local current_runtime = runtime))
    push!(exprs, :(local current_input = input))
    push!(exprs, :(local current_widened = widened))
    push!(exprs, :(local algos = @inline getalgos(r)))

    for i in 1:algo_count
        repeat_value = repeat_values[i]
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        child_usage_value = child_usage[i]
        push!(exprs, quote
            local func = @inline getfield(algos, $i)
            local child_step_wiring = $child_step_wiring_type()
            local child_namespace = $child_namespace_type()
            local child_parts = @inline _subroutine_step_nongen!(
                current_subcontexts,
                registry,
                current_runtime,
                current_input,
                current_widened,
                func,
                r,
                process,
                lifetime,
                typestable,
                $i,
                $repeat_value,
                child_step_wiring,
                child_namespace,
                Val($child_usage_value),
            )
            current_subcontexts = getfield(child_parts, :subcontexts)
            current_runtime = getfield(child_parts, :runtime)
            current_input = getfield(child_parts, :input)
            current_widened = getfield(child_parts, :widened)
        end)
    end

    push!(exprs, :(return NonGeneratedStepContextParts(current_subcontexts, registry, current_runtime, current_input, current_widened)))
    return Expr(:block, exprs...)
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
