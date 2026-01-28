"""
Get the name from a ScopedAlgorithm and prepare the inputs for it
"""
@inline function prepare(sa::ScopedAlgorithm, inputcontext::AbstractContext)
    name = getname(sa)
    inputview = @inline view(inputcontext, sa)
    prepared = @inline prepare(getalgorithm(sa), inputview)
    @inline replace(inputcontext, (;name => prepared))
end

"""
Direct prepare running for debugging
"""
@inline function prepare(sa::ScopedAlgorithm, input::NamedTuple = (;))
    return (;getname(sa) => prepare(getalgorithm(sa), input))
end

function cleanup(sa::ScopedAlgorithm, context::AbstractContext)
    contextview = view(context, sa)
    cleanup_args = @inline cleanup(getalgorithm(sa), contextview)
    @inline merge(contextview, cleanup_args)
end