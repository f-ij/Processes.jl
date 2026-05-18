"""
Build a package from prepared child algorithms.

Child algorithms are converted to `NewSubPackage` wrappers. Package-local
aliases belong to those wrappers, while `NewPackage` itself only carries the
schedule, init-only states, and call counter.
"""
function NewPackage(funcs::Funcs, intervals::Intervals; states::States = (), aliases = ntuple(_ -> VarAliases(), length(funcs)), name = Symbol(), id = TreeMatcher()) where {Funcs<:Tuple, Intervals<:Tuple, States<:Tuple}
    length(funcs) == length(intervals) || error("NewPackage needs one interval per child algorithm, got $(length(funcs)) funcs and $(length(intervals)) intervals.")
    length(funcs) == length(aliases) || error("NewPackage needs one alias bucket per child algorithm, got $(length(funcs)) funcs and $(length(aliases)) alias buckets.")
    children = newpackage_children(funcs, aliases, id)
    return NewPackage{typeof(children), States, intervals, id}(children, states, Ref(1))
end

"""
Build a package from a loop wrapper by packaging its plan and root states.
"""
function NewPackage(la::LoopAlgorithm, name = Symbol())
    return NewPackage(getplan(la), getstates(la), name)
end

"""
Build a package from a composite execution plan.

Route metadata is converted into a child-aligned `aliases` tuple. Root states
from the wrapper/composite are stored as explicit package `states`.
"""
function NewPackage(comp::CompositeAlgorithm, name = Symbol())
    return NewPackage(comp, (), name)
end

function NewPackage(comp::CompositeAlgorithm, states::States, name = Symbol()) where {States<:Tuple}
    identifiable_funcs = getalgos(comp)
    package_intervals = intervals(comp)
    routes = typefilter(Route, getoptions(comp))
    aliases = newpackage_aliases(identifiable_funcs, setup_registry(comp), routes)
    package_states = (states..., getstates(comp)...)
    customname = name == Symbol() || name == "" ? Symbol() : Symbol(name)
    return NewPackage(identifiable_funcs, package_intervals; states = package_states, aliases, name = customname)
end

function newpackage_children(funcs::Funcs, aliases::Aliases, id) where {Funcs<:Tuple, Aliases<:Tuple}
    return ntuple(i -> NewSubPackage(getfield(funcs, i), id, getfield(aliases, i)), length(funcs))
end

@inline varalias_pairs(::VarAliases{StoA, AtoS}) where {StoA, AtoS} = pairs(StoA)
@inline varalias_pairs(::Nothing) = ()

function newpackage_aliases(funcs::Funcs, registry::NameSpaceRegistry, routes::Routes) where {Funcs<:Tuple, Routes<:Tuple}
    return ntuple(i -> newpackage_alias(getfield(funcs, i), registry, routes), length(funcs))
end

@inline newpackage_base_aliases(func) = VarAliases()
@inline newpackage_base_aliases(func::AbstractIdentifiableAlgo) = getvaraliases(func)

function newpackage_alias(func, registry::NameSpaceRegistry, routes::Routes) where {Routes<:Tuple}
    pairs = varalias_pairs(newpackage_base_aliases(func))
    if isempty(routes)
        return VarAliases(;pairs...)
    end
    return newpackage_alias(func, registry, routes, pairs)
end

function newpackage_alias(func, registry::NameSpaceRegistry, routes::Routes, pairs) where {Routes<:Tuple}
    if isempty(routes)
        return VarAliases(;pairs...)
    end

    route = getfield(routes, 1)
    target = getto(route)
    next_pairs = match(func, target) ? (pairs..., route_to_alias_zip(route, registry)...) : pairs
    return newpackage_alias(func, registry, Base.tail(routes), next_pairs)
end
