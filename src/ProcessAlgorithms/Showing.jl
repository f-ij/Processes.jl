
function Base.show(io::IO, ca::CompositeAlgorithm)
    println(io, "CompositeAlgorithm")
    funcs = ca.funcs
    if isempty(funcs)
        print(io, "  (empty)")
        return
    end
    _intervals = intervals(ca)
    limit = get(io, :limit, false)
    for (idx, thisfunc) in enumerate(funcs)
        interval = _intervals[idx]
        func_str = repr(thisfunc; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        suffix = " (every " * string(interval) * " time(s))"
        print(io, "  | ", lines[1], suffix)
        for line in Iterators.drop(lines, 1)
            print(io, "\n  | ", line)
        end
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end


function Base.show(io::IO, r::Routine)
    println(io, "Routine")
    funcs = r.funcs
    if isempty(funcs)
        print(io, "  (empty)")
        return
    end
    reps = repeats(r)
    limit = get(io, :limit, false)
    for (idx, thisfunc) in enumerate(funcs)
        rep = reps[idx]
        func_str = repr(thisfunc; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        suffix = " (repeats " * string(rep) * " time(s))"
        print(io, "  | ", lines[1], suffix)
        for line in Iterators.drop(lines, 1)
            print(io, "\n  | ", line)
        end
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end

"""
Custom display helpers for composite algorithms.
"""

function _composite_algo_labels(funcs)
    labels = String[]
    for f in funcs
        if f isa ScopedAlgorithm
            push!(labels, scopedalgorithm_label(f))
        else
            push!(labels, summary(f))
        end
    end
    return labels
end

function _composite_algo_type_labels(types::Tuple)
    labels = String[]
    for t in types
        if t <: ScopedAlgorithm
            algo_type = t.parameters[1]
            push!(labels, string(nameof(algo_type), "@", getname(t)))
        else
            push!(labels, string(nameof(t)))
        end
    end
    return labels
end

function _composite_algo_type_labels(types::Core.SimpleVector)
    return _composite_algo_type_labels(tuple(types...))
end

function Base.summary(io::IO, ca::CompositeAlgorithm)
    labels = _composite_algo_labels(ca.funcs)
    print(io, "CompositeAlgorithm(", join(labels, ", "), ")")
end

function Base.show(io::IO, caT::Type{<:CompositeAlgorithm})
    dt = Base.unwrap_unionall(caT)
    if length(dt.parameters) == 0
        print(io, "CompositeAlgorithm")
        return
    end
    ft = dt.parameters[1]
    if ft isa TypeVar
        print(io, "CompositeAlgorithm")
        return
    end
    labels = _composite_algo_type_labels(ft.parameters)
    print(io, "CompositeAlgorithm(", join(labels, ", "), ")")
end

function Base.summary(io::IO, sa::SimpleAlgo)
    labels = _composite_algo_labels(sa.funcs)
    print(io, "SimpleAlgo(", join(labels, ", "), ")")
end

function Base.show(io::IO, saT::Type{<:SimpleAlgo})
    dt = Base.unwrap_unionall(saT)
    if length(dt.parameters) == 0
        print(io, "SimpleAlgo")
        return
    end
    ft = dt.parameters[1]
    if ft isa TypeVar
        print(io, "SimpleAlgo")
        return
    end
    labels = _composite_algo_type_labels(ft.parameters)
    print(io, "SimpleAlgo(", join(labels, ", "), ")")
end
