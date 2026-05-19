using Test
using Processes

@testset "Loop algorithm materialization" begin
    struct PrepSource <: ProcessAlgorithm end
    struct PrepTarget <: ProcessAlgorithm end
    struct PrepOther <: ProcessAlgorithm end

    algo = CompositeAlgorithm(
        PrepSource,
        PrepTarget,
        PrepOther,
        (1, 1, 1),
        Share(PrepSource, PrepTarget),
        Route(PrepSource => PrepOther, :value => :target),
    )

    @test length(Processes.getoptions(algo, Processes.Route)) == 1
    @test algo isa Processes.CompositeAlgorithm
    @test Processes.getplan(algo) isa Processes.CompositeAlgorithm
    @test length(Processes.getoptions(Processes.getplan(algo), Processes.Route)) == 1

    resolved = Processes.resolve(algo)
    registry = Processes.getregistry(resolved)

    source_name = Processes.static_findkey(registry, PrepSource)
    target_name = Processes.static_findkey(registry, PrepTarget)
    other_name = Processes.static_findkey(registry, PrepOther)

    @test resolved isa Processes.LoopAlgorithm
    @test Processes.getplan(resolved) isa Processes.CompositeAlgorithm
    @test Processes.isresolved(resolved)
    @test length(Processes.getoptions(Processes.getplan(resolved), Processes.Route)) == 1
    @test length(getfield(Processes.getplan(resolved), :local_wiring)) == length(Processes.getalgos(resolved))
    @test !isnothing(source_name)
    @test !isnothing(target_name)
    @test !isnothing(other_name)
    @test isempty(Processes.getoptions(resolved, Processes.Route))

    sharedcontexts, sharedvars = Processes._resolve_options(resolved)
    @test Processes.contextname(sharedcontexts[source_name]) == target_name
    @test Processes.contextname(sharedcontexts[target_name]) == source_name

    @test haskey(sharedvars, other_name)
    @test length(sharedvars[other_name]) == 1
    @test Processes.get_fromname(only(sharedvars[other_name])) == source_name

    initialized = Processes.init(algo)
    reinitialized = Processes.init(initialized)
    @test typeof(Processes.getplan(initialized)) === typeof(Processes.getplan(reinitialized))
    @test Processes.getplan(initialized) === Processes.getplan(reinitialized)

    routine = Routine(algo, PrepOther, (2, 3))
    resolved_routine = Processes.resolve(routine)
    nested_comp = first(Processes.getalgos(resolved_routine))

    @test resolved_routine isa Processes.LoopAlgorithm
    @test Processes.getplan(resolved_routine) isa Processes.Routine
    @test Processes.isresolved(resolved_routine)
    @test nested_comp isa Processes.CompositeAlgorithm
    @test all(Processes.getkey.(Processes.getalgos(nested_comp)) .!= Ref(Symbol()))
    routine_wiring = getfield(Processes.getplan(resolved_routine), :step_wiring)
    nested_wiring = @inferred Processes.routing_childwiring(routine_wiring[1])
    @test length(routine_wiring) == length(Processes.getalgos(resolved_routine))
    @test length(nested_wiring) == length(Processes.getalgos(nested_comp))
    @test length(Processes.routing_sharedcontexts(nested_wiring[2])) == 1
    @test length(Processes.routing_sharedvars(nested_wiring[3])) == 1

    threaded = ThreadedCompositeAlgorithm(PrepSource, PrepTarget, (1, 1))
    @test threaded isa Processes.ThreadedCompositeAlgorithm
    @test !Processes.isresolved(threaded)
    @test Processes.intervals(threaded) == (Processes.Interval(1), Processes.Interval(1))

    algo1 = CompositeAlgorithm(
        PrepSource,
        (1,),
        Share(PrepSource, PrepTarget),
        Route(PrepSource => PrepOther, :value => :target),
    )
    algo2 = CompositeAlgorithm(
        PrepTarget,
        PrepOther,
        (1, 1),
    )

    resolved1, resolved2 = Processes.resolve(algo1, algo2)

    @test Processes.isresolved(resolved1)
    @test Processes.isresolved(resolved2)
    @test Processes.getregistry(resolved1) === Processes.getregistry(resolved2)

    shared_registry = Processes.getregistry(resolved1)
    source_name = Processes.static_findkey(shared_registry, PrepSource)
    target_name = Processes.static_findkey(shared_registry, PrepTarget)
    other_name = Processes.static_findkey(shared_registry, PrepOther)

    sharedcontexts1, sharedvars1 = Processes._resolve_options(resolved1)
    sharedcontexts2, sharedvars2 = Processes._resolve_options(resolved2)

    @test haskey(sharedcontexts1, source_name)
    @test Processes.contextname(sharedcontexts1[source_name]) == target_name
    @test haskey(sharedcontexts1, target_name)
    @test Processes.contextname(sharedcontexts1[target_name]) == source_name
    @test haskey(sharedvars1, other_name)
    @test length(sharedvars1[other_name]) == 1
    @test Processes.get_fromname(only(sharedvars1[other_name])) == source_name
    @test isempty(sharedcontexts2)
    @test isempty(sharedvars2)
end
