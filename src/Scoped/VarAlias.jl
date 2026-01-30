using UUIDs

struct VarAliases{NT} end
externalnames(va::VarAliases{NT}) where {NT} = keys(NT)
internalnames(va::VarAliases{NT}) where {NT} = values(NT)
VarAliases(;names...) = VarAliases{(;names...)}()

@inline Base.@constprop :aggressive function apply_aliases(va::Union{VarAliases{NT}, Type{<:VarAliases{NT}}}, name::Symbol) where NT
    if isempty(NT)
        return name
    end
    @inline getproperty(NT, name)
end

@inline Base.@constprop :aggressive function apply_aliases(va::Union{VarAliases{NT}, Type{<:VarAliases{NT}}}, names::Union{Tuple, AbstractVector}) where NT
    @assert eltype(names) == Symbol "Aliases must be Symbols"
    if isempty(NT)
        return names
    end
    return map( n -> getproperty(NT, n), names)
end


