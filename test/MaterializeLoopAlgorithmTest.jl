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

    resolved = Processes.resolve(algo)
    registry = Processes.getregistry(resolved)

    source_name = Processes.static_findkey(registry, PrepSource)
    target_name = Processes.static_findkey(registry, PrepTarget)
    other_name = Processes.static_findkey(registry, PrepOther)

    @test resolved isa Processes.CompositeAlgorithm
    @test Processes.isresolved(resolved)
    @test !isnothing(source_name)
    @test !isnothing(target_name)
    @test !isnothing(other_name)
    @test isempty(Processes.getoptions(resolved, Processes.Route))

    opts = Processes.getoptions(resolved)
    sharedcontexts, sharedvars = Processes._resolve_options(resolved)
    @test opts == Processes.merge_nested_namedtuples(sharedvars, sharedcontexts)
    @test Processes.contextname(sharedcontexts[source_name]) == target_name
    @test Processes.contextname(sharedcontexts[target_name]) == source_name

    @test haskey(sharedvars, other_name)
    @test length(sharedvars[other_name]) == 1
    @test Processes.get_fromname(only(sharedvars[other_name])) == source_name

    routine = Routine(algo, PrepOther, (2, 3))
    resolved_routine = Processes.resolve(routine)
    nested_comp = first(Processes.getalgos(resolved_routine))

    @test resolved_routine isa Processes.Routine
    @test Processes.isresolved(resolved_routine)
    @test nested_comp isa Processes.CompositeAlgorithm
    @test Processes.all_keys(Processes.getregistry(nested_comp)) == Processes.all_keys(Processes.getregistry(resolved_routine))
    @test all(Processes.getkey.(Processes.getalgos(nested_comp)) .!= Ref(Symbol()))

    threaded = ThreadedCompositeAlgorithm(PrepSource, PrepTarget, (1, 1))
    @test threaded isa Processes.ThreadedCompositeAlgorithm
    @test !Processes.isresolved(threaded)
    @test Processes.intervals(threaded) == (Processes.Interval(1), Processes.Interval(1))
end
