
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


match_by(obj::Any) = obj
staticmatch_by(obj::Any) = obj
staticmatch_by(::Type{T}) where {T} = T
staticmatch_by(tt::Type{Type{T}}) where T = staticmatch_by(T) # For generated function compatibility

function match(obj1, obj2)
    id1 = match_by(obj1)
    id2 = match_by(obj2)
    return id1 == id2
end

function match(objtype1::Type{T1}, objtype2::Type{T2}) where {T1,T2}
    id1 = staticmatch_by(objtype1)
    id2 = staticmatch_by(objtype2)
    return id1 == id2
end

function staticmatch(obj1, obj2)
    id1 = staticmatch_by(obj1)
    id2 = staticmatch_by(obj2)
    return id1 == id2
end