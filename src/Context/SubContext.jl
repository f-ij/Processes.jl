@inline getdata(sc::SubContext) = getfield(sc, :data)

SubContext{Name}(d::D) where {Name, D<:NamedTuple} = SubContext{Name, D}(d)
SubContext(name, data::NamedTuple) = SubContext{name, typeof(data)}(data)

function newdata(sc::SubContext, data::NamedTuple)
    setfield(sc, :data, data)
end

@inline Base.isempty(sc::SubContext) = isempty(getdata(sc))
@inline Base.getkey(sct::Type{<:SubContext}) = sct.parameters[1]
@inline getdatatype(sct::Type{<:SubContext}) = sct.parameters[2]
@inline Base.getkey(sc::SubContext) = getkey(typeof(sc))
@inline getdatatype(sc::SubContext) = getdatatype(typeof(sc))

@inline Base.pairs(sc::SubContext) = pairs(getdata(sc))
@inline function Base.getproperty(sc::SubContext, name::Symbol)
    if !haskey(getdata(sc), name)
        error("Key $name not found in SubContext $(sc) \n with keys $(keys(getdata(sc)))")
    end
    getproperty(getdata(sc), name)
end

@inline function Base.merge(sc::SubContext{Name, T}, args::NamedTuple) where {Name, T}
    merged = merge(getdata(sc), args)
    @inline SubContext{Name, typeof(merged)}(merged)
end

"""
Merge subcontext into a NamedTuple.
"""
@inline function Base.merge(args::NamedTuple, sc::SubContext{Name, T}) where {Name, T}
    return merge(args, getdata(sc))
end

@inline function Base.replace(sc::SubContext{Name, T}, args::NamedTuple = (;)) where {Name, T}
    @inline setfield(sc, :data, args)
end

@inline Base.keys(sct::Type{<:SubContext}) = fieldnames(sct.parameters[2])
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))

@inline Base.iterate(sc::SubContext, state = 1) = iterate(getdata(sc), state)
