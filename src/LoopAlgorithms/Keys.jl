"""
Val-like location for a recursively nested loop-algorithm child.

The stored tuple is a path of consecutive indexes through `(algos..., states...)`
at each nested loop-algorithm level.
"""
struct KeyLocation{Path} end

@inline KeyLocation(path::Tuple) = KeyLocation{path}()
@inline keypath(::KeyLocation{Path}) where {Path} = Path

@inline trykey(::Any) = Symbol()
@inline trykey(sa::AbstractIdentifiableAlgo) = haskey(sa) ? getkey(sa) : Symbol()
@inline function trykey(::Type{SA}) where {SA<:AbstractIdentifiableAlgo}
    key = getkey(SA)
    return key == Symbol() ? Symbol() : key
end

@inline subalgo(::Any) = nothing
@inline subalgo(la::LoopAlgorithm) = la
@inline subalgo(::Type{LA}) where {LA<:LoopAlgorithm} = LA
@inline subalgo(sa::AbstractIdentifiableAlgo{F}) where {F} = F <: LoopAlgorithm ? getalgo(sa) : nothing
@inline subalgo(::Type{<:AbstractIdentifiableAlgo{F}}) where {F} = F <: LoopAlgorithm ? F : nothing

@inline childnodes(la::LoopAlgorithm) = tuple(getalgos(la)..., getstates(la)...)
@inline childnodes(::Type{LA}) where {LA<:LoopAlgorithm} = tuple(algotypes(LA)..., statetypes(LA)...)

function Base.keys(la::Union{LoopAlgorithm, Type{<:LoopAlgorithm}})
    names = Symbol[]
    for child in childnodes(la)
        key = trykey(child)
        key == Symbol() || push!(names, key)

        nested = subalgo(child)
        isnothing(nested) || append!(names, keys(nested))
    end

    return tuple(names...)
end

function _findkey(la::Union{LoopAlgorithm, Type{<:LoopAlgorithm}}, key::Symbol, prefix::Tuple = ())
    for (idx, child) in pairs(childnodes(la))
        child_key = trykey(child)
        if child_key == key && child_key != Symbol()
            return KeyLocation((prefix..., idx))
        end

        nested = subalgo(child)
        if !isnothing(nested)
            location = _findkey(nested, key, (prefix..., idx))
            isnothing(location) || return location
        end
    end

    return nothing
end

@inline findkey(la::Union{LoopAlgorithm, Type{<:LoopAlgorithm}}, key::Symbol) = _findkey(la, key)
@inline Base.haskey(la::Union{LoopAlgorithm, Type{<:LoopAlgorithm}}, key::Symbol) = !isnothing(findkey(la, key))

function _getindex_keylocation(current, path::Tuple)
    child = childnodes(current)[first(path)]
    length(path) == 1 && return child

    nested = subalgo(child)
    isnothing(nested) && error("KeyLocation $(path) descends through non-LoopAlgorithm child $(child).")
    return _getindex_keylocation(nested, Base.tail(path))
end

@inline Base.getindex(cla::LoopAlgorithm, location::KeyLocation) = _getindex_keylocation(cla, keypath(location))
