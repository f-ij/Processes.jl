using Test
using Processes

@testset "Symbol indexing and targeted initcontext" begin
    struct SymbolInitAlgo <: ProcessAlgorithm end
    struct SymbolOtherAlgo <: ProcessAlgorithm end

    function Processes.init(::SymbolInitAlgo, context)
        (; value = context.seed)
    end
    Processes.init(::SymbolOtherAlgo, context) = (;)
    Processes.step!(::SymbolInitAlgo, context) = (;)
    Processes.step!(::SymbolOtherAlgo, context) = (;)

    resolved = resolve(CompositeAlgorithm(SymbolInitAlgo, SymbolOtherAlgo, (1, 1)))
    reg = getregistry(resolved)

    @test reg[:SymbolInitAlgo_1] == resolved[:SymbolInitAlgo_1]
    @test resolved[:SymbolInitAlgo_1] == resolved.SymbolInitAlgo_1
    @test Processes.getkey(reg[:SymbolOtherAlgo_1]) == :SymbolOtherAlgo_1

    ctx = ProcessContext(resolved)
    ctx = initcontext(ctx, :SymbolInitAlgo_1; inputs = (; seed = 3))
    @test ctx[:SymbolInitAlgo_1].value == 3

    ctx = initcontext(ctx, resolved[:SymbolInitAlgo_1]; inputs = (; seed = 7), overrides = (; value = 11))
    @test ctx[:SymbolInitAlgo_1].value == 11

    p = Process(resolved, Input(:SymbolInitAlgo_1, :seed => 1); repeats = 1)
    reinit(p, :SymbolInitAlgo_1; inputs = (; seed = 13))
    wait(p)
    @test context(p)[:SymbolInitAlgo_1].value == 13
    @test isempty(context(p)[:SymbolOtherAlgo_1])
end
