@inline _newpackage_context_seed(context) = (;)
@inline _newpackage_context_seed(context::SubContextView) = filter_nt((; context...), :_instance)

@inline function _newpackage_child_view(context::C, func, injected::I) where {C<:AbstractContext, I}
    return inject(context, injected)
end

@inline function _newpackage_child_view(context::SubContextView{CType, SubKey}, func::NewSubPackage, injected::I) where {CType<:ProcessContext, SubKey, I}
    return SubContextView{CType, SubKey, typeof(func), typeof(injected), getvaraliases(func), (), ()}(getcontext(context), func, injected)
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
    state_acc = _newpackage_init_states(pkg, context, acc, getstates(pkg))
    return _newpackage_init_children(pkg, context, state_acc, getalgos(pkg))
end

@inline function step!(pkg::NewPackage{F, S, I, ID}, context::C) where {F, S, I, ID, C<:AbstractContext}
    this_inc = inc(pkg)
    acc = (;)
    ret = @inline unrollreplace_withargs(acc, getalgos(pkg); args = (context, this_inc), zip = intervals(pkg)) do acc, func, context, this_inc, interval
        if @inline divides(this_inc, interval)
            view = @inline _newpackage_child_view(context, func, acc)
            step_ret = @inline step!(getalgo(func), view)
            isnothing(step_ret) && return acc
            return @inline merge(acc, step_ret)
        end
        return acc
    end
    @inline inc!(pkg)
    return ret
end

@inline function _newpackage_init_states(pkg::NewPackage, context::C, acc::Acc, states::States) where {C<:AbstractContext, Acc<:NamedTuple, States<:Tuple}
    if isempty(states)
        return acc
    end

    state = getfield(states, 1)
    ret = init(state, inject(context, acc))
    next_acc = isnothing(ret) ? acc : merge(acc, ret)
    return _newpackage_init_states(pkg, context, next_acc, Base.tail(states))
end

@inline function _newpackage_init_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple}
    if isempty(funcs)
        return acc
    end

    func = getfield(funcs, 1)
    view = _newpackage_child_view(context, func, acc)
    ret = init(getalgo(func), view)
    next_acc = isnothing(ret) ? acc : merge(acc, ret)
    return _newpackage_init_children(pkg, context, next_acc, Base.tail(funcs))
end
