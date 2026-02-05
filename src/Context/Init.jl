"""
Set up an empty ProcessContext for a LoopAlgorithm with given shared specifications
"""
function ProcessContext(algos::LoopAlgorithm; globals = (;))
    registry = getregistry(algos)

    # shared_specs = get_sharedspecs(algos)

    # shares = filter(x -> x isa Share, shared_specs)
    # routes = filter(x -> x isa Route, shared_specs)
    shares = get_shares(algos)
    routes = get_routes(algos)

    @DebugMode "Shares are: $shares" "Routes are: $routes"

    sharedcontexts = resolve_options(registry, shares...)
    sharedvars = resolve_options(registry, routes...)

    @DebugMode "Resolved shared contexts: $sharedcontexts" "Resolved shared vars: $sharedvars"

    # Create Subcontexts from registry
    registered_names = all_names(registry)
    subcontexts = ntuple(length(registered_names)) do i
        algo_name = registered_names[i]
        SubContext(algo_name, (;), get(sharedcontexts, algo_name, ()), get(sharedvars, algo_name, ()))
    end

    named_subcontexts = NamedTuple{registered_names}(subcontexts)

    @DebugMode "Created subcontexts: $named_subcontexts"

    # Add globals
    named_subcontexts = (;named_subcontexts..., globals)
    return ProcessContext(named_subcontexts, registry)
end

function ProcessContext(func::Any; globals = (;))
    registry = SimpleRegistry(func)
    name = getkey(static_get(registry, func))
    subcontext = SubContext(name, (;), (;), (;))
    named_subcontexts = NamedTuple{(name,)}((subcontext,))
    (;named_subcontexts..., globals)
    return ProcessContext(named_subcontexts, registry)
end
