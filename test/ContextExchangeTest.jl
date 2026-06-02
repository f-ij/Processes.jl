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
        ContextExchange(:value),
        (1, 2),
        Route(:target => :_exchange, :value),
    ))
    context = initcontext(algo; lifetime = Repeat(5))

    interact!(context, :value => 2)
    @test getkey(algo[:_exchange]) == :_exchange
    @test context._exchange.store.pending.value[] == 2

    context = Processes._step!(algo, context, Processes.Unstable())
    @test context.target.value == 1.0
    @test context._exchange.store.pending.value[] == 2

    context = Processes._step!(algo, context, Processes.Stable())
    @test context.target.value == 2.0
    @test context._exchange.store.pending.value[] === Processes.context_exchange_no_update
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
        ContextExchange(:value),
        (1, 1),
        Route(:target => :_exchange, :value),
    ))
    context = initcontext(algo; lifetime = Repeat(3))

    ref = view(context, :value)
    @test ref[] === missing
    duplicate_ref = view(context, Var(:_exchange, :value))

    ref[] = 4
    @test ref[] === missing
    @test duplicate_ref[] === missing
    @test context._exchange.store.pending.value[] == 4

    context = Processes._step!(algo, context, Processes.Stable())
    @test ref[] == 4.0
    @test duplicate_ref[] == 4.0
    @test context._exchange.store.pending.value[] === Processes.context_exchange_no_update

    typed_ref = view(context, :value)
    typed_ref[] = 5
    context = Processes._step!(algo, context, Processes.Stable())
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
        ContextExchange(:seen),
        (1, 1),
        Route(:target => :_exchange, :seen),
    ))
    context = initcontext(algo; lifetime = Repeat(3))

    seen_ref = view(context, :seen)
    @test seen_ref[] === missing

    context = Processes._step!(algo, context, Processes.Stable())
    @test context.target.seen == 1
    @test seen_ref[] == 1

    interval_algo = resolve(CompositeAlgorithm(
        :target => PollingInteractiveTargetForTest(),
        ContextExchange(:seen),
        (1, 2),
        Route(:target => :_exchange, :seen),
    ))
    interval_context = initcontext(interval_algo; lifetime = Repeat(4))
    interval_ref = view(interval_context, :seen)

    interval_context = Processes._step!(interval_algo, interval_context, Processes.Stable())
    @test interval_context.target.seen == 1
    @test interval_ref[] === missing

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

    @test_throws ErrorException view(context, :value)
end

@testset "ContextExchange writes through routes" begin
    struct RoutedExchangeTargetForTest <: ProcessAlgorithm end

    function Processes.init(::RoutedExchangeTargetForTest, context)
        return (; value = 1.0)
    end

    function Processes.step!(::RoutedExchangeTargetForTest, context)
        return (;)
    end

    algo = resolve(CompositeAlgorithm(
        :target => RoutedExchangeTargetForTest(),
        ContextExchange(:value),
        (1, 1),
        Route(:target => :_exchange, :value),
    ))
    context = initcontext(algo; lifetime = Repeat(1))

    interact!(context, :value => 2.0)
    context = Processes._step!(algo, context, Processes.Stable())
    @test context.target.value == 2.0
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
        ContextExchange(:value),
        (1, 1),
        Route(:target => :_exchange, :value),
    ))
    process = Process(algo; repeat = Inf)

    run(process)

    started_deadline = time() + 2.0
    while loopint(process) < 3 && time() < started_deadline
        sleep(0.005)
    end
    @test loopint(process) >= 3

    ref = view(context(process), :value)
    ref[] = 42

    injected_deadline = time() + 2.0
    while loopint(process) < 6 && time() < injected_deadline
        sleep(0.005)
    end

    close(process)
    @test context(process).target.value == 42
    @test context(process).target.seen > 0
end
