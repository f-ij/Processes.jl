using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using Processes, Random
import Processes as ps

struct Walker <: ProcessAlgorithm end

function Walker(state, momentum, dt)
    println("State is now $state")
    println("pushing : $(momentum) * dt)")
    push!(state, state[end] + momentum * dt)
    return (;momentum)
end

function Processes.prepare(::Walker, input::A) where A
    (;dt) = input

    state = Float64[1.0]
    momentum = 1.0
    println("dt: $dt")
    processsizehint!(state, input)
    return (;state, momentum, dt)
end

struct InsertNoise <: ProcessAlgorithm
    seed::Int64
end

InsertNoise(seed = 1234) = InsertNoise(seed)

function Processes.step!(::InsertNoise, context::C) where C
    (;targetnum, scale, rng) = context
    T = typeof(targetnum)
    rand_num  = (rand(rng, T)-T(0.5))*T(2)*scale
    println("Adding noise: $rand_num")
    println("Scale: $scale")
    targetnum = targetnum + rand_num
    return (;targetnum)
end

function Processes.prepare(::InsertNoise, input::A) where A
    rng = MersenneTwister(1234)
    return (;rng)
end

RandomWalker = CompositeAlgorithm((Walker, InsertNoise), (1,2), Route(Walker, InsertNoise, :momentum => :targetnum, :dt => :scale))
# RandomWalker = CompositeAlgorithm((Walker, InsertNoise), (1,2))
p = Process(RandomWalker, lifetime = 10, Input(Walker, :dt => 0.01))
run(p)