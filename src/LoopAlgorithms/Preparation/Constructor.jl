export resolve
"""
Materialize a loop algorithm for context construction.

This builds the registry and updates names in the algorithm/options to match it.
Materialized loop algorithms are plain loop algorithms with a non-`nothing`
registry attached.
"""
function resolve(la::LoopAlgorithm)
    if isresolved(la)
        return la
    end

    registry = setup_registry(la)
    return _resolve_with_registry(la, registry)
end

function _resolve_options(la::LoopAlgorithm)
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
