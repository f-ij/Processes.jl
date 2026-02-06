
#=
Matching trait that can be extended

Will be used for matching algorithms to ones in a registry

Generally, a struct that extends match_by should have a static parameter that uniquely identifies it

Normal objects match by normal equality
=#


# Fallback
"""
Types extend this
"""
# match_id(a::Any) = match_id(typeof(a))
# match_id(t::Type) = t
# # match_by(tt::Type{Type{T}}) where T = match_by(T) # For generated function compatibility

# function match_by(obj)
#     id = nothing
#     if obj isa Type
#         id = match_id(obj)
#     else
#         id = match_id(typeof(obj))
#     end
#     if isnothing(id)
#         return obj
#     else
#         return id
#     end
# end

"""
Standard behavior: types match by themselves, objects match by their type
"""
match_by(obj) = match_by(typeof(obj))
match_by(t::Type{T}) where T = T

function match(obj1, obj2)
    id1 = match_by(obj1)
    id2 = match_by(obj2)
    return id1 == id2
end


### MATCHERS

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
get_tid(tm::TreeMatcher{TID}) where TID = tuple(TID.parameters...)

function TreeMatcher(id = uuid4())
    if id isa Tuple
        return TreeMatcher{Tuple{id...}}()
    else
        return TreeMatcher{Tuple{id}}()
    end
end

getchild(tm::TreeMatcher{TID}, id = uuid4()) where TID = TreeMatcher((get_tid(tm)...,id))

@inline function Base.:(==)(tm1::TreeMatcher{TID1}, tm2::TreeMatcher{TID2}) where {TID1,TID2}
    ids1 = get_tid(tm1)
    ids2 = get_tid(tm2)

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

"""
Matches BOTH with the object type or the match_by of the object type
"""
struct TypeMatcher{T} <: AbstractMatcher{T} end
TypeMatcher(t::Type) = TypeMatcher{t}()
match_by(tm::TypeMatcher{T}) where T = tm
function Base.:(==)(tm::TypeMatcher{T}, a) where T
    if a isa Type
        return a == T || match(a, T)
    else
        return typeof(a) == T || match(typeof(a), T)
    end
end
function Base.:(==)(a, tm::TypeMatcher{T}) where T
    if a isa Type
        return a == T || match(a, T)
    else 
        return typeof(a) == T || match(typeof(a), T)
    end
end