"""
Materialize a loop algorithm for context construction.

This builds the registry and updates names in the algorithm/options to match it.
Materialized loop algorithms are plain loop algorithms with a non-`nothing`
registry attached.
"""
function materialize(la::LoopAlgorithm)
    if ismaterialized(la)
        return la
    end

    registry = setup_registry(la)
    return update_keys(la, registry)
end

materialize(la::Type{<:LoopAlgorithm}) = materialize(instantiate(la))

function _resolve_materialized_links(la::LoopAlgorithm)
    registry = getregistry(la)
    options = getoptions(la)
    routes = typefilter(Route, options)
    shares = typefilter(Share, options)

    sharedcontexts = resolve_options(registry, shares...)
    sharedvars = resolve_options(registry, routes...)
    return sharedcontexts, sharedvars
end
