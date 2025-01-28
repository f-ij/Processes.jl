export Arena, ArenaVector, resizeblock!, growblock!, resizefor!, getblock, 
    ArenaZeros, ArenaAlloc

"""
Values of block i are stored in data[blocks[i]:blocks[i+1]-1]
Number of elements in block i is blocks[i+1] - blocks[i]

"""
const min_size = 8
const growth_factor = 2
const max_growth = 1024

abstract type Allocator end

struct Arena <: Allocator
    data::Vector{UInt8} # Data of the arena is allocated per 8 bits
    blocks::Vector{Int} # Indexes where the blocks start
    refs::Vector{ArenaVector}
end

blockstart(a::Arena, block::Int) = a.blocks[block]
blockend(a::Arena, block::Int) = a.blocks[block+1]-1
blocklength(a::Arena, block::Int) = a.blocks[block+1] - a.blocks[block]
number_of_type(a::Arena, block::Int) = blocklength(a, block) ÷ sizeof(eltype(a.refs[block]))
Base.length(a::Arena) = length(a.data)

function Arena()
    return Arena(Vector{UInt8}(), [1], ArenaVector[])
end

function Base.resize!(a::Arena, newsize::Int)
    resize!(a.data, newsize)
end

function addblock!(a::Arena, type, amount)
    bytes = sizeof(type)*amount
    resize!(a.data, length(a) + bytes)
end

"""
Resize block with index "block" to new_block_size.
new_block_size is given in multiples of the amount of bytes of the datatype
"""
function resizeblock!(a::Arena, block::Int, number_of_type::Int)
    bytesize = sizeof(eltype(a.refs[block]))
    new_block_size = number_of_type * bytesize
    old_block_size = blocklength(a, block)
    offset = new_block_size - old_block_size

    newsize = size(a.data) + offset
    resize!(a.data, newsize)

    # Move all data
    for i in block+1:length(a.blocks)
        a.refs[i].pos += offset
        a.refs[i].ptr = pointer(a.data, a.refs[i].pos)
        # Update block start
        a.blocks[i] += offset
    end
end

function growblock!(a::Arena, block::Int)
    oldnum = number_of_type(a, block)
    
    new_block_size = min(oldnum * growth_factor, max_growth)
    @inline resizeblock!(a, block, new_block_size)
end

function resizefor!(a::Arena, datatype, newsize::Int)
    _sizeof = sizeof(datatype)
    resize!(a.data, newsize * _sizeof)
end

@inline function Base.size(a::Arena)
    return size(a.data)
end

# Arena vector that works just like a normal vector,
# but which moves data in the arena when pushing etc
mutable struct ArenaVector{T, BoundsCheck} <: AbstractVector{T}
    arena::Arena
    pos::Int
    ptr::Ptr{T}
    used::Int
    alloc::Int
end

function ArenaZeros(type, a::Arena, len; boundscheck = true)
    original_len = length(a.data)
    alloc_size = max(len, min_size)
    addblock!(a, type, alloc_size)
    push!(a.blocks, length(a.data))
    ptr = pointer(a.data, original_len)
    av = ArenaVector{type, boundscheck}(a, original_len, ptr, len, len)
    push!(a.refs, av)
    return av
end

function ArenaAlloc(type, a::Arena, len; boundscheck = true)
    original_len = length(a.data)
    alloc_size = max(len, min_size)
    
    addblock!(a, type, alloc_size)

    push!(a.blocks, length(a.data))
    ptr = pointer(a.data, original_len)
    av = ArenaVector{type, boundscheck}(a, original_len, ptr, 0, alloc_size)
    push!(a.refs, av)
    return av
end

function Base.getindex(a::ArenaVector{T, BC}, i::Int) where {T, BC}
    if BC
        @assert 1 <= i <= length(a)
    end

    unsafe_load(a.ptr, i)
end

function Base.setindex!(a::ArenaVector{T, BC}, val, i::Int) where {T, BC}
    if BC
        @assert 1 <= i <= length(a)
    end

    unsafe_store!(a.ptr, val, i)
end

@inline Base.length(a::ArenaVector) = a.used
@inline Base.size(a::ArenaVector) = (a.used,)
@inline Base.eltype(a::ArenaVector{T}) where T = T
Base.IteratorSize(::Type{<:ArenaVector}) = Base.HasLength()
Base.IteratorEltype(::Type{<:ArenaVector}) = Base.eltype
Base.iterate(a::ArenaVector, i::Int=1) = i > length(a) ? nothing : (a[i], i+1)
getblock(a::ArenaVector) = findfirst(x -> x === a, a.arena.refs)

function Base.sizehint!(a::ArenaVector{T, BC}, newsize::Int) where {T, BC}
    if newsize > a.alloc
        block = getblock(a)
        resizeblock!(a.arena, block, newsize - length(a))
        a.alloc = newsize
    end
end

@inline function Base.push!(a::ArenaVector{T, BC}, val::T) where {T, BC}
    if length(a) == a.alloc
        block = getblock(a)
        growblock!(a.arena, block)
    end

    a.used += 1
    @inline unsafe_store!(a.ptr, val, length(a))
end

function Base.append!(a::ArenaVector{T, BC}, vals::AbstractVector{T}) where {T, BC}
    sizehint!(a, length(a) + length(vals))
    for val in vals
        push!(a, val)
    end
end