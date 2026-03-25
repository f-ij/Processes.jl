using Test
using Processes

@testset "Loop algorithm materialization" begin
    struct PrepSource <: ProcessAlgorithm end
    struct PrepTarget <: ProcessAlgorithm end
    struct PrepOther <: ProcessAlgorithm end

    algo = CompositeAlgorithm(
        PrepSource,
        PrepTarget,
        (1, 1),
        Share(PrepSource, PrepTarget),
        Route(PrepSource => PrepTarget, :value => :target),
    )

    materialized = Processes.materialize(algo)
    registry = Processes.getregistry(materialized)

    source_name = Processes.static_findkey(registry, PrepSource)
    target_name = Processes.static_findkey(registry, PrepTarget)

    @test materialized isa Processes.CompositeAlgorithm
    @test Processes.ismaterialized(materialized)
    @test !isnothing(source_name)
    @test !isnothing(target_name)

    route = only(Processes.getoptions(materialized, Processes.Route))
    @test Processes.getkey(Processes.getfrom(route)) == source_name
    @test Processes.getkey(Processes.getto(route)) == target_name

    sharedcontexts, sharedvars = Processes._resolve_materialized_links(materialized)
    @test Processes.contextname(sharedcontexts[source_name]) == target_name
    @test Processes.contextname(sharedcontexts[target_name]) == source_name

    @test haskey(sharedvars, target_name)
    @test length(sharedvars[target_name]) == 1
    @test Processes.get_fromname(only(sharedvars[target_name])) == source_name

    routine = Routine(algo, PrepOther, (2, 3))
    materialized_routine = Processes.materialize(routine)
    nested_comp = first(Processes.getalgos(materialized_routine))

    @test materialized_routine isa Processes.Routine
    @test Processes.ismaterialized(materialized_routine)
    @test nested_comp isa Processes.CompositeAlgorithm
    @test Processes.all_keys(Processes.getregistry(nested_comp)) == Processes.all_keys(Processes.getregistry(materialized_routine))
    @test all(Processes.getkey.(Processes.getalgos(nested_comp)) .!= Ref(Symbol()))

    threaded = ThreadedCompositeAlgorithm(PrepSource, PrepTarget, (1, 1))
    materialized_threaded = Processes.materialize(threaded)
    @test materialized_threaded isa Processes.ThreadedCompositeAlgorithm
    @test Processes.ismaterialized(materialized_threaded)
    @test Processes.all_keys(Processes.getregistry(materialized_threaded)) == (source_name, target_name)
end
