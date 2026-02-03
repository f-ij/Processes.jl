struct MatchBy{VT, id}
    val::VT
end

MatchBy(v::VT) where VT = MatchBy{VT, v}(v)
function MatchBy(::Type{VT}) where VT
    MatchBy{VT, VT}(VT())
end

match_by(a::Any) = a

static_matchby(t1::Type{MatchBy{VT, id}}) where { VT, id} = id

# For generated function compatibility
static_matchby(::Type{T}) where T = T
static_matchby(tt::Type{Type{T}}) where T = static_matchby(T)

match_by(t1::MatchBy{VT, id}) where {VT, id} = id

function match(t1::Type, t2::Type)
    matchby1 = static_matchby(t1)
    matchby2 = static_matchby(t2)

    return matchby1 == matchby2
end

function match(t1, t2)
    MatchBy1 = match_by(t1)
    MatchBy2 = match_by(t2)
    return MatchBy1 == MatchBy2
end
 
struct Fib end

F = MatchBy(Fib)

@generated function static_match(t1, t2) 
    if match(t1, t2)
        return :(true)
    else
        return :(false)
    end
end

