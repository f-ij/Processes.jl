
export Input, Override

"""
User facing input
"""
struct Input{T,NT<:NamedTuple}
    target_algo::T
    vars::NT
end

"""
Backend input system, translated from user input through registry
"""
struct NamedInput{Name, NT}
    vars::NT
end

function Input(target_algo::T, pairs::Pair{Symbol,<:Any}...) where {T}
    nt = (;pairs...)
    Input{T, typeof(nt)}(target_algo, nt)
end

function NamedInput{Name}(vars::NT) where {Name, NT}
    NamedInput{Name, NT}(vars)
end

"""
Override an internal prepared arg in the context of a target algorithm
"""
struct Override{T,NT<:NamedTuple}
    target_algo::T
    vars::NT
end

struct NamedOverride{Name, NT}
    vars::NT
end

function Override(target_algo::T, pairs::Pair{Symbol,<:Any}...) where {T}
    nt = (;pairs...)
    Override{T, typeof(nt)}(target_algo, nt)
end

function NamedOverride{Name}(vars::NT) where {Name, NT}
    NamedOverride{Name, NT}(vars)
end

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

function to_named(reg::NameSpaceRegistry, ov::Union{Override, Input})
    name = getname(reg, get_target_algo(ov))
    return Named(typeof(ov), name, get_vars(ov))
end

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


# """
# Construct named tuples from overrides and inputs, optionally adding common variables to all
# """
# @inline function construct_context_merge_tuples(registry::NameSpaceRegistry, overrides_inputs::Union{Override, Input}...; to_all = (;)) 
#     names = map(o -> static_lookup(registry, get_target_algo(o)), overrides_inputs) # Get the names from the registry
#     vars = get_vars.(overrides_inputs) # Get the input variables
#     if !isempty(to_all) # Add common variables to all named tuples
#         for algo in registry # Add to_all to each named tuple
#             name = getname(algo)
#             vars = (;vars..., name => (;get(vars, name, (;))..., to_all...))
#         end
#     end
#     return NamedTuple{(names...)}(vars)
# end

@inline function Base.merge(context::ProcessContext, overrides_or_inputs::Union{NamedOverride, NamedInput}...; to_all = (;))
    if isempty(overrides_or_inputs)
        return context
    end
    # override_nt = construct_context_merge_tuples(context.registry, overrides_or_inputs...; to_all = to_all)
    override_nt = construct_context_merge_tuples(overrides_or_inputs...; to_all = to_all)
    merge_into_subcontexts(context, override_nt)
end
