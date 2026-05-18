@inline _newpackage_return_tuple(ret::NamedTuple) = ret
@inline _newpackage_return_tuple(::Nothing) = (;)
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
