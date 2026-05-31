"""
Context view used by resolve-time step factories.

`OnDemandContext` contains only the subcontexts passed to one generated child
step. The resolved wiring and namespace decide which variables the algorithm can
read and where returned values are merged.
"""
struct OnDemandContext{Subcontexts, W, I, G, A, N} <: AbstractContext
    subcontexts::Subcontexts
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

@inline get_subcontexts(context::OnDemandContext) = getfield(context, :subcontexts)
@inline getruntimeinput(context::OnDemandContext) = getfield(context, :input)
@inline _runtime_value(runtime) = runtime
@inline _runtime_value(runtime::Base.RefValue) = runtime[]
@inline getglobals(context::OnDemandContext) = _runtime_value(getfield(context, :globals))
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
function _on_demand_local_locations(::Type{ODC}) where {ODC<:OnDemandContext}
    Subcontexts = ODC.parameters[1]
    namespace = ODC.parameters[6]
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
function _on_demand_shared_locations(::Type{ODC}) where {ODC<:OnDemandContext}
    Subcontexts = ODC.parameters[1]
    W = ODC.parameters[2]
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
function _on_demand_routed_locations(::Type{ODC}) where {ODC<:OnDemandContext}
    W = ODC.parameters[2]
    return named_flat_collect_broadcast(routes(W())) do route
        fromname = get_fromname(route)
        _localnames = localnames(route)
        _subvarcontextnames = subvarcontextnames(route)
        _transform = gettransform(route)
        location_type = fromname == :_runtime ? :runtime : :subcontext
        pairs = (_localnames[i] => VarLocation{location_type}(fromname, _subvarcontextnames[i], _transform) for i in 1:length(_localnames))
        return NamedTuple(pairs)
    end
end

"""Return all readable and writable variable locations for an on-demand context."""
function _on_demand_locations(::Type{ODC}) where {ODC<:OnDemandContext}
    return (; _on_demand_shared_locations(ODC)..., _on_demand_routed_locations(ODC)..., _on_demand_local_locations(ODC)...)
end

"""Resolve one algorithm-visible name to its on-demand storage location."""
function _on_demand_location(::Type{ODC}, name::Symbol) where {ODC<:OnDemandContext}
    aliases = _step_varaliases(ODC.parameters[5])
    subcontext_name = algo_to_subcontext_names(aliases, name)
    locations = _on_demand_locations(ODC)
    hasproperty(locations, subcontext_name) && return getproperty(locations, subcontext_name), subcontext_name
    return nothing, subcontext_name
end

@inline function Base.getproperty(context::OnDemandContext, name::Symbol)
    if name === :subcontexts || name === :wiring || name === :input || name === :globals || name === :algorithm || name === :namespace
        return getfield(context, name)
    end
    return getproperty(context, Val(name))
end

@inline @generated function Base.haskey(context::ODC, ::Val{name}) where {ODC<:OnDemandContext, name}
    location, _ = _on_demand_location(ODC, name)
    has_input = name in fieldnames(ODC.parameters[3])
    return :($( !isnothing(location) || has_input ))
end

@inline Base.haskey(context::OnDemandContext, name::Symbol) = haskey(context, Val(name))

@inline function Base.get(context::OnDemandContext, name::Symbol, default)
    return haskey(context, name) ? getproperty(context, name) : default
end

@inline @generated function Base.getproperty(context::ODC, ::Val{name}) where {ODC<:OnDemandContext, name}
    location, _ = _on_demand_location(ODC, name)
    if !isnothing(location)
        return quote
            return @inline getproperty(context, $location)
        end
    end
    if name in fieldnames(ODC.parameters[3])
        return quote
            return @inline getproperty(getruntimeinput(context), $(QuoteNode(name)))
        end
    end
    available = (keys(_on_demand_locations(ODC))..., fieldnames(ODC.parameters[3])...)
    return :(error("Variable $(name) requested from on-demand context, but it is not available. Available names are $available."))
end

