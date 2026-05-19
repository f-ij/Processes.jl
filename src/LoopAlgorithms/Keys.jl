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

"""Return the key for a child position, preferring resolved tuple names."""
@inline function _child_key(la::Union{CompositeAlgorithm, Routine}, idx::Int, child)
    names = _plan_func_names(getfield(la, :funcs))
    isnothing(names) && return trykey(child)
    return names[idx]
end

@inline _child_key(la, idx::Int, child) = trykey(child)

function _loopalgorithm_keys(la)
    names = Symbol[]
    funcs = getalgos(la)
    for idx in eachindex(funcs)
        child = funcs[idx]
        key = _child_key(la, idx, child)
        key == Symbol() || push!(names, key)

        nested = subalgo(child)
        isnothing(nested) || append!(names, keys(nested))
    end
    for state in getstates(la)
        key = trykey(state)
        key == Symbol() || push!(names, key)
    end

    return tuple(names...)
end

function _loopalgorithm_keys(::Type{LA}) where {FT, LA<:Union{CompositeAlgorithm{FT}, Routine{FT}}}
    names = Symbol[]
    child_names = _plan_func_names_type(FT)
    child_types = algotypes(LA)
    for idx in eachindex(child_types)
        child = child_types[idx]
        key = isnothing(child_names) ? trykey(child) : child_names[idx]
        key == Symbol() || push!(names, key)

        nested = subalgo(child)
        isnothing(nested) || append!(names, keys(nested))
    end
    for state in statetypes(LA)
        key = trykey(state)
        key == Symbol() || push!(names, key)
    end
    return tuple(names...)
end

function _loopalgorithm_keys(::Type{<:LoopAlgorithm{Plan}}) where {Plan}
    return _loopalgorithm_keys(Plan)
end

function _loopalgorithm_keys(la::LoopAlgorithm)
    names = collect(keys(getplan(la)))
    for state in getstates(la)
        key = trykey(state)
        key == Symbol() || push!(names, key)
    end
    return tuple(names...)
end

function _loopalgorithm_keys(::Type{FA}) where {LA, FA<:FinalizedAlgorithm{LA}}
    return _loopalgorithm_keys(LA)
end

function Base.keys(la::LA) where {LA<:AbstractLoopAlgorithm}
    return _loopalgorithm_keys(la)
end

function Base.keys(la::Type{<:AbstractLoopAlgorithm})
    return _loopalgorithm_keys(la)
end

function _findkey_loopalgorithm(la, key::Symbol, prefix::Tuple = ())
    funcs = getalgos(la)
    for idx in eachindex(funcs)
        child = funcs[idx]
        child_key = _child_key(la, idx, child)
        if child_key == key && child_key != Symbol()
            return KeyLocation((prefix..., idx))
        end

        nested = subalgo(child)
        if !isnothing(nested)
            location = _findkey(nested, key, (prefix..., idx))
            isnothing(location) || return location
        end
    end
    offset = length(funcs)
    for (idx, state) in pairs(getstates(la))
        state_key = trykey(state)
        if state_key == key && state_key != Symbol()
            return KeyLocation((prefix..., offset + idx))
        end
    end

    return nothing
end

function _findkey_loopalgorithm(::Type{LA}, key::Symbol, prefix::Tuple = ()) where {FT, LA<:Union{CompositeAlgorithm{FT}, Routine{FT}}}
    child_names = _plan_func_names_type(FT)
    child_types = algotypes(LA)
    for idx in eachindex(child_types)
        child = child_types[idx]
        child_key = isnothing(child_names) ? trykey(child) : child_names[idx]
        if child_key == key && child_key != Symbol()
            return KeyLocation((prefix..., idx))
        end

        nested = subalgo(child)
        if !isnothing(nested)
            location = _findkey(nested, key, (prefix..., idx))
            isnothing(location) || return location
        end
    end
    offset = length(child_types)
    for (idx, state) in pairs(statetypes(LA))
        state_key = trykey(state)
        if state_key == key && state_key != Symbol()
            return KeyLocation((prefix..., offset + idx))
        end
    end
    return nothing
end

function _findkey_loopalgorithm(::Type{<:LoopAlgorithm{Plan}}, key::Symbol, prefix::Tuple = ()) where {Plan}
    return _findkey_loopalgorithm(Plan, key, prefix)
end

function _findkey_loopalgorithm(la::LoopAlgorithm, key::Symbol, prefix::Tuple = ())
    location = _findkey(getplan(la), key, prefix)
    !isnothing(location) && return location

    offset = length(getalgos(la))
    for (idx, state) in pairs(getstates(la))
        state_key = trykey(state)
        if state_key == key && state_key != Symbol()
            return KeyLocation((prefix..., offset + idx))
        end
    end
    return nothing
end

function _findkey_loopalgorithm(::Type{FA}, key::Symbol, prefix::Tuple = ()) where {LA, FA<:FinalizedAlgorithm{LA}}
    return _findkey_loopalgorithm(LA, key, prefix)
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
