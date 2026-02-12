using Test
using Processes

struct RunFib <: Processes.ProcessAlgorithm end
struct RunLuc <: Processes.ProcessAlgorithm end

function Processes.step!(::RunFib, context)
    fiblist = context.fiblist
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return (;)
end

function Processes.init(::RunFib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)
    return (;fiblist)
end

function Processes.step!(::RunLuc, context)
    luclist = context.luclist
    push!(luclist, luclist[end] + luclist[end - 1])
    return (;)
end

function Processes.init(::RunLuc, context)
    luclist = Int[2, 1]
    processsizehint!(luclist, context)
    return (;luclist)
end

@testset "Process run fills context" begin
    n = 50_000
    fibluc = Processes.CompositeAlgorithm( RunFib, RunLuc , (1, 2))
    p = Processes.Process(fibluc; lifetime = n)
    Processes.run(p)
    ctx = fetch(p)

    fib_ctx = ctx[RunFib]
    luc_ctx = ctx[RunLuc]

    @test length(fib_ctx.fiblist) == n + 2
    @test length(luc_ctx.luclist) == n/2 + 2
end
