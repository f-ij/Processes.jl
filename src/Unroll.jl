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
    result = (f(gethead(elements))...,)
    result = (result..., _flat_collect_broadcast(f, gettail(elements))...)
end

@inline function _flat_collect_broadcast(f, elements::Tuple)
    if isempty(elements)
        return ()
    end
    return (f(gethead(elements))..., _flat_collect_broadcast(f, gettail(elements))...)
end


"""
For a function that will return a viariable number of outputs
    that is broadcasted over a variable number of inputs,
    recursively splat the outputs in a tuple
"""
@inline function named_flat_collect_broadcast(f, elements::Tuple)
    result = (;f(gethead(elements))...,)
    result = (;result..., _named_flat_collect_broadcast(f, gettail(elements))...)
end

@inline function _named_flat_collect_broadcast(f, elements::Tuple)
    if isempty(elements)
        return (;)
    end
    return (;f(gethead(elements))..., _named_flat_collect_broadcast(f, gettail(elements))...)
end