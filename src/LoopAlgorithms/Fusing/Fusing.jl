export fuse, isfused

include("ContextExt.jl")

#=
Fusing for now splats non-routine LoopAlgorithms into one CompositeAlgorithm.

Requirements that might be loosened later:
    - Every type can only have one value
    - Cannot contain any Routines or already fused Composites
=#
"""
"""
# isfused(cla::Union{LoopAlgorithm, Type{<:LoopAlgorithm}}) = !isnothing(getid(cla))

function flatten_comp_funcs(funcs, _intervals)
    flat_funcs, flat_intervals = flat_tree_property_recursion(funcs, _intervals) do el, trait
        if !(el isa CompositeAlgorithm)
            return nothing, nothing
        end
        newels = getalgos(el)
        newtraits = intervals(el)
        return newels, trait.*newtraits
    end
    return flat_funcs, flat_intervals
end

"""
Deconstruct a CompositeAlgorithm into its functions and intervals
"""
function flatten(comp::CompositeAlgorithm)
    flatten_comp_funcs((comp,), (1,))
    # flat_funcs, flat_intervals = flat_tree_property_recursion((comp,), (1,)) do el, trait
    #     if !(el isa CompositeAlgorithm)
    #         return nothing, nothing
    #     end
    #     newels = getalgos(el)
    #     newtraits = intervals(el)
    #     return newels, trait.*newtraits
    # end
    # return flat_funcs, flat_intervals
end



function fuse(cla::LoopAlgorithm, name_prefix = "")
    if isfused(cla)
        return cla
    end

    flat_funcs, flat_intervals = flatten(cla)

    return CompositeAlgorithm(flat_funcs, flat_intervals)
end
