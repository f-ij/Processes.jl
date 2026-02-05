
@inline function _algo_label(f)
    if f isa IdentifiableAlgo
        return Processes.IdentifiableAlgo_label(f)
    end
    return sprint(summary, f)
end

function Base.show(io::IO, ca::CompositeAlgorithm)
    println(io, "CompositeAlgorithm")
    funcs = ca.funcs
    if isempty(funcs)
        print(io, "  (empty)")
        return
    end
    _intervals = Processes.intervals(ca)
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

function Base.show(io::IO, sa::SimpleAlgo)
    funcs = sa.funcs
    if isempty(funcs)
        print(io, "SimpleAlgo (empty)")
        return
    end
    println(io, "SimpleAlgo")
    limit = get(io, :limit, false)
    for (idx, f) in enumerate(funcs)
        func_str = repr(f; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        print(io, "  | ", lines[1])
        for line in Iterators.drop(lines, 1)
            print(io, "\n  |   ", line)
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
    reps_is_type = reps isa Type
    limit = get(io, :limit, false)
    for (idx, thisfunc) in enumerate(funcs)
        rep = reps_is_type ? reps : reps[idx]
        suffix = reps_is_type ? " (repeats " * string(rep) * ")" : " (repeats " * string(rep) * " time(s))"
        func_str = repr(thisfunc; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        print(io, "  | ", lines[1], suffix)
        for line in Iterators.drop(lines, 1)
            print(io, "\n  |   ", line)
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
        if f isa IdentifiableAlgo
            push!(labels, Processes.IdentifiableAlgo_label(f))
        else
            push!(labels, summary(f))
        end
    end
    return labels
end

function _composite_algo_type_labels(types::Tuple)
    labels = String[]
    for t in types
        if t <: IdentifiableAlgo
            algo_type = t.parameters[1]
            push!(labels, string(nameof(algo_type), "@", Processes.getname(t)))
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
    funcs = ca.funcs
    if isempty(funcs)
        print(io, "CompositeAlgorithm (empty)")
        return
    end
    _intervals = Processes.intervals(ca)
    println(io, "CompositeAlgorithm")
    for (idx, f) in enumerate(funcs)
        interval = _intervals[idx]
        suffix = " (every " * string(interval) * " time(s))"
        print(io, "  | ", _algo_label(f), suffix)
        if idx < length(funcs)
            print(io, "\n")
        end
    end
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
    funcs = sa.funcs
    if isempty(funcs)
        print(io, "SimpleAlgo (empty)")
        return
    end
    println(io, "SimpleAlgo")
    limit = get(io, :limit, false)
    for (idx, f) in enumerate(funcs)
        func_str = repr(f; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        print(io, "  | ", lines[1])
        for line in Iterators.drop(lines, 1)
            print(io, "\n  |   ", line)
        end
        if idx < length(funcs)
            print(io, "\n")
        end
    end
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

function Base.summary(io::IO, r::Routine)
    funcs = r.funcs
    if isempty(funcs)
        print(io, "Routine (empty)")
        return
    end
    reps = repeats(r)
    reps_is_type = reps isa Type
    println(io, "Routine")
    limit = get(io, :limit, false)
    for (idx, f) in enumerate(funcs)
        rep = reps_is_type ? reps : reps[idx]
        suffix = reps_is_type ? " (repeats " * string(rep) * ")" : " (repeats " * string(rep) * " time(s))"
        func_str = repr(f; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        print(io, "  | ", lines[1], suffix)
        for line in Iterators.drop(lines, 1)
            print(io, "\n  |   ", line)
        end
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end

function Base.show(io::IO, rT::Type{<:Routine})
    dt = Base.unwrap_unionall(rT)
    if length(dt.parameters) == 0
        print(io, "Routine")
        return
    end
    ft = dt.parameters[1]
    if ft isa TypeVar
        print(io, "Routine")
        return
    end
    labels = _composite_algo_type_labels(ft.parameters)
    print(io, "Routine(", join(labels, ", "), ")")
end

"""
When composite is wrapped by a scope
"""
function Base.show(io::IO, sa::IdentifiableAlgo{F, Id, Aliases, AlgoName, ScopeName}) where {F<:CompositeAlgorithm, Id, Aliases, AlgoName, ScopeName}
    header = isnothing(algoname(sa)) ? "CompositeAlgorithm" : string(algoname(sa))
    println(io, header, "@", getname(sa))
    ca = getalgorithm(sa)
    funcs = getfuncs(ca)
    _intervals = intervals(ca)
    for (idx, f) in enumerate(funcs)
        interval = _intervals[idx]
        suffix = " (every " * string(interval) * " time(s))"
        print(io, "  | ", _algo_label(f), suffix)
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end
