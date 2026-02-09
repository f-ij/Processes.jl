
################################################
##################  ROUTES  ####################
################################################

"""
User-facing route from one subcontext to another
"""
struct Route{F,T,N, FT} <: AbstractOption
    from::F # From algo
    to::T   # To algo
    varnames::NTuple{N, Symbol}
    aliases::NTuple{N, Symbol}
    transform::FT
end

function Route(from, to, originalname_or_aliaspairs::Union{Symbol, Pair{Symbol, Symbol}}...; transform = nothing)
    @assert (from isa ProcessEntity) || from <: ProcessEntity "Origin of a Route must be a ProcessAlgorithm or ProcessState. Got: $from"
    @assert (to isa ProcessEntity) || to <: ProcessEntity "Target of a Route must be a ProcessAlgorithm or ProcessState. Got: $to"
    completed_pairs = ntuple(length(originalname_or_aliaspairs)) do i
        item = originalname_or_aliaspairs[i]
        item isa Symbol ? item => item : item
    end
    varnames = first.(completed_pairs)
    aliases = last.(completed_pairs)
    Route{typeof(from), typeof(to), length(varnames), typeof(transform)}(from, to, varnames, aliases, transform)
end