#!/usr/bin/env julia

# Branch-comparison benchmarks for the LoopAlgorithm plan/wrapper refactor.
#
# Run from a repository checkout:
#
#   julia --project=. benchmarks/plan_wrapper_compare.jl hot
#   julia --project=. benchmarks/plan_wrapper_compare.jl ttfp
#
# Useful knobs:
#
#   PROCESSES_COMPARE_TRIALS=25
#   PROCESSES_COMPARE_REPEATS=5000000
#   PROCESSES_COMPARE_CASES=inline_plain_default,inline_plain_nogen
#
# Output lines beginning with `RESULT` are intentionally simple to parse:
#
#   RESULT <mode> <label> best_s=<seconds> median_s=<seconds> alloc_bytes=<bytes>

using Printf
using Statistics

using Processes

const MODE = isempty(ARGS) ? "hot" : first(ARGS)
const TRIALS = parse(Int, get(ENV, "PROCESSES_COMPARE_TRIALS", "25"))
const REPEATS = parse(Int, get(ENV, "PROCESSES_COMPARE_REPEATS", "5000000"))
const CASE_FILTER = let raw = get(ENV, "PROCESSES_COMPARE_CASES", "")
    isempty(raw) ? nothing : Set(Symbol(strip(label)) for label in split(raw, ",") if !isempty(strip(label)))
end

struct PWBenchCounterA <: Processes.ProcessAlgorithm end
struct PWBenchCounterB <: Processes.ProcessAlgorithm end
struct PWBenchFib <: Processes.ProcessAlgorithm end
struct PWBenchLuc <: Processes.ProcessAlgorithm end

function Processes.init(::PWBenchCounterA, _context)
    return (; value = 0)
end

function Processes.init(::PWBenchCounterB, _context)
    return (; value = 0, input = 0)
end

function Processes.step!(::PWBenchCounterA, context::C) where {C}
    return (; value = context.value + 1)
end

function Processes.step!(::PWBenchCounterB, context::C) where {C}
    return (; value = context.value + context.input + 1)
end

function Processes.init(::PWBenchFib, context::C) where {C}
    fib = Int[0, 1]
    Processes.processsizehint!(fib, context)
    return (; fib)
end

function Processes.init(::PWBenchLuc, context::C) where {C}
    luc = Int[2, 1]
    Processes.processsizehint!(luc, context)
    return (; luc)
end

function Processes.step!(::PWBenchFib, context::C) where {C}
    fib = context.fib
    push!(fib, fib[end] + fib[end - 1])
    return nothing
end

function Processes.step!(::PWBenchLuc, context::C) where {C}
    luc = context.luc
    push!(luc, luc[end] + luc[end - 1])
    return nothing
end

function summarize(mode, label, times, allocs)
    best = minimum(times)
    med = median(times)
    alloc = round(Int, median(allocs))
    @printf("RESULT %s %s best_s=%.9f median_s=%.9f alloc_bytes=%d\n", mode, label, best, med, alloc)
    return (; label, best, median = med, alloc)
end

function sample(mode, label, f; trials = TRIALS)
    if CASE_FILTER !== nothing && Symbol(label) ∉ CASE_FILTER
        return nothing
    end

    f()
    GC.gc()

    times = Float64[]
    allocs = Int[]
    for _ in 1:trials
        GC.gc()
        push!(times, @elapsed f())
        push!(allocs, @allocated f())
    end
    return summarize(mode, label, times, allocs)
end

function run_inline(ip)
    Processes.reset!(ip)
    return run(ip)
end

function run_inline_nogen(ip)
    Processes.reset!(ip)
    return Processes.run_nogen(ip)
end

function hot()
    plain_counter = Processes.CompositeAlgorithm(PWBenchCounterA, PWBenchCounterB, (1, 1))
    routed_counter = Processes.CompositeAlgorithm(
        PWBenchCounterA,
        PWBenchCounterB,
        (1, 1),
        Processes.Route(PWBenchCounterA => PWBenchCounterB, :value => :input),
    )
    fib_luc = Processes.CompositeAlgorithm(PWBenchFib, PWBenchLuc, (1, 1))

    ip_plain = Processes.InlineProcess(plain_counter; repeats = REPEATS)
    ip_plain_nogen = Processes.InlineProcess(plain_counter; repeats = REPEATS)
    ip_routed = Processes.InlineProcess(routed_counter; repeats = REPEATS)
    ip_routed_nogen = Processes.InlineProcess(routed_counter; repeats = REPEATS)
    ip_fibluc = Processes.InlineProcess(fib_luc; repeats = REPEATS)
    ip_fibluc_nogen = Processes.InlineProcess(fib_luc; repeats = REPEATS)

    println("branch=", readchomp(`git branch --show-current`))
    println("mode=hot trials=$TRIALS repeats=$REPEATS")
    sample("hot", "inline_plain_default", () -> run_inline(ip_plain))
    sample("hot", "inline_plain_nogen", () -> run_inline_nogen(ip_plain_nogen))
    sample("hot", "inline_routed_default", () -> run_inline(ip_routed))
    sample("hot", "inline_routed_nogen", () -> run_inline_nogen(ip_routed_nogen))
    sample("hot", "inline_fibluc_default", () -> run_inline(ip_fibluc))
    sample("hot", "inline_fibluc_nogen", () -> run_inline_nogen(ip_fibluc_nogen))
    return nothing
end

function ttfp_case(thunk, label)
    GC.gc()
    elapsed = @elapsed thunk()
    alloc = @allocated thunk()
    @printf("RESULT ttfp %s best_s=%.9f median_s=%.9f alloc_bytes=%d\n", label, elapsed, elapsed, alloc)
end

function ttfp()
    println("branch=", readchomp(`git branch --show-current`))
    println("mode=ttfp repeats=$REPEATS")

    ttfp_case("first_inline_plain_run") do
        algo = Processes.CompositeAlgorithm(PWBenchCounterA, PWBenchCounterB, (1, 1))
        ip = Processes.InlineProcess(algo; repeats = REPEATS)
        run(ip)
    end

    ttfp_case("first_inline_routed_run") do
        algo = Processes.CompositeAlgorithm(
            PWBenchCounterA,
            PWBenchCounterB,
            (1, 1),
            Processes.Route(PWBenchCounterA => PWBenchCounterB, :value => :input),
        )
        ip = Processes.InlineProcess(algo; repeats = REPEATS)
        run(ip)
    end
    return nothing
end

if MODE == "hot"
    hot()
elseif MODE == "ttfp"
    ttfp()
else
    error("Unknown mode `$MODE`; expected `hot` or `ttfp`.")
end
