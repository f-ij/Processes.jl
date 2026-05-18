using Test
using Processes

struct Fib <: Processes.ProcessAlgorithm end
struct Luc <: Processes.ProcessAlgorithm end
struct FinalCounter <: Processes.ProcessAlgorithm end

function Processes.init(::FinalCounter, context)
    return (; count = 0, cleaned = false)
end

function Processes.step!(::FinalCounter, context)
    return (; count = context.count + 1)
end

function Processes.cleanup(::FinalCounter, context)
    return (; count = context.count + 10, cleaned = true)
end

@testset "Composite composition, flattening, routine" begin
    fdup_inst = Processes.Unique(Fib())
    fdup_type = Processes.Unique(Fib)
    ldup = Processes.Unique(Luc)

    fibluc = CompositeAlgorithm( Fib(), Fib, Luc, (1, 1, 2))
    @test Processes.intervals(fibluc) == (Processes.Interval(1), Processes.Interval(1), Processes.Interval(2))

    comp_unique = CompositeAlgorithm( Fib(), Fib, fdup_type , (1, 1, 1))
    # reg_unique = Processes.getregistry(comp_unique)
    # name_fib_inst = Processes.getkey(reg_unique, Fib())
    # name_fib_type = Processes.getkey(reg_unique, Fib)
    # name_fdup_type = Processes.getkey(reg_unique, fdup_type)
    # @test length(unique((name_fib_inst, name_fib_type, name_fdup_type))) == 3

    routine = Processes.Routine( Fib, Fib(), fibluc , (10, 20, 30))
    @test Processes.repeats(routine) == (10, 20, 30)
    @test Processes.lifetime(Process(resolve(routine))) == Repeat(1)

    ffluc = CompositeAlgorithm( fibluc, fdup_inst, Fib, ldup , (10, 5, 2, 1))
    @test Processes.intervals(ffluc) == (
        Processes.Interval(10),
        Processes.Interval(10),
        Processes.Interval(20),
        Processes.Interval(5),
        Processes.Interval(2),
        Processes.Interval(1),
    )
    @test length(Processes.getalgos(ffluc)) == 6

    flat_funcs, flat_intervals = Processes.flatten(ffluc)
    @test length(flat_funcs) == 6
    @test flat_funcs == Processes.getalgos(ffluc)
    @test flat_intervals == Processes.intervals(ffluc)

    routed = CompositeAlgorithm(
        Fib,
        Luc,
        (1, 2),
        Route(Fib => Luc, :fiblist => :source_fib),
    )
    routed_flat_funcs, routed_flat_intervals = Processes.flatten(routed)
    @test routed_flat_funcs == Processes.getalgos(routed)
    @test routed_flat_intervals == Processes.intervals(routed)

    resolved_flat_funcs, resolved_flat_intervals = Processes.flatten(resolve(routed))
    unwrap_identifiable(x) = x isa Processes.AbstractIdentifiableAlgo ? Processes.getalgo(x) : x
    unwrapped_resolved = map(unwrap_identifiable, resolved_flat_funcs)
    unwrapped_routed = map(unwrap_identifiable, Processes.getalgos(routed))
    @test unwrapped_resolved == unwrapped_routed
    @test resolved_flat_intervals == Processes.intervals(routed)

    inner = @Routine begin
        @alias dynamics = Fib()
        dynamics()
    end
    outer = @CompositeAlgorithm begin
        inner
    end
    loc = Processes.findkey(outer, :dynamics)

    @test :dynamics in keys(outer)
    @test :dynamics in propertynames(outer)
    @test !isnothing(loc)
    @test !isnothing(Processes.findkey(typeof(outer), :dynamics))
    @test Processes.getkey(outer.dynamics) == :dynamics
    @test outer[loc] === outer.dynamics

    # reg_ffluc = Processes.getregistry(ffluc)
    # name_fib_inst_ff = Processes.getkey(reg_ffluc, Fib())
    # name_fib_type_ff = Processes.getkey(reg_ffluc, Fib)
    # name_fdup_inst = Processes.getkey(reg_ffluc, fdup_inst)
    # @test length(unique((name_fib_inst_ff, name_fib_type_ff, name_fdup_inst))) == 3
