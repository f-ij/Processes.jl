using Test
using Processes

@testset "InlineProcess constructor matches Process inputs and overrides" begin
    struct InlineAccumulator <: ProcessAlgorithm end

    function Processes.init(::InlineAccumulator, context)
        (; start) = context
        return (; value = start, delta = 0)
    end

    function Processes.step!(::InlineAccumulator, context)
        return (; value = context.value + context.delta)
    end

    ip = InlineProcess(
        InlineAccumulator,
        Input(InlineAccumulator, :start => 3),
        Override(InlineAccumulator, :delta => 2);
        lifetime = 4,
    )

    ctx = run(ip)

    @test ctx[InlineAccumulator].delta == 2
    @test ip.loopidx == 5
    @test ctx[InlineAccumulator].value == 11
end
