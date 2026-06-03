"""
Context slice used by generated step factories.

`ContextSlice` contains only the variables visible to one generated child
step. The resolved wiring and namespace decide where returned values are merged.
"""
struct ContextSlice{Variables, Locations, W, I, G, A, N} <: AbstractContext
    variables::Variables
    input::I
    globals::G
end

"""Construct a context slice while keeping routing metadata in the type."""
@inline function ContextSlice(variables::Variables, locations::Locations, wiring::W, input::I, globals::G, algorithm::A, namespace::N) where {Variables, Locations, W, I, G, A, N}
    return ContextSlice{Variables, Locations, W, I, G, A, N}(variables, input, globals)
end

"""Construct a context slice when generated code already knows the location type."""
@inline function ContextSlice(variables::Variables, ::Type{Locations}, wiring::W, input::I, globals::G, algorithm::A, namespace::N) where {Variables, Locations, W, I, G, A, N}
    return ContextSlice{Variables, Locations, W, I, G, A, N}(variables, input, globals)
end

"""Backward-compatible name for `ContextSlice`."""
const OnDemandContext = ContextSlice

"""
Small context-like wrapper used for lifetime checks over active subcontexts.
"""
struct SubcontextsContext{Subcontexts, I, G} <: AbstractContext
    subcontexts::Subcontexts
    input::I
    globals::G
end

@inline get_variables(context::ContextSlice) = getfield(context, :variables)
@inline get_locations(context::CS) where {CS<:ContextSlice} =
    _context_slice_locations_from_type(CS.parameters[2])
@inline getruntimeinput(context::ContextSlice) = getfield(context, :input)
@inline getglobals(context::ContextSlice) = getfield(context, :globals)
@inline get_subcontexts(context::SubcontextsContext) = getfield(context, :subcontexts)
@inline getruntimeinput(context::SubcontextsContext) = getfield(context, :input)
@inline getglobals(context::SubcontextsContext) = getfield(context, :globals)

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
@inline break_context_from_subcontexts(subcontexts::S, inputs::I, globals::G = (;)) where {S<:NamedTuple, I<:NamedTuple, G} =
    SubcontextsContext(subcontexts, inputs, globals)

@inline function Base.getproperty(context::SubcontextsContext, name::Symbol)
    if name === :subcontexts || name === :input || name === :globals
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

@inline Base.getindex(context::SubcontextsContext, name::Symbol) =
    name === :globals || name === :_runtime ? getglobals(context) :
    name === :_input ? getruntimeinput(context) :
    getproperty(context, name)

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
@inline Base.getindex(context::SubcontextsContext, var::Var{:globals, name}) where {name} =
    getproperty(getglobals(context), name)
@inline Base.getindex(context::SubcontextsContext, var::Var{:_runtime, name}) where {name} =
    getproperty(getglobals(context), name)
@inline Base.getindex(context::SubcontextsContext, vars::Var...) =
    ntuple(i -> getindex(context, vars[i]), length(vars))

"""Return local variable names available in the context-slice local subcontext."""
function _context_slice_local_locations(::Type{Subcontexts}, ::Type{N}) where {Subcontexts<:NamedTuple, N<:Namespace}
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

"""Return shared variable locations available in a context slice."""
function _context_slice_shared_locations(::Type{Subcontexts}, ::Type{W}) where {Subcontexts<:NamedTuple, W<:Wiring}
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

"""Return routed variable locations available in a context slice."""
function _context_slice_routed_locations(::Type{W}) where {W<:Wiring}
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

"""Return all readable and writable variable locations for a context slice."""
function _context_slice_locations(::Type{Subcontexts}, ::Type{W}, ::Type{N}) where {Subcontexts<:NamedTuple, W<:Wiring, N<:Namespace}
    return (; _context_slice_shared_locations(Subcontexts, W)..., _context_slice_routed_locations(W)..., _context_slice_local_locations(Subcontexts, N)...)
end

"""Return singleton values from a locations `NamedTuple` type."""
function _context_slice_locations_from_type(::Type{L}) where {L<:NamedTuple}
    names = fieldnames(L)
    values = ntuple(i -> fieldtype(L, i)(), fieldcount(L))
    return NamedTuple{names}(values)
end

