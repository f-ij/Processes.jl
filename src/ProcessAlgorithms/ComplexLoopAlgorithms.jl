getmultiplier(cla::ComplexLoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getname(cla::ComplexLoopAlgorithm, obj) = getname(getregistry(cla), obj)

get_sharedcontexts(cla::ComplexLoopAlgorithm) = cla.shared_contexts
get_sharedvars(cla::ComplexLoopAlgorithm) = cla.shared_vars
