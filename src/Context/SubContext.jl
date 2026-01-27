
########################
    ### SUBCONTEXT ###
########################

"""
A subcontext can share share in two ways:
    1) Whole subcontext shares:         The entire subcontext is shared between processes
    2) Variable shares through shared vars: Only specific variables are shared between subcontexts, 
                                                defined by shared vars with optional aliases
"""
struct SubContext{Name, T<:NamedTuple, S, SV} <: AbstractSubContext
    data::T
    sharedcontexts::S # Whole subcontext shares
    sharedvars::SV # Variable shares with aliases
end

getdata(sc::SubContext) = getfield(sc, :data)
getsharedcontexts(sc::SubContext) = getfield(sc, :sharedcontexts)
getsharedvars(sc::SubContext) = getfield(sc, :sharedvars)

function SubContext{Name}(d::D, sc::SC, sv::SV) where {Name, D<:NamedTuple, SC, SV}
    SubContext{Name, D, SC, SV}(d, sc, sv)
end

function SubContext(name, data::NamedTuple, sharedcontexts, sharedvars)
    SubContext{name, typeof(data), typeof(sharedcontexts), typeof(sharedvars)}(data, sharedcontexts, sharedvars)
end

function newdata(sc::SubContext, data::NamedTuple)
    SubContext{getname(sc), typeof(data), getsharedcontext_types(sc), getsharedvars_types(sc)}(data, getsharedcontexts(sc), getsharedvars(sc))
end

@inline Base.isempty(sc::SubContext) = isempty(getdata(sc))
@inline getname(sct::Type{<:SubContext}) = sct.parameters[1]
@inline get_datatype(sct::Type{<:SubContext}) = sct.parameters[2]

@inline function getsharedcontext_types(sct::Type{<:SubContext})
    shared = sct.parameters[3]
    if shared <: Tuple
        params = shared.parameters
        return tuple(params...)
    end
    return (shared,)
end
@inline function getsharedvars_types(sct::Type{<:SubContext})
    shared = sct.parameters[4]
    if shared <: Tuple
        params = shared.parameters
        return tuple(params...)
    end
    return (shared,)
end

@inline getname(sc::SubContext) = getname(typeof(sc))
@inline get_datatype(sc::SubContext) = get_datatype(typeof(sc))
@inline getsharedcontext_types(sc::SubContext) = getsharedcontext_types(typeof(sc))
@inline getsharedvars_types(sc::SubContext) = getsharedvars_types(typeof(sc))

@inline function getsharedcontext_names(sct::Type{<:SubContext})
    shared_context_types = getsharedcontext_types(sct)
    if isempty(shared_context_types)
        return tuple()
    end
    contextname.(shared_context_types)
end

@inline Base.pairs(sc::SubContext) = pairs(getdata(sc))
@inline Base.getproperty(sc::SubContext, name::Symbol) = getproperty(getdata(sc), name)
@inline function Base.merge(sc::SubContext{Name, T, S, R}, args::NamedTuple) where {Name, T, S, R}
    merged = merge(getdata(sc), args)
    @inline SubContext{Name,typeof(merged), S, R}(merged, getsharedcontexts(sc), getsharedvars(sc))
end

@inline function Base.merge(args::NamedTuple, sc::SubContext{Name, T, S, R}) where {Name, T, S, R}
    merged = merge(args, getdata(sc))
    @inline SubContext{Name,typeof(merged), S, R}(merged, getsharedcontexts(sc), getsharedvars(sc))
end

@inline function Base.replace(sc::SubContext{Name, T, S, R}, args::NamedTuple) where {Name, T, S, R}
    @inline setfield(sc, :data, args)
end

@inline Base.propertynames(sct::Type{<:SubContext}) = fieldnames(sct.parameters[2])
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))






########################
### Setters ###
########################

set_sharedcontexts(sc::SubContext, sharedcontexts) = setproperty(sc, :sharedcontexts, sharedcontexts, SubContext{getname(sc)})
set_sharedvars(sc::SubContext, sharedvars) = setproperty(sc, :sharedvars, sharedvars, SubContext{getname(sc)})


function merge_sharedcontexts(sctuple::NamedTuple, sharedcontexts::NamedTuple)
    for (name, sharedcontexts) in pairs(sharedcontexts)
        sctuple = (sctuple..., name => set_sharedcontexts(sctuple[name], sharedcontexts))
    end
    return sctuple
end

function merge_sharedvars(sctuple::NamedTuple, sharedvars::NamedTuple)
    for (name, sharedvars) in pairs(sharedvars)
        sctuple = (sctuple..., name => set_sharedvars(sctuple[name], sharedvars))
    end
    return sctuple
end