"""Return location metadata for the variables visible to one child step."""
@inline @generated function context_slice_locations(subcontexts::S, wiring::W, algorithm::A, namespace::N) where {S<:NamedTuple, W<:Wiring, A, N<:Namespace}
    locations = _context_slice_locations(S, W, N)
    return :($locations)
end

"""Return a value expression that reads one variable location from live sources."""
function _context_slice_variable_value_expr(vl)
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
@inline @generated function context_slice_variables(subcontexts::S, locations::L, inputs::I, globals::G) where {S<:NamedTuple, L<:NamedTuple, I<:NamedTuple, G}
    location_values = _context_slice_locations_from_type(L)
    names = fieldnames(L)
    values = Any[_context_slice_variable_value_expr(getfield(location_values, i)) for i in eachindex(names)]
    return :(NamedTuple{$names}(($(values...),)))
end

"""Return all readable and writable variable locations for a context slice."""
function _context_slice_locations(::Type{CS}) where {CS<:ContextSlice}
    return _context_slice_locations_from_type(CS.parameters[2])
end

"""Resolve one algorithm-visible name to its context-slice storage location."""
function _context_slice_location(::Type{CS}, name::Symbol) where {CS<:ContextSlice}
    aliases = _step_varaliases(CS.parameters[6])
    subcontext_name = algo_to_subcontext_names(aliases, name)
    locations = _context_slice_locations(CS)
    hasproperty(locations, subcontext_name) && return getproperty(locations, subcontext_name), subcontext_name
    return nothing, subcontext_name
end

"""Return the context-slice variable names that store one resolved location."""
function _context_slice_names_for_location(::Type{CS}, ::Type{VL}) where {CS<:ContextSlice, VL<:VarLocation}
    Locations = CS.parameters[2]
    names = fieldnames(Locations)
    matches = Symbol[]
    for name in names
        fieldtype(Locations, name) === VL && push!(matches, name)
    end
    isempty(matches) && error("Location $(VL) is not available in this context slice. Available names are $(names).")
    return Tuple(matches)
end

Base.@constprop :aggressive @inline Base.getproperty(context::CS, name::Symbol) where {CS<:ContextSlice} =
    getproperty(context, Val(name))

@inline @generated function Base.haskey(context::CS, ::Val{name}) where {CS<:ContextSlice, name}
    Variables = CS.parameters[1]
    has_input = name in fieldnames(CS.parameters[4])
    return :($( name in fieldnames(Variables) || has_input ))
end

@inline Base.haskey(context::ContextSlice, name::Symbol) = haskey(context, Val(name))

@inline function Base.get(context::ContextSlice, name::Symbol, default)
    return haskey(context, name) ? getproperty(context, name) : default
end

@inline @generated function Base.getproperty(context::CS, ::Val{name}) where {CS<:ContextSlice, name}
    name === :variables && return :(return getfield(context, :variables))
    name === :input && return :(return getfield(context, :input))
    name === :globals && return :(return getfield(context, :globals))
    name === :locations && return :(return _context_slice_locations_from_type($(CS.parameters[2])))
    name === :wiring && return :(return $(CS.parameters[3])())
    name === :algorithm && return :(return $(CS.parameters[6]))
    name === :namespace && return :(return $(CS.parameters[7])())

    Variables = CS.parameters[1]
    if name in fieldnames(Variables)
        return quote
            return @inline getproperty(get_variables(context), $(QuoteNode(name)))
        end
    end
    if name in fieldnames(CS.parameters[4])
        return quote
            return @inline getproperty(getruntimeinput(context), $(QuoteNode(name)))
        end
    end
    available = (fieldnames(Variables)..., fieldnames(CS.parameters[4])...)
    return :(error("Variable $(name) requested from context slice, but it is not available. Available names are $available."))
end

@inline @generated function Base.getproperty(context::CS, vl::VL) where {CS<:ContextSlice, VL<:Union{VarLocation{:subcontext}, VarLocation{:local}, VarLocation{:input}, VarLocation{:runtime}}}
    variable_names = _context_slice_names_for_location(CS, VL)
    if length(variable_names) == 1
        variable_name = only(variable_names)
        return quote
            return @inline getproperty(get_variables(context), $(QuoteNode(variable_name)))
        end
    end

    value_exprs = [:(getproperty(get_variables(context), $(QuoteNode(variable_names[i])))) for i in eachindex(variable_names)]
    return :(return ($(value_exprs...),))
