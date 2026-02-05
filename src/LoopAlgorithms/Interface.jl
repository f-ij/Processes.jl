export SimpleAlgo, CompositeAlgorithm, Routine
export getkey, step!, prepare, getmultiplier, getoptions, get_shares, get_routes

getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getkey(cla::LoopAlgorithm, obj) = getkey(getregistry(cla), obj)
getoptions(cla::LoopAlgorithm) = getfield(cla, :options)

get_shares(cla::LoopAlgorithm) = filter(x -> x isa Share, getoptions(cla))
get_routes(cla::LoopAlgorithm) = filter(x -> x isa Route, getoptions(cla)) 

getoptions(la::LoopAlgorithm, T::Type{O}) where O = filter(x -> x isa O, getoptions(la))


@inline function Base.getindex(cla::LoopAlgorithm, idx)
    getalgos(cla)[idx]
end