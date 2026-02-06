"""
A simple registry works like a simple set based on matching
It's not hierarchical by type, making searching ever so slightly slower

But it's easier to imlplement and a better choice for a registry that is not expected to have a large number of entries
"""
struct SimpleRegistry{T} <: AbstractRegistry
    entries::T
    multipliers::Vector{Float64}
end
SimpleRegistry() = SimpleRegistry((), Float64[])

getentries(r::SimpleRegistry) = r.entries
all_algos(r::SimpleRegistry) = getentries(r)

Base.length(r::SimpleRegistry) = length(getentries(r))
function entrytypes(r::Union{SimpleRegistry{T}, Type{<:SimpleRegistry{T}}}) where T
    if isempty(T.parameters)
        return tuple()
    end
    tuple(T.parameters...)
end

static_findfirst_match(r::SimpleRegistry{T}, val) where T = static_findfirst_match(r, Val(val))

@generated function static_findfirst_match(r::SimpleRegistry{T}, ::Val{val}) where {T,val}
    ETypes = entrytypes(r)
    fidx = findfirst(x -> match(x, val), ETypes)
    if isnothing(fidx)
        return :(nothing)
    end
    return :(fidx)
end

function Base.getindex(r::SimpleRegistry{T}, key) where T
    fidx = static_findfirst_match(r, key)
    if isnothing(fidx)
        error("No match found for key: $key in registry of type $(typeof(r))")
    end
    return getentries(r)[fidx]
end
function Base.getindex(r::SimpleRegistry{T}, idx::Int) where T
    return getentries(r)[idx]
end

function add(r::SimpleRegistry{T}, obj, multiplier = 1.; withname = nothing) where T
    fidx = static_findfirst_match(r, obj)
    if isnothing(fidx)
        identifiable = Autokey(obj, length(getentries(r)) + 1)
        newentries = (getentries(r)..., identifiable)
        push!(r.multipliers, multiplier)
        return setfield(r, :entries, newentries), identifiable
    else
        multipliers = getmultipliers(r)
        multipliers[fidx] = multipliers[fidx] + multiplier
        return setfield(r, :multipliers, multipliers), getentries(r)[fidx]
    end
end


# inherit(parent::AbstractRegistry, child::AbstractRegistry) = error("inherit not implemented for $(typeof(parent)) and $(typeof(child))")
# static_findfirst_match(r::AbstractRegistry, val) = error("static_findfirst_match not implemented for $(typeof(r))")
