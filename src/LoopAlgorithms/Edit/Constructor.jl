export insert, addalgo, addstate, addoption, rename, changeinterval, changeintervals

import Base: rename

@inline function _ensure_unresolved_for_edit(la::LoopAlgorithm)
    isresolved(la) && error("LoopAlgorithm edit tools currently require an unresolved loop algorithm. Edit the unresolved algorithm first, then call resolve again.")
    return la
end

@inline _stored_schedule_spec(::CompositeAlgorithm{T, Spec}) where {T, Spec} = Spec
@inline _stored_schedule_spec(::Routine{T, Repeats}) where {T, Repeats} = Repeats
@inline _stored_schedule_spec(::ThreadedCompositeAlgorithm{T, Spec}) where {T, Spec} = Spec

@inline _constructor_type(::CompositeAlgorithm) = CompositeAlgorithm
@inline _constructor_type(::Routine) = Routine
@inline _constructor_type(::ThreadedCompositeAlgorithm) = ThreadedCompositeAlgorithm

@inline function _rebuild_loopalgorithm(
    la::LoopAlgorithm;
    funcs = getalgos(la),
    states = getstates(la),
    options = getoptions(la),
    schedule_spec = _stored_schedule_spec(la),
)
    LoopAlgorithm(_constructor_type(la), funcs, states, options, schedule_spec; id = getid(la))
end

@inline _edit_entity(x) = x
@inline function _edit_entity(x::Pair)
    @assert x.first isa Symbol "If passing an edit entity as a pair, the first element must be a Symbol key, but got $(x.first)"
    return IdentifiableAlgo(x.second, x.first)
end

@inline function _tuple_insert(t::Tuple, idx::Integer, val)
    @assert 1 <= idx <= length(t) + 1 "Insert index $idx out of bounds for tuple of length $(length(t))"
    return (t[1:(idx - 1)]..., val, t[idx:end]...)
end

@inline function _tuple_replace(t::Tuple, idx::Integer, val)
    @assert 1 <= idx <= length(t) "Replace index $idx out of bounds for tuple of length $(length(t))"
    return tuple_setindex(t, val, idx)
end

@inline _default_schedule_entry(::Routine) = 1
@inline _default_schedule_entry(::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm}) = Interval(1)

@inline _normalize_schedule_entry(::Routine, spec) = spec
@inline _normalize_schedule_entry(::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm}, spec::Interval) = spec
@inline _normalize_schedule_entry(::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm}, spec::Real) = Interval(round(Int, spec))

@inline function _schedule_entries(la::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm})
    ntuple(i -> interval(la, i), length(getalgos(la)))
end

@inline function _schedule_entries(la::Routine)
    ntuple(i -> repeats(la, i), length(getalgos(la)))
end

@inline _collapse_schedule_spec(::Routine, entries::Tuple) = entries
@inline function _collapse_schedule_spec(::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm}, entries::Tuple)
    return all(==(Interval(1)), entries) ? IntervalOnes{length(entries)} : entries
end

@inline _rename_item(item, replacements::Tuple{Vararg{Pair}}) = replacecontextkeys(item, collect(replacements))
@inline _rename_item(item, replacement::Pair) = replacecontextkeys(item, replacement)

@inline function _rename_item(s::Share, replacements)
    Share(
        _rename_item(get_firstalgo(s), replacements),
        _rename_item(get_secondalgo(s), replacements);
        directional = is_directional(s),
    )
end

@inline function _rename_item(r::Route, replacements)
    varnames = getvarnames(r)
    aliases = getaliases(r)
    mappings = ntuple(i -> varnames[i] == aliases[i] ? varnames[i] : (varnames[i] => aliases[i]), length(varnames))
    return Route(
        _rename_item(getfrom(r), replacements) => _rename_item(getto(r), replacements),
        mappings...;
        transform = gettransform(r),
    )
end

function rename(la::LoopAlgorithm, replacements::Pair...)
    _ensure_unresolved_for_edit(la)
    funcs = map(x -> _rename_item(x, replacements), getalgos(la))
    states = map(x -> _rename_item(x, replacements), getstates(la))
    options = map(x -> _rename_item(x, replacements), getoptions(la))
    return _rebuild_loopalgorithm(la; funcs, states, options)
end

function insert(la::LoopAlgorithm, idx::Integer, algo, schedule_spec = _default_schedule_entry(la))
    _ensure_unresolved_for_edit(la)
    newfuncs = _tuple_insert(getalgos(la), idx, _edit_entity(algo))
    schedule_entries = _schedule_entries(la)
    new_schedule_entries = _tuple_insert(schedule_entries, idx, _normalize_schedule_entry(la, schedule_spec))
    return _rebuild_loopalgorithm(
        la;
        funcs = newfuncs,
        schedule_spec = _collapse_schedule_spec(la, new_schedule_entries),
    )
end

@inline addalgo(la::LoopAlgorithm, algo, schedule_spec = _default_schedule_entry(la)) = insert(la, length(getalgos(la)) + 1, algo, schedule_spec)

function addstate(la::LoopAlgorithm, state)
    _ensure_unresolved_for_edit(la)
    newstates = (getstates(la)..., _edit_entity(state))
    return _rebuild_loopalgorithm(la; states = newstates)
end

function addoption(la::LoopAlgorithm, option)
    _ensure_unresolved_for_edit(la)
    newoptions = (getoptions(la)..., option)
    return _rebuild_loopalgorithm(la; options = newoptions)
end

function changeintervals(la::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm}, newintervals)
    _ensure_unresolved_for_edit(la)
    interval_entries = Tuple(newintervals)
    @assert length(interval_entries) == length(getalgos(la)) "Expected $(length(getalgos(la))) intervals, but got $(length(interval_entries))"
    normalized = map(x -> _normalize_schedule_entry(la, x), interval_entries)
    return _rebuild_loopalgorithm(
        la;
        schedule_spec = _collapse_schedule_spec(la, normalized),
    )
end

function changeinterval(la::Union{CompositeAlgorithm, ThreadedCompositeAlgorithm}, idx::Integer, newinterval)
    _ensure_unresolved_for_edit(la)
    normalized = _normalize_schedule_entry(la, newinterval)
    interval_entries = _tuple_replace(_schedule_entries(la), idx, normalized)
    return _rebuild_loopalgorithm(
        la;
        schedule_spec = _collapse_schedule_spec(la, interval_entries),
    )
end
