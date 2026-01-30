function flat_ntuple(f, n)
    if n <= 0
        return tuple()
    else
        ret = f(n)
        if ret isa Tuple
            return (ret..., flat_ntuple(f, n - 1)...)
        else
            return (ret, flat_ntuple(f, n - 1)...)
        end
    end
end


function flat_tree_property_recursion(nodefunc, elements::Tuple, traits::Tuple, mask = ntuple(_ -> true, length(elements)))
    function tuple_tuple_to_mask(t::Tuple, mask)
        flat_ntuple(i -> inner_tuple_to_mask(t[i], mask[i]), length(t))
    end

    inner_tuple_to_mask(t::Tuple, mask_el) = ntuple(i -> mask_el && !isnothing(t[1]), length(t))

    # @show elements
    # @show traits
    # @show mask

    if all(mask .== false)
        return elements, traits
    end

    level_pairs = ntuple(length(elements)) do i
        if mask[i] #Lets it through
            thisel = elements[i]
            thistrait = traits[i]
            els, newtraits = nodefunc(thisel, thistrait)
            if !isnothing(els)
                if els isa Tuple
                    return (els...,), (newtraits...,)
                else
                    return (tuple(els), tuple(newtraits))
                end
            else
                return tuple(nothing), tuple((nothing))
            end
            return (tuple(thisel), tuple(thistrait))
        end
    end

    justnodes = first.(level_pairs)
    justtraits = last.(level_pairs)


    # @show justnodes
    # @show justtraits
    new_mask = tuple_tuple_to_mask(justnodes, mask)
    # @show new_mask
    flat_replaced_nodes = flat_ntuple(i -> new_mask[i] ? justnodes[i] : elements[i], length(justnodes))
    flat_replaced_traits = flat_ntuple(i -> new_mask[i] ? justtraits[i] : traits[i], length(justtraits))
    return @inline flat_tree_property_recursion(nodefunc, flat_replaced_nodes, flat_replaced_traits, new_mask)
end

using Test

#  If value > 0, split into two children; otherwise terminate
function nodefunc(n::Node, trait::Int)
    if n.value > 0
        left  = Node(n.value - 1)
        right = Node(n.value - 1)
        return ((left, right), (trait + 1, trait + 2))
    else
        return nothing, nothing
    end
end

elements = (Node(2),)
traits = (10,)

final_nodes, final_traits = flat_tree_property_recursion(nodefunc, elements, traits)

@test final_nodes == (Node(0), Node(0), Node(0), Node(0))  # 1 → 2 → 4 leaves
@test final_traits == (12, 13, 13, 14)                    # traits propagated per split









