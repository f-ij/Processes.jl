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
function update_loopalgorithm_names(pa::ComplexLoopAlgorithm, base_registry)
    oldsfuncs = getfuncs(pa)
    funcs = update_loopalgorithm_names.(oldsfuncs, Ref(base_registry)) #Recursive replace ComplexLoopAlgorithm
    funcs = update_instance.(oldsfuncs, Ref(base_registry)) # Rename ScopedAlgorithms and remove old registries
    pa_new = newfuncs(pa, funcs)
    return pa_new
end

function update_loopalgorithm_names(a::Any, ::Any)
    return a
end

# @inline function mergeargs(args::NamedTuple, returnval)
#     if returnval isa NamedTuple
#         return (;args..., returnval...)
#     end
#     return args
#     # isnothing(returnval) ? args : (;args..., returnval...)
# end
# @inline function invert_namespace(args, name)
#     (;getproperty(args, name)..., globalargs = args)
# end

# @inline function namedstep!(namedalgo, args)
#     if hasname(namedalgo)
#         args = invert_namespace(args, getname(namedalgo))
#     end
#     @inline step!(namedalgo, args)
# end

instantiate(f) = f isa Type ? f() : f
