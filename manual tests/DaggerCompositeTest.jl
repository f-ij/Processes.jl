include("_env.jl")
using Random

"""
Manual benchmark that gives Dagger a real chance to help.

Pattern:
    Source
      ├─ BranchA
      ├─ BranchB
      ├─ BranchC
      └─ BranchD
        ↓
      Reducer

The four branch stages are independent once the source has produced its data, so the
Dagger-backed composite can execute them in parallel dependency layers. A normal
CompositeAlgorithm still runs them sequentially.
"""

struct HeavySource <: Processes.ProcessAlgorithm end
struct BranchA <: Processes.ProcessAlgorithm end
struct BranchB <: Processes.ProcessAlgorithm end
struct BranchC <: Processes.ProcessAlgorithm end
struct BranchD <: Processes.ProcessAlgorithm end
struct BranchReducer <: Processes.ProcessAlgorithm end

function Processes.init(::HeavySource, context)
    return (; signal = copy(context.start_signal), phase = 0.01)
end

function Processes.step!(::HeavySource, context)
    signal = context.signal
    phase = context.phase

    @inbounds for i in eachindex(signal)
        x = signal[i]
        signal[i] = sin(x + phase) + cos(0.5 * x - phase) + 0.0000005 * i
    end

    return (; phase = phase + 0.01)
end

function Processes.init(::BranchA, context)
    return (; output_a = zeros(context.n))
end

function Processes.step!(::BranchA, context)
    input_signal = context.input_signal
    output_a = context.output_a

    @inbounds for i in eachindex(output_a)
        x = input_signal[i]
        output_a[i] = sin(x) + sqrt(abs(x) + 1)
    end

    return (;)
end

function Processes.init(::BranchB, context)
    return (; output_b = zeros(context.n))
end

function Processes.step!(::BranchB, context)
    input_signal = context.input_signal
    output_b = context.output_b
    n = length(input_signal)

    @inbounds for i in eachindex(output_b)
        x = input_signal[i]
        y = input_signal[mod1(i + 23, n)]
        output_b[i] = cos(x - y) + abs(x * y)
    end

    return (;)
end

function Processes.init(::BranchC, context)
    return (; output_c = zeros(context.n))
end

function Processes.step!(::BranchC, context)
    input_signal = context.input_signal
    output_c = context.output_c
    n = length(input_signal)

    @inbounds for i in eachindex(output_c)
        left = input_signal[mod1(i - 1, n)]
        mid = input_signal[i]
        right = input_signal[mod1(i + 1, n)]
        output_c[i] = (left + 2mid + right) * 0.25
    end

    return (;)
end

function Processes.init(::BranchD, context)
    return (; output_d = zeros(context.n))
end

function Processes.step!(::BranchD, context)
    input_signal = context.input_signal
    output_d = context.output_d

    @inbounds for i in eachindex(output_d)
        x = input_signal[i]
        output_d[i] = exp(-abs(x)) + x * x * 0.001
    end

    return (;)
end

function Processes.init(::BranchReducer, _context)
    return (; energy_log = Float64[], checksum = 0.0)
end

function Processes.step!(::BranchReducer, context)
    a = context.a
    b = context.b
    c = context.c
    d = context.d

    energy = 0.0
    checksum = 0.0

    @inbounds for i in eachindex(a)
        v = a[i] + b[i] + c[i] + d[i]
        energy += v * v
        checksum += v
    end

    push!(context.energy_log, energy)
    return (; checksum)
end

function build_algorithms()
    routes = (
        Route(HeavySource => BranchA, :signal => :input_signal),
        Route(HeavySource => BranchB, :signal => :input_signal),
        Route(HeavySource => BranchC, :signal => :input_signal),
        Route(HeavySource => BranchD, :signal => :input_signal),
        Route(BranchA => BranchReducer, :output_a => :a),
        Route(BranchB => BranchReducer, :output_b => :b),
        Route(BranchC => BranchReducer, :output_c => :c),
        Route(BranchD => BranchReducer, :output_d => :d),
    )

    comp = CompositeAlgorithm(
        HeavySource, BranchA, BranchB, BranchC, BranchD, BranchReducer,
        (1, 1, 1, 1, 1, 1),
        routes...,
    )

    dag = DaggerCompositeAlgorithm(
        HeavySource, BranchA, BranchB, BranchC, BranchD, BranchReducer,
        (1, 1, 1, 1, 1, 1),
        routes...,
    )

    return comp, dag
end

function run_once(algo, start_signal; repeats)
    n = length(start_signal)
    p = Process(
        algo,
        Input(HeavySource, :start_signal => copy(start_signal)),
        Input(BranchA; n),
        Input(BranchB; n),
        Input(BranchC; n),
        Input(BranchD; n);
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

n = 400_000
repeats = 8
trials = 3
start_signal = randn(n)

comp, dag = build_algorithms()

println("Signal length: ", n)
println("Repeats: ", repeats)
println("Trials: ", trials)
println("Pattern: source -> 4 parallel branches -> reducer")
println()

comp_times, comp_ctx = benchmark(comp, start_signal; repeats, trials, label = "Composite")
println()
dag_times, dag_ctx = benchmark(dag, start_signal; repeats, trials, label = "Dagger")
println()

@assert isapprox(comp_ctx[HeavySource].signal, dag_ctx[HeavySource].signal; rtol = 0.0, atol = 1e-10)
@assert isapprox(comp_ctx[BranchA].output_a, dag_ctx[BranchA].output_a; rtol = 0.0, atol = 1e-10)
@assert isapprox(comp_ctx[BranchB].output_b, dag_ctx[BranchB].output_b; rtol = 0.0, atol = 1e-10)
@assert isapprox(comp_ctx[BranchC].output_c, dag_ctx[BranchC].output_c; rtol = 0.0, atol = 1e-10)
@assert isapprox(comp_ctx[BranchD].output_d, dag_ctx[BranchD].output_d; rtol = 0.0, atol = 1e-10)
@assert isapprox(comp_ctx[BranchReducer].energy_log, dag_ctx[BranchReducer].energy_log; rtol = 0.0, atol = 1e-10)
@assert isapprox(comp_ctx[BranchReducer].checksum, dag_ctx[BranchReducer].checksum; rtol = 0.0, atol = 1e-10)

comp_best = minimum(comp_times)
dag_best = minimum(dag_times)

println("Composite best: ", round(comp_best; digits = 4), " s")
println("Dagger best: ", round(dag_best; digits = 4), " s")
println("Dagger / Composite: ", round(dag_best / comp_best; digits = 3), "x")
println("Final checksum: ", round(comp_ctx[BranchReducer].checksum; digits = 6))
