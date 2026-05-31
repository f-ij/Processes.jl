"""
Context view used by resolve-time step factories.

`OnDemandContext` contains only the variables visible to one generated child
step. The resolved wiring and namespace decide where returned values are merged.
"""
struct OnDemandContext{Variables, Locations, W, I, G, A, N} <: AbstractContext
    variables::Variables
    locations::Locations
    wiring::W
    input::I
    globals::G
    algorithm::A
    namespace::N
end

"""
Small context-like wrapper used for lifetime checks over active subcontexts.
"""
struct SubcontextsContext{Subcontexts, I} <: AbstractContext
    subcontexts::Subcontexts
    input::I
end

@inline get_variables(context::OnDemandContext) = getfield(context, :variables)
@inline get_locations(context::OnDemandContext) = getfield(context, :locations)
@inline getruntimeinput(context::OnDemandContext) = getfield(context, :input)
@inline getglobals(context::OnDemandContext) = getfield(context, :globals)
@inline get_subcontexts(context::SubcontextsContext) = getfield(context, :subcontexts)
@inline getruntimeinput(context::SubcontextsContext) = getfield(context, :input)

@inline _step_varaliases(::Type{A}) where {A} = A <: AbstractIdentifiableAlgo ? varaliases(A) : VarAliases()

"""Return the local namespace name carried by a child namespace."""
_namespace_names(::Type{<:Namespace{Name}}) where {Name} = Name isa Symbol ? (Name,) : ()
_namespace_names(namespace::Namespace) = _namespace_names(typeof(namespace))

"""Select a statically named subset of a subcontext `NamedTuple`."""
@inline @generated function select_subcontexts(subcontexts::NT, ::Val{Names}) where {NT<:NamedTuple, Names}
    exprs = Any[]
    for name in Names
        push!(exprs, :(getproperty(subcontexts, $(QuoteNode(name)))))
    end
    return :(NamedTuple{$Names}(($(exprs...),)))
end

"""Merge returned active subcontexts back into the full context subcontext tuple."""
@inline function merge_subcontexts_by_name(all_subcontexts::A, returned_subcontexts::R) where {A<:NamedTuple, R<:NamedTuple}
    return merge(all_subcontexts, returned_subcontexts)
end

"""Build a small context for lifetime conditions from active subcontexts."""
@inline break_context_from_subcontexts(subcontexts::S, inputs::I) where {S<:NamedTuple, I<:NamedTuple} =
    SubcontextsContext(subcontexts, inputs)

@inline function Base.getproperty(context::SubcontextsContext, name::Symbol)
    if name === :subcontexts || name === :input
        return getfield(context, name)
    end
    subcontexts = get_subcontexts(context)
    if haskey(subcontexts, name)
        return getproperty(subcontexts, name)
    end
    input = getruntimeinput(context)
    if haskey(input, name)
        return getproperty(input, name)
    end
    error("Variable $(name) is not available in the generated subcontext break-condition view.")
end

"""Resolve a `Var` entity selector to one active subcontext key."""
@inline _subcontext_key_for_entity(::Type{Subcontexts}, entity::Symbol) where {Subcontexts<:NamedTuple} = entity

function _subcontext_key_for_entity(::Type{Subcontexts}, ::Type{Entity}) where {Subcontexts<:NamedTuple, Entity}
    subcontext_names = fieldnames(Subcontexts)
    exact_name = Symbol(nameof(Entity))
    exact_name in subcontext_names && return exact_name
    keyed_prefix = string(nameof(Entity), "_")
    matches = filter(subcontext_name -> startswith(String(subcontext_name), keyed_prefix), subcontext_names)
    length(matches) == 1 && return only(matches)
    isempty(matches) && error("No active subcontext found for selector $(Entity). Available subcontexts are $(subcontext_names).")
    error("Selector $(Entity) matches multiple active subcontexts $(Tuple(matches)); use a resolved namespace selector.")
end

@inline Base.getindex(context::SubcontextsContext{Subcontexts}, var::Var{Entity, name}) where {Subcontexts, Entity, name} =
    getproperty(getproperty(get_subcontexts(context), _subcontext_key_for_entity(Subcontexts, Entity)), name)
@inline Base.getindex(context::SubcontextsContext, var::Var{:_input, name}) where {name} =
    getproperty(getruntimeinput(context), name)
@inline Base.getindex(context::SubcontextsContext, vars::Var...) =
    ntuple(i -> getindex(context, vars[i]), length(vars))

"""Return local variable names available in the on-demand local subcontext."""
function _on_demand_local_locations(::Type{Subcontexts}, ::Type{N}) where {Subcontexts<:NamedTuple, N<:Namespace}
    namespace = N
    names = _namespace_names(namespace)
    isempty(names) && return (;)
    subcontext_name = first(names)
    subcontext_name in fieldnames(Subcontexts) || return (;)
    subcontext_type = fieldtype(Subcontexts, subcontext_name)
    local_varnames = keys(subcontext_type)
    locations = ntuple(i -> VarLocation{:local}(subcontext_name, local_varnames[i]), length(local_varnames))
    return NamedTuple{local_varnames}(locations)
