export SimpleAlgo, CompositeAlgorithm, Routine
export getname, step!, prepare, getmultiplier, getoptions, get_shares, get_routes

getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(get_registry(cla), obj)
getname(cla::LoopAlgorithm, obj) = getname(get_registry(cla), obj)
getoptions(cla::LoopAlgorithm) = getfield(cla, :options)

get_shares(cla::LoopAlgorithm) = filter(x -> x isa Share, getoptions(cla))
get_routes(cla::LoopAlgorithm) = filter(x -> x isa Route, getoptions(cla))  

@inline function Base.getindex(cla::LoopAlgorithm, idx)
    getfuncs(cla)[idx]
end