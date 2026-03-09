
#########################################
######## SHARED CONTEXT AND VARS ########
#########################################

struct SharedContext{from_name} end
contextname(st::Type{SharedContext{name}}) where {name} = name
contextname(st::SharedContext{name}) where {name} = name
contextname(::Any) = nothing

struct SharedVars{from_name, varnames, aliases, transform} end
SharedVars(fromname, transform = nothing; nt...) = SharedVars{fromname, (nt...,), transform}() # NamedTuple of varnames => aliases
SharedVars(fromname, varnames, aliases, transform = nothing) = SharedVars{fromname, varnames, aliases, transform}()

get_fromname(::Union{SharedVars{from_name}, Type{<:SharedVars{from_name}}}) where {from_name} = from_name
get_localname(sv::Union{SharedVars{from_name, varnames, aliases}, Type{<:SharedVars{from_name, varnames, aliases}}}, varname::Symbol) where {from_name, varnames, aliases} = aliases[findfirst(==(varname), varnames)]
@inline localnames(sv::Union{SharedVars{from_name, varnames, aliases}, Type{<:SharedVars{from_name, varnames, aliases}}}) where {from_name, varnames, aliases} = aliases
@inline subvarcontextnames(sv::Union{SharedVars{from_name, varnames, aliases}, Type{<:SharedVars{from_name, varnames, aliases}}}) where {from_name, varnames, aliases} = varnames
@inline gettransform(sv::Union{SharedVars{from_name, varnames, aliases, transform}, Type{<:SharedVars{from_name, varnames, aliases, transform}}}) where {from_name, varnames, aliases, transform} = transform

Base.keys(sv::Union{SharedVars{from_name, varnames, aliases}, Type{<:SharedVars{from_name, varnames, aliases}}}) where {from_name, varnames, aliases} = varnames
Base.values(sv::Union{SharedVars{from_name, varnames, aliases}, Type{<:SharedVars{from_name, varnames, aliases}}}) where {from_name, varnames, aliases} = aliases

# TODO CHECK IF USED
contextname(sv::Type{<:SharedVars{from_name}}) where {from_name} = from_name
contextname(sv::SharedVars{from_name}) where {from_name} = from_name

@noinline function _route_target_lookup_error(to_matcher, reg::NameSpaceRegistry, e)
    error("Error finding target of route: $(to_matcher)\n in registry: $(reg). Original error: $(e)")
end

@noinline function _route_missing_algos_error(reg::NameSpaceRegistry, r::Route)
    available = all_keys(reg)
    available_str = isempty(available) ? "<none>" : join(string.(available), ", ")
    msg = "Route references algo(s) not found in registry.\n" *
          "Requested: " * string(r.from) * " (type: " * string(typeof(r.from)) * "), " *
          string(r.to) * " (type: " * string(typeof(r.to)) * ")\n" *
          "Available names: " * available_str
    error(msg)
end

@inline function to_sharedvar(
    reg::NameSpaceRegistry,
    r::Route{F, T, FT, varnames, aliases, Fmatch, Tmatch},
) where {F, T, FT, varnames, aliases, Fmatch, Tmatch}
    fromobj = get_by_matcher(reg, Fmatch)
    toobj = try
        get_by_matcher(reg, Tmatch)
    catch e
        _route_target_lookup_error(Tmatch, reg, e)
    end

    toname = getkey(toobj)
    fromname = getkey(fromobj)
    if isnothing(fromname) || isnothing(toname)
        _route_missing_algos_error(reg, r)
    end
    return toname => SharedVars(fromname, varnames, aliases, FT)
end
