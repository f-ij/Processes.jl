
@inline function _maybe_scoped_label(name, key)
    if isnothing(key)
        return string(name)
    end
    return string(name, "@", key)
end

@inline function _abstract_identifiable_label(sa::AbstractIdentifiableAlgo)
    name = algoname(sa)
    label = isnothing(name) ? sprint(summary, getalgo(sa)) : string(name)
    return _maybe_scoped_label(label, getkey(typeof(sa)))
end

@inline function _packaged_algo_label(f)
    if f isa IdentifiableAlgo
        return Processes.IdentifiableAlgo_label(f)
    end
    if f isa AbstractIdentifiableAlgo
        return _abstract_identifiable_label(f)
    end
    return sprint(summary, f)
end

function Base.show(io::IO, sp::SubPackage)
    algo_repr = sprint(show, getalgo(sp))
    print(io, _abstract_identifiable_label(sp), ": ", algo_repr)
    @static if debug_mode()
        print(io, " [match_by=", match_by(sp), "]")
    end
end

@inline function _packaged_intervals(pa::PackagedAlgo)
    _intervals = Processes.intervals(pa)
    if _intervals isa Tuple
        return _intervals
    end
    return ntuple(_ -> 1, length(getalgos(pa)))
end

function Base.show(io::IO, pa::PackagedAlgo)
    println(io, "PackagedAlgo")
    funcs = pa.funcs
    if isempty(funcs)
        print(io, "  (empty)")
        return
    end
    _intervals = _packaged_intervals(pa)
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

function Base.summary(io::IO, pa::PackagedAlgo)
    funcs = pa.funcs
    if isempty(funcs)
        print(io, "PackagedAlgo (empty)")
        return
    end
    _intervals = _packaged_intervals(pa)
    println(io, "PackagedAlgo")
    for (idx, f) in enumerate(funcs)
        interval = _intervals[idx]
        suffix = " (every " * string(interval) * " time(s))"
        print(io, "  | ", _packaged_algo_label(f), suffix)
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end

function _packaged_algo_type_labels(types::Tuple)
    labels = String[]
    for t in types
        if t <: IdentifiableAlgo
            algo_type = t.parameters[1]
            push!(labels, string(nameof(algo_type), "@", getkey(t)))
        elseif t <: AbstractIdentifiableAlgo
            algo_type = t.parameters[1]
            push!(labels, string(nameof(algo_type), "@", getkey(t)))
        else
            push!(labels, string(nameof(t)))
        end
    end
    return labels
end

function _packaged_algo_type_labels(types::Core.SimpleVector)
    return _packaged_algo_type_labels(tuple(types...))
end

function Base.show(io::IO, paT::Type{<:PackagedAlgo})
    dt = Base.unwrap_unionall(paT)
    if length(dt.parameters) == 0
        print(io, "PackagedAlgo")
        return
    end
    ft = dt.parameters[1]
    if ft isa TypeVar
        print(io, "PackagedAlgo")
        return
    end
    labels = _packaged_algo_type_labels(ft.parameters)
    print(io, "PackagedAlgo(", join(labels, ", "), ")")
end
