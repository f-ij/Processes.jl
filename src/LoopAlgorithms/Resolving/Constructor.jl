"""
Attach a shared registry to one loop algorithm and resolve its routing/sharing
options against that registry.
"""
function _resolve_with_registry(la::LoopAlgorithm, registry::NameSpaceRegistry)
    options = getoptions(la)
    options isa Tuple || error("Resolving multiple loop algorithms together requires unresolved loop algorithms, but got $(typeof(la)) with options of type $(typeof(options)).")

    la = update_keys(la, registry)
    shares = typefilter(Share, options)
    routes = typefilter(Route, options)
    sharedcontexts = resolve_options(registry, shares...)
    sharedvars = resolve_options(registry, routes...)
    options = merge_nested_namedtuples(sharedvars, sharedcontexts)

    return setoptions(la, options)
end

"""
Resolve multiple loop algorithms onto one shared registry.

Each loop algorithm is updated separately against that registry and returned in the
same order.
"""
function resolve(la1::LoopAlgorithm, la2::LoopAlgorithm, las::LoopAlgorithm...)
    loopalgorithms = (la1, la2, las...)
    registry = setup_registry(loopalgorithms...)
    return map(la -> _resolve_with_registry(la, registry), loopalgorithms)
end

@inline resolve(loopalgorithms::Tuple{Vararg{LoopAlgorithm}}) = resolve(loopalgorithms...)
