"""
For patterns where we have to recursively replace a value from a function apply to a list of arguments,
we can unroll the recursion with this function
"""
@inline function UnrollReplace(f, to_replace, args...)
    if isempty(args)
        return to_replace
    end
    first_arg = gethead(args)
    to_replace = @inline f(to_replace, first_arg)
    return @inline UnrollReplace(f, to_replace, gettail(args)...)
end