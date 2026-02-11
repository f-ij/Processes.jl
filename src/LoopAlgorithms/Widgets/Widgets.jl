"""
Log a variable
"""
struct Logger{T} <: ProcessAlgorithm end

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

"""
Apply a function
"""
struct Apply{F} <: ProcessAlgorithm
    f::F
end
function Processes.init(a::Apply{F}, context) where F
    (;target) = context
    return (;target = a.f(target))
end

struct Interactive{T, id} <: ProcessAlgorithm 
    channel_size::Int
    isbitsptr::IsBitsPtr{Channel{T}, id}
end
function Processes.init(I::Interactive{T}, context) where T
    channel = Channel{T}(I.channel_size)
    
    return (;channel)
end
"""
Take value from channel, and overwrite target with it
"""
function Processes.step!(::Interactive{T}, context) where T
    (;channel, target) = context
    target = take!(channel)
    return (;target)
end
function Processes.cleanup(::Interactive{T}, context) where T
    (;channel) = context
    close(channel)
    return (;)
end

put!(I::Interactive{T}, value::T) where T = put!(I.channel, value)

