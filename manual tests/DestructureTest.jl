using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using Processes

import Processes as ps

mutable struct Agent
    position::Float64
    velocity::Float64
    history::Vector{Float64}
end

@ProcessAlgorithm function Tick(position, velocity, history)
    position = position + velocity
    push!(history, position)
    return (;position, history)
end

function Processes.prepare(::Tick, input)
    return (;)
end

agent = Agent(0.0, 1.0, Float64[])
destr = Destructure(agent) do fields, context
    processsizehint!(fields.history, context)
    return fields
end

Runner = SimpleAlgo((Tick,), destr, Share(destr, Tick))
r = get_registry(Runner)

p = Process(Runner)
@show p.context
# start(p)