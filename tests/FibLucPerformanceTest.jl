using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
using Test
using Processes

include(joinpath(@__DIR__, "..", "FibLucDef.jl"))

const LOOP_COUNT = 50_000
const TRIALS = 5
const RUNTIME_RTOL = 0.25

function manual_fibluc_runtime(loop_count::Int, trials::Int)
    runtimes = Float64[]
    for _ in 1:trials
        fiblist = Int[0, 1]
        luclist = Int[2, 1]
        sizehint!(fiblist, loop_count + 2)
        sizehint!(luclist, loop_count ÷ 2 + 2)

        start_ns = time_ns()
        for iteration in 1:loop_count
            push!(fiblist, fiblist[end] + fiblist[end-1])
            if iteration % 2 == 0
                push!(luclist, luclist[end] + luclist[end-1])
            end
        end
        elapsed = (time_ns() - start_ns) / 1e9
        push!(runtimes, elapsed)
    end
    return sum(runtimes) / length(runtimes)
end

@testset "FibLuc process runtime matches manual loop" begin
    fib_luc = CompositeAlgorithm((Fib, Luc), (1, 2))
    process_runtime = benchmark(fib_luc, LOOP_COUNT, TRIALS; progress = false)
    manual_runtime = manual_fibluc_runtime(LOOP_COUNT, TRIALS)

    # Allow a moderate tolerance to absorb scheduler noise.
    @test isapprox(process_runtime, manual_runtime; rtol = RUNTIME_RTOL)
end
