"""
    RuntimeStepResult

Result returned by one runtime-generated child step. The kernel receives the
required top-level `SubContext{Name,T}` values as positional arguments and
returns the updated subcontexts plus the current runtime and widened buckets
that the parent plan must thread forward.
"""
struct RuntimeStepResult{D,R,W}
    subcontexts::D
    runtime::R
    widened::W
end

"""
    RuntimeChildStep

Tagged runtime-generated child step. `RequiredNames` records which subcontexts
must be passed positionally, and `ReturnedNames` records which subcontexts come
back for parent-local patching.
"""
struct RuntimeChildStep{RequiredNames, ReturnedNames, F}
    func::F
end

"""
    RuntimePlanStepBundle

Per-plan runtime step bundle for the `NonGenerated()` path. `ScopeNames` is the
union of subcontexts touched anywhere in the plan, and `ChildSteps` is the
tuple of runtime-generated child kernels aligned with the plan's child tuple.
"""
struct RuntimePlanStepBundle{ScopeNames, ChildSteps}
    child_steps::ChildSteps
end

"""
    (step::RuntimeChildStep)(args...)

Call the wrapped runtime-generated child kernel.
"""
@inline function (step::RuntimeChildStep{RequiredNames, ReturnedNames, F})(args...) where {RequiredNames, ReturnedNames, F}
    return @inline getfield(step, :func)(args...)
end

"""
    runtime_scope_names(bundle)

Return the plan-local union of subcontext names touched by a runtime bundle.
"""
@inline runtime_scope_names(::RuntimePlanStepBundle{ScopeNames}) where {ScopeNames} = ScopeNames

"""
    runtime_child_steps(bundle)

Return the tuple of runtime-generated child kernels stored on a plan bundle.
"""
@inline runtime_child_steps(bundle::RuntimePlanStepBundle) = getfield(bundle, :child_steps)

"""
    runtime_required_names(step)

Return the ordered tuple of subcontext names required by one child kernel.
"""
@inline runtime_required_names(::RuntimeChildStep{RequiredNames}) where {RequiredNames} = RequiredNames

"""
    runtime_returned_names(step)

Return the ordered tuple of subcontext names returned by one child kernel.
"""
@inline runtime_returned_names(::RuntimeChildStep{RequiredNames, ReturnedNames}) where {RequiredNames, ReturnedNames} = ReturnedNames

"""
    _step!(algo, Val(names), wiring, namespace, process, lifetime, stability, registry, runtime, input, widened, subcontexts...)

Internal positional-subcontext step API used by runtime-generated child kernels.
`names` encodes the required top-level subcontext keys, and the remaining
positional arguments are exactly the matching `SubContext{Name,T}` values.
"""
@inline @generated function _step!(
    algo::A,
    ::Val{Names},
    wiring::W,
    namespace::N,
    process::P,
    lifetime::LT,
    stability::S,
    registry::Reg,
    runtime::R,
    input::I,
    widened::Wd,
    subcontexts::Vararg{Any, Count},
) where {A, Names, W, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability, Reg<:AbstractRegistry, R, I<:NamedTuple, Wd<:NamedTuple, Count}
    length(Names) == Count || error("Expected $(length(Names)) subcontexts for runtime step, got $(Count).")
    subcontext_expr = Expr(:tuple, Expr(:parameters, (
        Expr(:(=), name, :(subcontexts[$idx]))
        for (idx, name) in enumerate(Names)
    )...))
    return quote
        context = ProcessContext($subcontext_expr, registry, runtime, input, widened)
        stepped_context = @inline _step!(algo, context, wiring, namespace, process, lifetime, stability)
        return RuntimeStepResult(
            get_subcontexts(stepped_context),
            getglobals(stepped_context),
            getwidened(stepped_context),
        )
    end
end

"""
    getruntime_bundle(la)

Return the runtime step bundle stored on a resolved plan node.
"""
@inline getruntime_bundle(la::LoopAlgorithm) = @inline getruntime_bundle(getplan(la))

"""
    _push_runtime_step_subcontext_name(names, name)

Append one subcontext name to a tuple if it represents a real subcontext and is
not already present.
"""
function _push_runtime_step_subcontext_name(names::Names, name::Symbol) where {Names<:Tuple}
    (name === :_runtime || name === :_input || name === :globals) && return names
    name in names && return names
    return (names..., name)
end

"""
    _push_runtime_step_subcontext_name(names, name)

Ignore non-symbol route/share endpoints when collecting subcontext names.
"""
_push_runtime_step_subcontext_name(names::Names, name) where {Names<:Tuple} = names

"""
    _merge_runtime_step_subcontext_names(left, right)

Union two ordered tuples of subcontext names while preserving left-to-right
encounter order.
"""
function _merge_runtime_step_subcontext_names(left::Left, right::Right) where {Left<:Tuple, Right<:Tuple}
    merged = left
    for name in right
        merged = _push_runtime_step_subcontext_name(merged, name)
    end
    return merged
