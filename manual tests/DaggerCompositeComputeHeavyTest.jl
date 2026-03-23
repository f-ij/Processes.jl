include("_env.jl")
using Random

"""
Manual benchmark with a branch-heavy, compute-bound workload that is more favorable to Dagger.

Pattern:
    Source
      ├─ MetricA
      ├─ MetricB
      ├─ MetricC
      ├─ MetricD
      ├─ MetricE
      ├─ MetricF
      ├─ MetricG
      └─ MetricH
        ↓
      MetricReducer

The source and reducer are intentionally cheap. Most work happens in the eight independent
metric branches, each of which scans the same input signal and computes one scalar summary with
substantial arithmetic per element.
"""

struct StaticSource <: Processes.ProcessAlgorithm end
struct MetricA <: Processes.ProcessAlgorithm end
struct MetricB <: Processes.ProcessAlgorithm end
struct MetricC <: Processes.ProcessAlgorithm end
struct MetricD <: Processes.ProcessAlgorithm end
struct MetricE <: Processes.ProcessAlgorithm end
struct MetricF <: Processes.ProcessAlgorithm end
struct MetricG <: Processes.ProcessAlgorithm end
struct MetricH <: Processes.ProcessAlgorithm end
struct MetricReducer <: Processes.ProcessAlgorithm end

function Processes.init(::StaticSource, context)
    return (; signal = copy(context.start_signal))
end

Processes.step!(::StaticSource, _context) = (;)

@inline function metric_kernel(x, a, b, c, d, e, f)
    x = sin(x + a) + cos(b * x) + tanh(c * x)
    x = muladd(d, x * x, exp(-abs(x)))
    x = sin(x + e) + cos(f * x) + tanh((a + c) * x)
    x = muladd(b, x * x, exp(-abs(x)))
    x = sin(x + d) + cos(e * x) + tanh((f + c) * x)
    x = muladd(c, x * x, exp(-abs(x)))
    return x
end

function branch_metric(input_signal, a, b, c, d, e, f)
    acc = 0.0
    @inbounds for i in eachindex(input_signal)
        x = input_signal[i]
        x = metric_kernel(x, a, b, c, d, e, f)
        x = metric_kernel(x, f, e, d, c, b, a)
        acc += x
    end
    return acc
end

Processes.init(::MetricA, _context) = (; metric_a = 0.0)
Processes.init(::MetricB, _context) = (; metric_b = 0.0)
Processes.init(::MetricC, _context) = (; metric_c = 0.0)
Processes.init(::MetricD, _context) = (; metric_d = 0.0)
Processes.init(::MetricE, _context) = (; metric_e = 0.0)
Processes.init(::MetricF, _context) = (; metric_f = 0.0)
Processes.init(::MetricG, _context) = (; metric_g = 0.0)
Processes.init(::MetricH, _context) = (; metric_h = 0.0)

Processes.step!(::MetricA, context) = (; metric_a = branch_metric(context.input_signal, 0.13, 0.71, 0.29, 0.17, 0.91, 0.43))
Processes.step!(::MetricB, context) = (; metric_b = branch_metric(context.input_signal, 0.23, 0.67, 0.37, 0.11, 0.83, 0.31))
Processes.step!(::MetricC, context) = (; metric_c = branch_metric(context.input_signal, 0.19, 0.79, 0.41, 0.21, 0.73, 0.27))
Processes.step!(::MetricD, context) = (; metric_d = branch_metric(context.input_signal, 0.31, 0.61, 0.47, 0.15, 0.89, 0.35))
Processes.step!(::MetricE, context) = (; metric_e = branch_metric(context.input_signal, 0.17, 0.83, 0.33, 0.19, 0.77, 0.45))
Processes.step!(::MetricF, context) = (; metric_f = branch_metric(context.input_signal, 0.29, 0.69, 0.39, 0.13, 0.87, 0.25))
Processes.step!(::MetricG, context) = (; metric_g = branch_metric(context.input_signal, 0.11, 0.75, 0.35, 0.23, 0.81, 0.41))
Processes.step!(::MetricH, context) = (; metric_h = branch_metric(context.input_signal, 0.27, 0.65, 0.43, 0.09, 0.93, 0.29))

Processes.init(::MetricReducer, _context) = (; total_metric = 0.0)

