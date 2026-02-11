include("Utils.jl")
include("GetFirst.jl")
include("CompositeAlgorithms.jl")
include("SimpleAlgo.jl")
include("Routines.jl")
include("Setup.jl")
include("Init.jl")
include("Interface.jl")
include("Step.jl")
include("GeneratedStep.jl")
include("Fusing/Fusing.jl")
include("IsBitsStorage.jl")
include("Widgets/Widgets.jl")


include("Showing.jl")





# function match_cla(claT1::Type{<:LoopAlgorithm}, checkobj)
#     if !(checkobj <: LoopAlgorithm)
#         return false
#     end
#     return getid(claT1) == getid(checkobj)
# end