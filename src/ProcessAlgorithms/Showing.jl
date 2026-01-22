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

function Base.show(io::IO, ::Type{<:CompositeAlgorithm{FT}}) where {FT}
    labels = _composite_algo_type_labels(FT.parameters)
    print(io, "CompositeAlgorithm(", join(labels, ", "), ")")
end
