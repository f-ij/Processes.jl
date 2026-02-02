struct Identified{T, id}
    value::T
end

function Unique(val)
    return Identified{typeof(val), uuid4()}(val)
end

function ValMatch(val)
    return Identified{typeof(val), val}(val)
end

function TypeMatch(val)
    return Identified{typeof(val), typeof(val)}(val)
end

match_by(::Identified{T, id}) where {T, id} = id