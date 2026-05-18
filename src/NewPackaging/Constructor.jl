"""
Build a package from prepared child algorithms.

`funcs` are the stepped algorithms. `states` are initialized once before those
children and are not stepped. `aliases` must be a tuple with one `VarAliases`
entry per child, so package-local route aliases are carried by the package
plan instead of being baked into child `IdentifiableAlgo` wrappers.
"""
function NewPackage(funcs::Funcs, intervals::Intervals; states::States = (), aliases::Aliases = ntuple(_ -> VarAliases(), length(funcs)), name = Symbol()) where {Funcs<:Tuple, Intervals<:Tuple, States<:Tuple, Aliases<:Tuple}
    length(funcs) == length(intervals) || error("NewPackage needs one interval per child algorithm, got $(length(funcs)) funcs and $(length(intervals)) intervals.")
    length(funcs) == length(aliases) || error("NewPackage needs one alias bucket per child algorithm, got $(length(funcs)) funcs and $(length(aliases)) alias buckets.")
    return NewPackage{Funcs, States, intervals, Aliases, Symbol(name)}(funcs, states, aliases, Ref(1))
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
    funcs = getalgos(comp)
    package_intervals = intervals(comp)
    routes = typefilter(Route, getoptions(comp))
    aliases = newpackage_aliases(funcs, setup_registry(comp), routes)
    package_states = (states..., getstates(comp)...)
    customname = name == Symbol() || name == "" ? Symbol() : Symbol(name)
    return NewPackage(funcs, package_intervals; states = package_states, aliases, name = customname)
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
