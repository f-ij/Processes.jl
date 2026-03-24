export SimpleAlgo, CompositeAlgorithm, Routine
export getkey, step!, init, getmultiplier, getoptions, get_shares, get_routes

getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getkey(cla::LoopAlgorithm, obj) = getkey(getregistry(cla), obj)
getoptions(cla::LoopAlgorithm) = getfield(cla, :options)

get_shares(cla::LoopAlgorithm) = @inline filter_args(Share, getoptions(cla))
get_routes(cla::LoopAlgorithm) = @inline filter_args(Route, getoptions(cla)) 
get_states(cla::LoopAlgorithm) = getfield(cla, :states)

getoptions(la::LoopAlgorithm, T::Type{O}) where O = @inline filter_args(O, getoptions(la))

iscomposite(::Any) = false
iscomposite(::Type{<:LoopAlgorithm}) = false
iscomposite(::Type{<:CompositeAlgorithm}) = true
iscomposite(la::LoopAlgorithm) = iscomposite(typeof(la))

# Reset needs to be implemented
reset!(a::Any) = a

"""
Get the numbers Val(1), Val(2), ... Val(N) for the N algorithms in a composite or routine, as a tuple.
"""
@generated function algonvalumbers(ca::LoopAlgorithm)  
    nums = ntuple(i -> Val(i), numalgos(ca))
    return :($nums)
end

@inline function Base.getindex(cla::LoopAlgorithm, idx)
    getalgos(cla)[idx]
end