end

"""
    _runtime_step_wiring_subcontext_names(wiring)

Collect the subcontext names that a resolved `Wiring` bucket can read or write
through shares or routes.
"""
function _runtime_step_wiring_subcontext_names(wiring::W) where {W<:Wiring}
    names = ()
    for share in shares(wiring)
        names = _push_runtime_step_subcontext_name(names, contextname(share))
    end
    for route in routes(wiring)
        names = _push_runtime_step_subcontext_name(names, get_fromname(route))
    end
    return names
end

"""
    _runtime_step_required_names(algo, wiring, namespace)

Return the ordered subcontext list needed by a concrete non-loop child.
"""
function _runtime_step_required_names(algo, wiring::W, namespace::Namespace{Name}) where {W<:Wiring, Name}
    names = _push_runtime_step_subcontext_name((), Name)
    return _merge_runtime_step_subcontext_names(names, _runtime_step_wiring_subcontext_names(wiring))
end

"""
    _runtime_step_required_names(algo, wiring, namespace)

Return the transitive subcontext scope of a nested loop child by reading the
child plan's own runtime bundle.
"""
function _runtime_step_required_names(algo::LA, wiring::W, namespace::N) where {LA<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Namespace}
    return runtime_scope_names(getruntime_bundle(algo))
end

"""
    _runtime_step_required_names(algo, wiring, namespace)

Forward nested-loop scope collection through the `LoopAlgorithm` wrapper.
"""
function _runtime_step_required_names(algo::LA, wiring::W, namespace::N) where {LA<:LoopAlgorithm, W<:PlanWiring, N<:Namespace}
    return runtime_scope_names(getruntime_bundle(algo))
end

"""
    _runtime_plan_scope_names(child_steps)

Compute the union of subcontext names touched by all children in one plan.
"""
function _runtime_plan_scope_names(child_steps::ChildSteps) where {ChildSteps<:Tuple}
    names = ()
    for child_step in child_steps
        names = _merge_runtime_step_subcontext_names(names, runtime_required_names(child_step))
    end
    return names
end

"""
    _runtime_child_requires_plan_scope(algo)

Return whether a child must run against the full parent plan scope rather than
just its routed/view-local subcontexts.
"""
@inline _runtime_child_requires_plan_scope(algo) = false

"""
    _runtime_child_requires_plan_scope(algo)

`ContextInjector` mutates arbitrary buffered target subcontexts, so it must see
the whole parent-plan working subset.
"""
@inline _runtime_child_requires_plan_scope(::ContextInjector) = true

"""
    _runtime_child_step(algo, wiring, namespace, required_names)

Build one runtime-generated child kernel that accepts exactly the top-level
`SubContext{Name,T}` values it needs as positional arguments.
"""
function _runtime_child_step(algo, wiring, namespace, required_names = _runtime_step_required_names(algo, wiring, namespace))
    subcontext_args = ntuple(i -> Symbol(:subcontext_, i), length(required_names))

    body = quote
        return @inline _step!(
            algo,
            Val{$(QuoteNode(required_names))}(),
            wiring,
            namespace,
            process,
            lifetime,
            stability,
            registry,
            runtime,
            input,
            widened,
            $(subcontext_args...),
        )
    end

    step_expr = Expr(
        :->,
        Expr(:tuple, :algo, :wiring, :namespace, :registry, :runtime, :input, :widened, :process, :lifetime, :stability, subcontext_args...),
        body,
    )
    func = RuntimeGeneratedFunctions.RuntimeGeneratedFunction(@__MODULE__, @__MODULE__, Base.remove_linenums!(step_expr))
    return RuntimeChildStep{required_names, required_names, typeof(func)}(func)
end

"""
    _plan_runtime_bundle(funcs, child_wirings, namespaces)

Build the runtime-generated child kernels and the transitive local scope for one
resolved plan node.
"""
function _plan_runtime_bundle(funcs::Funcs, child_wirings::ChildWirings, namespaces::Namespaces) where {Funcs<:Tuple, ChildWirings<:Tuple, Namespaces<:Tuple}
    provisional_required = ntuple(i -> _runtime_step_required_names(getfield(funcs, i), getfield(child_wirings, i), getfield(namespaces, i)), length(funcs))
    scope_names = ()
    for names in provisional_required
        scope_names = _merge_runtime_step_subcontext_names(scope_names, names)
    end

    # Some children mutate indirect targets that are not visible through normal
    # route/share scope analysis, so widen those children to the full parent
    # plan scope after the plan-wide union is known.
    child_steps = ntuple(length(funcs)) do i
        func = getfield(funcs, i)
        names = _runtime_child_requires_plan_scope(func) ? scope_names : getfield(provisional_required, i)
        _runtime_child_step(func, getfield(child_wirings, i), getfield(namespaces, i), names)
    end
    scope_names = _runtime_plan_scope_names(child_steps)
    return RuntimePlanStepBundle{scope_names, typeof(child_steps)}(child_steps)
