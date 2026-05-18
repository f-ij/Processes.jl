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

Processes.init(::NewPackSource, context) = (; value = 0)

function Processes.step!(::NewPackSource, context)
    return (; value = context.value + 1)
end

function Processes.init(::NewPackTarget, context)
    log = Int[]
    processsizehint!(log, context)
    return (; log)
end

function Processes.step!(::NewPackTarget, context)
    push!(context.log, context.input)
    return (;)
end

@testset "NewPackage runs as a ProcessAlgorithm" begin
    comp = CompositeAlgorithm(
        NewPackSource,
        NewPackTarget,
        (1, 2),
        Route(NewPackSource => NewPackTarget, :value => :input),
    )
    pkg = NewPackage(comp, "NewPack")

    @test pkg isa ProcessAlgorithm
    @test !(pkg isa Processes.AbstractIdentifiableAlgo)
    @test Processes.intervals(pkg) == Processes.intervals(comp)
    @test Processes.getalgos(pkg) == Processes.getalgos(comp)
    @test length(Processes.getaliases(pkg)) == length(Processes.getalgos(pkg))
    @test Processes.algo_to_subcontext_names(Processes.getalias(pkg, 2), :input) == :value

    p = Process(pkg; repeats = 6)
    run(p)
    wait(p)
    ctx = fetch(p)

    @test ctx[pkg].value == 6
    @test ctx[pkg].log == [2, 4, 6]
    @test Processes.inc(pkg) == 1
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

@testset "PackagedAlgo runs and benchmarks" begin
    n = 1_000
    @show n
    fibluc = CompositeAlgorithm( PackFib, PackLuc , (1, 1))
    pack = PackagedAlgo(fibluc, "FLPack")

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
