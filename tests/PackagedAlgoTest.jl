using Test
using Processes

struct PackFib <: Processes.ProcessAlgorithm end
struct PackLuc <: Processes.ProcessAlgorithm end

function Processes.step!(::PackFib, context)
    fiblist = context.fiblist
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return (;)
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

    p = Process(pack; lifetime = n)
    run(p)
    wait(p)
    ctx = fetch(p)

    @test length(ctx[pack].fiblist) == n + 2
    @test length(ctx[pack].luclist) == n + 2

    bench = benchmark(pack, n, 1)
    @test bench > 0

    # Test routes to package
     # Route functions test
    struct Logger{T} <: ProcessAlgorithm end
    Logger(name::Symbol) = Logger{name}()

    function Processes.init(::Logger{T}, _input) where {T}
        log = Vector{Any}()
        processsizehint!(log, _input)
        return (;log)
    end
    function Processes.step!(::Logger{T}, context) where {T}
        (;log, targetnum) = context
        push!(log, targetnum)
        return (;)
    end

    Logger1 = Logger(:fibidiboo)
    Logging = CompositeAlgorithm( pack, Logger1, (1, 100), 
        Route(pack => Logger1, :fiblist => :targetnum, transform = x -> x[end]))
    p = Process(Logging; lifetime = 1000)
    run(p)

    c = fetch(p)
    @test c isa ProcessContext
    log = c[Logger1].log
    @test log == c[pack].fiblist[2+100:100:end]
    @test length(log) == 10
end
