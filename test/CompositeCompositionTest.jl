using Test
using Processes

struct Fib <: Processes.ProcessAlgorithm end
struct Luc <: Processes.ProcessAlgorithm end

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