end

"""
    refresh_runtime_bundle(plan)

Regenerate the runtime step bundle after a plan's funcs, namespaces, or wiring
has changed during construction or resolve-time rewrites.
"""
function refresh_runtime_bundle(plan::Plan) where {Plan<:Union{CompositeAlgorithm, Routine}}
    bundle = _plan_runtime_bundle(getalgos(plan), child_wiring(getwiring(plan)), getfield(plan, :namespaces))
    return setfield(plan, :runtime_bundle, bundle)
end

"""
    select_namedtuple_fields(nt, Val(names))

Extract a named-tuple subset in the requested order.
"""
@inline @generated function select_namedtuple_fields(nt::NT, ::Val{Names}) where {NT<:NamedTuple, Names}
    return :(NamedTuple{$Names}(tuple($((
        :(getproperty(nt, $(QuoteNode(name))))
        for name in Names
    )...))))
end

"""
    narrow_namedtuple_fields(nt, Val(names))

Extract the fields from `nt` that exist in `names`, preserving `nt`'s existing
field order. This is used for `_widened`, where some required subcontexts may
not yet have widened patches.
"""
@inline @generated function narrow_namedtuple_fields(nt::NT, ::Val{Names}) where {NT<:NamedTuple, Names}
    nt_names = fieldnames(NT)
    exprs = Expr[]
    for name in nt_names
        if name in Names
            push!(exprs, Expr(:(=), name, :(getproperty(nt, $(QuoteNode(name))))))
        end
    end
    return Expr(:tuple, Expr(:parameters, exprs...))
end

"""
    merge_widened_patches(left, right)

Merge two widened patch named tuples by subcontext key, merging overlapping
inner patch named tuples with right precedence.
"""
@inline @generated function merge_widened_patches(left::L, right::R) where {L<:NamedTuple, R<:NamedTuple}
    left_names = fieldnames(L)
    right_names = fieldnames(R)
    merged_names = left_names
    for name in right_names
        if !(name in merged_names)
            merged_names = (merged_names..., name)
        end
    end

    value_exprs = Any[]
    for name in merged_names
        in_left = name in left_names
        in_right = name in right_names
        if in_left && in_right
            push!(value_exprs, :(merge(getproperty(left, $(QuoteNode(name))), getproperty(right, $(QuoteNode(name))))))
        elseif in_left
            push!(value_exprs, :(getproperty(left, $(QuoteNode(name)))))
        else
            push!(value_exprs, :(getproperty(right, $(QuoteNode(name)))))
        end
    end

    return :(NamedTuple{$merged_names}(tuple($(value_exprs...))))
end

"""
    _call_runtime_child_step(...)

Run one runtime-generated child kernel against the parent-local working set and
return the updated local subcontexts, runtime bucket, and widened patches.
"""
@inline @generated function _call_runtime_child_step(
    step::RuntimeChildStep{RequiredNames, ReturnedNames, F},
    local_subcontexts::D,
    runtime::R,
    input::I,
    widened::W,
    registry::Reg,
    algo::A,
    wiring::WT,
    namespace::N,
    process::P,
    lifetime::LT,
    stability::S,
) where {RequiredNames, ReturnedNames, F, D<:NamedTuple, R, I, W<:NamedTuple, Reg, A, WT, N<:Namespace, P<:AbstractProcess, LT<:Lifetime, S<:Stability}
    subcontext_args = Any[
        :(getproperty(local_subcontexts, $(QuoteNode(name))))
        for name in RequiredNames
    ]

    child_call = Expr(
        :call,
        :step,
        :algo,
        :wiring,
        :namespace,
        :registry,
        :runtime,
        :input,
        :(narrow_namedtuple_fields(widened, Val{$(QuoteNode(RequiredNames))}())),
        :process,
        :lifetime,
        :stability,
        subcontext_args...,
    )

    return quote
        child_result = $child_call
        updated_subcontexts = @inline replace_namedtuple_fields(local_subcontexts, getfield(child_result, :subcontexts))
        updated_widened = @inline merge_widened_patches(widened, getfield(child_result, :widened))
        return updated_subcontexts, getfield(child_result, :runtime), updated_widened
    end
end

"""
    merge_runtime_plan_scope(context, local_subcontexts, runtime, widened)

Merge a parent plan's local working subset back into the outer `ProcessContext`
in one rebuild pass.
"""
@inline function merge_runtime_plan_scope(
    context::C,
    local_subcontexts::D,
    runtime::R,
    widened::W,
) where {C<:ProcessContext, D<:NamedTuple, R, W<:NamedTuple}
    merged_subcontexts = @inline replace_namedtuple_fields(get_subcontexts(context), local_subcontexts)
    merged_widened = @inline merge_widened_patches(getwidened(context), widened)
    return ProcessContext(merged_subcontexts, getregistry(context), runtime, getruntimeinput(context), merged_widened)
end
