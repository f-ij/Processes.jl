export setrepeats, setintervals, setinterval, setrepeats

function setrepeats(r::Routine{F, Repeats, NS}, newrepeats) where {F, Repeats, NS}
    normalized = map(x -> x isa Lifetime ? x : Repeat(x), Tuple(newrepeats))
    return Routine{typeof(getalgos(r)), typeof(normalized), typeof(getfield(r, :namespaces)), typeof(get_resume_idxs(r)), typeof(getwiring(r)), typeof(get_child_steps(r)), getid(r)}(
        getalgos(r),
        normalized,
        getfield(r, :namespaces),
        get_resume_idxs(r),
        getwiring(r),
        get_child_steps(r),
    )
end

function setintervals(r::Routine{F, Intervals, NS}, newintervals) where {F, Intervals, NS}
    return setrepeats(r, newintervals)
end

function setinterval(r::CompositeAlgorithm{F, Intervals, NS}, idx::Int, newinterval::Interval) where {F, Intervals, NS}
    updated_intervals = setindex(intervals(r), newinterval, idx)
    return setintervals(r, updated_intervals)
end

setinterval(r::CompositeAlgorithm{F, Intervals, NS}, idx::Int, newinterval::Number) where {F, Intervals, NS} = setinterval(r, idx, Interval(newinterval))

function setrepeats(r::CompositeAlgorithm{F, Repeats, NS}, idx::Int, newrepeats) where {F, Repeats, NS}
    updated_repeats = setindex(intervals(r), newrepeats, idx)
    return setintervals(r, updated_repeats)
end
