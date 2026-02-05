function route_to_alias_zip(route::Route, registry::NameSpaceRegistry)
    origin_obj = getfrom(route)
    target_obj = getto(route)
    @assert origin_obj ∈ registry "Cannot convert Route: $route to Alias if origin object: $origin_obj is not in the registry"
    @assert target_obj ∈ registry "Cannot convert Route: $route to Alias if target object: $target_obj is not in the registry"

    _localnames = localnames(route)
    _subcontextvarnames = subcontextvarnames(route)
    
    # return VarAliases(;zip(_subcontextvarnames, _localnames)...)
    return zip(_subcontextvarnames, _localnames)
end

function set_aliases_from_routes(identifiable::IdentifiableAlgo, registry::NameSpaceRegistry, routes...)
    if isempty(routes)
        return identifiable
    end

    total_zip = tuple()
    for route in routes
        target_obj = getto(route)
        if match(identifiable, target_obj)
            total_zip = (total_zip..., route_to_alias_zip(route, registry)...)
        end
    end
    va = VarAliases(;total_zip...)
    return setaliases(identifiable, va)
end