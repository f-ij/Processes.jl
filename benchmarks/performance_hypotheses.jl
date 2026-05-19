#!/usr/bin/env julia

# Standalone performance probes for semantics-preserving optimization work.
#
# Run from the repository root:
#
#   julia --project=. benchmarks/performance_hypotheses.jl
#
# Optional knobs:
#
#   PROCESSES_BENCH_TRIALS=10
#   PROCESSES_BENCH_REPEATS=1000000
#   PROCESSES_BENCH_CONSTRUCTION_TRIALS=1000
#   PROCESSES_BENCH_LLVM=1
#
# The benchmarks intentionally avoid BenchmarkTools so they can run from the
# package project without adding another benchmark environment. They are meant
# as quick hypothesis probes, not final statistically rigorous numbers.

using InteractiveUtils
using Printf
using Statistics

using Processes

const TRIALS = parse(Int, get(ENV, "PROCESSES_BENCH_TRIALS", "5"))
const REPEATS = parse(Int, get(ENV, "PROCESSES_BENCH_REPEATS", "200000"))
const CONSTRUCTION_TRIALS = parse(Int, get(ENV, "PROCESSES_BENCH_CONSTRUCTION_TRIALS", "200"))
const PRINT_LLVM = get(ENV, "PROCESSES_BENCH_LLVM", "0") == "1"

struct BenchSource <: Processes.ProcessAlgorithm end
struct BenchStableSink <: Processes.ProcessAlgorithm end
struct BenchLateSink <: Processes.ProcessAlgorithm end

function Processes.init(::BenchSource, context)
    return (; tick = 0, scale = context.scale, source = 0.0)
end

function Processes.init(::BenchStableSink, _context)
    return (; tick = 0, accum = 0.0, derived = 0.0)
end

function Processes.init(::BenchLateSink, _context)
    return (; tick = 0, accum = 0.0)
end

function Processes.step!(::BenchSource, context::C) where {C}
    tick = context.tick + 1
    source = muladd(context.scale, tick, context.source)
    return (; tick, source)
end

function Processes.step!(::BenchStableSink, context::C) where {C}
    tick = context.tick + 1
    derived = muladd(0.5, context.input_source, 0.001 * tick)
    accum = context.accum + derived
    return (; tick, accum, derived)
end

function Processes.step!(::BenchLateSink, context::C) where {C}
    tick = context.tick + 1
    derived = muladd(0.5, context.input_source, 0.001 * tick)
    accum = context.accum + derived
    return (; tick, accum, derived)
end

const StableRouteGraph = Processes.CompositeAlgorithm(
    BenchSource,
    BenchStableSink,
    (1, 1),
    Processes.Route(BenchSource => BenchStableSink, :source => :input_source),
)

const LateRouteGraph = Processes.CompositeAlgorithm(
    BenchSource,
    BenchLateSink,
    (1, 1),
    Processes.Route(BenchSource => BenchLateSink, :source => :input_source),
)

struct BenchFib <: Processes.ProcessAlgorithm end
struct BenchLuc <: Processes.ProcessAlgorithm end

function Processes.init(::BenchFib, context)
    fib = Int[0, 1]
    Processes.processsizehint!(fib, context)
    return (; fib)
end

function Processes.init(::BenchLuc, context)
    luc = Int[2, 1]
    Processes.processsizehint!(luc, context)
    return (; luc)
end

function Processes.step!(::BenchFib, context::C) where {C}
    fib = context.fib
    push!(fib, fib[end] + fib[end - 1])
    return nothing
end

function Processes.step!(::BenchLuc, context::C) where {C}
    luc = context.luc
    push!(luc, luc[end] + luc[end - 1])
    return nothing
end

const FibLucGraph = Processes.CompositeAlgorithm(BenchFib, BenchLuc, (1, 1))

function summarize(label, times, allocs)
    sorted_times = sort(times)
    sorted_allocs = sort(allocs)
    @printf(
        "%-34s best %9.6f s   median %9.6f s   alloc median %10d bytes\n",
        label,
        first(sorted_times),
        median(sorted_times),
        round(Int, median(sorted_allocs)),
    )
    return nothing
end

