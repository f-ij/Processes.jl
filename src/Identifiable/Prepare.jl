"""
Get the name from a IdentifiableAlgo and prepare the inputs for it
"""
@inline function prepare(sa::IdentifiableAlgo, inputcontext::AbstractContext)
    name = getname(sa)
    inputcontext = merge_into_subcontexts(inputcontext, (;name => (;_instance = sa)))
    inputview = @inline view(inputcontext, sa)
    prepared = @inline prepare(getalgorithm(sa), inputview)
    @inline replace(inputcontext, (;name => prepared))
end

"""
Direct prepare running for debugging
"""
@inline function prepare(sa::IdentifiableAlgo, input::NamedTuple = (;))
    return (;getname(sa) => prepare(getalgorithm(sa), input))
end

function cleanup(sa::IdentifiableAlgo, context::AbstractContext)
    contextview = view(context, sa)
    cleanup_args = @inline cleanup(getalgorithm(sa), contextview)
    @inline merge(contextview, cleanup_args)
end