@inline @generated function Base.getproperty(context::ODC, vl::Union{VarLocation{:subcontext}, VarLocation{:local}}) where {ODC<:OnDemandContext}
    target_subcontext = get_subcontextname(vl)
    target_variable = get_originalname(vl)
    if isnothing(getfunc(vl)) && target_variable isa Symbol
        if target_subcontext === :_input
            return quote
                return @inline getproperty(getruntimeinput(context), $(QuoteNode(target_variable)))
            end
        end
        return quote
            subcontext = @inline getproperty(get_subcontexts(context), $(QuoteNode(target_subcontext)))
            return @inline getproperty(subcontext, $(QuoteNode(target_variable)))
        end
    end

    varnames = target_variable isa Tuple ? target_variable : (target_variable,)
    varsymbols = ntuple(i -> gensym(:var), length(varnames))
    assign_exprs = if target_subcontext === :_input
        [ :($(varsymbols[i]) = @inline getproperty(getruntimeinput(context), $(QuoteNode(varnames[i])))) for i in eachindex(varnames) ]
    else
        [ :($(varsymbols[i]) = @inline getproperty(getproperty(get_subcontexts(context), $(QuoteNode(target_subcontext))), $(QuoteNode(varnames[i])))) for i in eachindex(varnames) ]
    end
    fexpr = funcexpr(vl, varsymbols...)
    return quote
        $(assign_exprs...)
        return $fexpr
    end
end

@inline @generated function Base.getproperty(context::ODC, vl::VarLocation{:runtime}) where {ODC<:OnDemandContext}
    target_variables = get_originalname(vl)
    if isnothing(getfunc(vl)) && target_variables isa Symbol
        return quote
            return @inline getproperty(getglobals(context), $(QuoteNode(target_variables)))
        end
    end

    varnames = target_variables isa Tuple ? target_variables : (target_variables,)
    varsymbols = ntuple(i -> gensym(:runtime_var), length(varnames))
    assign_exprs = [ :($(varsymbols[i]) = @inline getproperty(getglobals(context), $(QuoteNode(varnames[i])))) for i in eachindex(varnames) ]
    fexpr = funcexpr(vl, varsymbols...)
    return quote
        $(assign_exprs...)
        return $fexpr
    end
end

@inline Base.propertynames(context::OnDemandContext) = (keys(_on_demand_locations(typeof(context)))..., fieldnames(typeof(getruntimeinput(context)))...)
@inline Base.keys(context::OnDemandContext) = propertynames(context)

@inline merge_by_wiring(context::OnDemandContext, ::Nothing) = get_subcontexts(context)

"""Merge temporary runtime outputs produced inside an on-demand step."""
@inline function merge_ondemand_runtime!(context::OnDemandContext, patch::NamedTuple)
    runtime = getfield(context, :globals)
    runtime isa Base.RefValue || error("On-demand runtime writes require a runtime Ref.")
    runtime[] = merge(runtime[], patch)
    return nothing
end

"""Return whether unlocated child return values should be written to runtime state."""
@inline _merge_unlocated_returns_to_runtime(::Type{T}) where {T} = nameof(T) === :FuncWrapper

"""Merge a child `step!` return into the subcontexts available to that child."""
@inline @generated function merge_by_wiring(context::ODC, retval::R) where {ODC<:OnDemandContext, R<:NamedTuple}
    Subcontexts = ODC.parameters[1]
    A = ODC.parameters[5]
    local_names = _namespace_names(ODC.parameters[6])
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
        target_subcontext in fieldnames(Subcontexts) || error("Generated step tried to merge into unavailable subcontext $(target_subcontext). Available subcontexts are $(fieldnames(Subcontexts)).")
        exprs = get!(updates, target_subcontext, Expr[])
        push!(exprs, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
    end

    merge_exprs = Any[:(_subcontexts = @inline get_subcontexts(context))]
    if !isempty(runtime_fields)
        runtime_patch_expr = Expr(:tuple, Expr(:parameters, runtime_fields...))
        push!(merge_exprs, :(@inline merge_ondemand_runtime!(context, $runtime_patch_expr)))
    end
    for (subcontext_name, fields) in updates
        patch_expr = Expr(:tuple, Expr(:parameters, fields...))
        push!(merge_exprs, quote
            _old_subcontext = @inline getproperty(_subcontexts, $(QuoteNode(subcontext_name)))
            _new_subcontext = @inline merge(_old_subcontext, $patch_expr)
            _subcontexts = @inline replace_namedtuple_field(_subcontexts, Val($(QuoteNode(subcontext_name))), _new_subcontext)
        end)
    end
    push!(merge_exprs, :(return _subcontexts))
    return Expr(:block, merge_exprs...)
end
