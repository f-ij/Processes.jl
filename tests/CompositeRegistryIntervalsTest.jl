using Test
using Processes

struct CompFib <: Processes.ProcessAlgorithm end
struct CompLuc <: Processes.ProcessAlgorithm end

function Processes.step!(::CompFib, context)
    fiblist = context.fiblist
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return (;)
end

function Processes.prepare(::CompFib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)
    return (;fiblist)
end

function Processes.step!(::CompLuc, context)
    luclist = context.luclist
    push!(luclist, luclist[end] + luclist[end - 1])
    return (;)
end

function Processes.prepare(::CompLuc, context)
    luclist = Int[2, 1]
    processsizehint!(luclist, context)
    return (;luclist)
end

@testset "Composite registry + intervals" begin
    fibluc = CompositeAlgorithm((CompFib(), CompFib, CompLuc), (1, 1, 2))
    @test Processes.intervals(fibluc) == (1, 1, 2)

    reg = Processes.get_registry(fibluc)
    @test Processes.get(reg, CompFib(), nothing) !== nothing
    @test Processes.get(reg, CompFib, nothing) !== nothing
    @test Processes.get(reg, CompLuc, nothing) !== nothing

    @test Processes.getmultiplier(reg, CompFib()) ≈ 1.0
    @test Processes.getmultiplier(reg, CompFib) ≈ 1.0
    @test Processes.getmultiplier(reg, CompLuc) ≈ 0.5
end

@testset "Nested composite registry + intervals" begin
    fibluc = CompositeAlgorithm((CompFib(), CompFib, CompLuc), (1, 1, 2))
    fdup = Processes.Unique(CompFib())
    ldup = Processes.Unique(CompLuc)

    ffluc = CompositeAlgorithm((fibluc, fdup, CompFib, ldup), (10, 5, 2, 1))
    @test Processes.intervals(ffluc) == (10, 5, 2, 1)

    reg = Processes.get_registry(ffluc)
    @test Processes.get(reg, CompFib(), nothing) !== nothing
    @test Processes.get(reg, CompFib, nothing) !== nothing
    @test Processes.get(reg, CompLuc, nothing) !== nothing
    @test Processes.get(reg, fdup, nothing) !== nothing
    @test Processes.get(reg, ldup, nothing) !== nothing

    @test Processes.getmultiplier(reg, CompFib()) ≈ 0.1
    @test Processes.getmultiplier(reg, CompFib) ≈ 0.6
    @test Processes.getmultiplier(reg, CompLuc) ≈ 0.05
    @test Processes.getmultiplier(reg, fdup) ≈ 0.2
    @test Processes.getmultiplier(reg, ldup) ≈ 1.0
end
