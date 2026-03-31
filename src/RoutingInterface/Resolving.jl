#=
Resolving goes from Share and Route objects to SharedContext and SharedVars objects
    i.e. from ***user-facing routing/sharing definitions to backend definitions***
=#

################################################
#################  RESOLVING  ##################
################################################
@inline resolve(reg::NameSpaceRegistry, options...) = @inline resolve_options(reg, options...)

function resolve_options(reg::NameSpaceRegistry)
    return (;)
end

"""
From a collection of Share objects
Construct a namedtuple of (;target_namespace => SharedContext{origin_namespace},...)
Bi-directional shares are represented twice
"""
function resolve_options(reg::NameSpaceRegistry, shares::Share...)
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
@inline function resolve_options(reg::NameSpaceRegistry, routes::Route...)
    if isempty(routes)
        return (;)
    end
    # @show routes
    # return map(route -> to_sharedvar(reg, route), routes)
    named_routes = (;)
    named_routes = unrollreplace(named_routes, routes...) do named_routes, route
        this_one = resolve_options(reg, route)
        name = first(keys(this_one))
        merged = (get(named_routes, name, tuple())..., this_one[1][1])
        (;named_routes..., name => merged)
    end
    # named_routes = resolve_options.(Ref(reg), routes)
    return named_routes
end

"""
Go from single route to SharedVar
    Also gives the target subcontext name for the route as a namedtuple key
"""
@inline function resolve_options(reg::NameSpaceRegistry, route::R) where R <: Route
    tosubcontextname, sharedvar = to_sharedvar(reg, route)
    return (;tosubcontextname => tuple(sharedvar))
end
