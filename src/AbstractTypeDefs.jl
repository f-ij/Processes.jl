abstract type ProcessAlgorithm end
abstract type AbstractOption end
abstract type ProcessState <: AbstractOption end

# abstract type ProcessLoopAlgorithm <: ProcessAlgorithm end # Algorithms that can be inlined in processloop
# abstract type LoopAlgorithm <: ProcessLoopAlgorithm end # Algorithms that have multiple functions and intervals
abstract type LoopAlgorithm <: ProcessAlgorithm end # Algorithms that have multiple functions and intervals
Base.iterate(la::LoopAlgorithm) = iterate(getalgos(la))



abstract type AbstractContext end
abstract type AbstractSubContext end


abstract type AbstractAVec{T} <: AbstractVector{T} end

"""
And AbstractRegistry has some overlap in functionality with Sets
- However, identity is determined by the match_by
- Also registries need to have type stable getindex, so that types can be inferred
    at compile time
- This allows for unrollable loops over registry entries, which is important for performance in the contexts that use them
"""
abstract type AbstractRegistry end

"""
One should have a method for keys
Then one should match the type of idx item returned by static_findfirst_match
"""
Base.getindex(r::AbstractRegistry, key) = error("getindex not implemented for $(typeof(r))")
all_algos(r::AbstractRegistry) = error("all_algos not implemented for $(typeof(r))")
static_get(r::AbstractRegistry, key) = error("static_get not implemented for $(typeof(r))")
static_get_multiplier(r::AbstractRegistry, key) = error("static_get_multiplier not implemented for $(typeof(r))")
add(r::AbstractRegistry, obj, multiplier = 1.; withkey = nothing) = error("add not implemented for $(typeof(r))")
inherit(parent::AbstractRegistry, child::AbstractRegistry) = error("inherit not implemented for $(typeof(parent)) and $(typeof(child))")
static_findfirst_match(r::AbstractRegistry, val) = error("static_findfirst_match not implemented for $(typeof(r))")

"""
Get a key, errors if not present
"""
getkey(r::AbstractRegistry, obj) = error("getkey not implemented for $(typeof(r))")
"""
Find a key, returns nothing if not present
"""
static_findkey(r::AbstractRegistry, obj) = error("static_findkey not implemented for $(typeof(r))")