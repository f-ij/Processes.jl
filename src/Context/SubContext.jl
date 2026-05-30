@inline getdata(sc::SubContext) = getfield(sc, :data)

function newdata(sc::SubContext, data::NamedTuple)
    # Mutable SubContext experiment:
    # setfield!(sc, :data, data)
    # return sc
    return @set sc.data = data
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
    return @inline SubContext(getkey(sc), merged)
end

"""
Merge subcontext into a NamedTuple.
"""
@inline function Base.merge(args::NamedTuple, sc::SubContext{T}) where {T}
    return merge(args, getdata(sc))
end

@inline function Base.replace(sc::SubContext{T}, args::NamedTuple = (;)) where {T}
    # Constructor path kept for comparison:
    # return @inline SubContext(getkey(sc), args)
    return @inline @set sc.data = args
end

@inline Base.keys(sct::Type{<:SubContext}) = fieldnames(getdatatype(sct))
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))

@inline Base.iterate(sc::SubContext, state = 1) = iterate(getdata(sc), state)
