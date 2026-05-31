"""
    RuntimeStepResult

Result returned by one runtime-generated child step. The child runs on a narrow
`ProcessContext`, so the parent only has to patch the subcontexts that were
visible to that child.
"""
struct RuntimeStepResult{D,R,W}
    subcontexts::D
    runtime::R
    widened::W
end

"""
    RuntimeChildStep

Tagged runtime-generated child step. `RequiredNames` records which subcontexts
are passed positionally to the generated function, and `ReturnedNames` records
which subcontexts are merged back into the parent-local working set.
"""
struct RuntimeChildStep{RequiredNames, ReturnedNames, F}
    func::F
end

"""
    RuntimePlanSteps

Constructor-time bundle of child kernels for one loop plan. `ScopeNames` is the
plan-local union of subcontexts touched by all child kernels.
"""
struct RuntimePlanSteps{ScopeNames, ChildSteps}
    child_steps::ChildSteps
end

"""Call the wrapped runtime-generated child kernel."""
@inline function (step::RuntimeChildStep{RequiredNames, ReturnedNames, F})(args...) where {RequiredNames, ReturnedNames, F}
    return @inline getfield(step, :func)(args...)
end

"""Return the plan-local union of subcontext names touched by a runtime bundle."""
@inline runtime_scope_names(::RuntimePlanSteps{ScopeNames}) where {ScopeNames} = ScopeNames

"""Return the child kernels aligned with a plan's child algorithms."""
@inline runtime_child_steps(steps::RuntimePlanSteps) = getfield(steps, :child_steps)

"""Return the ordered subcontext names required by one child kernel."""
@inline runtime_required_names(::RuntimeChildStep{RequiredNames}) where {RequiredNames} = RequiredNames

"""Return the runtime step bundle stored on a resolved loop wrapper."""
@inline getruntime_steps(la::LoopAlgorithm) = @inline getruntime_steps(getplan(la))

"""Append one concrete subcontext name if it is not already present."""
function _push_runtime_step_subcontext_name(names::Names, name::Symbol) where {Names<:Tuple}
    (name === :_runtime || name === :_input || name === :globals) && return names
    name in names && return names
    return (names..., name)
end

"""Ignore route/share endpoints that are not concrete subcontext symbols."""
_push_runtime_step_subcontext_name(names::Names, name) where {Names<:Tuple} = names

"""Union two ordered tuples of subcontext names."""
function _merge_runtime_step_subcontext_names(left::Left, right::Right) where {Left<:Tuple, Right<:Tuple}
    merged = left
    for name in right
        merged = _push_runtime_step_subcontext_name(merged, name)
    end
    return merged
end

"""Collect subcontext names read or written by one resolved wiring bucket."""
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

"""Return the ordered subcontext list needed by a concrete non-loop child."""
function _runtime_step_required_names(algo, wiring::W, namespace::Namespace{Name}) where {W<:Wiring, Name}
    names = _push_runtime_step_subcontext_name((), Name)
    return _merge_runtime_step_subcontext_names(names, _runtime_step_wiring_subcontext_names(wiring))
end

"""Return the transitive subcontext scope needed by a nested loop child."""
function _runtime_step_required_names(algo::LA, wiring::W, namespace::N) where {LA<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Namespace}
    return runtime_scope_names(getruntime_steps(algo))
end

"""Forward nested-loop scope collection through a `LoopAlgorithm` wrapper."""
function _runtime_step_required_names(algo::LA, wiring::W, namespace::N) where {LA<:LoopAlgorithm, W<:PlanWiring, N<:Namespace}
    return runtime_scope_names(getruntime_steps(algo))
end

"""Compute the union of subcontext names touched by all children in one plan."""
function _runtime_plan_scope_names(child_steps::ChildSteps) where {ChildSteps<:Tuple}
    names = ()
    for child_step in child_steps
        names = _merge_runtime_step_subcontext_names(names, runtime_required_names(child_step))
    end
    return names
end

"""Return whether a child must see the full parent plan scope."""
@inline _runtime_child_requires_plan_scope(algo) = false

