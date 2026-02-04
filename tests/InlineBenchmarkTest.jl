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
    for i in 1:n
        push!(fiblist, fiblist[end] + fiblist[end - 1])
        push!(luclist, luclist[end] + luclist[end - 1])
    end
    return fiblist, luclist
end

function inline_bmark(ip::Processes.InlineProcess, trials = 5)
    runtimes = Float64[]
    for _ in 1:trials
        reset!(ip)
        start_ns = time_ns()
        @inline run!(ip)
        elapsed = (time_ns() - start_ns) / 1e9
        push!(runtimes, elapsed)
    end
    return mean(runtimes)
end

@testset "InlineProcess benchmark" begin
    n = 50_000
    fibluc = Processes.CompositeAlgorithm((InlineFib, InlineLuc), (1, 1))
    ip = Processes.InlineProcess(fibluc; lifetime = n)

    inline_time = inline_bmark(ip, 5)

    naive_times = Float64[]
    for _ in 1:5
        start_ns = time_ns()
        naive_fibluc(n)
        elapsed = (time_ns() - start_ns) / 1e9
        push!(naive_times, elapsed)
    end
    naive_time = mean(naive_times)

    @test inline_time <= naive_time * 2.0
end
