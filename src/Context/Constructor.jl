# """
# Set up an empty ProcessContext for a LoopAlgorithm with given shared specifications
# """
# function ProcessContext(la::LoopAlgorithm; globals = (;))
# # function ProcessContext(la::LoopAlgorithm)
#     registry = setup_registry(la)

#     @DebugMode "Creating ProcessContext for LoopAlgorithm with registry: $registry"
#     # shared_specs = get_sharedspecs(algos)
    
#     options = getoptions(la)
#     routes = typefilter(Route, options)
#     shares = typefilter(Share, options)

#     sharedvars = resolve_options(registry, routes...)
#     sharedcontexts = resolve_options(registry, shares...)

#     # sharedcontexts = filter(x -> x isa SubContext, resolved)
#     # sharedvars = filter(x -> x isa Route, resolved)

#     @DebugMode "Shares are: $shares" "Routes are: $routes"

#     # sharedcontexts = resolve_options(registry, shares...)
#     # sharedvars = resolve_options(registry, routes...)

#     @DebugMode "Resolved shared contexts: $sharedcontexts" "Resolved shared vars: $sharedvars"

#     # Create Subcontexts from registry
#     registered_keys = all_keys(registry)
#     @DebugMode "Registered names: $registered_keys"
#     subcontexts = ntuple(length(registered_keys)) do i
#         algo_name = registered_keys[i]
#         SubContext(algo_name, (;), get(sharedcontexts, algo_name, ()), get(sharedvars, algo_name, ()))
#     end

#     named_subcontexts = NamedTuple{registered_keys}(subcontexts)

#     @DebugMode "Created subcontexts: $named_subcontexts"

#     # Add globals
#     named_subcontexts = (;named_subcontexts..., globals)
#     return ProcessContext(named_subcontexts, registry)
# end


"""
Set up an empty ProcessContext for a LoopAlgorithm with given shared specifications
"""
function _build_process_context(registry, sharedcontexts, sharedvars; globals = (;))
    @DebugMode "Creating ProcessContext with registry: $registry"
    @DebugMode "Resolved shared contexts: $sharedcontexts" "Resolved shared vars: $sharedvars"

    # Create Subcontexts from registry
    registered_keys = all_keys(registry)
    @DebugMode "Registered names: $registered_keys"
    subcontexts = ntuple(length(registered_keys)) do i
        algo_name = registered_keys[i]
        SubContext(algo_name, (;), get(sharedcontexts, algo_name, ()), get(sharedvars, algo_name, ()))
    end

    named_subcontexts = NamedTuple{registered_keys}(subcontexts)

    @DebugMode "Created subcontexts: $named_subcontexts"

    # Add globals
    named_subcontexts = (;named_subcontexts..., globals)
    return ProcessContext(named_subcontexts, registry)
end

function ProcessContext(la::LoopAlgorithm; globals = (;))
    la = materialize(la)
    sharedcontexts, sharedvars = _resolve_materialized_links(la)
    return _build_process_context(
        getregistry(la),
        sharedcontexts,
        sharedvars;
        globals,
    )
end