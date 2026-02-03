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
isfused(cla::Union{LoopAlgorithm, Type{<:LoopAlgorithm}}) = !isnothing(getid(cla))

"""
Deconstruct a CompositeAlgorithm into its functions and intervals
"""
function flatten(comp::CompositeAlgorithm)
    flat_funcs, flat_intervals = flat_tree_property_recursion((comp,), (1,)) do el, trait
        if !(el isa CompositeAlgorithm)
            return nothing, nothing
        end
        newels = getfuncs(el)
        newtraits = intervals(el)
        return newels, trait.*newtraits
    end
    return flat_funcs, flat_intervals
end

function fuse(cla::LoopAlgorithm, name_prefix = "")
    if isfused(cla)
        return cla
    end
    
    # fusename = Symbol(name_prefix,"_fused_", gensym())
    # new_cla = replace_all_names(cla, fusename)
    # new_cla = setid(new_cla, uuid4())

    flat_funcs, flat_intervals = flatten(cla)

    return CompositeAlgorithm(flat_funcs, flat_intervals)
    # flat_funcs = replace_all_names.(flat_funcs, fusename)

    # @DebugMode println("Fusing LoopAlgorithm ", cla, " into ", fusename, " with ", length(flat_funcs), " functions.")

    # id = uuid4()

    # # fused = IdentifiableAlgo(CompositeAlgorithm(flat_funcs, flat_intervals; id), fusename,; customname = fusename)
end
