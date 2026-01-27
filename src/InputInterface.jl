
abstract type InputInterface end

target_type(ii::InputInterface) = typeof(ii.target_algo)
change_target(ii::InputInterface, newtarget) = setfield(ii, :target_algo, newtarget)

export Input, Override

"""
User facing input
"""
struct Input{T,NT<:NamedTuple} <: InputInterface
    target_algo::T
    vars::NT
end

"""
Backend input system, translated from user input through registry
"""
struct NamedInput{Name, NT}
    vars::NT
end

function Input(target_algo::T, pairs::Pair{Symbol,<:Any}...; kwargs...) where {T}
    nt = (;pairs..., kwargs...)
    Input{T, typeof(nt)}(target_algo, nt)
end


function NamedInput{Name}(vars::NT) where {Name, NT}
    NamedInput{Name, NT}(vars)
end

"""
Override an internal prepared arg in the context of a target algorithm
"""
struct Override{T,NT<:NamedTuple} <: InputInterface
    target_algo::T
    vars::NT
end

struct NamedOverride{Name, NT}
    vars::NT
end

function Override(target_algo::T, pairs::Pair{Symbol,<:Any}...; kwargs...) where {T}
    nt = (;pairs..., kwargs...)
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

"""
If a ComplexLoopAlgorithm is given, duplicate the Override/Input for all contained algorithms
"""
function to_named(cla::ComplexLoopAlgorithm, ov::Union{Override, Input})
    if target_type(ov) <: ComplexLoopAlgorithm
        target_T = target_type(ov)
        reg = nothing
        if target_T <: typeof(cla)
            reg = get_registry(cla)
        else
            find_first_target = getfirst_node(x -> match_cla(target_T, typeof(x)), cla, unwrap = unwrap_cla)
            if isnothing(find_first_target)
                error("Target algorithm $(target_T) not found in ComplexLoopAlgorithm $(cla)")
            end
            reg = get_registry(find_first_target)
        end
        reg = get_registry(cla)
        # Duplicate for all in registry
        all_algos = all_named_algos(reg)
        # @show all_algos
        duplicates = change_target.(Ref(ov), all_algos)
        # @show duplicates
        return flat_collect_broadcast(duplicates) do dup
            to_named(reg, dup)
        end
    else
        # @show ov
        return ov
        reg = get_registry(cla)
        return to_named(reg, ov)
    end 
end

function to_named(reg::NameSpaceRegistry, ov::Union{Override, Input})
    name = getname(reg, get_target_algo(ov))
    return (Named(typeof(ov), name, get_vars(ov)),)
end

to_named(cla::ComplexLoopAlgorithm, ovs::Union{Override, Input}...) = flat_collect_broadcast(ovs) do ov
    to_named(cla, ov)
end

to_named(::ComplexLoopAlgorithm) = ()
to_named(::NameSpaceRegistry) = ()

"""

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
    override_nt = @inline construct_context_merge_tuples(overrides_or_inputs...; to_all = to_all)
    @inline merge_into_subcontexts(context, override_nt)
end



########################
### SHOWING ###
########################


@inline function _target_label(x)
    T = Base.unwrap_unionall(typeof(x))
    return string(nameof(T))
end

function Base.summary(io::IO, ov::Input)
    print(io, "Input(target=", _target_label(get_target_algo(ov)), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::Input)
    summary(io, ov)
end

function Base.summary(io::IO, ov::Override)
    print(io, "Override(target=", _target_label(get_target_algo(ov)), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::Override)
    summary(io, ov)
end

function Base.summary(io::IO, ov::NamedInput)
    print(io, "NamedInput(name=", get_target_name(ov), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::NamedInput)
    summary(io, ov)
end

function Base.summary(io::IO, ov::NamedOverride)
    print(io, "NamedOverride(name=", get_target_name(ov), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::NamedOverride)
    summary(io, ov)
end
