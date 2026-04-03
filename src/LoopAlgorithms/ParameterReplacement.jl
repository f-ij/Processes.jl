export setrepeats, setintervals, setinterval, setrepeats

function setrepeats(r::Routine{F, Repeats}, newrepeats) where {F, Repeats}
    setparameter(r, 2, newrepeats)
end

function setintervals(r::Routine{F, Intervals}, newintervals) where {F, Intervals}
    setparameter(r, 2, newintervals)
end

function setinterval(r::CompositeAlgorithm{F, Intervals}, idx::Int, newinterval::Interval) where {F, Intervals}
    intervals = getparameter(r, 2)
    intervals = setindex(intervals, newinterval, idx)
    setparameter(r, 2, intervals)
end

setinterval(r::CompositeAlgorithm{F, Intervals}, idx::Int, newinterval::Number) where {F, Intervals} = setinterval(r, idx, Interval(newinterval))

function setrepeats(r::CompositeAlgorithm{F, Repeats}, idx::Int, newrepeats) where {F, Repeats}
    repeats = getparameter(r, 2)
    repeats = setindex(repeats, newrepeats, idx)
    setparameter(r, 2, repeats)
end