"""
Build a package from already prepared child algorithm tuples.

`funcs` are stepped according to `intervals`. `initfuncs` are initialized in
order and default to the same algorithms as `funcs`.
"""
function NewPackage(funcs::Funcs, intervals::Intervals; initfuncs::InitFuncs = funcs, name = Symbol()) where {Funcs<:Tuple, Intervals<:Tuple, InitFuncs<:Tuple}
    length(funcs) == length(intervals) || error("NewPackage needs one interval per child algorithm, got $(length(funcs)) funcs and $(length(intervals)) intervals.")
    return NewPackage{Funcs, InitFuncs, intervals, Symbol(name)}(funcs, initfuncs, Ref(1))
end

"""
Build a package from a loop wrapper by packaging its plan and root states.
"""
function NewPackage(la::LoopAlgorithm, name = Symbol())
    return NewPackage(getplan(la), getstates(la), name)
end

"""
Build a package from a composite execution plan.

Child route metadata is translated into child `VarAliases`. Root states are
kept as init-only children so they fill the package subcontext without becoming
stepped algorithms.
"""
function NewPackage(comp::CompositeAlgorithm, name = Symbol())
    return NewPackage(comp, (), name)
end

function NewPackage(comp::CompositeAlgorithm, states::States, name = Symbol()) where {States<:Tuple}
    funcs = getalgos(comp)
    package_intervals = intervals(comp)
    registry = setup_registry(comp)
    routes = typefilter(Route, getoptions(comp))
    routed_funcs = map(func -> func isa IdentifiableAlgo ? routes_to_varaliases(func, registry, routes...) : func, funcs)
    initfuncs = (states..., getstates(comp)..., routed_funcs...)
    customname = name == Symbol() || name == "" ? Symbol() : Symbol(name)
    return NewPackage(routed_funcs, package_intervals; initfuncs, name = customname)
end
