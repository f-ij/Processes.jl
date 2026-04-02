export GeneralState, InlineState

"""
General-purpose ProcessState that acts only as an initialization scheme.

`Fields` and `Required` are stored in the type, while `defaults_builder`
produces the optional defaults each time `init` runs.
"""
struct GeneralState{Fields, Required, Builder} <: ProcessState
    defaults_builder::Builder
end

const InlineState = GeneralState

@inline function GeneralState(defaults_builder::Builder, ::Val{Fields}, ::Val{Required}) where {Builder, Fields, Required}
    GeneralState{Fields, Required, Builder}(defaults_builder)
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
