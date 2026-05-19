using Test
using Processes

@testset "Routing wiring types" begin
    struct WiringSource <: ProcessAlgorithm end
    struct WiringTarget <: ProcessAlgorithm end
    struct WiringOther <: ProcessAlgorithm end

    @test Processes.Route <: Processes.AbstractWiring
    @test Processes.Share <: Processes.AbstractWiring
    @test Processes.LocalPlanOption <: Processes.AbstractWiring
    @test !(Processes.Route <: Processes.AbstractOption)
    @test !(Processes.Share <: Processes.AbstractOption)
    @test !(Processes.LocalPlanOption <: Processes.AbstractOption)
    @test !isdefined(Processes, :StepRouting)
    @test !isdefined(Processes, :SharedContext)
    @test !isdefined(Processes, :SharedVars)

    empty_wiring = Processes.Wiring()
    @test empty_wiring isa Processes.Wiring{Tuple{}, Tuple{}}
    @test isempty(empty_wiring)

    resolved_route = Route(:source => :target, :value => :seen)
    @test Processes.isresolved(resolved_route)
    @test typeof(resolved_route)() == resolved_route

    raw_route = Route(WiringSource => WiringTarget, :value)
    @test !Processes.isresolved(raw_route)
    @test Processes.getfrom(raw_route) === WiringSource
    @test Processes.getto(raw_route) === WiringTarget

    resolved_share = Share(:source, :target)
    @test Processes.isresolved(resolved_share)
    @test typeof(resolved_share)() == resolved_share

    raw_share = Share(WiringSource, WiringTarget)
    @test !Processes.isresolved(raw_share)
    @test Processes.get_firstalgo(raw_share) === WiringSource
    @test Processes.get_secondalgo(raw_share) === WiringTarget

    route_a = Route{:a, :target, nothing, (:x,), (:value,), Nothing, Nothing}()
    route_b = Route{:b, :target, nothing, (:y,), (:value,), Nothing, Nothing}()
    merged = Processes.merge_wiring(Processes.Wiring((route_a,), ()), Processes.Wiring((route_b,), ()))
    @test Processes.routes(merged) == (route_b,)

    plan = CompositeAlgorithm(
        WiringSource,
        WiringTarget,
        WiringOther,
        (1, 1, 1),
        Share(WiringSource, WiringTarget),
        Route(WiringSource => WiringOther, :value),
    )
    plan_wiring = Processes.getwiring(plan)
    @test Processes.global_wiring(plan_wiring) isa Processes.Wiring
    @test length(Processes.child_wiring(plan_wiring)) == 3
    @test all(x -> x isa Processes.Wiring, Processes.child_wiring(plan_wiring))

    resolved = resolve(plan)
    resolved_wiring = Processes.getwiring(Processes.getplan(resolved))
    @test Processes.global_wiring(resolved_wiring) isa NamedTuple
    @test length(Processes.child_wiring(resolved_wiring)) == 3

    all_resolved(w::Processes.Wiring) =
        all(Processes.isresolved, Processes.routes(w)) &&
        all(Processes.isresolved, Processes.shares(w))
    all_resolved(w::Processes.PlanWiring) =
        all(all_resolved, values(Processes.global_wiring(w))) &&
        all(all_resolved, Processes.child_wiring(w))

    @test all_resolved(resolved_wiring)
end
