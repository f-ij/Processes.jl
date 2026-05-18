"""
ProcessAlgorithm package that owns its child execution locally.

`NewPackage` is intentionally not an `AbstractIdentifiableAlgo` and does not
register its children as subpackages. The outer process sees one normal
`ProcessAlgorithm`; package init/step then orchestrate the enclosed algorithms
inside the package subcontext.
"""
struct NewPackage{Funcs, InitFuncs, Intervals, CustomName} <: ProcessAlgorithm
    funcs::Funcs
    initfuncs::InitFuncs
    inc::Base.RefValue{Int}
end

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
Build a package from a `CompositeAlgorithm`.

The composite is flattened into package-local child algorithms. Route metadata
is translated into child `VarAliases`, while root states are kept as init-only
children so they fill the package subcontext without becoming stepped
algorithms.
"""
function NewPackage(la::LoopAlgorithm, name = Symbol())
    return NewPackage(getplan(la), getstates(la), name)
end

function NewPackage(comp::CompositeAlgorithm, name = Symbol())
    return NewPackage(comp, (), name)
end

function NewPackage(comp::CompositeAlgorithm, states::States, name = Symbol()) where {States<:Tuple}
    flatfuncs = getalgos(comp)
    flatintervals = intervals(comp)
    registry = setup_registry(comp)
    routes = typefilter(Route, getoptions(comp))
    funcs = map(func -> func isa IdentifiableAlgo ? routes_to_varaliases(func, registry, routes...) : func, flatfuncs)
    initfuncs = (states..., getstates(comp)..., funcs...)
    customname = name == Symbol() || name == "" ? Symbol() : Symbol(name)
    return NewPackage(funcs, flatintervals; initfuncs, name = customname)
end

@inline getalgos(pkg::NewPackage) = getfield(pkg, :funcs)
@inline getalgo(pkg::NewPackage, idx) = getalgos(pkg)[idx]
@inline getinitalgos(pkg::NewPackage) = getfield(pkg, :initfuncs)
@inline getinc(pkg::NewPackage) = getfield(pkg, :inc)
@inline inc(pkg::NewPackage) = getinc(pkg)[]
@inline intervals(::Union{NewPackage{Funcs, InitFuncs, Intervals}, Type{<:NewPackage{Funcs, InitFuncs, Intervals}}}) where {Funcs, InitFuncs, Intervals} = Intervals
@inline interval(pkg::Union{NewPackage, Type{<:NewPackage}}, idx) = intervals(pkg)[idx]
@inline getname(::Union{NewPackage{Funcs, InitFuncs, Intervals, CustomName}, Type{<:NewPackage{Funcs, InitFuncs, Intervals, CustomName}}}) where {Funcs, InitFuncs, Intervals, CustomName} = CustomName
@inline reset!(pkg::NewPackage) = (getinc(pkg)[] = 1; reset!.(getalgos(pkg)); pkg)

@inline @generated function inc!(pkg::NewPackage)
    _lcm = lcm(intervals(pkg)...)
    return :(getinc(pkg)[] = mod1(getinc(pkg)[] + 1, $_lcm))
end

@inline _newpackage_return_tuple(ret::NamedTuple) = ret
@inline _newpackage_return_tuple(::Nothing) = ()
@inline _newpackage_inner(func) = func
@inline _newpackage_inner(func::AbstractIdentifiableAlgo) = getalgo(func)
@inline _newpackage_context_seed(context) = (;)
@inline _newpackage_context_seed(context::SubContextView) = filter_nt((; context...), :_instance)

@inline function _newpackage_child_view(context::C, func, injected::I) where {C<:AbstractContext, I}
    return inject(context, injected)
end

@inline function _newpackage_child_view(context::SubContextView{CType, SubKey}, func::AbstractIdentifiableAlgo, injected::I) where {CType<:ProcessContext, SubKey, I}
    return SubContextView{CType, SubKey, typeof(func), typeof(injected)}(getcontext(context), func; inject = injected)
end

@inline function _newpackage_child_multiplier(pkg::NewPackage, child)
    return _newpackage_child_multiplier(getalgos(pkg), intervals(pkg), child)
end

@inline function _newpackage_child_multiplier(funcs::Funcs, intervals::Intervals, child) where {Funcs<:Tuple, Intervals<:Tuple}
    if isempty(funcs)
        error("Child $(child) is not part of NewPackage child tuple $(funcs).")
    end
    if match(getfield(funcs, 1), child)
        return 1 / getinterval(getfield(intervals, 1))
    end
    return _newpackage_child_multiplier(Base.tail(funcs), Base.tail(intervals), child)
end

@inline function getmultiplier(contextview::SubContextView{CType, SubKey}, instance::AbstractIdentifiableAlgo) where {CType<:ProcessContext, SubKey}
    registered = getregistry(contextview)[SubKey]
    algo = getalgo(registered)
    if algo isa NewPackage
        return getmultiplier(getregistry(contextview), registered) * _newpackage_child_multiplier(algo, instance)
    end
    return getmultiplier(getregistry(contextview), instance)
end

@inline function getmultiplier(contextview::SubContextView{CType, SubKey}, subpackage::SubPackage) where {CType<:ProcessContext, SubKey}
    registry = getregistry(contextview)
    package = registry[subpackage]
    package_multiplier = static_get_multiplier(registry, package)
    sub_multiplier = getmultiplier(package, subpackage)
    return package_multiplier * sub_multiplier
end

@inline function init(pkg::NewPackage, context::C) where {C<:AbstractContext}
    acc = _newpackage_context_seed(context)
    return _newpackage_init_children(pkg, context, acc, getinitalgos(pkg))
end

@inline function _newpackage_init_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple}
    if isempty(funcs)
        return acc
    end

    func = getfield(funcs, 1)
    view = _newpackage_child_view(context, func, acc)
    ret = init(_newpackage_inner(func), view)
    next_acc = merge(acc, _newpackage_return_tuple(ret))
    return _newpackage_init_children(pkg, context, next_acc, Base.tail(funcs))
end

Base.@constprop :aggressive @inline function step!(pkg::NewPackage, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    this_inc = inc(pkg)
    acc = (;)
    ret = _newpackage_step_children(pkg, context, acc, getalgos(pkg), intervals(pkg), this_inc)
    inc!(pkg)
    return ret
end

@inline function _newpackage_step_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs, intervals::Intervals, this_inc) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple, Intervals<:Tuple}
    if isempty(funcs)
        return acc
    end

    func = getfield(funcs, 1)
    interval = getfield(intervals, 1)
    next_acc = if divides(this_inc, interval)
        view = _newpackage_child_view(context, func, acc)
        ret = step!(_newpackage_inner(func), view)
        merge(acc, _newpackage_return_tuple(ret))
    else
        acc
    end
    return _newpackage_step_children(pkg, context, next_acc, Base.tail(funcs), Base.tail(intervals), this_inc)
end

@inline function cleanup(pkg::NewPackage, context::C) where {C<:AbstractContext}
    acc = (;)
    return _newpackage_cleanup_children(pkg, context, acc, getalgos(pkg))
end

@inline function _newpackage_cleanup_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple}
    if isempty(funcs)
        return acc
    end

    func = getfield(funcs, 1)
    view = _newpackage_child_view(context, func, acc)
    ret = cleanup(_newpackage_inner(func), view)
    next_acc = merge(acc, _newpackage_return_tuple(ret))
    return _newpackage_cleanup_children(pkg, context, next_acc, Base.tail(funcs))
end
