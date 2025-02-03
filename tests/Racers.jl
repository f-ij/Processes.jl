using Processes

mutable struct RaceForMe{T}
    data::Vector{T}
end

const raceme = RaceForMe(rand(1000))

struct Racing <: ProcessAlgorithm end

function Processes.prepare(::Racing, args)
    return (;raceme, data = args.raceme.data)
end

function Racing(args)
    (;data) = args
    _racing(data)
end

function _racing(data)
    i = rand(1:length(data))
    data[i] = -data[i]*rand() + rand()
end

ps = [Process(Racing; raceme) for i in 1:8]

start.(ps)