function sample(label, f; trials = TRIALS, gc = true)
    f()
    gc && GC.gc()

    times = Float64[]
    allocs = Int[]
    for _ in 1:trials
        gc && GC.gc()
        push!(times, @elapsed f())
        push!(allocs, @allocated f())
    end
    summarize(label, times, allocs)
    return (; label, times, allocs)
end

function run_process_graph(algo; repeats = REPEATS)
    p = Processes.Process(
        algo,
        Processes.Input(BenchSource; scale = 0.001);
        repeats,
    )
    Processes.run(p)
    wait(p)
    result = fetch(p)
    Processes.quit(p)
    return result
end

function construct_and_quit_process(algo)
    p = Processes.Process(
        algo,
        Processes.Input(BenchSource; scale = 0.001);
        repeats = 1,
    )
    Processes.quit(p)
    return nothing
end

function stable_step_probe(algo)
    ip = Processes.InlineProcess(
        algo,
        Processes.Input(BenchSource; scale = 0.001);
        repeats = 1,
    )
    runtime_context = Processes._merge_into_globals(Processes.context(ip), (; process = ip))
    graph = Processes.getalgo(Processes.taskdata(ip))
    boot_context = Processes.step!(graph, runtime_context, Processes.Unstable())
    return graph, boot_context
end

function direct_stable_step_alloc(algo)
    graph, boot_context = stable_step_probe(algo)
    return @allocated Processes.step!(graph, boot_context, Processes.Stable())
end

function run_inline_default(ip)
    Processes.reset!(ip)
    return run(ip)
end

function run_inline_nongenerated(ip)
    Processes.reset!(ip)
    return Processes.run_nogen(ip)
end

function run_inline_generated(ip)
    Processes.reset!(ip)
    graph = Processes.getalgo(Processes.taskdata(ip))
    runtime_context = Processes._merge_into_globals(Processes.context(ip), (; process = ip))
    return Processes.loop(ip, graph, runtime_context, Processes.lifetime(ip), Processes.Generated())
end

function naive_fibluc(n)
    fib = Int[0, 1]
    luc = Int[2, 1]
    sizehint!(fib, n + 2)
    sizehint!(luc, n + 2)
    for _ in 1:n
        push!(fib, fib[end] + fib[end - 1])
        push!(luc, luc[end] + luc[end - 1])
    end
    return fib[end] + luc[end]
end

function print_llvm_probe()
    graph, boot_context = stable_step_probe(StableRouteGraph)
    println()
    println("LLVM for one stable routed CompositeAlgorithm step:")
    code_llvm(
        stdout,
        Processes.step!,
        Tuple{typeof(graph), typeof(boot_context), Processes.Stable};
        debuginfo = :none,
        optimize = true,
    )
    return nothing
end

function main()
    println("Processes.jl performance hypothesis probes")
    println("trials: ", TRIALS)
    println("repeats: ", REPEATS)
    println("construction trials: ", CONSTRUCTION_TRIALS)
    println()

    sample("Process construct+quit stable", () -> construct_and_quit_process(StableRouteGraph); trials = CONSTRUCTION_TRIALS)
    sample("Process construct+quit late", () -> construct_and_quit_process(LateRouteGraph); trials = CONSTRUCTION_TRIALS)
    println()

    stable_alloc = direct_stable_step_alloc(StableRouteGraph)
    late_alloc = direct_stable_step_alloc(LateRouteGraph)
    println("Direct post-bootstrap stable step allocation probes:")
    println("  StableRouteGraph: ", stable_alloc, " bytes")
    println("  LateRouteGraph:   ", late_alloc, " bytes")
    println()

    sample("Process run stable routed", () -> run_process_graph(StableRouteGraph))
    sample("Process run late-growth routed", () -> run_process_graph(LateRouteGraph))
    println()

    ip_default = Processes.InlineProcess(FibLucGraph; repeats = REPEATS)
    ip_nogen = Processes.InlineProcess(FibLucGraph; repeats = REPEATS)
    ip_gen = Processes.InlineProcess(FibLucGraph; repeats = REPEATS)

    sample("InlineProcess default", () -> run_inline_default(ip_default))
    sample("InlineProcess NonGenerated", () -> run_inline_nongenerated(ip_nogen))
    sample("InlineProcess Generated", () -> run_inline_generated(ip_gen))
    sample("Naive fib/luc loop", () -> naive_fibluc(REPEATS))

    PRINT_LLVM && print_llvm_probe()
    return nothing
end

main()

