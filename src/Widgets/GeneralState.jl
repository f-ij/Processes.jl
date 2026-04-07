export GeneralState, InlineState

"""
General-purpose ProcessState that acts only as an initialization scheme.

`Fields` and `Required` are stored in the type, while `defaults_builder`
produces the optional defaults each time `init` runs.

General states have custom matching behavior that allows them to merge with other general states
"""
struct GeneralState{Fields, Required, Builder} <: ProcessState
    defaults_builder::Builder
end


# TODO Maybe make it match with any general state where one has a subset of the fields of the other? 
"""
General states match by key for now
"""
match_by(ia::Union{IdentifiableAlgo{<:GeneralState}, Type{<:IdentifiableAlgo{<:GeneralState}}}) = getkey(ia)

const InlineState = GeneralState

@inline function GeneralState(defaults_builder::Builder, ::Val{Fields}, ::Val{Required}) where {Builder, Fields, Required}
    GeneralState{Fields, Required, Builder}(defaults_builder)
end

Processes.registry_allowmerge(::Union{GeneralState, Type{<:GeneralState}}) = true

@inline general_state_fields(::GeneralState{Fields}) where {Fields} = Fields
@inline general_state_required_fields(::GeneralState{Fields, Required}) where {Fields, Required} = Required

function _general_state_signature(state::GeneralState)
    parts = String[]
    required = general_state_required_fields(state)

    for field in general_state_fields(state)
        if field in required
            push!(parts, string(field))
        else
            push!(parts, string(field, " = <default>"))
        end
    end

    return string("GeneralState(", join(parts, ", "), ")")
end

Base.summary(io::IO, state::GeneralState) = print(io, _general_state_signature(state))
Base.show(io::IO, state::GeneralState) = print(io, _general_state_signature(state))

function _merge_general_state_fields(fields_a::Tuple, fields_b::Tuple)
    overlaps = filter(name -> name in fields_a, fields_b)
    isempty(overlaps) || error(
        "Cannot merge GeneralState values with overlapping field names: $(collect(overlaps)). " *
        "Mergeable GeneralState values must define disjoint state fields."
    )
    return (fields_a..., fields_b...)
end

function _merge_general_state_required(required_a::Tuple, required_b::Tuple)
    merged = Symbol[required_a...]
    for name in required_b
        name in merged || push!(merged, name)
    end
    return tuple(merged...)
end

"""
Merge two `GeneralState` initialization schemes.

This is intended for higher-level registry/setup code that decides two state
entries with the same outer key should coalesce. The states themselves must
define disjoint field names; overlapping state fields are rejected so state
composition stays explicit.
"""
function Base.merge(
    a::GeneralState{FieldsA, RequiredA},
    b::GeneralState{FieldsB, RequiredB},
) where {FieldsA, RequiredA, FieldsB, RequiredB}
    merged_fields = _merge_general_state_fields(FieldsA, FieldsB)
    merged_required = _merge_general_state_required(RequiredA, RequiredB)
    merged_builder = let a = a, b = b
        () -> merge(a.defaults_builder(), b.defaults_builder())
    end
    return GeneralState(merged_builder, Val{merged_fields}(), Val{merged_required}())
end

"""Fetch a required state input or raise a readable error."""
@inline function _general_state_required(context, name::Symbol)
    haskey(context, name) || error("Missing required @state input `$(name)`.")
    return getproperty(context, name)
end

"""Fetch an optional state input, falling back to the generated default if the source is not initialized yet."""
@inline function _general_state_optional(context, name::Symbol, default)
    haskey(context, name) || return default
    try
        return getproperty(context, name)
    catch
        return default
    end
end

"""Initialize a `GeneralState` from a context or plain named tuple."""
@generated function Processes.init(state::GeneralState{Fields, Required, Builder}, context::C) where {Fields, Required, Builder, C <: Union{Processes.AbstractContext, NamedTuple}}
    values = Expr[]
    for field in Fields
        if field in Required
            push!(values, :(_general_state_required(context, $(QuoteNode(field)))))
        else
            push!(values, :(_general_state_optional(context, $(QuoteNode(field)), getproperty(defaults, $(QuoteNode(field))))))
        end
    end

    nt_type = Expr(:curly, :NamedTuple, QuoteNode(Fields))
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        local defaults = state.defaults_builder()
        return $nt_type(($(values...),))
    end
end
