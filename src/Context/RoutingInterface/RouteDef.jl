
################################################
##################  ROUTES  ####################
################################################

"""
User-facing route from one subcontext to another
"""
struct Route{F,T,N} <: AbstractOption
    from::F # From algo
    to::T   # To algo
    varnames::NTuple{N, Symbol}
    aliases::NTuple{N, Symbol}
end

function Route(from, to, originalname_or_aliaspairs::Union{Symbol, Pair{Symbol, Symbol}}...)
    completed_pairs = ntuple(length(originalname_or_aliaspairs)) do i
        item = originalname_or_aliaspairs[i]
        item isa Symbol ? item => item : item
    end
    varnames = first.(completed_pairs)
    aliases = last.(completed_pairs)
    Route{typeof(from), typeof(to), length(varnames)}(from, to, varnames, aliases)
end