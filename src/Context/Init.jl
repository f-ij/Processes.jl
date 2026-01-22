"""
Set up an empty ProcessContext for a ComplexLoopAlgorithm with given shared specifications
"""
function ProcessContext(algos::ComplexLoopAlgorithm; globals = (;))
    registry = getregistry(algos)

    # shared_specs = get_sharedspecs(algos)

    # shares = filter(x -> x isa Share, shared_specs)
    # routes = filter(x -> x isa Route, shared_specs)

    # sharedcontexts = resolve_shares(registry, shares...)
    # sharedvars = resolve_routes(registry, routes...)



    shared_contexts = get_sharedcontexts(algos)
    shared_vars = get_sharedvars(algos)

    # Create Subcontexts from registry
    registered_names = all_names(registry)
    subcontexts = ntuple(length(registered_names)) do i
        algo_name = registered_names[i]
        SubContext(algo_name, (;), get(shared_contexts, algo_name, ()), get(shared_vars, algo_name, ()))
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
