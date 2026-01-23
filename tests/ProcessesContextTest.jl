using Test
using Processes

@testset "Context, Routes, SharedContexts" begin
    Processes.@ProcessAlgorithm function Source(state, dt)
        state = state + dt
        return (;state)
    end

    Processes.@ProcessAlgorithm function Target(targetnum, scale)
        return (;observed = targetnum * scale)
    end

    Processes.@ProcessAlgorithm function SharedConsumer(state)
        return (;seen = state)
    end

    function Processes.prepare(::Source, input)
        return (;state = 0.0, dt = 1.0)
    end

    function Processes.prepare(::Target, input)
        return (;observed = 0.0, scale = 2.0)
    end

    function Processes.prepare(::SharedConsumer, input)
        return (;seen = 0.0)
    end

    routed = Processes.CompositeAlgorithm((Source, Target), (1, 1),
        Processes.Route(Source, Target, :state => :targetnum, :dt => :scale))
    rp = Processes.InlineProcess(routed; lifetime = 1)
    rcontext = Processes.run!(rp)
    target_name = Processes.getname(routed, Target())
    target_ctx = getproperty(rcontext, target_name)
    @test target_ctx.observed == 2.0

    shared = Processes.CompositeAlgorithm((Source, SharedConsumer), (1, 1),
        Processes.Share(Source, SharedConsumer))
    sp = Processes.InlineProcess(shared; lifetime = 1)
    scontext = Processes.run!(sp)
    shared_name = Processes.getname(shared, SharedConsumer())
    shared_ctx = getproperty(scontext, shared_name)
    @test shared_ctx.seen == 1.0

    base_context = Processes.prepare(shared, (;))
    source_name = Processes.getname(shared, Source())
    @test hasproperty(base_context, source_name)
    @test hasproperty(base_context, shared_name)
end
