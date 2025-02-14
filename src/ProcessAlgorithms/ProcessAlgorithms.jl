include("SimpleAlgo.jl")
include("CompositeAlgorithms.jl")
include("Routines.jl")

"""
Prepare function for Composite algorithms and Routines
    Counts the number of unique algorithms and only prepares each unique algorithm once
"""
function prepare(pa::Union{CompositeAlgorithm, Routine}, args)
    unique_algos = UniqueAlgoTracker(pa)
    prepare(unique_algos, args)
end

function cleanup(pa::Union{CompositeAlgorithm, Routine}, args)
    unique_algos = UniqueAlgoTracker(pa)
    cleanup(unique_algos, args)
end

