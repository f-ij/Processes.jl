using Test
using Processes

@testset "ContextExchange buffers interactive updates" begin
    struct ExchangeTargetForTest <: ProcessAlgorithm end

    function Processes.init(::ExchangeTargetForTest, context)
        return (; value = 1.0, count = 1)
    end

    function Processes.step!(::ExchangeTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => ExchangeTargetForTest(),
        ContextExchange(),
        (1, 2),
    ))
    context = initcontext(algo; lifetime = Repeat(5))

    interact!(context, Input(:target, :value => 2))
    @test getkey(algo[:_exchange]) == :_exchange
    @test length(context._exchange.buffer) == 1

    context = Processes._step!(algo, context, Processes.Unstable())
    @test context.target.value == 1.0
    @test length(context._exchange.buffer) == 1

    context = Processes._step!(algo, context, Processes.Stable())
    @test context.target.value == 2.0
    @test isempty(context._exchange.buffer)

    @test_throws ErrorException interact!(context, Input(:target, :value => "not a float"))
end

@testset "InteractiveVar writes through ContextExchange" begin
    struct InteractiveVarTargetForTest <: ProcessAlgorithm end

    function Processes.init(::InteractiveVarTargetForTest, context)
        return (; value = 1.0)
    end

    function Processes.step!(::InteractiveVarTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => InteractiveVarTargetForTest(),
        ContextExchange(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(3))

    ref = view(context, Var(:target, :value))
    @test ref[] == 1.0

    ref[] = 4
    @test ref[] == 1.0
    @test length(context._exchange.buffer) == 1

    context = Processes.step!(algo[:_exchange], context)
    ref = view(context, Var(:target, :value))
    @test ref[] == 4.0
    @test isempty(context._exchange.buffer)

    typed_ref = view(context, Var(InteractiveVarTargetForTest, :value); exchange = :_exchange)
    typed_ref[] = 5
    context = Processes.step!(algo[:_exchange], context)
    typed_ref = view(context, Var(InteractiveVarTargetForTest, :value); exchange = :_exchange)
    @test typed_ref[] == 5.0
end

@testset "InteractiveVar polls ContextExchange state" begin
    struct PollingInteractiveTargetForTest <: ProcessAlgorithm end

    function Processes.init(::PollingInteractiveTargetForTest, context)
        return (; value = 1, seen = 0)
    end

    function Processes.step!(::PollingInteractiveTargetForTest, context)
        return (; seen = context.seen + 1)
    end

    algo = resolve(CompositeAlgorithm(
        :target => PollingInteractiveTargetForTest(),
        ContextExchange(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(3))

    seen_ref = view(context, Var(:target, :seen))
    @test seen_ref[] == 0

    context = Processes._step!(algo, context, Processes.Stable())
    @test context.target.seen == 1
    @test seen_ref[] == 1

    interval_algo = resolve(CompositeAlgorithm(
        :target => PollingInteractiveTargetForTest(),
        ContextExchange(),
        (1, 2),
    ))
    interval_context = initcontext(interval_algo; lifetime = Repeat(4))
    interval_ref = view(interval_context, Var(:target, :seen))

    interval_context = Processes._step!(interval_algo, interval_context, Processes.Stable())
    @test interval_context.target.seen == 1
    @test interval_ref[] == 0

    interval_context = Processes._step!(interval_algo, interval_context, Processes.Stable())
    @test interval_context.target.seen == 2
    @test interval_ref[] == 2
end

@testset "InteractiveVar requires a ContextExchange" begin
    struct NoExchangeTargetForTest <: ProcessAlgorithm end

    function Processes.init(::NoExchangeTargetForTest, context)
        return (; value = 1.0)
    end

    algo = resolve(CompositeAlgorithm(:target => NoExchangeTargetForTest(), (1,)))
    context = initcontext(algo; lifetime = Repeat(1))

    @test_throws ErrorException view(context, Var(:target, :value))
end

@testset "ContextExchange lets context merge reject missing runtime targets" begin
    struct MissingRuntimeTargetForTest <: ProcessAlgorithm end

    function Processes.init(::MissingRuntimeTargetForTest, context)
        return (; value = 1.0)
    end

    function Processes.step!(::MissingRuntimeTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => MissingRuntimeTargetForTest(),
        ContextExchange(),
        (1, 1),
    ))
    context = initcontext(algo; lifetime = Repeat(1))

    push!(context._exchange.buffer, Processes.BufferedContextUpdate(:missing_target, :value, 2.0))
    push!(context._exchange.buffer, Processes.BufferedContextUpdate(:target, :missing_value, 3.0))

    @test_throws Exception Processes.step!(algo[:_exchange], context)
    @test context.target.value == 1.0
end

@testset "ContextExchange updates running process state" begin
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
        ContextExchange(),
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