end

@inline Base.propertynames(context::ContextSlice) = (fieldnames(typeof(get_variables(context)))..., fieldnames(typeof(getruntimeinput(context)))...)
@inline Base.keys(context::ContextSlice) = propertynames(context)

@inline merge_by_wiring(context::ContextSlice, ::Nothing) =
    (; globals = getglobals(context))

"""Return unchanged active subcontexts for a generated child with no writeback."""
@inline function backmerge_by_wiring(context::CS, ::Nothing, subcontexts::S) where {CS<:ContextSlice, S<:NamedTuple}
    return (; globals = getglobals(context), subcontexts...)
end

"""Return globals after merging only runtime-targeted child outputs."""
@inline backmerge_globals_by_wiring(context::ContextSlice, ::Nothing) =
    getglobals(context)

"""Return globals with temporary runtime outputs produced inside a context-slice step."""
@inline function merge_context_slice_runtime(context::CS, patch::P) where {CS<:ContextSlice, P<:NamedTuple}
    return merge(getglobals(context), patch)
end

"""Return one active subcontext after merging only writes targeting that subcontext."""
@inline backmerge_subcontext_by_wiring(context::ContextSlice, ::Nothing, ::Val{name}, subcontext::S) where {name, S} =
    subcontext

"""Merge one generated block return into the loop-level `ProcessContext`.

This is used by generated block paths that keep a single context aggregate live
through the loop. Returned runtime values update `_runtime`; returned
subcontext values must update existing fields without changing their concrete
types.
"""
@inline function backmerge_context_by_wiring(context::CS, ::Nothing, process_context::PC) where {CS<:ContextSlice, PC<:ProcessContext}
    return process_context
end

"""Return whether unlocated child return values should be written to runtime state."""
@inline _merge_unlocated_returns_to_runtime(::Type{T}) where {T} = nameof(T) === :FuncWrapper

"""Merge a child `step!` return into the subcontexts available to that child."""
@inline @generated function merge_by_wiring(context::CS, retval::R) where {CS<:ContextSlice, R<:NamedTuple}
    A = CS.parameters[6]
    local_names = _namespace_names(CS.parameters[7])
    isempty(local_names) && error("Generated concrete child step needs a resolved namespace for local return values.")
    local_subcontext = first(local_names)

    updates = Dict{Symbol, Vector{Expr}}()
    runtime_fields = Expr[]
    for retval_name in fieldnames(R)
        location, subcontext_name = _context_slice_location(CS, retval_name)
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
        push!(merge_exprs, :(_globals = @inline merge_context_slice_runtime(context, $runtime_patch_expr)))
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

