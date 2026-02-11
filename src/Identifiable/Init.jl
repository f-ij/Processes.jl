"""
Get the name from a IdentifiableAlgo and init the inputs for it
"""
@inline function init(sa::IdentifiableAlgo, inputcontext::AbstractContext)
    name = getkey(sa)
    inputcontext = merge_into_subcontexts(inputcontext, (;name => (;_instance = sa)))
    inputview = @inline view(inputcontext, sa)
    prepared = @inline init(getalgo(sa), inputview)
    @inline replace(inputcontext, (;name => prepared))
end

"""
Direct init running for debugging
"""
@inline function init(sa::IdentifiableAlgo, input::NamedTuple = (;))
    return (;getkey(sa) => init(getalgo(sa), input))
end

function cleanup(sa::IdentifiableAlgo, context::AbstractContext)
    contextview = view(context, sa)
    cleanup_args = @inline cleanup(getalgo(sa), contextview)
    @inline merge(contextview, cleanup_args)
end