"""
For patterns where we have to recursively replace a value from a function apply to a list of arguments,
we can unroll the recursion with this function

f requires two arguments: the value to be replaced, and the next argument from the list
"""
@inline function UnrollReplace(f, to_replace, args...)
    if isempty(args)
        return to_replace
    end
    first_arg = gethead(args)
    to_replace = @inline f(to_replace, first_arg)
    return @inline UnrollReplace(f, to_replace, gettail(args)...)
end


"""
For a function that will return a viariable number of outputs
    that is broadcasted over a variable number of inputs,
    recursively splat the outputs in a tuple
"""
@inline function flat_collect_broadcast(f, elements::Tuple)
    if isempty(elements)
        return tuple()
    end
    result = (f(gethead(elements))...,)
    result = (result..., _flat_collect_broadcast(f, gettail(elements))...)
end

@inline function _flat_collect_broadcast(f, elements::Tuple)
    if isempty(elements)
        return tuple()
    end
    return (f(gethead(elements))..., _flat_collect_broadcast(f, gettail(elements))...)
end


"""
For a function that will return a viariable number of outputs
    that is broadcasted over a variable number of inputs,
    recursively splat the outputs in a tuple
"""
@inline function named_flat_collect_broadcast(f, elements::Tuple)
    if isempty(elements)
        return (;)
    end
    result = (;f(gethead(elements))...,)
    result = (;result..., _named_flat_collect_broadcast(f, gettail(elements))...)
end

@inline function _named_flat_collect_broadcast(f, elements::Tuple)
    if isempty(elements)
        return (;)
    end
    return (;f(gethead(elements))..., _named_flat_collect_broadcast(f, gettail(elements))...)
end

"""
Ntuple, but if f returns a tuple, flatten it
"""
function flat_ntuple(f, n)
    function _flat_ntuple(f, n, idx)
        if idx > n
            return tuple()
        else
            ret = f(idx)
            if ret isa Tuple
                return (ret..., _flat_ntuple(f, n, idx + 1)...)
            else
                return (ret, _flat_ntuple(f, n, idx + 1)...)
            end
        end
    end
    return _flat_ntuple(f, n, 1)
end

"""
For tree like structures, where an apply returns (nodes...), (traits...)
    We recur down the tree applying f(node, trait) at each level, and flattening in the end

    A stop condition is that f(node, traits) = nothing, nothing

    f needs to be function that takes (node, trait) and returns tuple(newnodes), tuple(newtraits)

    In the end we will end up with a flat tuple of nodes and a flat tuple of traits
"""
function flat_tree_property_recursion(nodefunc, elements::Tuple, traits::Tuple, mask = ntuple(_ -> true, length(elements)))
    function tuple_tuple_to_mask(t::Tuple, mask)
        flat_ntuple(i -> inner_tuple_to_mask(t[i], mask[i]), length(t))
    end

    function inner_tuple_to_mask(tup::Tuple, mask_el)
        t = ntuple(i -> mask_el * !isnothing(tup[1]), length(tup))
        return t
    end

    if all(mask .== false)
        return elements, traits
    end
    level_pairs = ntuple(length(elements)) do i
        if mask[i]
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
                return (tuple(nothing), tuple(nothing))
            end
        else
            return (tuple(elements[i]), tuple(traits[i]))
        end
    end

    justnodes = first.(level_pairs)
    justtraits = last.(level_pairs)

    curr_mask = map(x -> !isnothing(first(x)), justnodes)
    next_mask = tuple_tuple_to_mask(justnodes, mask)
    flat_replaced_nodes = flat_ntuple(length(curr_mask)) do i
        curr_mask[i]  ? justnodes[i]  : elements[i]
    end
    flat_replaced_traits = flat_ntuple(length(curr_mask)) do i
        curr_mask[i]  ? justtraits[i]  : traits[i]
    end
    return @inline flat_tree_property_recursion(nodefunc, flat_replaced_nodes, flat_replaced_traits, next_mask)
end
