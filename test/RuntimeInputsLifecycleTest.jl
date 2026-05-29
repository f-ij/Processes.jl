using Test
using Processes

struct LifecycleInitA <: Processes.ProcessAlgorithm end
struct LifecycleInitB <: Processes.ProcessAlgorithm end
mutable struct RuntimeShapeChanger <: Processes.ProcessAlgorithm
    count::Int
end
struct PauseRuntimeInputConsumer <: Processes.ProcessAlgorithm end

function Processes.init(::LifecycleInitA, context)
    return (; x = Ref(get(context, :x, 0)), z = get(context, :z, 0))
end

function Processes.init(::LifecycleInitB, context)
    return (; y = Ref(get(context, :y, 0)))
end

function Processes.step!(::LifecycleInitA, context)
    context.x[] += 1
    return (;)
end

function Processes.step!(::LifecycleInitB, context)
    context.y[] += 1
    return (;)
end

function Processes.step!(algo::RuntimeShapeChanger, context)
    algo.count += 1
    return algo.count == 1 ? (; added = 1) : (; added = 1, extra = 1)
end

Processes.init(::PauseRuntimeInputConsumer, context) = (; total = 0)

function Processes.step!(::PauseRuntimeInputConsumer, context)
    sleep(0.005)
    return (; total = context.total + context.delta)
end

runtime_inputs_lifecycle_value(seed, temp, scale; bias = 0) = seed + temp * scale + bias
runtime_shape_context(ctx) = getproperty(Processes.get_subcontexts(ctx), :RuntimeShapeChanger_1)

