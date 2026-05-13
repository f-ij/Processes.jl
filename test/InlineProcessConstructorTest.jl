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

@testset "Process constructor resolves inputs for algorithm types" begin
    struct TypeInputAccumulator <: ProcessAlgorithm end

    function Processes.init(::TypeInputAccumulator, context)
        return (; value = context.start)
    end

    function Processes.step!(::TypeInputAccumulator, context)
        return (; value = context.value + 1)
    end

    p = Process(
        TypeInputAccumulator,
        Input(TypeInputAccumulator, :start => 4);
        repeats = 2,
    )

    run(p)
    wait(p)
    close(p)

    @test context(p)[TypeInputAccumulator].value == 6

    unresolved = SimpleAlgo(TypeInputAccumulator)
    @test_throws ArgumentError Processes.resolve_process_inputs_overrides(
        unresolved,
        Input(TypeInputAccumulator, :start => 4),
    )

    resolved = resolve(unresolved)
    named_inputs, named_overrides = Processes.resolve_process_inputs_overrides(
        resolved,
        Input(TypeInputAccumulator, :start => 4),
    )
    @test length(named_inputs) == 1
    @test isempty(named_overrides)
end
