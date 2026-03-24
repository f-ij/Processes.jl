const ProcessEntity = Union{ProcessState, ProcessAlgorithm}

init(::ProcessEntity, context) = (;)
step!(pe::ProcessEntity, context) = error("step! not implemented for $(typeof(pe))")
cleanup(::ProcessEntity, context) = (;)

include("Matching.jl")
include("Utils.jl")

include("ProcessStates/ProcessStates.jl")
include("ProcessAlgorithms.jl")
include("ProcessAlgorithmsNew.jl")
