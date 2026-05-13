export resolve
"""
Materialize a loop algorithm for context construction.

This builds the registry and updates names in the algorithm/options to match it.
Materialized loop algorithms are plain loop algorithms with a non-`nothing`
registry attached.
"""
function resolve(la::LA) where {LA<:LoopAlgorithm}
    if isresolved(la)
        return la
    end

    registry, keyed_la = setup_registry_and_keyed_algos(la)
    keyed_la = attach_registry_to_tree(keyed_la, registry)
    return _resolve_keyed_with_registry(keyed_la, registry, getoptions(la))
end

function setup_registry_and_keyed_algos(la::LA) where {LA<:LoopAlgorithm}
    registry = NameSpaceRegistry()

    # States are context-owned entries. They are registered first so the final
    # registry keeps the same ordering as `setup_registry`.
    states = flat_states(la)
    multipliers = ntuple(i -> 1, length(states))
    registry = addall(registry, states, multipliers)

    return add_algos_to_registry(registry, la, 1.0)
end

function add_algos_to_registry(registry::R, la::LA, multiplier) where {R<:NameSpaceRegistry, LA<:LoopAlgorithm}
    funcs = getalgos(la)
    algo_multipliers = multiplier .* multipliers(la)
    registry, keyed_funcs = add_algo_tuple_to_registry(registry, funcs, algo_multipliers)
    return registry, rebuild_loopalgorithm_funcs(la, keyed_funcs)
end

add_algo_tuple_to_registry(registry::R, ::Tuple{}, ::Tuple{}) where {R<:NameSpaceRegistry} = registry, ()

function add_algo_tuple_to_registry(registry::R, funcs::F, multipliers::M) where {R<:NameSpaceRegistry, F<:Tuple, M<:Tuple}
    registry, keyed_head = add_algo_to_registry(registry, first(funcs), first(multipliers))
    registry, keyed_tail = add_algo_tuple_to_registry(registry, Base.tail(funcs), Base.tail(multipliers))
    return registry, (keyed_head, keyed_tail...)
end

function add_algo_to_registry(registry::R, algo::LA, multiplier) where {R<:NameSpaceRegistry, LA<:LoopAlgorithm}
    return add_algos_to_registry(registry, algo, multiplier)
end

function add_algo_to_registry(registry::R, algo::A, multiplier) where {R<:NameSpaceRegistry, A}
    return add(registry, algo, multiplier)
end

function rebuild_loopalgorithm_funcs(la::LA, funcs::F) where {LA<:LoopAlgorithm, F<:Tuple}
    return setfield(la, :funcs, funcs)
end

function rebuild_loopalgorithm_funcs(fa::FA, funcs::F) where {FA<:FinalizedAlgorithm, F<:Tuple}
    return finalstep(rebuild_loopalgorithm_funcs(inneralgorithm(fa), funcs), finalfunction(fa))
end

function attach_registry_to_tree(la::LA, registry::R) where {LA<:LoopAlgorithm, R<:NameSpaceRegistry}
    funcs = map(getalgos(la)) do func
        func isa LoopAlgorithm ? attach_registry_to_tree(func, registry) : func
    end
    la = rebuild_loopalgorithm_funcs(la, funcs)
    return _attach_registry(la, registry)
end

function attach_registry_to_tree(fa::FA, registry::R) where {FA<:FinalizedAlgorithm, R<:NameSpaceRegistry}
    return finalstep(attach_registry_to_tree(inneralgorithm(fa), registry), finalfunction(fa))
end

function _resolve_keyed_with_registry(la::LA, registry::R, options::O) where {LA<:LoopAlgorithm, R<:NameSpaceRegistry, O<:Tuple}
    shares = typefilter(Share, options)
    routes = typefilter(Route, options)
    sharedcontexts = resolve_options(registry, shares...)
    sharedvars = resolve_options(registry, routes...)
    options = merge_nested_namedtuples(sharedvars, sharedcontexts)
    return setoptions(la, options)
end

function _resolve_options(la::LA) where {LA<:LoopAlgorithm}
    if isresolved(la)
        options = getoptions(la)
        sharedcontexts = inner_typefilter(SharedContext, options)
        sharedvars = inner_typefilter(SharedVars, options)
        return sharedcontexts, sharedvars
    end

    options = getoptions(la)
    if length(options) >= 2 && options[end-1] isa NamedTuple && options[end] isa NamedTuple
        return options[end-1], options[end]
    end

    registry = getregistry(la)
    routes = typefilter(Route, options)
    shares = typefilter(Share, options)

    sharedcontexts = resolve_options(registry, shares...)
    sharedvars = resolve_options(registry, routes...)
    return sharedcontexts, sharedvars
end
