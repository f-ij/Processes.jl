@inline getdata(sc::SubContext) = getfield(sc, :data)

"""
    withdata(sc, data)

Return an immutable `SubContext` rebuild with the same logical key and new local
data. This is the package-local replacement for `@set sc.data = data`.
"""
@inline function withdata(sc::SC, data::D) where {Name, SC<:SubContext{Name}, D<:NamedTuple}
    return SubContext{Name, D}(data)
end

"""
    newdata(sc, data)

Compatibility wrapper around `withdata` for call sites that treat a subcontext
payload replacement as "new data" construction.
"""
function newdata(sc::SubContext, data::NamedTuple)
    return @inline withdata(sc, data)
    # Mutable SubContext path kept for comparison:
    # setfield!(sc, :data, data)
    # return sc
end

@inline Base.isempty(sc::SubContext) = isempty(getdata(sc))
@inline getdatatype(sct::Type{<:SubContext{Name, T}}) where {Name, T} = T
@inline Base.getkey(::Union{SubContext{Name}, Type{<:SubContext{Name}}}) where {Name} = Name
@inline getdatatype(sc::SubContext) = getdatatype(typeof(sc))

@inline Base.pairs(sc::SubContext) = pairs(getdata(sc))
"""
    Base.getproperty(sc, name)

Expose the type-level subcontext key as `sc.name` and forward all other lookups
into the payload named tuple.
"""
@inline function Base.getproperty(sc::SubContext, name::Symbol)
    if name === :name
        return @inline getkey(sc)
    end
    if name === :data
        return getfield(sc, :data)
    end
    if !haskey(getdata(sc), name)
        error("Key $name not found in SubContext $(sc) \n with keys $(keys(getdata(sc)))")
    end
    getproperty(getdata(sc), name)
end

"""
    Base.merge(sc, args)

Merge payload updates into one immutable subcontext while preserving the typed
subcontext key.
"""
@inline function Base.merge(sc::SubContext{Name, T}, args::NamedTuple) where {Name, T}
    merged = merge(getdata(sc), args)
    return @inline withdata(sc, merged)
end

"""
Merge subcontext into a NamedTuple.
"""
@inline function Base.merge(args::NamedTuple, sc::SubContext{Name, T}) where {Name, T}
    return merge(args, getdata(sc))
end

"""
    Base.replace(sc, args)

Replace the payload of one immutable subcontext while preserving its typed key.
"""
@inline function Base.replace(sc::SubContext{Name, T}, args::NamedTuple = (;)) where {Name, T}
    return @inline withdata(sc, args)
    # Accessors path kept for comparison:
    # return @inline @set sc.data = args
end

@inline Base.keys(sct::Type{<:SubContext}) = fieldnames(getdatatype(sct))
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))

@inline Base.iterate(sc::SubContext, state = 1) = iterate(getdata(sc), state)
