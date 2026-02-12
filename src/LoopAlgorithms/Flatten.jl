
function flat_funcs(la::LoopAlgorithm)
    tree_flatten(la) do func
        if func isa Processes.LoopAlgorithm
            return Processes.getalgos(func)
        else
            return nothing
        end
    end
end

function flat_multipliers(la::LoopAlgorithm)
    @inline tree_trait_flatten(la, 1.) do func, multiplier
        if func isa Processes.LoopAlgorithm
            return getalgos(func), multiplier .* Processes.multipliers(func)
        else
            return nothing, nothing
        end
    end
end

flat_comp(t::Tuple) = flat_comp(t...)
flat_comp(a, b) = (a, b)
function flat_comp(ca::CompositeAlgorithm, interval)
    funcs = tree_flatten(ca) do func
        if func isa Processes.CompositeAlgorithm
            return Processes.getalgos(func)
        else
            return nothing
        end
    end

    intervals = tree_trait_flatten(ca, interval) do func, interval
        if func isa Processes.CompositeAlgorithm
            return getalgos(func), interval .* Processes.intervals(func)
        else 
            return nothing, nothing
        end
    end
    return funcs, intervals
end
