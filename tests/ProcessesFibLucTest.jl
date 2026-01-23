using Test
using BenchmarkTools
using Statistics
using Processes

Processes.@ProcessAlgorithm function TestFib(fiblist)
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return nothing
end

Processes.@ProcessAlgorithm function TestLuc(luclist)
    push!(luclist, luclist[end] + luclist[end - 1])
    return nothing
end

function Processes.prepare(::TestFib, input)
    return (;fiblist = [0, 1])
end

function Processes.prepare(::TestLuc, input)
    return (;luclist = [2, 1])
end

@testset "Composite, Routine, InlineProcess, Unique" begin

    fibluc_comp = Processes.CompositeAlgorithm((TestFib, TestLuc), (1, 2))
    p = Processes.InlineProcess(fibluc_comp; lifetime = 5)
    context = Processes.run!(p)
    fib_name = Processes.getname(fibluc_comp, TestFib())
    luc_name = Processes.getname(fibluc_comp, TestLuc())
    fib_ctx = getproperty(context, fib_name)
    luc_ctx = getproperty(context, luc_name)
    @test fib_ctx.fiblist[end] == 8
    @test length(fib_ctx.fiblist) == 7
    @test length(luc_ctx.luclist) == 4

    fibluc_routine = Processes.Routine((TestFib, TestLuc), (2, 3))
    pr = Processes.InlineProcess(fibluc_routine; lifetime = 1)
    rcontext = Processes.run!(pr)
    rfib_name = Processes.getname(fibluc_routine, TestFib())
    rluc_name = Processes.getname(fibluc_routine, TestLuc())
    rfib_ctx = getproperty(rcontext, rfib_name)
    rluc_ctx = getproperty(rcontext, rluc_name)
    @test length(rfib_ctx.fiblist) == 4
    @test length(rluc_ctx.luclist) == 5

    unique_comp = Processes.CompositeAlgorithm((Processes.Unique(TestFib), Processes.Unique(TestFib)), (1, 1))
    ucontext = Processes.ProcessContext(unique_comp)
    subnames = propertynames(Processes.subcontexts(ucontext))
    @test length(subnames) == length(unique(subnames))
end

@testset "FibLuc speed" begin
    function fibluc_handwritten!(fiblist, luclist, n)
        for i in 1:n
            push!(fiblist, fiblist[end] + fiblist[end - 1])
            if i % 2 == 0
                push!(luclist, luclist[end] + luclist[end - 1])
            end
        end
        return fiblist, luclist
    end

    n = 50_000
    fibluc_comp = Processes.CompositeAlgorithm((TestFib, TestLuc), (1, 2))
    ip = Processes.InlineProcess(fibluc_comp; lifetime = n)

    bench_hand = @benchmark begin
        fib = [0, 1]
        luc = [2, 1]
        fibluc_handwritten!(fib, luc, $n)
    end samples=10 evals=1

    bench_proc = @benchmark begin
        Processes.reset!($ip)
        Processes.run!($ip)
    end samples=10 evals=1

    hand_med = median(bench_hand).time
    proc_med = median(bench_proc).time
    @test proc_med <= hand_med * 2.5
end
