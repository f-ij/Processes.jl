using Test
using Processes

@testset "ContextInjector buffers interactive updates" begin
    struct InjectorTargetForTest <: ProcessAlgorithm end

    function Processes.init(::InjectorTargetForTest, context)
        return (; value = 1.0, count = 1)
    end

    function Processes.step!(::InjectorTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => InjectorTargetForTest(),
        ContextInjector(),
        (1, 2),
    ))
    context = initcontext(algo; lifetime = Repeat(5))

    interact!(context, Input(:target, :value => 2))
    @test getkey(algo[:_injector]) == :_injector
    @test length(context._injector.buffer) == 1

    context = Processes._step!(algo, context, Processes.Unstable())
    @test context.target.value == 1.0
    @test length(context._injector.buffer) == 1

    context = Processes._step!(algo, context, Processes.Stable())
    @test context.target.value == 2.0
    @test isempty(context._injector.buffer)

    @test_throws ErrorException interact!(context, Input(:target, :value => "not a float"))
end

@testset "InteractiveVar writes through ContextInjector" begin
    struct InteractiveVarTargetForTest <: ProcessAlgorithm end

    function Processes.init(::InteractiveVarTargetForTest, context)
        return (; value = 1.0)
    end

    function Processes.step!(::InteractiveVarTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => InteractiveVarTargetForTest(),
        ContextInjector(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(3))

    ref = view(context, Var(:target, :value))
    @test ref[] == 1.0

    ref[] = 4
    @test ref[] == 1.0
    @test length(context._injector.buffer) == 1

    context = Processes.step!(algo[:_injector], context)
    ref = view(context, Var(:target, :value))
    @test ref[] == 4.0
    @test isempty(context._injector.buffer)

    typed_ref = view(context, Var(InteractiveVarTargetForTest, :value); injector = :_injector)
    typed_ref[] = 5
    context = Processes.step!(algo[:_injector], context)
    typed_ref = view(context, Var(InteractiveVarTargetForTest, :value); injector = :_injector)
    @test typed_ref[] == 5.0
end

@testset "InteractiveVar requires a ContextInjector" begin
    struct NoInjectorTargetForTest <: ProcessAlgorithm end

    function Processes.init(::NoInjectorTargetForTest, context)
        return (; value = 1.0)
    end

    algo = resolve(CompositeAlgorithm(:target => NoInjectorTargetForTest(), (1,)))
    context = initcontext(algo; lifetime = Repeat(1))

    @test_throws ErrorException view(context, Var(:target, :value))
end

@testset "ContextInjector lets context merge reject missing runtime targets" begin
    struct MissingRuntimeTargetForTest <: ProcessAlgorithm end

    function Processes.init(::MissingRuntimeTargetForTest, context)
        return (; value = 1.0)
    end

    function Processes.step!(::MissingRuntimeTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => MissingRuntimeTargetForTest(),
        ContextInjector(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(1))

    push!(context._injector.buffer, Processes.BufferedContextUpdate(:missing_target, :value, 2.0))
    push!(context._injector.buffer, Processes.BufferedContextUpdate(:target, :missing_value, 3.0))

    @test_throws Exception Processes.step!(algo[:_injector], context)
    @test context.target.value == 1.0
end

@testset "ContextInjector updates running process state" begin
    struct SlowInteractiveTargetForTest <: ProcessAlgorithm end

    function Processes.init(::SlowInteractiveTargetForTest, context)
        return (; value = 1, seen = 0)
    end

    function Processes.step!(::SlowInteractiveTargetForTest, context)
        sleep(0.01)
        return (; seen = context.seen + 1)
    end

    algo = resolve(CompositeAlgorithm(
        :target => SlowInteractiveTargetForTest(),
        ContextInjector(),
        (1, 1),
    ))
    process = Process(algo; repeat = Inf)

    run(process)

    started_deadline = time() + 2.0
    while loopint(process) < 3 && time() < started_deadline
        sleep(0.005)
    end
    @test loopint(process) >= 3

    ref = view(context(process), Var(:target, :value))
    ref[] = 42

    injected_deadline = time() + 2.0
    while loopint(process) < 6 && time() < injected_deadline
        sleep(0.005)
    end

    close(process)
    @test context(process).target.value == 42
    @test context(process).target.seen > 0
end
