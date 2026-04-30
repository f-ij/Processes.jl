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
        :injector => ContextInjector(check_every = 2),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(5))

    interact!(context, Input(:target, :value => 2))
    @test length(context.injector.buffer) == 1

    context = Processes.step!(algo, context, Processes.Unstable())
    @test context.target.value == 1.0
    @test length(context.injector.buffer) == 1

    context = Processes.step!(algo, context, Processes.Stable())
    @test context.target.value == 2.0
    @test context.injector.step_counter == 2
    @test isempty(context.injector.buffer)

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
        :injector => ContextInjector(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(3))

    ref = view(context, Var(:target, :value))
    @test ref[] == 1.0

    ref[] = 4
    @test ref[] == 1.0
    @test length(context.injector.buffer) == 1

    context = Processes.step!(algo[:injector], context, Processes.Stable())
    @test ref[] == 4.0
    @test isempty(context.injector.buffer)

    typed_ref = view(context, Var(InteractiveVarTargetForTest, :value); injector = :injector)
    typed_ref[] = 5
    context = Processes.step!(algo[:injector], context, Processes.Stable())
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

@testset "ContextInjector skips missing runtime targets" begin
    struct MissingRuntimeTargetForTest <: ProcessAlgorithm end

    function Processes.init(::MissingRuntimeTargetForTest, context)
        return (; value = 1.0)
    end

    function Processes.step!(::MissingRuntimeTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => MissingRuntimeTargetForTest(),
        :injector => ContextInjector(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(1))

    push!(context.injector.buffer, Processes.BufferedContextUpdate(:missing_target, :value, 2.0))
    push!(context.injector.buffer, Processes.BufferedContextUpdate(:target, :missing_value, 3.0))

    context = @test_logs (:warn, r"missing_target\.value") (:warn, r"target\.missing_value") Processes.step!(algo[:injector], context, Processes.Stable())
    @test context.target.value == 1.0
    @test isempty(context.injector.buffer)
end