end

"""Return shared variable locations available in an on-demand child context."""
function _on_demand_shared_locations(::Type{Subcontexts}, ::Type{W}) where {Subcontexts<:NamedTuple, W<:Wiring}
    shared_context_names = contextname.(shares(W()))
    return named_flat_collect_broadcast(shared_context_names) do name
        name isa Symbol || return (;)
        name in fieldnames(Subcontexts) || return (;)
        shared_subcontext_type = fieldtype(Subcontexts, name)
        shared_varnames = keys(shared_subcontext_type)
        pairs = (shared_varnames[i] => VarLocation{:subcontext}(name, shared_varnames[i]) for i in 1:length(shared_varnames))
        return NamedTuple(pairs)
    end
end

"""Return routed variable locations available in an on-demand child context."""
function _on_demand_routed_locations(::Type{W}) where {W<:Wiring}
    return named_flat_collect_broadcast(routes(W())) do route
        fromname = get_fromname(route)
        _localnames = localnames(route)
        _subvarcontextnames = subvarcontextnames(route)
        _transform = gettransform(route)
        location_type = fromname == :_runtime ? :runtime : fromname == :_input ? :input : :subcontext
        pairs = (_localnames[i] => VarLocation{location_type}(fromname, _subvarcontextnames[i], _transform) for i in 1:length(_localnames))
        return NamedTuple(pairs)
    end
end

"""Return all readable and writable variable locations for an on-demand context."""
function _on_demand_locations(::Type{Subcontexts}, ::Type{W}, ::Type{N}) where {Subcontexts<:NamedTuple, W<:Wiring, N<:Namespace}
    return (; _on_demand_shared_locations(Subcontexts, W)..., _on_demand_routed_locations(W)..., _on_demand_local_locations(Subcontexts, N)...)
end

"""Return singleton values from a locations `NamedTuple` type."""
function _on_demand_locations_from_type(::Type{L}) where {L<:NamedTuple}
    names = fieldnames(L)
    values = ntuple(i -> fieldtype(L, i)(), fieldcount(L))
    return NamedTuple{names}(values)
end

"""Return location metadata for the variables visible to one child step."""
@inline @generated function on_demand_locations(subcontexts::S, wiring::W, algorithm::A, namespace::N) where {S<:NamedTuple, W<:Wiring, A, N<:Namespace}
    locations = _on_demand_locations(S, W, N)
    return :($locations)
end

"""Return a value expression that reads one variable location from live sources."""
function _on_demand_variable_value_expr(vl)
    target_subcontext = get_subcontextname(vl)
    target_variables = get_originalname(vl)
    varnames = target_variables isa Tuple ? target_variables : (target_variables,)
    value_exprs = if target_subcontext === :_runtime
        [:(getproperty(globals, $(QuoteNode(varname)))) for varname in varnames]
    elseif target_subcontext === :_input
        [:(getproperty(inputs, $(QuoteNode(varname)))) for varname in varnames]
    else
        [:(getproperty(getproperty(subcontexts, $(QuoteNode(target_subcontext))), $(QuoteNode(varname)))) for varname in varnames]
    end
    return funcexpr(vl, value_exprs...)
end

"""Flatten child-visible subcontext variables into an algorithm-facing tuple."""
@inline @generated function on_demand_variables(subcontexts::S, locations::L, inputs::I, globals::G) where {S<:NamedTuple, L<:NamedTuple, I<:NamedTuple, G}
    location_values = _on_demand_locations_from_type(L)
    names = fieldnames(L)
    values = Any[_on_demand_variable_value_expr(getfield(location_values, i)) for i in eachindex(names)]
    return :(NamedTuple{$names}(($(values...),)))
end

"""Return all readable and writable variable locations for an on-demand context."""
function _on_demand_locations(::Type{ODC}) where {ODC<:OnDemandContext}
    return _on_demand_locations_from_type(ODC.parameters[2])
end

"""Resolve one algorithm-visible name to its on-demand storage location."""
function _on_demand_location(::Type{ODC}, name::Symbol) where {ODC<:OnDemandContext}
    aliases = _step_varaliases(ODC.parameters[6])
    subcontext_name = algo_to_subcontext_names(aliases, name)
    locations = _on_demand_locations(ODC)
    hasproperty(locations, subcontext_name) && return getproperty(locations, subcontext_name), subcontext_name
    return nothing, subcontext_name
end

"""Return the on-demand variable names that store one resolved location."""
function _on_demand_names_for_location(::Type{ODC}, ::Type{VL}) where {ODC<:OnDemandContext, VL<:VarLocation}
    Locations = ODC.parameters[2]
    names = fieldnames(Locations)
    matches = Symbol[]
    for name in names
        fieldtype(Locations, name) === VL && push!(matches, name)
    end
    isempty(matches) && error("Location $(VL) is not available in this on-demand context. Available names are $(names).")
    return Tuple(matches)
