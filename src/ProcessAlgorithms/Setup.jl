
function setup(cla_target_type::Type{<:ComplexLoopAlgorithm},funcs::NTuple{N, Any}, 
                            specification_num::NTuple{N, Real} = ntuple(_ -> 1, N), 
                            options::AbstractOption...) where {N}

    allfuncs = Any[]
    registry = NameSpaceRegistry()
    multipliers = getmultipliers_from_specification_num(cla_target_type, specification_num)
    options_all = options

    for (func_idx, func) in enumerate(funcs)
        if func isa ComplexLoopAlgorithm # Deepcopy to make multiple instances independent
            func = deepcopy(func)
        else
            registry, func = add_instance(registry, func, multipliers[func_idx])
        end
        push!(allfuncs, func)
    end


    registry = inherit(registry, get_registry.(allfuncs)...; multipliers)

    process_state = filter(x -> x isa ProcessState, options_all)
    registry = add(registry, process_state...)

    allfuncs = recursive_update_cla_names.(allfuncs, Ref(registry))

    functuple = tuple(allfuncs...)
    specification_num = tuple(floor.(Int, specification_num)...)

    # routes = filter(x -> x isa Route, options_all)
    # shares = filter(x -> x isa Share, options_all)
    # resolved_options = resolve_options(registry, options_all...)

    # shared_contexts = resolve_options(registry, shares...)
    # shared_vars = resolve_options(registry, routes...)
    (;functuple, registry, options)
end
