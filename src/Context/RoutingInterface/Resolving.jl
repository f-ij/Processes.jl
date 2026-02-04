#=
Resolving goes from Share and Route objects to SharedContext and SharedVars objects
    i.e. from user-facing routing/sharing definitions to backend definitions
=#

################################################
#################  RESOLVING  ##################
################################################


function resolve_options(reg::NameSpaceRegistry)
    return (;)
end

function resolve_options(reg::NameSpaceRegistry, options::AbstractOption...)
    if isempty(options)
        return (;)
    end
    shares = filter(x -> x isa Share, options)
    routes = filter(x -> x isa Route, options)

    return (resolve_options(reg, shares...)..., resolve_options(reg, routes...)...)
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
function resolve_options(reg::NameSpaceRegistry, routes::Route...)
    if isempty(routes)
        return (;)
    end
    # return map(route -> to_sharedvar(reg, route), routes)
    named_flat_collect_broadcast(routes) do route
        to_sharedvar(reg, route)
    end
end
