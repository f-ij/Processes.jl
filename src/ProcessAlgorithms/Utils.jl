reset!(a::Any) = nothing

function replace_name!(pa::ComplexLoopAlgorithm, idx, newname::Symbol) 
    oldnames = getnames(pa)
    newnames = ntuple(i -> i == idx ? newname : oldnames[i], length(oldnames))
    pa.names = newnames
end

get_registry(pa::ComplexLoopAlgorithm) = pa.registry
get_registry(a::Any) = NameSpaceRegistry()

"""
Obtain all the registriees, merge them and update the names downwards in the algorithm accordingly
"""
function recursive_update_cla_names(pa::ComplexLoopAlgorithm, base_registry)
    oldsfuncs = getfuncs(pa)

    funcs = recursive_update_cla_names.(oldsfuncs, Ref(base_registry)) #Recursive replace ComplexLoopAlgorithm
    funcs = update_scope.(funcs, Ref(base_registry)) # Rename ScopedAlgorithms and remove old registries
    pa_new = newfuncs(pa, funcs)
    update_scope(pa_new, base_registry)
end

function recursive_update_cla_names(a::Any, ::Any)
    return a
end

instantiate(f) = f isa Type ? f() : f
