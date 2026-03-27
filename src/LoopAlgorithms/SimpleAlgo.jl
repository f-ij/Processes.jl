struct RepeatOne{N} <: AbstractArray{Int,1} end
RepeatOne(n::Integer) = RepeatOne{n}()
Base.getindex(::Union{RepeatOne{N}, Type{RepeatOne{N}}}, idx = nothing) where N = 1
Base.length(::Union{RepeatOne{N}, Type{RepeatOne{N}}}) where {N} = N
Base.iterate(ro::Union{RepeatOne{N}, Type{RepeatOne{N}}}, state = 1) where {N} = state > N ? nothing : (1, state + 1)


"""
Simple algo is base case for composite algorithms with all intervals set to 1
"""
const SimpleAlgo{T, S, O, id} = CompositeAlgorithm{T, <:RepeatOne, S, O, id}
SimpleAlgo(args...) = CompositeAlgorithm(args...)

@inline intervals(sa::SA) where SA <: SimpleAlgo = ntuple(_ -> 1, length(sa))
