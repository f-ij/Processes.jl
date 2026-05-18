export resolve
"""
Materialize a loop algorithm for context construction.

This wraps bare plan nodes in a concrete `LoopAlgorithm`, builds a registry,
keys the child algorithms, and resolves route/share options against that
registry. The returned value is always a runtime wrapper unless the input was a
`FinalizedAlgorithm`, in which case the finalized outer shape is preserved and
its inner loop is materialized.
"""
@inline function resolve(la::LA) where {LA<:AbstractLoopAlgorithm}
    if la isa FinalizedAlgorithm
        return finalstep(resolve(inneralgorithm(la)), finalfunction(la))
    end
    if !(la isa LoopAlgorithm)
        return resolve(LoopAlgorithm(la))
    end
    if isresolved(la)
        return la
    end

    registry, keyed_la = setup_registry_and_keyed_algos(la)
    keyed_la = attach_registry_to_tree(keyed_la, registry)
    keyed_la = resolve_step_wiring(keyed_la, registry)
    return setoptions(keyed_la, _root_loop_options(_unresolved_options(la)))
end

@inline function setup_registry_and_keyed_algos(la::LoopAlgorithm)
    registry = NameSpaceRegistry()

    # States are context-owned entries. They are registered first so the final
    # registry keeps the same ordering as `setup_registry`.
    states = flat_states(la)
    multipliers = ntuple(i -> 1, length(states))
    registry = addall(registry, states, multipliers)

    registry, keyed_plan = add_algos_to_registry(registry, getplan(la), 1.0)
    return registry, setfield(la, :plan, keyed_plan)
end

@inline function add_algos_to_registry(registry::R, la::LA, multiplier) where {R<:NameSpaceRegistry, LA<:AbstractLoopAlgorithm}
    funcs = getalgos(la)
    algo_multipliers = multiplier .* multipliers(la)
    registry, keyed_funcs = add_algo_tuple_to_registry(registry, funcs, algo_multipliers)
    return registry, rebuild_loopalgorithm_funcs(la, keyed_funcs)
end

@inline add_algo_tuple_to_registry(registry::R, ::Tuple{}, ::Tuple{}) where {R<:NameSpaceRegistry} = registry, ()

@inline function add_algo_tuple_to_registry(registry::R, funcs::F, multipliers::M) where {R<:NameSpaceRegistry, F<:Tuple, M<:Tuple}
    registry, keyed_head = add_algo_to_registry(registry, first(funcs), first(multipliers))
    registry, keyed_tail = add_algo_tuple_to_registry(registry, Base.tail(funcs), Base.tail(multipliers))
    return registry, (keyed_head, keyed_tail...)
end

@inline function add_algo_to_registry(registry::R, algo::LA, multiplier) where {R<:NameSpaceRegistry, LA<:AbstractLoopAlgorithm}
    inner = algo isa LoopAlgorithm ? getplan(algo) : algo
    return add_algos_to_registry(registry, inner, multiplier)
end

@inline function add_algo_to_registry(registry::R, algo::A, multiplier) where {R<:NameSpaceRegistry, A}
    return add(registry, algo, multiplier)
end

@inline function rebuild_loopalgorithm_funcs(la::LA, funcs::F) where {LA<:AbstractLoopAlgorithm, F<:Tuple}
    return setfield(la, :funcs, funcs)
end

@inline function rebuild_loopalgorithm_funcs(la::LoopAlgorithm, funcs::F) where {F<:Tuple}
    return setfield(la, :plan, rebuild_loopalgorithm_funcs(getplan(la), funcs))
end

@inline function rebuild_loopalgorithm_funcs(fa::FA, funcs::F) where {FA<:FinalizedAlgorithm, F<:Tuple}
    return finalstep(rebuild_loopalgorithm_funcs(inneralgorithm(fa), funcs), finalfunction(fa))
end

@inline function attach_registry_to_tree(la::LoopAlgorithm, registry::R) where {R<:NameSpaceRegistry}
    plan = attach_registry_to_tree(getplan(la), registry)
    return _attach_registry(setfield(la, :plan, plan), registry)
end

@inline function attach_registry_to_tree(la::LA, registry::R) where {LA<:AbstractLoopAlgorithm, R<:NameSpaceRegistry}
    funcs = map(getalgos(la)) do func
        func isa AbstractLoopAlgorithm ? attach_registry_to_tree(func, registry) : func
    end
    return rebuild_loopalgorithm_funcs(la, funcs)
