using Test
using Processes

struct Fib <: Processes.ProcessAlgorithm end
struct Luc <: Processes.ProcessAlgorithm end

@testset "Composite composition, flattening, routine" begin
    fdup_inst = Processes.Unique(Fib())
    fdup_type = Processes.Unique(Fib)
    ldup = Processes.Unique(Luc)

    fibluc = CompositeAlgorithm((Fib(), Fib, Luc), (1, 1, 2))
    @test Processes.intervals(fibluc) == (1, 1, 2)

    comp_unique = CompositeAlgorithm((Fib(), Fib, fdup_type), (1, 1, 1))
    reg_unique = Processes.getregistry(comp_unique)
    name_fib_inst = Processes.getkey(reg_unique, Fib())
    name_fib_type = Processes.getkey(reg_unique, Fib)
    name_fdup_type = Processes.getkey(reg_unique, fdup_type)
    @test length(unique((name_fib_inst, name_fib_type, name_fdup_type))) == 3

    routine = Processes.Routine((Fib, Fib(), fibluc), (10, 20, 30))
    @test Processes.repeats(routine) == (10, 20, 30)

    ffluc = CompositeAlgorithm((fibluc, fdup_inst, Fib, ldup), (10, 5, 2, 1))
    @test Processes.intervals(ffluc) == (10, 10, 20, 5, 2, 1)
    @test length(Processes.getalgos(ffluc)) == 6

    flat_funcs, flat_intervals = Processes.flatten(ffluc)
    @test length(flat_funcs) == 6
    @test flat_funcs == Processes.getalgos(ffluc)
    @test flat_intervals == Processes.intervals(ffluc)

    reg_ffluc = Processes.getregistry(ffluc)
    name_fib_inst_ff = Processes.getkey(reg_ffluc, Fib())
    name_fib_type_ff = Processes.getkey(reg_ffluc, Fib)
    name_fdup_inst = Processes.getkey(reg_ffluc, fdup_inst)
    @test length(unique((name_fib_inst_ff, name_fib_type_ff, name_fdup_inst))) == 3
end
