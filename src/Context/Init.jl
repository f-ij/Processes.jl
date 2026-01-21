"""
From a collection of Share objects
Construct a namedtuple of (;target_namespace => SharedContext{origin_namespace},...)
Bi-directional shares are represented twice
"""
function resolve_shares(reg::NameSpaceRegistry, shares::Share...)
    if isempty(shares)
        return (;)
    end
    all_sharedcontexts = merge(get_sharedcontexts.(Ref(reg), shares)...)
    return all_sharedcontexts
end

"""
From a collection of Route objects
Construct a namedtuple of (;target_namespace => SharedVars{origin_namespace, varnames, aliases},...)
"""
function resolve_routes(reg::NameSpaceRegistry, routes::Route...)
    if isempty(routes)
        return (;)
    end
    return map(route -> to_sharedvars(reg, route), routes)
end

"""
Set up an empty ProcessContext for a ComplexLoopAlgorithm with given shared specifications
"""
function ProcessContext(algos::ComplexLoopAlgorithm; globals = (;))
    registry = getregistry(algos)

    shared_specs = get_sharedspecs(algos)

    shares = filter(x -> x isa Share, shared_specs)
    routes = filter(x -> x isa Route, shared_specs)

    sharedcontexts = resolve_shares(registry, shares...)
    sharedvars = resolve_routes(registry, routes...)

    # Create Subcontexts from registry
    registered_names = all_names(registry)
    subcontexts = ntuple(length(registered_names)) do i
        algo_name = registered_names[i]
        SubContext(algo_name, (;), get(sharedvars, algo_name, ()), get(sharedcontexts, algo_name, ()))
    end
    named_subcontexts = NamedTuple{registered_names}(subcontexts)

    # Add globals
    named_subcontexts = (;named_subcontexts..., globals)
    return ProcessContext(named_subcontexts, registry)
end

function ProcessContext(func::Any; globals = (;))
    registry = SimpleRegistry(func)
    name = static_lookup(registry, func)
    subcontext = SubContext(name, (;), (;), (;))
    named_subcontexts = NamedTuple{(name,)}((subcontext,))
    (;named_subcontexts..., globals)
    return ProcessContext(named_subcontexts, registry)
end