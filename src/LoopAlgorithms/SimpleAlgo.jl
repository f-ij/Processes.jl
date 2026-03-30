struct IntervalOnes{N} <: AbstractArray{Int,1} end
# struct One end
IntervalOnes(n::Integer) = IntervalOnes{n}()
Base.getindex(::Union{IntervalOnes{N}, Type{IntervalOnes{N}}}, idx = nothing) where N = Interval{1, :end, 0}()
Base.length(::Union{IntervalOnes{N}, Type{IntervalOnes{N}}}) where {N} = N
Base.iterate(ro::Union{IntervalOnes{N}, Type{IntervalOnes{N}}}, state = 1) where {N} = state > N ? nothing : (Interval{1, :end, 0}(), state + 1)
# Base.convert(Int, ::One) = 1
# Base.:(*)(::One, x) = x
# Base.:(*)(x, ::One) = x
# Base:(/)(::One, x) = x
# Base.:(/)(x, ::One) = x
# divides(num, ::One) = true


"""
Simple algo is base case for composite algorithms with all intervals set to 1
"""
const SimpleAlgo{T, S, O, id} = CompositeAlgorithm{T, <:IntervalOnes, S, O, id}
SimpleAlgo(args...) = CompositeAlgorithm(args...)

@inline intervals(sa::SA) where SA <: SimpleAlgo = ntuple(_ -> 1, length(sa))
