const ProcessEntity = Union{ProcessState, ProcessAlgorithm}

init(::ProcessEntity, context) = (;)
step!(pe::ProcessEntity, context) = error("step! not implemented for $(typeof(pe))")
cleanup(::ProcessEntity, context) = (;)



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