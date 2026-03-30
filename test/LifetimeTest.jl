using Test
using Processes

@testset "Additional lifetime variants" begin
    struct LifetimeCounter <: ProcessAlgorithm end

    function Processes.init(::LifetimeCounter, context)
        return (; count = 0)
    end

    function Processes.step!(::LifetimeCounter, context)
        return (; count = context.count + 1)
    end

    atleast_process = InlineProcess(
        LifetimeCounter;
        lifetime = Processes.AtLeast(x -> x >= 1, 4, Var(LifetimeCounter, :count)),
    )
    atleast_context = run(atleast_process)
    @test atleast_context[LifetimeCounter].count == 4

    early_stop_process = InlineProcess(
        LifetimeCounter;
        lifetime = Processes.AtLeastAtMost(x -> x >= 4, 3, 10, Var(LifetimeCounter, :count)),
    )
    early_stop_context = run(early_stop_process)
    @test early_stop_context[LifetimeCounter].count == 4

    capped_process = Process(
        LifetimeCounter;
        lifetime = Processes.AtLeastAtMost(x -> x >= 10, 3, 5, Var(LifetimeCounter, :count)),
    )
    run(capped_process)
    capped_context = fetch(capped_process)
    @test capped_context[LifetimeCounter].count == 5
end
