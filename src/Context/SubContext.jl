getdata(sc::SubContext) = getfield(sc, :data)
@inline getsharedcontexts(sc::SubContext) = getsharedcontexts(typeof(sc))
@inline getsharedvars(sc::SubContext) = getsharedvars(typeof(sc))

function SubContext{Name}(d::D, sc, sv) where {Name, D<:NamedTuple}
    SubContext{Name, D, sc, sv}(d)
end

function SubContext(name, data::NamedTuple, sharedcontexts, sharedvars)
    SubContext{name, typeof(data), sharedcontexts, sharedvars}(data)
end

function newdata(sc::SubContext, data::NamedTuple)
    # SubContext{getkey(sc), typeof(data), getsharedcontexts(sc), getsharedvars(sc)}(data)
    setfield(sc, :data, data)
end

@inline Base.isempty(sc::SubContext) = isempty(getdata(sc))
@inline Base.getkey(sct::Type{<:SubContext}) = sct.parameters[1]
@inline getdatatype(sct::Type{<:SubContext}) = sct.parameters[2]
@inline getsharedcontexts(sct::Type{<:SubContext}) = sct.parameters[3]
@inline getsharedvars(sct::Type{<:SubContext}) = sct.parameters[4]

@inline function getsharedcontext_types(sct::Type{<:SubContext})
    shared = getsharedcontexts(sct)
    return shared isa Tuple ? shared : (shared,)
end
@inline function getsharedvars_types(sct::Type{<:SubContext})
    shared = getsharedvars(sct)
    return shared isa Tuple ? shared : (shared,)
end

@inline Base.getkey(sc::SubContext) = getkey(typeof(sc))
@inline getdatatype(sc::SubContext) = getdatatype(typeof(sc))
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
@inline function Base.getproperty(sc::SubContext, name::Symbol)
    if !haskey(getdata(sc), name)
        error("Key $name not found in SubContext $(sc) \n with keys $(keys(getdata(sc)))")
    end
    getproperty(getdata(sc), name)
end

@inline function Base.merge(sc::SubContext{Name, T, S, R}, args::NamedTuple) where {Name, T, S, R}
    merged = merge(getdata(sc), args)
    @inline SubContext{Name, typeof(merged), S, R}(merged)
end

"""
Merge subcontext into a NamedTuple
"""
@inline function Base.merge(args::NamedTuple, sc::SubContext{Name, T, S, R}) where {Name, T, S, R}
    merged = merge(args, getdata(sc))
    # return @inline SubContext{Name, typeof(merged), S, R}(merged)
    return merged
end

@inline function Base.replace(sc::SubContext{Name, T, S, R}, args::NamedTuple = (;)) where {Name, T, S, R}
    # println("Replace called from SubContext: $Name with args: $args")
    # if isempty(args)
    #     @warn "Replacing SubContext: $Name with empty NamedTuple"
    # end
    @inline setfield(sc, :data, args)
end

@inline Base.keys(sct::Type{<:SubContext}) = fieldnames(sct.parameters[2])
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))

@inline Base.iterate(sc::SubContext, state = 1) = iterate(getdata(sc), state)

########################
####### Setters ########
########################

set_sharedcontexts(sc::SubContext{Name, T, S, R}, sharedcontexts) where {Name, T, S, R} =
    SubContext{Name, T, sharedcontexts, R}(getdata(sc))
set_sharedvars(sc::SubContext{Name, T, S, R}, sharedvars) where {Name, T, S, R} =
    SubContext{Name, T, S, sharedvars}(getdata(sc))


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


################################################
####### Replacing ROUTES/SHARES ########
################################################

@inline function replace_routes(sc::SubContext, routes::R) where R
    SubContext{getkey(sc), getdatatype(sc), getsharedcontexts(sc), routes}(getdata(sc))::SubContext{getkey(sc), getdatatype(sc), getsharedcontexts(sc), R}
end

@inline function replace_shares(sc::SubContext{K, T, Ss, R}, shares::S) where {K, T, Ss, R, S}
    if Ss == S
        return sc
    end
    SubContext{K, T, shares, R}(getdata(sc))::SubContext{getkey(sc), getdatatype(sc), S, R}
end
