using Test
using Processes

struct LifecycleInitA <: Processes.ProcessAlgorithm end
struct LifecycleInitB <: Processes.ProcessAlgorithm end
mutable struct RuntimeShapeChanger <: Processes.ProcessAlgorithm
    count::Int
end

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

runtime_inputs_lifecycle_value(seed, temp, scale; bias = 0) = seed + temp * scale + bias
runtime_shape_context(ctx) = getproperty(Processes.get_subcontexts(ctx), :RuntimeShapeChanger_1)

@testset "Runtime inputs and LoopAlgorithm lifecycle" begin
    @test Input === Init
    @test Init(LifecycleInitA; x = 1).vars == (; x = 1)
    @test Input(LifecycleInitA, :x => 2).vars == (; x = 2)

    la = CompositeAlgorithm(LifecycleInitA, LifecycleInitB, (1, 1))
    initialized = init(la, Init(LifecycleInitA; x = 1), Init(LifecycleInitB; y = 2))
    replayed = init(initialized)
    overridden = init(replayed, Init(LifecycleInitA; x = 5))

    @test Processes.context(replayed)[LifecycleInitA].x[] == 1
    @test Processes.context(replayed)[LifecycleInitB].y[] == 2
    @test Processes.context(overridden)[LifecycleInitA].x[] == 5
    @test Processes.context(overridden)[LifecycleInitB].y[] == 2

    b_ref = Processes.context(overridden)[LifecycleInitB].y
    partial = partialinit(overridden, Init(LifecycleInitA; x = 9, z = 4))

    @test Processes.context(partial)[LifecycleInitA].x[] == 9
    @test Processes.context(partial)[LifecycleInitA].z == 4
    @test Processes.context(partial)[LifecycleInitB].y === b_ref

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
    @test runtime_context[:FuncWrapper_1].value == 6.0
    @test !haskey(Processes.get_subcontexts(runtime_context), :_input)

    for entry in (runtime_algo, resolve(runtime_algo), initialized_runtime)
        process = Process(entry; repeats = 1)
        run(process; temp = 2.0, scale = 3)
        wait(process)
        @test Processes.context(process)[:FuncWrapper_1].value == 9.0
        @test !haskey(Processes.get_subcontexts(Processes.context(process)), :_input)
        close(process)
    end

    shape_result = run(init(SimpleAlgo(RuntimeShapeChanger(0))); lifetime = Repeat(0))
    @test runtime_shape_context(Processes.context(shape_result)).added == 1
    @test_throws Exception run(init(SimpleAlgo(RuntimeShapeChanger(0))); lifetime = Repeat(2))
end