function Processes.step!(::MetricReducer, context)
    total_metric = context.a + context.b + context.c + context.d +
                   context.e + context.f + context.g + context.h
    return (; total_metric)
end

function build_algorithms()
    routes = (
        Route(StaticSource => MetricA, :signal => :input_signal),
        Route(StaticSource => MetricB, :signal => :input_signal),
        Route(StaticSource => MetricC, :signal => :input_signal),
        Route(StaticSource => MetricD, :signal => :input_signal),
        Route(StaticSource => MetricE, :signal => :input_signal),
        Route(StaticSource => MetricF, :signal => :input_signal),
        Route(StaticSource => MetricG, :signal => :input_signal),
        Route(StaticSource => MetricH, :signal => :input_signal),
        Route(MetricA => MetricReducer, :metric_a => :a),
        Route(MetricB => MetricReducer, :metric_b => :b),
        Route(MetricC => MetricReducer, :metric_c => :c),
        Route(MetricD => MetricReducer, :metric_d => :d),
        Route(MetricE => MetricReducer, :metric_e => :e),
        Route(MetricF => MetricReducer, :metric_f => :f),
        Route(MetricG => MetricReducer, :metric_g => :g),
        Route(MetricH => MetricReducer, :metric_h => :h),
    )

    comp = CompositeAlgorithm(
        StaticSource, MetricA, MetricB, MetricC, MetricD, MetricE, MetricF, MetricG, MetricH, MetricReducer,
        ntuple(_ -> 1, 10),
        routes...,
    )

    dag = DaggerCompositeAlgorithm(
        StaticSource, MetricA, MetricB, MetricC, MetricD, MetricE, MetricF, MetricG, MetricH, MetricReducer,
        ntuple(_ -> 1, 10),
        routes...,
    )

    return comp, dag
end

function run_once(algo, start_signal; repeats)
    p = Process(
        algo,
        Input(StaticSource, :start_signal => copy(start_signal));
        lifetime = repeats,
    )

    elapsed = @elapsed begin
        run(p)
        wait(p)
    end

    ctx = fetch(p)
    quit(p)

    return elapsed, ctx
end

function benchmark(algo, start_signal; repeats, trials, label)
    times = Float64[]
    final_ctx = nothing

    run_once(algo, start_signal; repeats = 1)
    GC.gc()

    for trial in 1:trials
        elapsed, ctx = run_once(algo, start_signal; repeats)
        push!(times, elapsed)
        final_ctx = ctx
        GC.gc()
        println(label, " trial ", trial, ": ", round(elapsed; digits = 4), " s")
    end

    return times, final_ctx
end

Random.seed!(1234)

n = 200_000
repeats = 4
trials = 3
start_signal = randn(n)

comp, dag = build_algorithms()

println("Signal length: ", n)
println("Repeats: ", repeats)
println("Trials: ", trials)
println("Pattern: source -> 8 compute-heavy scalar branches -> reducer")
println()

comp_times, comp_ctx = benchmark(comp, start_signal; repeats, trials, label = "Composite")
println()
dag_times, dag_ctx = benchmark(dag, start_signal; repeats, trials, label = "Dagger")
println()

@assert isapprox(comp_ctx[StaticSource].signal, dag_ctx[StaticSource].signal; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricA].metric_a, dag_ctx[MetricA].metric_a; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricB].metric_b, dag_ctx[MetricB].metric_b; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricC].metric_c, dag_ctx[MetricC].metric_c; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricD].metric_d, dag_ctx[MetricD].metric_d; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricE].metric_e, dag_ctx[MetricE].metric_e; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricF].metric_f, dag_ctx[MetricF].metric_f; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricG].metric_g, dag_ctx[MetricG].metric_g; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricH].metric_h, dag_ctx[MetricH].metric_h; rtol = 0.0, atol = 1e-12)
@assert isapprox(comp_ctx[MetricReducer].total_metric, dag_ctx[MetricReducer].total_metric; rtol = 0.0, atol = 1e-10)

comp_best = minimum(comp_times)
dag_best = minimum(dag_times)

println("Composite best: ", round(comp_best; digits = 4), " s")
println("Dagger best: ", round(dag_best; digits = 4), " s")
println("Dagger / Composite: ", round(dag_best / comp_best; digits = 3), "x")
println("Final total metric: ", round(comp_ctx[MetricReducer].total_metric; digits = 6))
