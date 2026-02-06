
#=
Matching trait that can be extended

Will be used for matching algorithms to ones in a registry

Generally, a struct that extends match_by should have a static parameter that uniquely identifies it

Normal objects match by normal equality
=#
abstract type AbstractMatcher{A} end
getmatchers(m::AbstractMatcher{A}) where {A} = A



struct MatchAny{A} <: AbstractMatcher{A} end
MatchAny(matchers...) = MatchAny(tuple(matchers...))
function Base.:(==)(m1::MatchAny, a)
    return any(x -> x == a, getmatchers(m1))
end
function Base.:(==)(a, m1::MatchAny)
    return any(x -> x == a, getmatchers(m1))
end

struct MatchAll{A} <: AbstractMatcher{A} end
MatchAll(matchers...) = MatchAll(tuple(matchers...))
function Base.:(==)(m1::MatchAll, a)
    return all(x -> x == a, getmatchers(m1))
end
function Base.:(==)(a, m1::MatchAll)
    return all(x -> x == a, getmatchers(m1))
end

"""
Match with any parent nodes but not other siblings
"""
struct TreeMatcher{A} <: AbstractMatcher{A} end
function TreeMatcher(id = uuid4())
    if id isa Tuple
        return TreeMatcher{tuple(id...)}()
    else
        return TreeMatcher{tuple(id)}()
    end
end

getchild(tm::TreeMatcher{ids}) where ids = TreeMatcher((ids...,uuid4()))
@inline function Base.:(==)(tm1::TreeMatcher{ids1}, tm2::TreeMatcher{ids2}) where {ids1,ids2}
    l1 = length(ids1)
    l2 = length(ids2)
    if l1 == l2
        return ids1 == ids2
    elseif l1 < l2
        return ids1 == ids2[1:l1]
    else
        return ids1[1:l2] == ids2
    end
end 

# Fallback
"""
Types extend this
"""
match_id(t::Type) = nothing
# match_by(tt::Type{Type{T}}) where T = match_by(T) # For generated function compatibility

function match_by(obj)
    id = nothing
    if obj isa Type
        id = match_id(obj)
    else
        id = match_id(typeof(obj))
    end
    if isnothing(id)
        return obj
    else
        return id
    end
end

function match(obj1, obj2)
    id1 = match_by(obj1)
    id2 = match_by(obj2)
    return id1 == id2
end

# match_by(obj::Any) = obj
# match_by(obj::Any) = obj
# match_by(::Type{T}) where {T} = T
# match_by(tt::Type{Type{T}}) where T = match_by(T) # For generated function compatibility

# function match(obj1, obj2)
#     id1 = match_by(obj1)
#     id2 = match_by(obj2)
#     return id1 == id2
# end

# function match(objtype1::Type{T1}, objtype2::Type{T2}) where {T1,T2}
#     id1 = match_by(objtype1)
#     id2 = match_by(objtype2)
#     return id1 == id2
# end

# function match(obj1, obj2)
#     id1 = match_by(obj1)
#     id2 = match_by(obj2)
#     return id1 == id2
# end