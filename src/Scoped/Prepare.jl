"""
Get the name from a ScopedAlgorithm and prepare the inputs for it
"""
@inline function prepare(sa::ScopedAlgorithm, inputcontext::AbstractContext)
    name = getname(sa)
    inputview = view(inputcontext, sa)
    replace(inputcontext, (;name => prepare(getalgorithm(sa), inputview)))
end

"""
Direct prepare running for debugging
"""
@inline function prepare(sa::ScopedAlgorithm, input::NamedTuple = (;))
    return (;getname(sa) => prepare(getalgorithm(sa), input))
end

function cleanup(sa::ScopedAlgorithm, context::AbstractContext)
    contextview = view(context, sa)
    cleanup_args = cleanup(getalgorithm(sa), contextview)
    merge(contextview, cleanup_args)
end