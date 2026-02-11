
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
