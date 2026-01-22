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
