const ProcessEntity = Union{ProcessState, ProcessAlgorithm}

"""
Process entities match by value if a value is given
"""
match_by(pe::ProcessEntity) = pe
"""
Process entity types match by their type
"""
match_by(t::Type{<:ProcessEntity}) = t

include("ProcessStates/ProcessStates.jl")
include("ProcessAlgorithms.jl")