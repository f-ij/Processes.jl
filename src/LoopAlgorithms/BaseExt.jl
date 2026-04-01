"""
Get the algorithm that matches in the LA tree
"""
function Base.getindex(ela::LoopAlgorithm, key)
    _flat_funcs = flat_funcs(ela) 
    return staticmatch(_flat_funcs, Val(key))
end

