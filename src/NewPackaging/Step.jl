@inline _newpackage_return_tuple(ret::NamedTuple) = ret
@inline _newpackage_return_tuple(::Nothing) = (;)
@inline _newpackage_inner(func) = func
@inline _newpackage_inner(func::AbstractIdentifiableAlgo) = getalgo(func)
@inline _newpackage_context_seed(context) = (;)
@inline _newpackage_context_seed(context::SubContextView) = filter_nt((; context...), :_instance)

@inline function _newpackage_child_view(context::C, func, injected::I, aliases) where {C<:AbstractContext, I}
    return inject(context, injected)
end

@inline function _newpackage_child_view(context::SubContextView{CType, SubKey}, func::AbstractIdentifiableAlgo, injected::I, aliases::Aliases) where {CType<:ProcessContext, SubKey, I, Aliases}
    return SubContextView{CType, SubKey, typeof(func), typeof(injected), Aliases, (), ()}(getcontext(context), func, injected)
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
    return _newpackage_init_children(pkg, context, state_acc, getalgos(pkg), getaliases(pkg))
end

@inline function step!(pkg::NewPackage{F, S, I, A}, context::C) where {F, S, I, A, C<:AbstractContext}
    this_inc = inc(pkg)
    intervals = intervals(pkg)
    acc = (;)
    ret = unrollreplace_withargs(acc, getalgos(pkg); args = (this_inc,), zip = intervals) do acc, func, this_inc, interval
        
    end

end

# @inline function _newpackage_init_states(pkg::NewPackage, context::C, acc::Acc, states::States) where {C<:AbstractContext, Acc<:NamedTuple, States<:Tuple}
#     if isempty(states)
#         return acc
#     end

#     state = getfield(states, 1)
#     ret = init(state, inject(context, acc))
#     next_acc = merge(acc, _newpackage_return_tuple(ret))
#     return _newpackage_init_states(pkg, context, next_acc, Base.tail(states))
# end

# @inline function _newpackage_init_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs, aliases::Aliases) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple, Aliases<:Tuple}
#     if isempty(funcs)
#         return acc
#     end

#     func = getfield(funcs, 1)
#     alias = getfield(aliases, 1)
#     view = _newpackage_child_view(context, func, acc, alias)
#     ret = init(_newpackage_inner(func), view)
#     next_acc = merge(acc, _newpackage_return_tuple(ret))
#     return _newpackage_init_children(pkg, context, next_acc, Base.tail(funcs), Base.tail(aliases))
# end

# Base.@constprop :aggressive @inline function step!(pkg::NewPackage, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
#     this_inc = inc(pkg)
#     acc = (;)
#     ret = _newpackage_step_children(pkg, context, acc, getalgos(pkg), intervals(pkg), getaliases(pkg), this_inc)
#     inc!(pkg)
#     return ret
# end

# @inline function _newpackage_step_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs, intervals::Intervals, aliases::Aliases, this_inc) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple, Intervals<:Tuple, Aliases<:Tuple}
#     if isempty(funcs)
#         return acc
#     end

#     func = getfield(funcs, 1)
#     interval = getfield(intervals, 1)
#     alias = getfield(aliases, 1)
#     next_acc = if divides(this_inc, interval)
#         view = _newpackage_child_view(context, func, acc, alias)
#         ret = step!(_newpackage_inner(func), view)
#         merge(acc, _newpackage_return_tuple(ret))
#     else
#         acc
#     end
#     return _newpackage_step_children(pkg, context, next_acc, Base.tail(funcs), Base.tail(intervals), Base.tail(aliases), this_inc)
# end

# @inline function cleanup(pkg::NewPackage, context::C) where {C<:AbstractContext}
#     acc = (;)
#     return _newpackage_cleanup_children(pkg, context, acc, getalgos(pkg), getaliases(pkg))
# end

# @inline function _newpackage_cleanup_children(pkg::NewPackage, context::C, acc::Acc, funcs::Funcs, aliases::Aliases) where {C<:AbstractContext, Acc<:NamedTuple, Funcs<:Tuple, Aliases<:Tuple}
#     if isempty(funcs)
#         return acc
#     end

#     func = getfield(funcs, 1)
#     alias = getfield(aliases, 1)
#     view = _newpackage_child_view(context, func, acc, alias)
#     ret = cleanup(_newpackage_inner(func), view)
#     next_acc = merge(acc, _newpackage_return_tuple(ret))
#     return _newpackage_cleanup_children(pkg, context, next_acc, Base.tail(funcs), Base.tail(aliases))
# end
