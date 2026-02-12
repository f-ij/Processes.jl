
################################################
##################  ROUTES  ####################
################################################

"""
User-facing route from one subcontext to another
"""
struct Route{F,T,N, FT, varnames, aliases, Fmatch, Tmatch} <: AbstractOption
    from::F # From algo
    to::T   # To algo
    # varnames::NTuple{N, Symbol}
    # aliases::NTuple{N, Symbol}
    # transform::FT
end

function Route(from_to::Pair, originalname_or_aliaspairs::Union{Symbol, Pair{Symbol, Symbol}}...; transform = nothing)
    from, to = from_to
    @assert (from isa ProcessEntity) || from <: ProcessEntity "Origin of a Route must be a ProcessAlgorithm or ProcessState. Got: $from"
    @assert (to isa ProcessEntity) || to <: ProcessEntity "Target of a Route must be a ProcessAlgorithm or ProcessState. Got: $to"
    completed_pairs = ntuple(length(originalname_or_aliaspairs)) do i
        item = originalname_or_aliaspairs[i]
        item isa Symbol ? item => item : item
    end
    varnames = first.(completed_pairs)
    aliases = last.(completed_pairs)

    Fmatch = match_by(from)
    Tmatch = match_by(to)
    # @show typeof(from), typeof(to), Fmatch, Tmatch, transform Fmatch Tmatch
    Route{typeof(from), typeof(to), length(varnames), transform, varnames, aliases, Fmatch, Tmatch}(from, to)
end

@inline function _route_endpoint_label(x)
    if x isa IdentifiableAlgo
        return IdentifiableAlgo_label(x)
    elseif x isa Type
        return string(nameof(x))
    else
        return summary(x)
    end
end

# function Base.show(io::IO, r::Route)
#     print(io, "Route(", _route_endpoint_label(getfrom(r)), " -> ", _route_endpoint_label(getto(r)))

#     vns = getvarnames(r)
#     als = getaliases(r)
#     if !isempty(vns)
#         print(io, "; ")
#         for i in eachindex(vns)
#             print(io, vns[i])
#             if als[i] != vns[i]
#                 print(io, "=>", als[i])
#             end
#             if i < length(vns)
#                 print(io, ", ")
#             end
#         end
#     end

#     t = getransform(r)
#     if !isnothing(t)
#         print(io, "; transform=", summary(t))
#     end
#     print(io, ")")
# end
