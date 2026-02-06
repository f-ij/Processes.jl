"""
Set up an empty ProcessContext for a LoopAlgorithm with given shared specifications
Inputargs are given as a NamedTuple of (;algo_name => (; inputname1 = value1, ...), ...)
"""
function prepare(algos::LoopAlgorithm, inputcontext::ProcessContext)
    registry = getregistry(algos)
    named_algos = all_algos(registry)

    context = UnrollReplace(inputcontext, named_algos...) do context, named_algo # Recursively replace context
        prepare(named_algo, context)
    end

    # newcontext = replace(inputcontext, prepared_subcontexts)
    
    return context
end

function cleanup(algos::LoopAlgorithm, context)
    registry = getregistry(algos)
    named_algos = all_algos(registry)

    context = UnrollReplace(context, named_algos...) do context, named_algo # Recursively replace context
        cleanup(named_algo, context)
    end
    
    return context
end

function prepare(algos::LoopAlgorithm, input::NamedTuple = (;))
    # If prepared from a namedtuple, create an empty context first
    newcontext = ProcessContext(algos)
    
    registry = getregistry(algos)
    named_algos = all_named_algos(registry)


    prepared_subcontexts = named_flat_collect_broadcast(named_algos) do named_algo
        prepare(named_algo, get(input, getkey(named_algo), (;)))
    end


    newcontext = replace(newcontext, prepared_subcontexts)
    
    return newcontext
end