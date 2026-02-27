"""
Log a variable
"""
struct Logger{T, Name} <: ProcessAlgorithm end

Logger(T; name = uuid4()) = Logger{T, name}()

function Processes.init(::Logger{T}, context) where T
    log = Vector{T}()
    processsizehint!(log, context)
    return (;log)
end
function Processes.step!(::Logger{T}, context) where T
    (;log, value) = context

    push!(log, value)
    return (;)
end