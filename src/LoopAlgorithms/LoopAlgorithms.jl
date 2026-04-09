include("Utils.jl")
include("Interval.jl")
include("GetFirst.jl")
include("CompositeAlgorithms.jl")
include("SimpleAlgo.jl")
include("Routines.jl")
include("Setup.jl")
include("Preparation/Preparation.jl")
include("Resolving/Resolving.jl")
include("Init.jl")
include("Keys.jl")
include("Interface.jl")
include("Step.jl")
include("GeneratedStep.jl")
include("CompositeDSL.jl")
include("Fusing/Fusing.jl")
include("Flatten.jl")
include("Traits.jl")
include("BaseExt.jl")
include("ParameterReplacement.jl")
include("Showing.jl")





# function match_cla(claT1::Type{<:LoopAlgorithm}, checkobj)
#     if !(checkobj <: LoopAlgorithm)
#         return false
#     end
#     return getid(claT1) == getid(checkobj)
# end

"""
Raw loop algorithms match by object identity when passed as values.

This keeps existing wrapper surfaces like `IdentifiableAlgo(loopalgo, :name)`
and routed references from `@context` consistent without introducing any custom
DSL runtime machinery.
"""
@inline function match_by(la::LoopAlgorithm)
    if isbits(la)
        return la
    end
    return objectid(la)
end

"""Loop algorithm types match by their type."""
@inline match_by(t::Type{<:LoopAlgorithm}) = t
