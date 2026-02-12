# using Pkg
# Pkg.activate((@__DIR__ )*"/..")

using Test
using Random
using Processes

@testset "Routes: Walker->InsertNoise updates Walker momentum" begin
    # Minimal reproduction of `manual tests/WalkerTest.jl` without print spam.

    struct Walker <: ProcessAlgorithm end

    function Processes.init(::Walker, input)
            (; dt) = input
            state = Float64[1.0]
            momentum = 1.0
            Processes.processsizehint!(state, input)
            return (; state, momentum, dt)
        end

    function Processes.step!(::Walker, context)
        (; state, momentum, dt) = context
        push!(state, state[end] + momentum * dt)
        return (; momentum)
    end

    

    struct InsertNoise <: ProcessAlgorithm
        seed::Int64
    end

    InsertNoise(seed::Integer = 1234) = InsertNoise(Int64(seed))

    function Processes.step!(::InsertNoise, context)
        (; targetnum, scale, rng) = context
        T = typeof(targetnum)
        rand_num = (rand(rng, T) - T(0.5)) * T(2) * scale
        targetnum = targetnum + rand_num
        return (; targetnum)
    end

    function Processes.init(::InsertNoise, _input)
        rng = MersenneTwister(1234)
        return (; rng)
    end

    algo = CompositeAlgorithm(
        Walker, InsertNoise,
        (1, 2),
        Route(Walker => InsertNoise, :momentum => :targetnum, :dt => :scale),
    )

    p = Process(algo, lifetime = 10, Input(Walker, :dt => 0.01))
    start(p; threaded = false)
    wait(p)
    c = fetch(p)

    # Test for correct cleanup output
    @test c isa ProcessContext

    actual = p.context[Walker].state
    expected = [
        1.0,
        1.01,
        1.02,
        1.030007664202586,
        1.0400153284051719,
        1.0501224635132498,
        1.0602295986213277,
        1.0702422421047793,
        1.0802548855882308,
        1.0901816017078885,
        1.1001083178275463,
    ]

    @test isapprox(actual, expected; rtol = 0.0, atol = 1e-12)


    # Route functions test
    struct Logger{T} <: ProcessAlgorithm end
    Logger(name::Symbol) = Logger{name}()

    function Processes.init(::Logger{T}, _input) where {T}
        log = Vector{Any}()
        return (;log)
    end
    function Processes.step!(::Logger{T}, context) where {T}
        (;log, targetnum) = context
        push!(log, targetnum)
        return (;)
    end

    Logger1 = Logger(:normal)
    Logger2 = Logger(:squared)

    algo2 = CompositeAlgorithm(
        Walker, InsertNoise, Logger1, Logger2,
        (1, 2, 1, 1),
        Route(Walker => InsertNoise, :momentum => :targetnum, :dt => :scale),
        Route(Walker => Logger1, :state => :targetnum, transform = x-> x[end]),
        Route(Walker => Logger2, :state => :targetnum, transform = x-> x[end]^2),
    )

    p2 = Process(algo2, lifetime = 10, Input(Walker, :dt => 0.01))
    run(p2)
    c2 = fetch(p2)

    log1 = c2[Logger1].log
    log2 = c2[Logger2].log
    @test all((log1 .^ 2) .== log2)

end
