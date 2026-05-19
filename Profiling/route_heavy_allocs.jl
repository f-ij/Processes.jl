include(joinpath(@__DIR__, "route_heavy_benchmark.jl"))

const ALLOC_STEPS = parse(Int, get(ENV, "ROUTE_HEAVY_ALLOC_STEPS", "2000"))
const ALLOC_RUNS = parse(Int, get(ENV, "ROUTE_HEAVY_ALLOC_RUNS", "1000"))
const ALLOC_SINK = Ref{Any}(nothing)

function route_heavy_prepared()
    return init(resolve(route_heavy_algorithm()))
end

function route_heavy_runtime_context(algo::A, lifetime::LT) where {A<:Processes.AbstractLoopAlgorithm, LT}
    process = Processes.LoopRunProcess(lifetime)
    stored_context = Processes.getstoredcontext(algo)
    runtime_context = Processes._merge_into_globals(stored_context, (; process, lifetime))
    return process, stored_context, runtime_context
end

function route_heavy_after_bootstrap(algo::A, lifetime::LT) where {A<:Processes.AbstractLoopAlgorithm, LT}
    process, stored_context, runtime_context = route_heavy_runtime_context(algo, lifetime)
    step_wiring = Processes.getwiring(algo)
    runtime_context = Processes._step!(algo, runtime_context, step_wiring, process, lifetime, Processes.Unstable())
    Processes.tick!(process)
    Processes.inc!(process)
    return process, stored_context, step_wiring, runtime_context
end

function route_heavy_stable_steps!(algo::A, context::C, step_wiring::SW, n::Int) where {A<:Processes.AbstractLoopAlgorithm, C<:Processes.AbstractContext, SW<:Processes.PlanWiring}
    runtime_context = context
    lifetime = Repeat(n)
    process = Processes.LoopRunProcess(lifetime)
    for _ in 1:n
        runtime_context = Processes._step!(algo, runtime_context, step_wiring, process, lifetime, Processes.Stable())
    end
    return runtime_context
end

"""Measure allocations for a repeated benchmark block written with Julia `do` syntax."""
function allocation_per_call(f, label::AbstractString, runs::Int)
    GC.gc()
    bytes = @allocated begin
        local result
        for _ in 1:runs
            result = f()
        end
        ALLOC_SINK[] = result
    end
    println(label, "_bytes_total=", bytes)
    println(label, "_bytes_per_call=", bytes / runs)
end

function main()
    algo = route_heavy_prepared()
    lifetime = Repeat(ALLOC_STEPS)
    step_wiring = Processes.getwiring(algo)
    stored_context = Processes.getstoredcontext(algo)

    # Warm all measured paths before recording allocations.
    warm_result = run(algo; repeats = ALLOC_STEPS)
    process, stored, runtime_context = route_heavy_runtime_context(algo, lifetime)
    process2, stored2, wiring2, boot_context = route_heavy_after_bootstrap(algo, lifetime)
    stable_context = route_heavy_stable_steps!(algo, boot_context, wiring2, 16)
    stripped = Processes._strip_runtime_inputs(stable_context, stored2)
    ALLOC_SINK[] = Processes._with_lifecycle(algo, stripped, Processes.getstoredinits(algo), Processes.getstoredoverrides(algo))

    println("route_heavy_alloc_steps=", ALLOC_STEPS)
    println("route_heavy_alloc_runs=", ALLOC_RUNS)
    println("step_wiring_type=", typeof(step_wiring))
    println("stored_context_type=", typeof(stored_context))
    println("runtime_context_type=", typeof(runtime_context))

    allocation_per_call("looprunprocess", ALLOC_RUNS) do
        Processes.LoopRunProcess(lifetime)
    end

    allocation_per_call("merge_runtime", ALLOC_RUNS) do
        p = Processes.LoopRunProcess(lifetime)
        Processes._merge_into_globals(stored_context, (; process = p, lifetime))
    end

    allocation_per_call("bootstrap_step", ALLOC_RUNS) do
        p, _, runtime = route_heavy_runtime_context(algo, lifetime)
        Processes._step!(algo, runtime, step_wiring, p, lifetime, Processes.Unstable())
    end

    allocation_per_call("stable_step", ALLOC_RUNS) do
        p = Processes.LoopRunProcess(lifetime)
        Processes._step!(algo, boot_context, step_wiring, p, lifetime, Processes.Stable())
    end

    allocation_per_call("stable_100_steps", ALLOC_RUNS) do
        route_heavy_stable_steps!(algo, boot_context, step_wiring, 100)
    end

    allocation_per_call("strip_runtime", ALLOC_RUNS) do
        Processes._strip_runtime_inputs(stable_context, stored)
    end

    allocation_per_call("with_lifecycle", ALLOC_RUNS) do
        Processes._with_lifecycle(algo, stripped, Processes.getstoredinits(algo), Processes.getstoredoverrides(algo))
    end

    allocation_per_call("base_run", ALLOC_RUNS) do
        run(algo; repeats = ALLOC_STEPS)
    end
end

main()