end

@inline function Base.getproperty(context::OnDemandContext, name::Symbol)
    if name === :variables || name === :locations || name === :wiring || name === :input || name === :globals || name === :algorithm || name === :namespace
        return getfield(context, name)
    end
    return getproperty(context, Val(name))
end

@inline @generated function Base.haskey(context::ODC, ::Val{name}) where {ODC<:OnDemandContext, name}
    Variables = ODC.parameters[1]
    has_input = name in fieldnames(ODC.parameters[4])
    return :($( name in fieldnames(Variables) || has_input ))
end

@inline Base.haskey(context::OnDemandContext, name::Symbol) = haskey(context, Val(name))

@inline function Base.get(context::OnDemandContext, name::Symbol, default)
    return haskey(context, name) ? getproperty(context, name) : default
end

@inline @generated function Base.getproperty(context::ODC, ::Val{name}) where {ODC<:OnDemandContext, name}
    Variables = ODC.parameters[1]
    if name in fieldnames(Variables)
        return quote
            return @inline getproperty(get_variables(context), $(QuoteNode(name)))
        end
    end
    if name in fieldnames(ODC.parameters[4])
        return quote
            return @inline getproperty(getruntimeinput(context), $(QuoteNode(name)))
        end
    end
    available = (fieldnames(Variables)..., fieldnames(ODC.parameters[4])...)
    return :(error("Variable $(name) requested from on-demand context, but it is not available. Available names are $available."))
end

@inline @generated function Base.getproperty(context::ODC, vl::VL) where {ODC<:OnDemandContext, VL<:Union{VarLocation{:subcontext}, VarLocation{:local}, VarLocation{:input}, VarLocation{:runtime}}}
    variable_names = _on_demand_names_for_location(ODC, VL)
    if length(variable_names) == 1
        variable_name = only(variable_names)
        return quote
            return @inline getproperty(get_variables(context), $(QuoteNode(variable_name)))
        end
    end

    value_exprs = [:(getproperty(get_variables(context), $(QuoteNode(variable_names[i])))) for i in eachindex(variable_names)]
    return :(return ($(value_exprs...),))
end

@inline Base.propertynames(context::OnDemandContext) = (fieldnames(typeof(get_variables(context)))..., fieldnames(typeof(getruntimeinput(context)))...)
@inline Base.keys(context::OnDemandContext) = propertynames(context)

@inline merge_by_wiring(context::OnDemandContext, ::Nothing) =
    (; globals = getglobals(context))

"""Return globals with temporary runtime outputs produced inside an on-demand step."""
@inline function merge_ondemand_runtime(context::ODC, patch::P) where {ODC<:OnDemandContext, P<:NamedTuple}
    return merge(getglobals(context), patch)
end

"""Return whether unlocated child return values should be written to runtime state."""
@inline _merge_unlocated_returns_to_runtime(::Type{T}) where {T} = nameof(T) === :FuncWrapper

"""Merge a child `step!` return into the subcontexts available to that child."""
@inline @generated function merge_by_wiring(context::ODC, retval::R) where {ODC<:OnDemandContext, R<:NamedTuple}
    A = ODC.parameters[6]
    local_names = _namespace_names(ODC.parameters[7])
    isempty(local_names) && error("Generated concrete child step needs a resolved namespace for local return values.")
    local_subcontext = first(local_names)

    updates = Dict{Symbol, Vector{Expr}}()
    runtime_fields = Expr[]
    for retval_name in fieldnames(R)
        location, subcontext_name = _on_demand_location(ODC, retval_name)
        target_subcontext = isnothing(location) ? local_subcontext : get_subcontextname(location)
        target_variable = isnothing(location) ? subcontext_name : get_originalname(location)
        target_variable isa Symbol || error("Algorithm returned $(retval_name), which maps to multiple target variables $(target_variable). Inverse transform merges are not supported.")
        if target_subcontext == :_runtime || (isnothing(location) && _merge_unlocated_returns_to_runtime(A))
            push!(runtime_fields, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
            continue
        end
        exprs = get!(updates, target_subcontext, Expr[])
        push!(exprs, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
    end

    merge_exprs = Any[
        :(_globals = @inline getglobals(context)),
    ]
    if !isempty(runtime_fields)
        runtime_patch_expr = Expr(:tuple, Expr(:parameters, runtime_fields...))
        push!(merge_exprs, :(_globals = @inline merge_ondemand_runtime(context, $runtime_patch_expr)))
    end
    return_fields = Expr[]
    for subcontext_name in sort!(collect(keys(updates)); by = string)
        fields = updates[subcontext_name]
        patch_expr = Expr(:tuple, Expr(:parameters, fields...))
        push!(return_fields, Expr(:(=), subcontext_name, patch_expr))
    end
    push!(merge_exprs, :(return (; globals = _globals, $(return_fields...))))
    return Expr(:block, merge_exprs...)
end
