reset!(a::Any) = nothing

function replace_name!(pa::LoopAlgorithm, idx, newname::Symbol) 
    oldnames = getnames(pa)
    newnames = ntuple(i -> i == idx ? newname : oldnames[i], length(oldnames))
    pa.names = newnames
end

getregistry(pa::LoopAlgorithm) = pa.registry
getregistry(a::Any) = NameSpaceRegistry()

"""
Obtain all the registriees, merge them and update the names downwards in the algorithm accordingly
"""
function update_names(cla::LoopAlgorithm, base_registry::NameSpaceRegistry)
    oldsfuncs = getalgos(cla)
    @DebugMode "Updating names for LoopAlgorithm: $cla using base registry: $base_registry"
    newfuncs = update_names.(oldsfuncs, Ref(base_registry)) #Recursive replace LoopAlgorithm
    # newfuncs = update_name.(funcs, Ref(base_registry)) # Rename IdentifiableAlgos and remove old registries
    updated_registry = update_names(getregistry(cla), base_registry)
    cla = setfield(cla, :funcs, newfuncs)
    cla = setfield(cla, :registry, updated_registry)
    return cla
    # pa_new = newfuncs(pa, funcs)
    # update_names(pa_new, base_registry)
end

function recursive_update_cla_names(a::Any, ::Any)
    return a
end

struct InstantiateError <: Exception
    f
    err::Exception
end

function Base.showerror(io::IO, e::InstantiateError)
    print(io, "instantiate(", e.f, ") failed. If you passed a Type, it must have a zero-arg constructor. Caused by: ")
    showerror(io, e.err)
end

function instantiate(f)
    try
        return f isa Type ? f() : f
    catch err
        throw(InstantiateError(f, err))
    end
end