end

@inline function attach_registry_to_tree(fa::FA, registry::R) where {FA<:FinalizedAlgorithm, R<:NameSpaceRegistry}
    return finalstep(attach_registry_to_tree(inneralgorithm(fa), registry), finalfunction(fa))
end

@inline resolve_step_wiring(la, ::NameSpaceRegistry) = la

@inline function resolve_step_wiring(la::LoopAlgorithm, registry::NameSpaceRegistry)
    return setfield(la, :plan, resolve_step_wiring(getplan(la), registry))
end

function resolve_step_wiring(la::Union{CompositeAlgorithm, Routine}, registry::NameSpaceRegistry)
    funcs = map(getalgos(la)) do func
        func isa AbstractLoopAlgorithm ? resolve_step_wiring(func, registry) : func
    end
    la = rebuild_loopalgorithm_funcs(la, funcs)

    funcs = getalgos(la)
    global_options = getfield(la, :global_options)
    local_wiring = getfield(la, :wiring)
    step_wiring = ntuple(length(funcs)) do i
        child = funcs[i]
        child_wiring = child isa AbstractLoopAlgorithm ? _plan_step_wiring(child) :
            child isa AbstractIdentifiableAlgo{<:AbstractLoopAlgorithm} ? _plan_step_wiring(getalgo(child)) :
            ()
        if child isa AbstractLoopAlgorithm || child isa AbstractIdentifiableAlgo{<:AbstractLoopAlgorithm}
            isempty(local_wiring[i]) || error("Local plan wiring $(local_wiring[i]) was assigned to nested plan child $(child), which has no root context key. Attach the route/share to a concrete child inside the nested plan.")
            return StepRouting((), (), child_wiring)
        end
        target_key = getkey(registry[child])

        global_sharedcontexts = get(resolve_options(registry, typefilter(Share, global_options)...), target_key, ())
        local_sharedcontexts = get(resolve_options(registry, typefilter(Share, local_wiring[i])...), target_key, ())
        global_sharedcontexts = global_sharedcontexts isa Tuple ? global_sharedcontexts : (global_sharedcontexts,)
        local_sharedcontexts = local_sharedcontexts isa Tuple ? local_sharedcontexts : (local_sharedcontexts,)

        global_sharedvars = get(resolve_options(registry, typefilter(Route, global_options)...), target_key, ())
        local_sharedvars = get(resolve_options(registry, typefilter(Route, local_wiring[i])...), target_key, ())
        local_aliases = mapreduce(localnames, (a, b) -> (a..., b...), local_sharedvars; init = ())
        sharedvars = (
            filter(sv -> !any(alias -> alias in local_aliases, localnames(sv)), global_sharedvars)...,
            local_sharedvars...,
        )

        StepRouting((global_sharedcontexts..., local_sharedcontexts...), sharedvars, child_wiring)
    end
    return setfield(la, :step_wiring, step_wiring)
end

@inline function resolve_step_wiring(fa::FA, registry::NameSpaceRegistry) where {FA<:FinalizedAlgorithm}
    return finalstep(resolve_step_wiring(inneralgorithm(fa), registry), finalfunction(fa))
end

function _plan_tree_options(la::LA) where {LA<:AbstractLoopAlgorithm}
    nested = mapreduce(
        child -> child isa AbstractLoopAlgorithm ? _plan_tree_options(child) : (),
        (a, b) -> (a..., b...),
        getalgos(la);
        init = (),
    )
    return (getoptions(la)..., nested...)
end

@inline _plan_tree_options(la::LoopAlgorithm) = (_plan_tree_options(getplan(la))..., getoptions(la)...)

@inline _unresolved_options(la::LoopAlgorithm) = (_plan_tree_options(getplan(la))..., getoptions(la)...)
@inline _unresolved_options(la::LA) where {LA<:AbstractLoopAlgorithm} = _plan_tree_options(la)

@inline function _resolve_options(la::LA) where {LA<:AbstractLoopAlgorithm}
    options = _unresolved_options(la)
    if length(options) >= 2 && options[end-1] isa NamedTuple && options[end] isa NamedTuple
        return options[end-1], options[end]
    end

    registry = getregistry(resolve(la))
    routes = typefilter(Route, options)
    shares = typefilter(Share, options)

    sharedcontexts = resolve_options(registry, shares...)
    sharedvars = resolve_options(registry, routes...)
    return sharedcontexts, sharedvars
end
