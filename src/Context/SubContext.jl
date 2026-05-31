@inline getdata(sc::SubContext) = getfield(sc, :data)

"""
    withdata(sc, data)

Return `sc` with updated local data.

Type-preserving writes mutate the existing `SubContext`. Shape-changing writes
rebuild a new typed `SubContext`, which keeps widening explicit and rare.
"""
@inline function withdata(sc::SubContext{T}, data::T) where {T<:NamedTuple}
    setfield!(sc, :data, data)
    return sc
end

@inline function withdata(sc::SC, data::D) where {SC<:SubContext, D<:NamedTuple}
    return SubContext(getkey(sc), data)
end

function newdata(sc::SubContext, data::NamedTuple)
    return @inline withdata(sc, data)
end

@inline Base.isempty(sc::SubContext) = isempty(getdata(sc))
@inline getdatatype(sct::Type{<:SubContext{T}}) where {T} = T
@inline Base.getkey(sc::SubContext) = getfield(sc, :name)
@inline getdatatype(sc::SubContext) = getdatatype(typeof(sc))

@inline Base.pairs(sc::SubContext) = pairs(getdata(sc))
@inline function Base.getproperty(sc::SubContext, name::Symbol)
    if name === :name || name === :data
        return getfield(sc, name)
    end
    if !haskey(getdata(sc), name)
        error("Key $name not found in SubContext $(sc) \n with keys $(keys(getdata(sc)))")
    end
    getproperty(getdata(sc), name)
end

@inline function Base.merge(sc::SubContext{T}, args::NamedTuple) where {T}
    merged = merge(getdata(sc), args)
    return @inline withdata(sc, merged)
end

"""
Merge subcontext into a NamedTuple.
"""
@inline function Base.merge(args::NamedTuple, sc::SubContext{T}) where {T}
    return merge(args, getdata(sc))
end

@inline function Base.replace(sc::SubContext{T}, args::NamedTuple = (;)) where {T}
    return @inline withdata(sc, args)
end

@inline Base.keys(sct::Type{<:SubContext}) = fieldnames(getdatatype(sct))
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))

@inline Base.iterate(sc::SubContext, state = 1) = iterate(getdata(sc), state)
