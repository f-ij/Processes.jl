"""
A named override or input is an entity that has a name and associated variables.

It specifies variables with names and values that target a namespace
They are resolved versions of Inputs and Overrides

The resolver will take an Override or Input that either targets a namespace directly, or an ProcessEntity
and resolve it to a NamedOverride or NamedInput with the name of the target namespace and the variables
"""
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
function resolve(cla::LoopAlgorithm, ov::Union{Override, Input})
    target_obj = get_target_algo(ov)
    return resolve(getregistry(cla), ov)
end

resolve(reg::NameSpaceRegistry, ov::Union{Override, Input}...) = flat_collect_broadcast(ov) do o
    resolve(reg, o)
end

@inline function resolve(reg::NameSpaceRegistry, ov::Union{Override, Input})
    target_algo = get_target_algo(ov)
    if target_algo isa Symbol
        @assert haskey(reg, target_algo) "Target algorithm $(target_algo) not found in registry: $reg \n Cannot convert to Named"
        return (Named(typeof(ov), target_algo, get_vars(ov)),)
    elseif target_algo isa Tuple #i.e. multiple targets for same variables
        duplicated_ovs = map(t -> typeof(ov)(t, get_vars(ov)), target_algo)
        return resolve(reg, duplicated_ovs...)
    end

    key = static_findkey(reg, target_algo)
    if isnothing(key)
        error("Target algorithm $(target_algo) not found in registry: $reg \n Cannot convert to Named")
    end
    return (Named(typeof(ov), key, get_vars(ov)),)
end

resolve(cla::LoopAlgorithm, ovs::Union{Override, Input}...) = flat_collect_broadcast(ovs) do ov
    resolve(cla, ov)
end

"""
Termination
"""
resolve(::Any) = ()

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
