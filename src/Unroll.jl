"""
For patterns where we have to recursively replace a value from a function apply to a list of arguments,
we can unroll the recursion with this function

f requires two arguments: the value to be replaced, and the next argument from the list
"""
# @inline function unrollreplace(f::F, to_replace::C, args...) where {F, C}
#     if isempty(args)
#         return to_replace
#     end
#     first_arg = gethead(args)
#     to_replace = @inline f(to_replace, first_arg)
#     return @inline unrollreplace(f, to_replace, gettail(args)...)
# end

# @inline @generated function unrollreplace(f::F, to_replace::C, args...) where {F, C}
#     num_args = length(args)
#     replaceblocks = Expr(:block, (Expr(:(=), :to_replace, Expr(:call, :f, :to_replace, Expr(:call, :getindex, :args, i)) ) for i in 1:num_args)...)
#     quote
#         $(LineNumberNode(@__LINE__, @__FILE__))
#         $replaceblocks
#         to_replace
#     end
# end

@inline @generated function unrollreplace(f::F, to_replace::C, args::Vararg{Any,N}) where {F,C,N}
    block = Expr(:block, :(r = to_replace))
    for i in 1:N
        push!(block.args, :(r = f(r, getfield(args, $i))))
    end
    push!(block.args, :r)
    return block
end

@inline @generated function unrollreplace_withcallback(f::F, to_replace::C, callback::CB, args::Vararg{Any,N}) where {F,C,CB,N}
    block = Expr(:block, :(r = to_replace))
    for i in 1:N
        push!(block.args, :(r = f(r, getfield(args, $i))))
    end
    push!(block.args, :(callback(r)))
    return block
end

"""
For a function that will return a viariable number of outputs
    that is broadcasted over a variable number of inputs,
    recursively splat the outputs in a tuple
"""
@inline function flat_collect_broadcast(f::F, elements::Tuple) where F
    if isempty(elements)
        return tuple()
    end
    result = (f(gethead(elements))...,)
    result = (result..., _flat_collect_broadcast(f, gettail(elements))...)
end

@inline function _flat_collect_broadcast(f::F, elements::Tuple) where F
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
@inline function named_flat_collect_broadcast(f::F, elements::Tuple) where F
    if isempty(elements)
        return (;)
    end
    result = (;f(gethead(elements))...,)
    result = (;result..., _named_flat_collect_broadcast(f, gettail(elements))...)
end

@inline function _named_flat_collect_broadcast(f::F, elements::Tuple) where F
    if isempty(elements)
        return (;)
    end
    return (;f(gethead(elements))..., _named_flat_collect_broadcast(f, gettail(elements))...)
end

"""
Ntuple, but if f returns a tuple, flatten it
"""
Base.@constprop :aggressive @inline function flat_ntuple(f::F, n) where F
    function _flat_ntuple(f, v::Val{n}, ::Val{idx}) where {n, idx}
        if idx > n
            return tuple()
        else
            ret = f(idx)
            if ret isa Tuple
                return (ret..., _flat_ntuple(f, v, Val(idx + 1))...)
            else
                return (ret, _flat_ntuple(f, v, Val(idx + 1))...)
            end
        end
    end
    return @inline _flat_ntuple(f, Val(n), Val(1))
end

"""
For tree like structures, where an apply returns (nodes...), (traits...)
    We recur down the tree applying f(node, trait) at each level, and flattening in the end

    A stop condition is that f(node, traits) = nothing, nothing

    f needs to be function that takes (node, trait) and returns tuple(newnodes), tuple(newtraits)

    In the end we will end up with a flat tuple of nodes and a flat tuple of traits
"""
function flat_tree_property_recursion(nodefunc::F, elements::Tuple, traits::Tuple, mask = ntuple(_ -> true, length(elements))) where F
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


"""
Nodefunc should return either nothing or a tuple of new nodes
"""
function tree_flatten(nodefunc, node)
    applied = nodefunc(node)
    if isnothing(applied)
        return tuple(node)
    end

    return @inline flat_collect_broadcast(x -> tree_flatten(nodefunc, x), applied)
end

"""
For a tree with traits at each node
Nodefunction should return nothing, nothing
or next leaves, nodetrait 

This only works if every node has the same number of traits, and the traits are tuples
"""
@inline function tree_trait_flatten(nodefunc, node, carry_trait)
    next_nodes, newtrait = nodefunc(node, carry_trait)
    isnothing(next_nodes) && return (carry_trait,)
    return _ttf(nodefunc, next_nodes, newtrait)
end

@inline _ttf(nodefunc, ::Tuple{}, ::Tuple{}) = ()

@inline function _ttf(nodefunc, nodes::Tuple, traits::Tuple)
    (tree_trait_flatten(nodefunc, first(nodes), first(traits))...,
     _ttf(nodefunc, Base.tail(nodes), Base.tail(traits))...)
end

@inline function typefilter(type::Type{T}, elements) where T
    if isempty(elements)
        return tuple()
    end
    first_el = gethead(elements)
    if first_el isa T
        return (first_el, typefilter(T, gettail(elements))...)
    else
        return typefilter(T, gettail(elements))
    end
end


"""
Apply a function f to the nodes of a tree, f returns (newchildren, tuple(whatever...))
    Not sure if this works
"""
function tree_apply_collect(f::F, node, collected = tuple()) where F
    newchildren, newcollect = f(node)

    if isnothing(newchildren)
        return (collected..., newcollect...)
    else

        next = flat_collect_broadcast(x -> tree_apply_collect(f, x), newchildren)
        return (collected..., newcollect..., next...)
    end
end