"""`ContextInjector` can patch indirect buffered targets, so keep its scope wide."""
@inline _runtime_child_requires_plan_scope(::ContextInjector) = true

"""
    _runtime_child_step(algo, wiring, namespace, required_names)

Build one runtime-generated child kernel that accepts only the required
subcontexts as positional arguments.
"""
function _runtime_child_step(algo, wiring, namespace, required_names = _runtime_step_required_names(algo, wiring, namespace))
    subcontext_args = ntuple(i -> Symbol(:subcontext_, i), length(required_names))

    subcontext_fields = (
        Expr(:(=), required_names[i], subcontext_args[i])
        for i in eachindex(required_names)
    )
    subcontexts_expr = Expr(:tuple, Expr(:parameters, subcontext_fields...))

    body = quote
        narrow_context = ProcessContext($subcontexts_expr, registry, runtime, input, widened)
        stepped_context = @inline _step!(algo, narrow_context, wiring, namespace, process, lifetime, stability)
        return RuntimeStepResult(
            get_subcontexts(stepped_context),
            getglobals(stepped_context),
            getwidened(stepped_context),
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
    _plan_runtime_steps(funcs, child_wirings, namespaces)

Build runtime-generated child kernels and the transitive local scope for one
plan node.
"""
function _plan_runtime_steps(funcs::Funcs, child_wirings::ChildWirings, namespaces::Namespaces) where {Funcs<:Tuple, ChildWirings<:Tuple, Namespaces<:Tuple}
    provisional_required = ntuple(i -> _runtime_step_required_names(getfield(funcs, i), getfield(child_wirings, i), getfield(namespaces, i)), length(funcs))
    scope_names = ()
    for names in provisional_required
        scope_names = _merge_runtime_step_subcontext_names(scope_names, names)
    end

    child_steps = ntuple(length(funcs)) do i
        func = getfield(funcs, i)
        names = _runtime_child_requires_plan_scope(func) ? scope_names : getfield(provisional_required, i)
        _runtime_child_step(func, getfield(child_wirings, i), getfield(namespaces, i), names)
    end
    scope_names = _runtime_plan_scope_names(child_steps)
    return RuntimePlanSteps{scope_names, typeof(child_steps)}(child_steps)
end

"""
    refresh_runtime_steps(plan)

Regenerate a plan's runtime step bundle after funcs, namespaces, or wiring have
changed during resolve-time rewrites.
"""
function refresh_runtime_steps(plan::Plan) where {Plan<:Union{CompositeAlgorithm, Routine}}
    runtime_steps = _plan_runtime_steps(getalgos(plan), child_wiring(getwiring(plan)), getfield(plan, :namespaces))
    return setfield(plan, :runtime_steps, runtime_steps)
end

"""
    clear_runtime_steps(plan)

Drop any packaged runtime kernels after unresolved constructor-time rewrites.
The concrete kernels are built only after route/share resolution has produced
the exact child wiring passed to each runtime-generated step.
"""
@inline function clear_runtime_steps(plan::Plan) where {Plan<:Union{CompositeAlgorithm, Routine}}
    return setfield(plan, :runtime_steps, nothing)
end

"""Report unresolved runtime packaging with an actionable error."""
runtime_scope_names(::Nothing) = error("Runtime-generated steps are unavailable before route/share resolution. Call `resolve` or construct a `Process` before stepping this plan.")

"""Extract a named-tuple subset in the requested order."""
@inline @generated function select_namedtuple_fields(nt::NT, ::Val{Names}) where {NT<:NamedTuple, Names}
    return :(NamedTuple{$Names}(tuple($((
        :(getproperty(nt, $(QuoteNode(name))))
        for name in Names
    )...))))
end

"""
    narrow_namedtuple_fields(nt, Val(names))

Extract fields from `nt` that exist in `names`, preserving `nt`'s field order.
This is used for `_widened`, where not every required subcontext has a patch.
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

"""Merge widened patch named tuples by subcontext key with right precedence."""
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

Run one runtime-generated child kernel against a parent-local working set and
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