"""Return globals after merging only runtime-targeted child outputs."""
@inline @generated function backmerge_globals_by_wiring(context::CS, retval::R) where {CS<:ContextSlice, R<:NamedTuple}
    A = CS.parameters[6]
    local_names = _namespace_names(CS.parameters[7])
    isempty(local_names) && error("Generated concrete child step needs a resolved namespace for local return values.")
    local_subcontext = first(local_names)

    runtime_fields = Expr[]
    for retval_name in fieldnames(R)
        location, subcontext_name = _context_slice_location(CS, retval_name)
        target_subcontext = isnothing(location) ? local_subcontext : get_subcontextname(location)
        target_variable = isnothing(location) ? subcontext_name : get_originalname(location)
        target_variable isa Symbol || error("Algorithm returned $(retval_name), which maps to multiple target variables $(target_variable). Inverse transform merges are not supported.")
        if target_subcontext == :_runtime || (isnothing(location) && _merge_unlocated_returns_to_runtime(A))
            push!(runtime_fields, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
        end
    end

    isempty(runtime_fields) && return :(return @inline getglobals(context))
    runtime_patch_expr = Expr(:tuple, Expr(:parameters, runtime_fields...))
    return quote
        return @inline merge_context_slice_runtime(context, $runtime_patch_expr)
    end
end

"""Return one active subcontext after merging only writes targeting that subcontext."""
@inline @generated function backmerge_subcontext_by_wiring(context::CS, retval::R, ::Val{name}, subcontext::S) where {CS<:ContextSlice, R<:NamedTuple, name, S}
    A = CS.parameters[6]
    local_names = _namespace_names(CS.parameters[7])
    isempty(local_names) && error("Generated concrete child step needs a resolved namespace for local return values.")
    local_subcontext = first(local_names)

    fields = Expr[]
    replacements = Dict{Symbol, Expr}()
    data_type = getdatatype(S)
    data_names = fieldnames(data_type)
    can_rebuild_stably = true
    for retval_name in fieldnames(R)
        location, subcontext_name = _context_slice_location(CS, retval_name)
        target_subcontext = isnothing(location) ? local_subcontext : get_subcontextname(location)
        target_variable = isnothing(location) ? subcontext_name : get_originalname(location)
        target_variable isa Symbol || error("Algorithm returned $(retval_name), which maps to multiple target variables $(target_variable). Inverse transform merges are not supported.")
        if target_subcontext == :_runtime || (isnothing(location) && _merge_unlocated_returns_to_runtime(A))
            continue
        end
        target_subcontext == name || continue
        value_expr = :(getproperty(retval, $(QuoteNode(retval_name))))
        push!(fields, Expr(:(=), target_variable, value_expr))

        # The generated loop wants a stable subcontext type. Only use the direct
        # rebuild when this write updates an existing field without changing its
        # field type; otherwise keep the existing merge fallback for now.
        target_variable in data_names || (can_rebuild_stably = false; continue)
        fieldtype(R, retval_name) === fieldtype(data_type, target_variable) || (can_rebuild_stably = false; continue)
        replacements[target_variable] = value_expr
    end

    isempty(fields) && return :(return subcontext)

    if can_rebuild_stably
        value_exprs = Any[
            haskey(replacements, data_name) ?
                replacements[data_name] :
                :(getproperty(subcontext, $(QuoteNode(data_name))))
            for data_name in data_names
        ]
        data_expr = :(NamedTuple{$data_names}(($(value_exprs...),)))
        return quote
            return @inline withdata(subcontext, $data_expr)
        end
    end

    patch_expr = Expr(:tuple, Expr(:parameters, fields...))
    return quote
        return @inline merge(subcontext, $patch_expr)
    end
end

"""Merge one generated block return into the loop-level `ProcessContext`."""
@inline @generated function backmerge_context_by_wiring(context::CS, retval::R, process_context::PC) where {CS<:ContextSlice, R<:NamedTuple, PC<:ProcessContext}
    A = CS.parameters[6]
    local_names = _namespace_names(CS.parameters[7])
    isempty(local_names) && error("Generated concrete child step needs a resolved namespace for local return values.")
    local_subcontext = first(local_names)
    subcontext_type = PC.parameters[1]
    subcontext_names = fieldnames(subcontext_type)

    updates = Dict{Symbol, Dict{Symbol, Expr}}()
    runtime_fields = Expr[]
    for retval_name in fieldnames(R)
        location, subcontext_name = _context_slice_location(CS, retval_name)
        target_subcontext = isnothing(location) ? local_subcontext : get_subcontextname(location)
        target_variable = isnothing(location) ? subcontext_name : get_originalname(location)
        target_variable isa Symbol || error("Algorithm returned $(retval_name), which maps to multiple target variables $(target_variable). Inverse transform merges are not supported.")
        if target_subcontext == :_runtime || (isnothing(location) && _merge_unlocated_returns_to_runtime(A))
            push!(runtime_fields, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
            continue
        end

        target_subcontext in subcontext_names || error("Generated block return writes to unknown subcontext $(target_subcontext). Available subcontexts are $(subcontext_names).")
        target_data_type = getdatatype(fieldtype(subcontext_type, target_subcontext))
        target_variable in fieldnames(target_data_type) || error("Generated block return would widen subcontext $(target_subcontext) with $(target_variable). Widening is disallowed on this path.")
        fieldtype(R, retval_name) === fieldtype(target_data_type, target_variable) || error("Generated block return changes $(target_subcontext).$(target_variable) from $(fieldtype(target_data_type, target_variable)) to $(fieldtype(R, retval_name)). Type-changing writes are disallowed on this path.")

        replacements = get!(updates, target_subcontext, Dict{Symbol, Expr}())
        replacements[target_variable] = :(getproperty(retval, $(QuoteNode(retval_name))))
    end

    merge_exprs = Any[:(_updated_context = process_context)]
    if !isempty(runtime_fields)
        runtime_patch_expr = Expr(:tuple, Expr(:parameters, runtime_fields...))
        push!(merge_exprs, :(_updated_context = @inline withruntime_if_changed(_updated_context, @inline merge_context_slice_runtime(context, $runtime_patch_expr))))
    end

    if !isempty(updates)
        old_subcontexts = gensym(:old_subcontexts)
        push!(merge_exprs, :(local $old_subcontexts = @inline get_subcontexts(_updated_context)))
        subcontext_value_exprs = Any[]
        for subcontext_name in subcontext_names
            old_subcontext_expr = :(getproperty($old_subcontexts, $(QuoteNode(subcontext_name))))
            if haskey(updates, subcontext_name)
                old_subcontext = gensym(:old_subcontext)
                data_type = getdatatype(fieldtype(subcontext_type, subcontext_name))
                data_names = fieldnames(data_type)
                replacements = updates[subcontext_name]
                data_values = Any[
                    haskey(replacements, data_name) ?
                        replacements[data_name] :
                        :(getproperty($old_subcontext, $(QuoteNode(data_name))))
                    for data_name in data_names
                ]
                data_expr = :(NamedTuple{$data_names}(($(data_values...),)))
                push!(merge_exprs, quote
                    local $old_subcontext = $old_subcontext_expr
                end)
                push!(subcontext_value_exprs, :(@inline withdata($old_subcontext, $data_expr)))
            else
                push!(subcontext_value_exprs, old_subcontext_expr)
            end
        end
        new_subcontexts_expr = :(NamedTuple{$subcontext_names}(($(subcontext_value_exprs...),)))
        push!(merge_exprs, :(_updated_context = @inline withsubcontexts(_updated_context, $new_subcontexts_expr)))
    end
    push!(merge_exprs, :(return _updated_context))
    return Expr(:block, merge_exprs...)
end

"""Merge a generated child return directly into the active subcontext tuple."""
@inline @generated function backmerge_by_wiring(context::CS, retval::R, subcontexts::S) where {CS<:ContextSlice, R<:NamedTuple, S<:NamedTuple}
    A = CS.parameters[6]
    local_names = _namespace_names(CS.parameters[7])
    isempty(local_names) && error("Generated concrete child step needs a resolved namespace for local return values.")
    local_subcontext = first(local_names)
    active_names = fieldnames(S)

    updates = Dict{Symbol, Vector{Expr}}()
    runtime_fields = Expr[]
    for retval_name in fieldnames(R)
        location, subcontext_name = _context_slice_location(CS, retval_name)
        target_subcontext = isnothing(location) ? local_subcontext : get_subcontextname(location)
        target_variable = isnothing(location) ? subcontext_name : get_originalname(location)
        target_variable isa Symbol || error("Algorithm returned $(retval_name), which maps to multiple target variables $(target_variable). Inverse transform merges are not supported.")
        if target_subcontext == :_runtime || (isnothing(location) && _merge_unlocated_returns_to_runtime(A))
            push!(runtime_fields, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
            continue
        end
        target_subcontext in active_names || error("Generated child return writes to subcontext $(target_subcontext), but only $(active_names) are active.")
        exprs = get!(updates, target_subcontext, Expr[])
        push!(exprs, Expr(:(=), target_variable, :(getproperty(retval, $(QuoteNode(retval_name))))))
    end

    merge_exprs = Any[:(_globals = @inline getglobals(context))]
    if !isempty(runtime_fields)
        runtime_patch_expr = Expr(:tuple, Expr(:parameters, runtime_fields...))
        push!(merge_exprs, :(_globals = @inline merge_context_slice_runtime(context, $runtime_patch_expr)))
    end

    return_fields = Any[Expr(:(=), :globals, :_globals)]
    for subcontext_name in active_names
        current_expr = :(getproperty(subcontexts, $(QuoteNode(subcontext_name))))
        if haskey(updates, subcontext_name)
            patch_expr = Expr(:tuple, Expr(:parameters, updates[subcontext_name]...))
            push!(return_fields, Expr(:(=), subcontext_name, :(@inline merge($current_expr, $patch_expr))))
        else
            push!(return_fields, Expr(:(=), subcontext_name, current_expr))
        end
    end
    push!(merge_exprs, :(return (; $(return_fields...))))
    return Expr(:block, merge_exprs...)
end
