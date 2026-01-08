reset!(a::Any) = nothing

function replace_name!(pa::ComplexLoopAlgorithm, idx, newname::Symbol) 
    oldnames = getnames(pa)
    newnames = ntuple(i -> i == idx ? newname : oldnames[i], length(oldnames))
    pa.names = newnames
end

getregistry(pa::ComplexLoopAlgorithm) = pa.registry
getregistry(a::Any) = NameSpaceRegistry()

get_registry(pa::ComplexLoopAlgorithm) = pa.registry
get_registry(a::Any) = NameSpaceRegistry()

"""
Obtain all the registriees, merge them and update the names downwards in the algorithm accordingly
"""
function update_loopalgorithm_names(pa::ComplexLoopAlgorithm, replacements::Vector{Pair{Symbol,Symbol}})
    oldsfuncs = getfuncs(pa)
    funcs = update_loopalgorithm_names.(oldsfuncs, Ref(replacements)) #Recursive replace ComplexLoopAlgorithm
    funcs = replacename.(oldsfuncs, Ref(replacements)) # Rename NamedAlgorithms
    pa_new = newfuncs(pa, funcs)
    return pa_new
end

function update_loopalgorithm_names(a::Any, ::Any)
    return a
end

@inline function mergeargs(args::NamedTuple, returnval)
    if returnval isa NamedTuple
        return (;args..., returnval...)
    end
    return args
    # isnothing(returnval) ? args : (;args..., returnval...)
end
@inline function invert_namespace(args, name)
    (;getproperty(args, name)..., globalargs = args)
end

@inline function namedstep!(namedalgo, args)
    if hasname(namedalgo)
        args = invert_namespace(args, getname(namedalgo))
    end
    @inline step!(namedalgo, args)
end
