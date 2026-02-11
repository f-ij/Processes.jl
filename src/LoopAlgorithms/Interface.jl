export SimpleAlgo, CompositeAlgorithm, Routine
export getkey, step!, init, getmultiplier, getoptions, get_shares, get_routes

getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getkey(cla::LoopAlgorithm, obj) = getkey(getregistry(cla), obj)
getoptions(cla::LoopAlgorithm) = getfield(cla, :options)

get_shares(cla::LoopAlgorithm) = filter(x -> x isa Share, getoptions(cla))
get_routes(cla::LoopAlgorithm) = filter(x -> x isa Route, getoptions(cla)) 

getoptions(la::LoopAlgorithm, T::Type{O}) where O = filter(x -> x isa O, getoptions(la))

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