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
@inline subalgo(la::LA) where {LA<:AbstractLoopAlgorithm} = la
@inline subalgo(::Type{LA}) where {LA<:AbstractLoopAlgorithm} = LA
@inline subalgo(sa::AbstractIdentifiableAlgo{F}) where {F} = F <: AbstractLoopAlgorithm ? getalgo(sa) : nothing
@inline subalgo(::Type{<:AbstractIdentifiableAlgo{F}}) where {F} = F <: AbstractLoopAlgorithm ? F : nothing

@inline childnodes(la::LA) where {LA<:AbstractLoopAlgorithm} = tuple(getalgos(la)..., getstates(la)...)
@inline childnodes(::Type{LA}) where {LA<:AbstractLoopAlgorithm} = tuple(algotypes(LA)..., statetypes(LA)...)

function _loopalgorithm_keys(la)
    names = Symbol[]
    for child in childnodes(la)
        key = trykey(child)
        key == Symbol() || push!(names, key)

        nested = subalgo(child)
        isnothing(nested) || append!(names, keys(nested))
    end

    return tuple(names...)
end

function Base.keys(la::LA) where {LA<:AbstractLoopAlgorithm}
    return _loopalgorithm_keys(la)
end

function Base.keys(la::Type{<:AbstractLoopAlgorithm})
    return _loopalgorithm_keys(la)
end

function _findkey_loopalgorithm(la, key::Symbol, prefix::Tuple = ())
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

function _findkey(la::LA, key::Symbol, prefix::Tuple = ()) where {LA<:AbstractLoopAlgorithm}
    return _findkey_loopalgorithm(la, key, prefix)
end

function _findkey(la::Type{<:AbstractLoopAlgorithm}, key::Symbol, prefix::Tuple = ())
    return _findkey_loopalgorithm(la, key, prefix)
end

@inline findkey(la::LA, key::Symbol) where {LA<:AbstractLoopAlgorithm} = _findkey(la, key)
@inline findkey(la::Type{<:AbstractLoopAlgorithm}, key::Symbol) = _findkey(la, key)
@inline Base.haskey(la::LA, key::Symbol) where {LA<:AbstractLoopAlgorithm} = !isnothing(findkey(la, key))
@inline Base.haskey(la::Type{<:AbstractLoopAlgorithm}, key::Symbol) = !isnothing(findkey(la, key))

function _getindex_keylocation(current, path::Tuple)
    child = childnodes(current)[first(path)]
    length(path) == 1 && return child

    nested = subalgo(child)
    isnothing(nested) && error("KeyLocation $(path) descends through non-LoopAlgorithm child $(child).")
    return _getindex_keylocation(nested, Base.tail(path))
end

@inline Base.getindex(cla::LA, location::KeyLocation) where {LA<:AbstractLoopAlgorithm} = _getindex_keylocation(cla, keypath(location))
