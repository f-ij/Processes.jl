function rebuild_with_instance_name(pa, encountered_instances::Vector = Pair{Any,Symbol}[], )
    for (func_idx, func) in enumerate(getfuncs(pa))
        if !(func isa ComplexLoopAlgorithm)
            push!(encountered_instances, func => getnames(pa,func_idx))
        end
    end
    if !(pa isa ComplexLoopAlgorithm)
        return pa
    end
    intial_funcs = getfuncs(pa)
    rebuilt_funcs = rebuild_with_instance_name.(intial_funcs, Ref(instance_name))
    funcs_and_names = zip(rebuilt_funcs, getnames(pa))
    final_funcnames = 

end