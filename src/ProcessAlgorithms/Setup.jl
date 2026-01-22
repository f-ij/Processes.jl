
function setup(cla_target_type::Type{<:ComplexLoopAlgorithm},funcs::NTuple{N, Any}, 
                            specification_num::NTuple{N, Real} = ntuple(_ -> 1, N), 
                            shares_and_routes::Union{Share, Route}...; 
                            flags...) where {N}

    allfuncs = Any[]
    registry = NameSpaceRegistry()
    multipliers = getmultipliers_from_specification_num(cla_target_type, specification_num)

    for (func_idx, func) in enumerate(funcs)
        if func isa ComplexLoopAlgorithm # Deepcopy to make multiple instances independent
            func = deepcopy(func)
        else
            registry, namedfunc = add_instance(registry, func, multipliers[func_idx])
        end
        push!(allfuncs, namedfunc)
    end

    registry = inherit(registry, get_registry.(allfuncs)...; multipliers)
    allfuncs = update_loopalgorithm_names.(allfuncs, Ref(registry))

    functuple = tuple(allfuncs...)
    specification_num = tuple(floor.(Int, specification_num)...)

    flags = Set(flags...)

    routes = filter(x -> x isa Route, shares_and_routes)
    shares = filter(x -> x isa Share, shares_and_routes)

    shared_contexts = resolve_shares(registry, shares...)
    shared_vars = resolve_routes(registry, routes...)
    (;functuple, flags, registry, shared_contexts, shared_vars)
end