@testset "Runtime inputs and LoopAlgorithm lifecycle" begin
    @test Input === Init
    @test Init(LifecycleInitA; x = 1).vars == (; x = 1)
    @test Init(; x = 1).vars == (; x = 1)
    @test Input(LifecycleInitA, :x => 2).vars == (; x = 2)
    @test !Processes.isresolved(Init(LifecycleInitA; x = 1))
    @test !Processes.isresolved(typeof(Init(LifecycleInitA; x = 1)))
    @test !Processes.isresolved(Init(; x = 1))
    @test !Processes.isresolved(typeof(Init(; x = 1)))
    @test Processes.isalltargets(Init(; x = 1))
    @test Processes.isalltargets(typeof(Init(; x = 1)))
    @test !Processes.isalltargets(Init(LifecycleInitA; x = 1))
    @test !Processes.isalltargets(Override(LifecycleInitA; x = 1))
    @test Processes.isresolved(Init(:LifecycleInitA_1; x = 1))
    @test Processes.isresolved(typeof(Init(:LifecycleInitA_1; x = 1)))

    la = CompositeAlgorithm(LifecycleInitA, LifecycleInitB, (1, 1))
    initialized = init(la, Init(LifecycleInitA; x = 1), Init(LifecycleInitB; y = 2))
    replayed = init(initialized)
    overridden = init(replayed, Init(LifecycleInitA; x = 5))

    @test Processes.context(replayed)[LifecycleInitA].x[] == 1
    @test Processes.context(replayed)[LifecycleInitB].y[] == 2
    @test Processes.context(overridden)[LifecycleInitA].x[] == 5
    @test Processes.context(overridden)[LifecycleInitB].y[] == 2

    general_init = init(la, Init(; x = 3, y = 4, z = 5))
    @test Processes.context(general_init)[LifecycleInitA].x[] == 3
    @test Processes.context(general_init)[LifecycleInitA].z == 5
    @test Processes.context(general_init)[LifecycleInitB].y[] == 4

    targeted_after_general = init(la, Init(; x = 3, y = 4), Init(LifecycleInitA; x = 8))
    @test Processes.context(targeted_after_general)[LifecycleInitA].x[] == 8
    @test Processes.context(targeted_after_general)[LifecycleInitB].y[] == 4

    b_ref = Processes.context(overridden)[LifecycleInitB].y
    partial = partialinit(overridden, Init(LifecycleInitA; x = 9, z = 4))

    @test Processes.context(partial)[LifecycleInitA].x[] == 9
    @test Processes.context(partial)[LifecycleInitA].z == 4
    @test Processes.context(partial)[LifecycleInitB].y === b_ref

    resolved_la = resolve(la)
    resolved_target = getkey(only(findall(LifecycleInitA, Processes.getregistry(resolved_la))))
    resolved_input = only(Processes.resolve(Processes.getregistry(resolved_la), Init(resolved_target; x = 7)))
    @test Processes.get_ref(resolved_input) === nothing
    @test Processes.isresolved(resolved_input)
    @test Processes.isresolved(typeof(resolved_input))
    resolved_general_inputs = Processes.resolve(Processes.getregistry(resolved_la), Init(; x = 11))
    @test length(resolved_general_inputs) == length(keys(Processes.getregistry(resolved_la)))
    @test all(Processes.isresolved, resolved_general_inputs)
    initialized_by_symbol = init(resolved_la, Init(resolved_target; x = 7))
    @test Processes.context(initialized_by_symbol)[LifecycleInitA].x[] == 7

    runtime_algo = @CompositeAlgorithm begin
        @state seed = 1
        @input temp::AbstractFloat
        @input scale
        @input bias = 2.0
        value = runtime_inputs_lifecycle_value(seed, temp, scale; bias = bias)
    end
    initialized_runtime = init(resolve(runtime_algo))

    @test_throws ErrorException run(initialized_runtime)
    @test_throws ErrorException run(initialized_runtime; temp = 1.0, scale = 2, extra = 1)
    @test_throws ErrorException run(initialized_runtime; temp = 1, scale = 2)

    runtime_result = run(initialized_runtime; temp = 1.5, scale = 2)
    runtime_context = Processes.context(runtime_result)
    @test isempty(runtime_context[:FuncWrapper_1])
    @test !haskey(Processes.getglobals(runtime_context), :value)
    @test !haskey(Processes.get_subcontexts(runtime_context), :_input)
    @test !haskey(Processes.getglobals(runtime_context), :process)

    for entry in (runtime_algo, resolve(runtime_algo), initialized_runtime)
        process = Process(entry; repeats = 1)
        run(process; temp = 2.0, scale = 3)
        wait(process)
        fetched_context = fetch(process)
        @test Processes.getglobals(fetched_context).value == 9.0
        @test isempty(Processes.context(process)[:FuncWrapper_1])
        @test !haskey(Processes.getglobals(Processes.context(process)), :value)
        @test !haskey(Processes.get_subcontexts(Processes.context(process)), :_input)
        @test !haskey(Processes.getglobals(Processes.context(process)), :process)
        close(process)
    end

    shape_result = run(init(CompositeAlgorithm(RuntimeShapeChanger(0))); lifetime = Repeat(0))
    @test runtime_shape_context(Processes.context(shape_result)).added == 1
    @test_throws Exception run(init(CompositeAlgorithm(RuntimeShapeChanger(0))); lifetime = Repeat(2))

    pause_algo = @CompositeAlgorithm begin
        @input delta::Int
        PauseRuntimeInputConsumer(delta = delta)
    end
    process = Process(pause_algo; repeat = Inf)
    run(process; delta = 2)

    deadline = time() + 2.0
    while loopint(process) < 4 && time() < deadline
        sleep(0.005)
    end
    pause(process)
    wait(process)

    paused_context = context(process)
    paused_total = paused_context[PauseRuntimeInputConsumer].total
    @test paused_total > 0
    @test haskey(Processes.get_subcontexts(paused_context), :_input)
    @test_throws ErrorException run(process; delta = 3)

    run(process)
    deadline = time() + 2.0
    while loopint(process) < 7 && time() < deadline
        sleep(0.005)
    end
    pause(process)
    wait(process)

    @test context(process)[PauseRuntimeInputConsumer].total > paused_total
    close(process)
    @test !haskey(Processes.get_subcontexts(context(process)), :_input)
end
