using Test
using Processes

struct PackFib <: Processes.ProcessAlgorithm end
struct PackLuc <: Processes.ProcessAlgorithm end

function Processes.step!(::PackFib, context)
    fiblist = context.fiblist
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return (;)
end

struct NewPackSource <: Processes.ProcessAlgorithm end
struct NewPackTarget <: Processes.ProcessAlgorithm end
struct NewPackOuterSource <: Processes.ProcessAlgorithm end
struct NewPackNeedsRoute <: Processes.ProcessAlgorithm end
struct NewPackCounter <: Processes.ProcessAlgorithm end

Processes.init(::NewPackSource, context) = (; value = 0)
Processes.init(::NewPackOuterSource, context) = (; delta = 0)

function Processes.step!(::NewPackSource, context)
    return (; value = context.value + 1)
end

function Processes.step!(::NewPackOuterSource, context)
    return (; delta = context.delta + 1)
end

function Processes.init(::NewPackTarget, context)
    log = Int[]
    processsizehint!(log, context)
    return (; log, expected_calls = Processes.num_calls(context))
end

Processes.init(::NewPackCounter, context) = (; expected_calls = Processes.num_calls(context))
Processes.step!(::NewPackCounter, context) = (;)

function Processes.step!(::NewPackTarget, context)
    push!(context.log, context.input)
    return (;)
end

Processes.init(::NewPackNeedsRoute, context) = (; seen = 0)
Processes.step!(::NewPackNeedsRoute, context) = (; seen = context.delta)

@testset "Package runs as a ProcessAlgorithm" begin
    comp = CompositeAlgorithm(
        NewPackSource,
        NewPackTarget,
        (1, 2),
        Route(NewPackSource => NewPackTarget, :value => :input),
    )
    pkg = Package(comp, "NewPack")

    @test pkg isa ProcessAlgorithm
    @test !(pkg isa Processes.AbstractIdentifiableAlgo)
    @test Processes.getname(pkg) == :NewPack
    @test Processes.intervals(pkg) == Processes.intervals(comp)
    @test all(child -> child isa SubPackage, Processes.getalgos(pkg))
    @test all(child -> !haskey(child), Processes.getalgos(pkg))
    @test map(child -> Processes.getalgo(child), Processes.getalgos(pkg)) == map(Processes.getalgo, Processes.getalgos(comp))
    @test Processes.algo_to_subcontext_names(Processes.getvaraliases(Processes.getalgo(pkg, 2)), :input) == :value
    reg = Processes.NameSpaceRegistry()
    reg, registered_pkg = Processes.add(reg, pkg, 1.0)
    @test Processes.getkey(registered_pkg) == :NewPack_1
    @test Processes.algoname(registered_pkg) == :NewPack

    p = Process(pkg; repeats = 6)
    run(p)
    wait(p)
    ctx = fetch(p)

    @test ctx[pkg].value == 6
    @test ctx[pkg].log == [2, 4, 6]
    @test ctx[pkg].expected_calls == 3
    @test Processes.inc(pkg) == 1

    nested_pkg = Package(comp)
    outer = CompositeAlgorithm(nested_pkg, (2,))
    nested_process = Process(outer; repeats = 8)
    run(nested_process)
    wait(nested_process)
    nested_ctx = fetch(nested_process)

    @test nested_ctx[nested_pkg].log == [2, 4]
    @test nested_ctx[nested_pkg].expected_calls == 2

    repeated = Package((NewPackCounter, NewPackCounter), (2, 3))
    repeated_process = Process(repeated; repeats = 12)
    run(repeated_process)
    wait(repeated_process)
    repeated_ctx = fetch(repeated_process)

    @test repeated_ctx[repeated].expected_calls == 10

    unique_pkg = Processes.Unique(Package(comp, "UniquePack"))
    unique_process = Process(unique_pkg; repeats = 6)
    run(unique_process)
    wait(unique_process)
    unique_ctx = fetch(unique_process)

    @test unique_ctx[unique_pkg].log == [2, 4, 6]
    @test unique_ctx[unique_pkg].expected_calls == 3

    routed_into_package = Package((NewPackNeedsRoute,), (1,))
    outer_routed = CompositeAlgorithm(
        NewPackOuterSource,
        routed_into_package,
        (1, 1),
        Route(NewPackOuterSource => routed_into_package, :delta),
    )
    routed_process = Process(outer_routed; repeats = 4)
    run(routed_process)
    wait(routed_process)
    routed_ctx = fetch(routed_process)

    @test routed_ctx[routed_into_package].seen == 4
