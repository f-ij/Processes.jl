using Test
using Processes

struct PackFib <: Processes.ProcessAlgorithm end
struct PackLuc <: Processes.ProcessAlgorithm end

function Processes.step!(::PackFib, context)
    fiblist = context.fiblist
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return (;)
end

function Processes.prepare(::PackFib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)
    return (;fiblist)
end

function Processes.step!(::PackLuc, context)
    luclist = context.luclist
    push!(luclist, luclist[end] + luclist[end - 1])
    return (;)
end

function Processes.prepare(::PackLuc, context)
    luclist = Int[2, 1]
    processsizehint!(luclist, context)
    return (;luclist)
end

@testset "PackagedAlgo runs and benchmarks" begin
    n = 1_000
    @show n
    fibluc = CompositeAlgorithm((PackFib, PackLuc), (1, 1))
    pack = PackagedAlgo(fibluc, "FLPack")

    p = Process(pack; lifetime = n)
    start(p)
    wait(p)
    ctx = fetch(p)
    @show ctx

    @test length(ctx[pack].fiblist) == n + 2
    @test length(ctx[pack].luclist) == n + 2

    bench = benchmark(pack, n, 1)
    @test bench > 0
end
