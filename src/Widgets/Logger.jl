"""
Log a variable
"""
struct Logger{T, Name} <: ProcessAlgorithm end

Logger(T; name = uuid4()) = Logger{T, name}()

function Processes.init(::Logger{T}, context::C) where {T, C}
    log = Vector{T}()
    processsizehint!(log, context)
    return (;log)
end
function pushderef!(vec::V, val::Val) where {V<:AbstractVector, Val}
    if val isa Ref
        push!(vec, val[])
    else
        push!(vec, val)
    end
end

function Processes.step!(::Logger{T}, context::C) where {T, C}
    (;log, value) = context
    pushderef!(log, value)
    return (;)
end