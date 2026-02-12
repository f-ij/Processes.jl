
function Named(T::Type, name, vars::NT) where {NT}
    if T <: Override
        return NamedOverride{name, NT}(vars)
    elseif T <: Input
        return NamedInput{name, NT}(vars)
    else
        error("Type $T is not supported for Named")
    end
end

get_target_algo(ov::Union{Override, Input}) = ov.target_algo
get_vars(ov::Union{Override, Input}) = ov.vars

get_target_name(ov::Union{NamedOverride{N, NT}, NamedInput{N, NT}}) where {N, NT} = N
get_vars(ov::Union{NamedOverride, NamedInput}) = ov.vars

"""
If Overrides and inputs target a LoopAlgorithm, duplicate them for all contained algorithms
    Maybe this is not used anymore after the fusing system
"""
function to_named(cla::LoopAlgorithm, ov::Union{Override, Input})
    target_obj = get_target_algo(ov)
    return to_named(getregistry(cla), ov)

    # if target_type(ov) <: LoopAlgorithm
    #     target_T = target_type(ov)
    #     reg = nothing
    #     if target_T <: typeof(cla)
    #         reg = getregistry(cla)
    #     else
    #         # find_first_target = getfirst_node(x -> match_cla(target_T, typeof(x)), cla, unwrap = unwrap_cla)
    #         # if isnothing(find_first_target)
    #         #     error("Target algorithm $(target_T) not found in LoopAlgorithm $(cla)")
    #         # end
    #         # reg = getregistry(find_first_target)
    #     end
    #     reg = getregistry(cla)
    #     # Duplicate for all in registry
    #     all_algos = all_named_algos(reg)
    #     # @show all_algos
    #     duplicates = change_target.(Ref(ov), all_algos)
    #     # @show duplicates
    #     return flat_collect_broadcast(duplicates) do dup
    #         to_named(reg, dup)
    #     end
    # else
    #     # @show ov
    #     return ov
    #     reg = getregistry(cla)
    #     return to_named(reg, ov)
    # end 
end

to_named(reg::NameSpaceRegistry, ov::Union{Override, Input}...) = flat_collect_broadcast(ov) do o
    to_named(reg, o)
end

@inline function to_named(reg::NameSpaceRegistry, ov::Union{Override, Input})
    target_algo = get_target_algo(ov)
    key = static_findkey(reg, target_algo)
    if isnothing(key)
        error("Target algorithm $(target_algo) not found in registry: $reg \n Cannot convert to Named")
    end
    return (Named(typeof(ov), key, get_vars(ov)),)
end

to_named(cla::LoopAlgorithm, ovs::Union{Override, Input}...) = flat_collect_broadcast(ovs) do ov
    to_named(cla, ov)
end

"""
Teremination
"""
to_named(::Any) = ()

"""
From inputs and overrides construct NamedTuples for merging into ProcessContext
"""
@inline function construct_context_merge_tuples(named_overrides_inputs::Union{NamedOverride, NamedInput}...; to_all = (;)) 
    if isempty(named_overrides_inputs)
        return (;)
    end
    names = map(o -> get_target_name(o), named_overrides_inputs) # Get the names from the registry
    vars = get_vars.(named_overrides_inputs) # Get the input variables
    if !isempty(to_all) # Add common variables to all named tuples
        vars = merge.(vars, Ref(to_all))
    end
    return NamedTuple{tuple(names...)}(vars)
end

"""
Merge NamedOverrides and NamedInputs into a ProcessContext
"""
@inline function Base.merge(context::ProcessContext, overrides_or_inputs::Union{NamedOverride, NamedInput}...; to_all = (;))
    if isempty(overrides_or_inputs)
        return context
    end
    # override_nt = construct_context_merge_tuples(context.registry, overrides_or_inputs...; to_all = to_all)
    override_nt = @inline construct_context_merge_tuples(overrides_or_inputs...; to_all = to_all)
    @inline merge_into_subcontexts(context, override_nt)
end