end

function Processes.init(::PackFib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)
    return (;fiblist)
end

function Processes.step!(::PackLuc, context)
    luclist = context.luclist
    push!(luclist, luclist[end] + luclist[end - 1])
    return (;)
end

function Processes.init(::PackLuc, context)
    luclist = Int[2, 1]
    processsizehint!(luclist, context)
    return (;luclist)
end

@testset "Registry findall by algorithm type" begin
    fib1 = Processes.Unique(PackFib)
    fib2 = Processes.Unique(PackFib)
    comp = resolve(CompositeAlgorithm(fib1, fib2, PackLuc, (1, 1, 1)))
    reg = Processes.getregistry(comp)

    fib_matches = findall(PackFib, reg)
    luc_matches = findall(PackLuc, reg)

    @test length(fib_matches) == 2
    @test all(match -> Processes.getalgo(match) isa PackFib, fib_matches)
    @test length(luc_matches) == 1
    @test Processes.getalgo(only(luc_matches)) isa PackLuc
end

@testset "Package runs and benchmarks" begin
    n = 1_000
    @show n
    fibluc = CompositeAlgorithm( PackFib, PackLuc , (1, 1))
    pack = Package(fibluc, "FLPack")

    @test !haskey(pack)
    @test !Processes.hasautokey(pack)
    keyed_pack = Processes.Autokey(pack, 1)
    @test haskey(keyed_pack)
    @test Processes.hasautokey(keyed_pack)

    reg = Processes.NameSpaceRegistry()
    reg, registered_pack = Processes.add(reg, pack, 1.0)
    reg, reregistered_pack = Processes.add(reg, pack, 1.0)
    @test Processes.getkey(registered_pack) == :FLPack_1
    @test Processes.getkey(reregistered_pack) == :FLPack_1

    p = Process(pack; repeats = n)
    run(p)
    wait(p)
    ctx = fetch(p)

    @test length(ctx[pack].fiblist) == n + 2
    @test length(ctx[pack].luclist) == n + 2

    routed_fibluc = CompositeAlgorithm(
        PackFib,
        PackLuc,
        (1, 1),
        Route(PackFib => PackLuc, :fiblist => :source_fib),
    )
    routed_pack = Package(routed_fibluc, "RoutedFLPack")
    routed_aliases = Processes.getvaraliases(Processes.getalgo(routed_pack, 2))
    @test Processes.algo_to_subcontext_names(routed_aliases, :source_fib) == :fiblist

    bench = benchmark(pack, n, 1)
    @test bench > 0

    # Test routes to package
     # Route functions test
    struct PackLogger{T} <: ProcessAlgorithm end
    PackLogger(name::Symbol) = PackLogger{name}()

    function Processes.init(::PackLogger{T}, _input) where {T}
        log = Vector{Any}()
        processsizehint!(log, _input)
        return (;log)
    end
    function Processes.step!(::PackLogger{T}, context) where {T}
        (;log, targetnum) = context
        push!(log, targetnum)
        return (;)
    end

    Logger1 = PackLogger(:fibidiboo)
    Logging = CompositeAlgorithm( pack, Logger1, (1, 100), 
        Route(pack => Logger1, :fiblist => :targetnum, transform = x -> x[end]))
    p = Process(Logging; repeats = 1000)
    run(p)

    c = fetch(p)
    @test c isa ProcessContext
    log = c[Logger1].log
    @test log == c[pack].fiblist[2+100:100:end]
    @test length(log) == 10
end
