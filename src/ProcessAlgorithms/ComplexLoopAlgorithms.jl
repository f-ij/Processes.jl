getmultiplier(cla::ComplexLoopAlgorithm, obj) = getmultiplier(get_registry(cla), obj)
getname(cla::ComplexLoopAlgorithm, obj) = getname(get_registry(cla), obj)

get_sharedcontexts(cla::ComplexLoopAlgorithm) = cla.shared_contexts
get_sharedvars(cla::ComplexLoopAlgorithm) = cla.shared_vars
