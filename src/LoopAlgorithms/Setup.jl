
function setup(cla_target_type::Type{<:LoopAlgorithm},funcs::NTuple{N, Any}, 
                            specification_num::NTuple{N, Real} = ntuple(_ -> 1, N), 
                            options::AbstractOption...) where {N}

    allfuncs = Any[]
    registry = NameSpaceRegistry()
    multipliers = getmultipliers_from_specification_num(cla_target_type, specification_num)
    options_all = options

    for (func_idx, func) in enumerate(funcs)
        if func isa LoopAlgorithm # Deepcopy to make multiple instances independent
            func = deepcopy(func)
        else
            registry, func = add(registry, func, multipliers[func_idx])
        end
        push!(allfuncs, func)
    end

    registry = inherit(registry, getregistry.(allfuncs)...; multipliers)
    @DebugMode "Combined registry: $registry, after inheriting: $(getregistry.(allfuncs))"

    process_state = filter(x -> x isa ProcessState, options_all)
    registry = addall(registry, process_state)
    @DebugMode "Adding process state options: $process_state"
    @DebugMode "Final registry: $registry"

    # allfuncs = recursive_update_cla_names.(allfuncs, Ref(registry))
    allfuncs = update_names.(allfuncs, Ref(registry))
    # @show allfuncs

    functuple = tuple(allfuncs...)
    specification_num = tuple(floor.(Int, specification_num)...)

    # routes = filter(x -> x isa Route, options_all)
    # shares = filter(x -> x isa Share, options_all)
    # resolved_options = resolve_options(registry, options_all...)

    # shared_contexts = resolve_options(registry, shares...)
    # shared_vars = resolve_options(registry, routes...)
    (;functuple, registry, options)
end
