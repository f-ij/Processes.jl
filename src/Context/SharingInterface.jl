export Share, Route, to_sharedcontext, to_sharedvar


"""
Whole name space from A1 to A2, optionally directional
"""
struct Share{A1,A2} <: AbstractOption
    algo1::A1
    algo2::A2
    directional::Bool
end

function Share(algo1, algo2; directional::Bool=false)
    Share{typeof(algo1), typeof(algo2)}(algo1, algo2, directional)
end

function to_sharedcontext(reg::NameSpaceRegistry, s::Share)
    names = (static_find_name(reg, s.algo1), static_find_name(reg, s.algo2))
    if any(isnothing, names)
        error("No registered name found for share endpoints $(s.algo1), $(s.algo2)")
    end
    nt = (; names[1] => SharedContext{ names[2] }())
    if !s.directional
        nt = (; nt..., names[2] => SharedContext{ names[1] }())
    end
    return nt
end

"""
User-facing route from one subcontext to another
"""
struct Route{F,T,N} <: AbstractOption
    from::F # From algo
    to::T   # To algo
    varnames::NTuple{N, Symbol}
    aliases::NTuple{N, Symbol}
end

function Route(from, to, originalname_or_aliaspairs::Union{Symbol, Pair{Symbol, Symbol}}...)
    completed_pairs = ntuple(length(originalname_or_aliaspairs)) do i
        item = originalname_or_aliaspairs[i]
        item isa Symbol ? item => item : item
    end
    varnames = first.(completed_pairs)
    aliases = last.(completed_pairs)
    Route{typeof(from), typeof(to), length(varnames)}(from, to, varnames, aliases)
end

struct SharedContext{from_name} end
contextname(st::Type{SharedContext{name}}) where {name} = name
contextname(st::SharedContext{name}) where {name} = name
contextname(::Any) = nothing

struct SharedVars{from_name, varnames, aliases} end
get_fromname(::Type{<:SharedVars{from_name}}) where {from_name} = from_name
get_fromname(::SharedVars{from_name}) where {from_name} = from_name
get_varname(::Type{<:SharedVars{from_name, varnames, aliases}}) where {from_name, varnames, aliases} = varnames
get_aliasname(::Type{<:SharedVars{from_name, varnames, aliases}}) where {from_name, varnames, aliases} = aliases
contextname(sv::Type{<:SharedVars{from_name}}) where {from_name} = from_name
contextname(sv::SharedVars{from_name}) where {from_name} = from_name

function Base.iterate(r::Union{SharedVars{F,V,SharedVarsA}, Type{SharedVars{F,V,SharedVarsA}}}, state = 1) where {F,V,SharedVarsA}
    if state > length(V)
        return nothing
    else
        return ( (V[state], SharedVarsA[state]), state + 1 )
    end
end

function to_sharedvar(reg::NameSpaceRegistry, r::Route)
    fromname = static_find_name(reg, r.from)
    toname = static_find_name(reg, r.to)
    (;toname => SharedVars{fromname, r.varnames, r.aliases}())
end

"""
From a collection of Share objects
Construct a namedtuple of (;target_namespace => SharedContext{origin_namespace},...)
Bi-directional shares are represented twice
"""
function resolve_shares(reg::NameSpaceRegistry, shares::Share...)
    if isempty(shares)
        return (;)
    end
    # all_sharedcontexts = merge(to_sharedcontext.(Ref(reg), shares)...)
    # return all_sharedcontexts
    named_flat_collect_broadcast(shares) do s
        to_sharedcontext(reg, s)
    end
end

"""
From a collection of Route objects
Construct a namedtuple of (;target_namespace => SharedVars{origin_namespace, varnames, aliases},...)
"""
function resolve_routes(reg::NameSpaceRegistry, routes::Route...)
    if isempty(routes)
        return (;)
    end
    # return map(route -> to_sharedvar(reg, route), routes)
    named_flat_collect_broadcast(routes) do route
        to_sharedvar(reg, route)
    end
end
