using Test
using Processes

@testset "Loop algorithm edit tools" begin
    struct EditAlgoA <: ProcessAlgorithm end
    struct EditAlgoB <: ProcessAlgorithm end
    struct EditAlgoC <: ProcessAlgorithm end
    struct EditState <: ProcessState end

    inner = CompositeAlgorithm(:left => EditAlgoA, EditAlgoB, (1, 2))
    outer = CompositeAlgorithm(inner, EditAlgoC, (3, 4))

    renamed = rename(outer, :left => :renamed_left)
    @test :renamed_left in keys(renamed)
    @test !(:left in keys(renamed))
    @test getkey(renamed.renamed_left) == :renamed_left

    inserted = insert(outer, 2, :middle => EditAlgoB, 5)
    @test length(getalgos(inserted)) == 4
    @test inserted[2] isa IdentifiableAlgo
    @test getkey(inserted[2]) == :middle
    @test interval(inserted, 1) == Processes.Interval(3)
    @test interval(inserted, 2) == Processes.Interval(5)
    @test interval(inserted, 3) == Processes.Interval(6)
    @test interval(inserted, 4) == Processes.Interval(4)

    retimed = changeinterval(outer, 2, 9)
    @test interval(retimed, 1) == Processes.Interval(3)
    @test interval(retimed, 2) == Processes.Interval(9)
    @test interval(retimed, 3) == Processes.Interval(4)

    retimed_all = changeintervals(outer, (8, 9, 10))
    @test interval(retimed_all, 1) == Processes.Interval(8)
    @test interval(retimed_all, 2) == Processes.Interval(9)
    @test interval(retimed_all, 3) == Processes.Interval(10)

    routine = Routine(EditAlgoA, EditAlgoB, (2, 3))
    extended_routine = addalgo(routine, :tail => EditAlgoC, 7)
    @test length(getalgos(extended_routine)) == 3
    @test repeats(extended_routine) == (2, 3, 7)
    @test getkey(extended_routine[3]) == :tail

    with_state = addstate(outer, :stateful => EditState)
    @test length(Processes.getstates(with_state)) == 1
    @test getkey(only(Processes.getstates(with_state))) == :stateful

    with_option = addoption(outer, Share(EditAlgoC, EditAlgoA))
    @test length(getoptions(with_option)) == length(getoptions(outer)) + 1
    @test only(getoptions(with_option, Share)) isa Share

    resolved = resolve(outer)
    @test_throws Exception insert(resolved, 1, EditAlgoA, 1)
    @test_throws Exception rename(resolved, :left => :nope)
end