end

@testset "Loop algorithm recipes and root final wrapper" begin
    comp_recipe = CompositeAlgorithm(Fib, Luc, (1, 1))
    @test comp_recipe isa CompositeAlgorithmRecipe
    @test !(resolve(comp_recipe) isa CompositeAlgorithmRecipe)

    routine_recipe = Routine(Fib, Luc, (1, 1))
    @test routine_recipe isa RoutineRecipe
    @test !(resolve(routine_recipe) isa RoutineRecipe)

    finalized = finalstep(
        CompositeAlgorithm(FinalCounter, (1,)),
        context -> (; count = context[FinalCounter].count, cleaned = context[FinalCounter].cleaned),
    )
    resolved = resolve(finalized)
    @test resolved isa Processes.FinalizedAlgorithm
    @test Processes.isresolved(resolved)
    @test length(resolved) == 1

    p = Process(resolved, repeat = 2)
    run(p)
    result = fetch(p)
    @test result == (; count = 12, cleaned = true)
    @test context(p)[FinalCounter].count == 12
    @test context(p)[FinalCounter].cleaned

    close(p)
    @test fetch(p) == result
    @test context(p)[FinalCounter].count == 12

    inner = finalstep(CompositeAlgorithm(FinalCounter, (1,)), context -> :inner_final)
    nested = @test_logs (:warn, r"root-only") CompositeAlgorithm(inner, Luc, (1, 1))
    @test !(Processes.getalgo(nested, 1) isa Processes.FinalizedAlgorithm)
end

@testset "IfWrapped parser options filter constructor inputs" begin
    kept_comp = CompositeAlgorithm(IfWrapped(Fib, true), Luc, (2, 3))
    @test length(Processes.getalgos(kept_comp)) == 2
    @test Processes.intervals(kept_comp) == (Processes.Interval(2), Processes.Interval(3))

    skipped_comp = CompositeAlgorithm(IfWrapped(Fib, false), Luc, (2, 3))
    @test length(Processes.getalgos(skipped_comp)) == 1
    @test Processes.intervals(skipped_comp) == (Processes.Interval(3),)

    skipped_routine = Routine(IfWrapped(Fib, false), Luc, (2, 3))
    @test length(Processes.getalgos(skipped_routine)) == 1
    @test Processes.repeats(skipped_routine) == (3,)

    named_outer = resolve(CompositeAlgorithm(:fib => IfWrapped(Fib, true), Luc, (1, 1)))
    @test Processes.getkey(Processes.getalgo(named_outer, 1)) == :fib

    named_inner = resolve(CompositeAlgorithm(IfWrapped(:fib => Fib, true), Luc, (1, 1)))
    @test Processes.getkey(Processes.getalgo(named_inner, 1)) == :fib

    @test_throws AssertionError CompositeAlgorithm(IfWrapped(Fib, false), (1,))
end

@testset "Identifiable merge forwarding preserves keyed GeneralState" begin
    left_state = @state begin
        seed = 4
    end
    right_state = @state begin
        scale
    end
    other_state = @state begin
        offset = 2
    end

    left = IdentifiableAlgo(left_state, :_state)
    right = IdentifiableAlgo(right_state, :_state)
    other_key = IdentifiableAlgo(other_state, :other_state)

    @test registry_allowmerge(left)
    @test registry_allowmerge(right)
    @test registry_allowmerge(left, right)
    @test !registry_allowmerge(left, other_key)

    merged = merge(left, right)
    @test getkey(merged) == :_state
    @test Processes.general_state_fields(getalgo(merged)) == (:seed, :scale)
    @test Processes.general_state_required_fields(getalgo(merged)) == (:scale,)
    @test Processes.init(getalgo(merged), (; scale = 3.0)) == (; seed = 4, scale = 3.0)
    @test sprint(show, merged) == "GeneralState(seed = <default>, scale)@_state: GeneralState(seed = <default>, scale)"
end

@testset "separate_nested_namedtuples preserves outer order" begin
    nested = (; a = (; x = 1, y = 2), b = (; z = 3))
    @test Processes.separate_nested_namedtuples(nested) == (
        (; a = (; x = 1, y = 2)),
        (; b = (; z = 3)),
    )
end
