using Test
using Statistics
using Processes

struct InlineFib <: Processes.ProcessAlgorithm end
struct InlineLuc <: Processes.ProcessAlgorithm end

function Processes.step!(::InlineFib, context)
    fiblist = context.fiblist
    push!(fiblist, fiblist[end] + fiblist[end - 1])
    return (;)
end

function Processes.prepare(::InlineFib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)
    return (;fiblist)
end

function Processes.step!(::InlineLuc, context)
    luclist = context.luclist
    push!(luclist, luclist[end] + luclist[end - 1])
    return (;)
end

function Processes.prepare(::InlineLuc, context)
    luclist = Int[2, 1]
    processsizehint!(luclist, context)
    return (;luclist)
end

function naive_fibluc(n)
    luclist = Int[2, 1]
    fiblist = Int[0, 1]
    sizehint!(fiblist, n + 2)
    sizehint!(luclist, n + 2)
    time_i = time_ns()
    for i in 1:n
        push!(fiblist, fiblist[end] + fiblist[end - 1])
        push!(luclist, luclist[end] + luclist[end - 1])
    end
    total_time = (time_ns() - time_i) / 1e9
    return total_time
end

function inline_bmark(ip::Processes.InlineProcess, trials = 5)
    runtimes = Float64[]
    for _ in 1:trials
        @inline reset!(ip)
        start_ns = time_ns()
        @inline run(ip)
        elapsed = (time_ns() - start_ns) / 1e9
        push!(runtimes, elapsed)
    end
    return mean(runtimes)
end

function naive_benchmark(trials = 5, n = 100_000)
    runtimes = Float64[]
    for _ in 1:trials
        elapsed = naive_fibluc(n)
        push!(runtimes, elapsed)
    end
    return mean(runtimes)
end

@testset "InlineProcess benchmark" begin
    n = 100_000
    fibluc = Processes.CompositeAlgorithm((InlineFib, InlineLuc), (1, 1))
    ip = Processes.InlineProcess(fibluc; repeats = n)
    
    println("Benchmarking InlineProcess with $n repeats...")
    inline_time = inline_bmark(ip, 1)
    naive_time = naive_benchmark(1, n)

    inline_time = inline_bmark(ip, 1000)
    naive_time = naive_benchmark(1000, n)
   

    @info "InlineProcess time: $inline_time s and Naive time: $naive_time s"
    @info "InlineProcess is $((inline_time/naive_time)*100 ) % of Naive time"
    @test inline_time <= naive_time * 1.2
end
