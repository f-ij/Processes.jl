
#########################################
######## SHARED CONTEXT AND VARS ########
#########################################

struct SharedContext{from_name} end
contextname(st::Type{SharedContext{name}}) where {name} = name
contextname(st::SharedContext{name}) where {name} = name
contextname(::Any) = nothing

struct SharedVars{from_name, NT, transform} end
SharedVars(fromname, transform = nothing; nt...) = SharedVars{fromname, (nt...,), transform}() # NamedTuple of varnames => aliases
SharedVars(fromname, varnames, aliases, transform = nothing) = SharedVars{fromname, NamedTuple{tuple(varnames...)}(tuple(aliases...)), transform}()

get_fromname(::Union{SharedVars{from_name}, Type{<:SharedVars{from_name}}}) where {from_name} = from_name
get_localname(sv::Union{SharedVars{from_name, NT}, Type{<:SharedVars{from_name, NT}}}, varname::Symbol) where {from_name, NT} = getproperty(NT, varname)
@inline localnames(sv::Union{SharedVars{from_name, NT}, Type{<:SharedVars{from_name, NT}}}) where {from_name, NT} = values(NT)
@inline subvarcontextnames(sv::Union{SharedVars{from_name, NT}, Type{<:SharedVars{from_name, NT}}}) where {from_name, NT} = keys(NT)
@inline gettransform(sv::Union{SharedVars{from_name, NT, transform}, Type{<:SharedVars{from_name, NT, transform}}}) where {from_name, NT, transform} = transform

Base.keys(sv::Union{SharedVars{from_name, NT}, Type{<:SharedVars{from_name, NT}}}) where {from_name, NT} = keys(NT)
Base.values(sv::Union{SharedVars{from_name, NT}, Type{<:SharedVars{from_name, NT}}}) where {from_name, NT} = values(NT)

# TODO CHECK IF USED
contextname(sv::Type{<:SharedVars{from_name}}) where {from_name} = from_name
contextname(sv::SharedVars{from_name}) where {from_name} = from_name

## TODO MOVE
function to_sharedvar(reg::NameSpaceRegistry, r::Route)
        fromname = static_findkey(reg, r.from)
        toname = static_findkey(reg, r.to)
        if isnothing(fromname) || isnothing(toname)
            available = all_keys(reg)
            available_str = isempty(available) ? "<none>" : join(string.(available), ", ")
            msg = "Route references algo(s) not found in registry.\n" *
                  "Requested: " * string(r.from) * " (type: " * string(typeof(r.from)) * "), " *
                  string(r.to) * " (type: " * string(typeof(r.to)) * ")\n" *
                  "Available names: " * available_str
            error(msg)
        end
        # (; toname => tuple(SharedVars(fromname, getvarnames(r), getaliases(r)) ))
        toname => SharedVars(fromname, getvarnames(r), getaliases(r), getransform(r))
        # (;toname => SharedVars{fromname, r.varnames, r.aliases}())
end
