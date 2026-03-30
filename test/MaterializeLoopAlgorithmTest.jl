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

    resolved = Processes.resolve(algo)
    registry = Processes.getregistry(resolved)

    source_name = Processes.static_findkey(registry, PrepSource)
    target_name = Processes.static_findkey(registry, PrepTarget)

    @test resolved isa Processes.CompositeAlgorithm
    @test Processes.isresolved(resolved)
    @test !isnothing(source_name)
    @test !isnothing(target_name)

    route = only(Processes.getoptions(resolved, Processes.Route))
    @test Processes.getkey(Processes.getfrom(route)) == source_name
    @test Processes.getkey(Processes.getto(route)) == target_name

    sharedcontexts, sharedvars = Processes._resolve_options(resolved)
    @test Processes.contextname(sharedcontexts[source_name]) == target_name
    @test Processes.contextname(sharedcontexts[target_name]) == source_name

    @test haskey(sharedvars, target_name)
    @test length(sharedvars[target_name]) == 1
    @test Processes.get_fromname(only(sharedvars[target_name])) == source_name

    routine = Routine(algo, PrepOther, (2, 3))
    resolved_routine = Processes.resolve(routine)
    nested_comp = first(Processes.getalgos(resolved_routine))

    @test resolved_routine isa Processes.Routine
    @test Processes.isresolved(resolved_routine)
    @test nested_comp isa Processes.CompositeAlgorithm
    @test Processes.all_keys(Processes.getregistry(nested_comp)) == Processes.all_keys(Processes.getregistry(resolved_routine))
    @test all(Processes.getkey.(Processes.getalgos(nested_comp)) .!= Ref(Symbol()))

    threaded = ThreadedCompositeAlgorithm(PrepSource, PrepTarget, (1, 1))
    resolved_threaded = Processes.resolve(threaded)
    @test resolved_threaded isa Processes.ThreadedCompositeAlgorithm
    @test Processes.isresolved(resolved_threaded)
    @test Processes.all_keys(Processes.getregistry(resolved_threaded)) == (source_name, target_name)
end
