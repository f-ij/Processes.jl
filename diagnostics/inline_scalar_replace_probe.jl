using Printf
using Test
using Processes

const SCALAR_REPLACE_STEPS = parse(Int, get(ENV, "SCALAR_REPLACE_STEPS", "100000"))
const SCALAR_REPLACE_TRIALS = parse(Int, get(ENV, "SCALAR_REPLACE_TRIALS", "100"))
const SCALAR_REPLACE_SINK = Ref{Any}(nothing)

struct ProbeScalarFib <: Processes.ProcessAlgorithm end
struct ProbeScalarLuc <: Processes.ProcessAlgorithm end

"""Initialize the tiny scalar Fibonacci state used by the replace probe."""
function Processes.init(::ProbeScalarFib, context::C) where {C}
    return (; prev = Int64(0), curr = Int64(1))
end

"""Initialize the tiny scalar Lucas state used by the replace probe."""
function Processes.init(::ProbeScalarLuc, context::C) where {C}
    return (; prev = Int64(2), curr = Int64(1))
end

"""Replace both scalar Fibonacci fields with the next pair."""
function Processes.step!(::ProbeScalarFib, context::C) where {C}
    return (; prev = context.curr, curr = context.prev + context.curr)
end

"""Replace both scalar Lucas fields with the next pair."""
function Processes.step!(::ProbeScalarLuc, context::C) where {C}
    return (; prev = context.curr, curr = context.prev + context.curr)
end

"""Build the tiny scalar replace algorithm with stable subcontext names."""
function scalar_replace_algorithm()
    return Processes.CompositeAlgorithm(ProbeScalarFib, ProbeScalarLuc, (1, 1))
end

"""Create an inline process for the tiny scalar replace workload."""
function scalar_replace_process(steps::I) where {I<:Integer}
    return Processes.InlineProcess(scalar_replace_algorithm(); repeats = steps)
end

"""Run the same tiny scalar semantics as ordinary local variables."""
function scalar_replace_plain(steps::I) where {I<:Integer}
    fib_prev = Int64(0)
    fib_curr = Int64(1)
    luc_prev = Int64(2)
    luc_curr = Int64(1)

    for _ in 1:steps
        fib_prev, fib_curr = fib_curr, fib_prev + fib_curr
        luc_prev, luc_curr = luc_curr, luc_prev + luc_curr
    end

    return (; fib_prev, fib_curr, luc_prev, luc_curr)
end

"""Run the scalar replace workload through the direct plan entrypoint."""
function scalar_replace_direct_plan_loop(process::IP) where {IP<:Processes.InlineProcess}
    isdefined(Processes, :Namespace) || error("direct plan entrypoint requires Processes.Namespace")
    algo = Processes.getalgo(process)
    lifetime = Processes.lifetime(process)
    plan = Processes.getplan(algo)
    wiring = Processes.getwiring(plan)
    context = Processes.context(process)

    context = Processes._step!(
        plan,
        context,
        wiring,
        Processes.Namespace{nothing}(),
        process,
        lifetime,
        Processes.Unstable(),
    )
    Processes.inc!(process)

    for _ in Processes.loopidx(process):Processes.repeats(lifetime)
        context = Processes._step!(
            plan,
            context,
            wiring,
            Processes.Namespace{nothing}(),
            process,
            lifetime,
            Processes.Stable(),
        )
        Processes.inc!(process)
        Processes.breakcondition(lifetime, process, context) && break
    end

    return context
end

"""Extract comparable values from the scalar replace process result."""
function scalar_replace_summary(context::C) where {C<:Processes.ProcessContext}
    subcontexts = Processes.get_subcontexts(context)
    subcontext_names = filter(!=(:globals), fieldnames(typeof(subcontexts)))
    fib = getproperty(subcontexts, subcontext_names[1])
    luc = getproperty(subcontexts, subcontext_names[2])
    return (; fib_prev = fib.prev, fib_curr = fib.curr, luc_prev = luc.prev, luc_curr = luc.curr)
end

"""Return the minimum elapsed seconds across repeated setup/timed samples."""
function scalar_replace_best_seconds(setup::S, timed::F, trials::I) where {S<:Function,F<:Function,I<:Integer}
    setup()
    SCALAR_REPLACE_SINK[] = timed()
    GC.gc()

    best_ns = typemax(UInt64)
    for _ in 1:trials
        setup()
        start_ns = time_ns()
        SCALAR_REPLACE_SINK[] = timed()
        elapsed_ns = time_ns() - start_ns
        best_ns = min(best_ns, elapsed_ns)
    end
    return best_ns / 1e9
end

"""Run the scalar replace allocation and timing probe."""
function run_scalar_replace_probe(;
    steps::I = SCALAR_REPLACE_STEPS,
    trials::J = SCALAR_REPLACE_TRIALS,
) where {I<:Integer,J<:Integer}
    process = scalar_replace_process(steps)
    reset!(process)

    context = Processes.context(process)
    subcontext_names = filter(!=(:globals), fieldnames(typeof(Processes.get_subcontexts(context))))
    merge_target = subcontext_names[1]
    has_direct_plan_api = isdefined(Processes, :Namespace) &&
        isdefined(Processes, :getplan) &&
        isdefined(Processes, :getwiring) &&
        isdefined(Processes, :_step!)

    if has_direct_plan_api
        algo = Processes.getalgo(process)
        lifetime = Processes.lifetime(process)
        plan = Processes.getplan(algo)
        wiring = Processes.getwiring(plan)
        namespace = Processes.Namespace{nothing}()
    end

    reset!(process)
    run_summary = scalar_replace_summary(run(process))
    plain_summary = scalar_replace_plain(steps)
    @test run_summary == plain_summary

    # Warm the exact allocation probes before recording their steady-state value.
    reset!(process)
    Processes.merge_into_subcontexts(context, (; merge_target => (; prev = Int64(1), curr = Int64(1))))
    has_direct_plan_api && Processes._step!(plan, context, wiring, namespace, process, lifetime, Processes.Stable())
    reset!(process)
    run(process)
    if has_direct_plan_api
        reset!(process)
        scalar_replace_direct_plan_loop(process)
    end

    reset_alloc = @allocated reset!(process)
    reset!(process)
    merge_alloc = @allocated Processes.merge_into_subcontexts(context, (; merge_target => (; prev = Int64(1), curr = Int64(1))))
    stable_step_alloc = if has_direct_plan_api
        @allocated Processes._step!(plan, context, wiring, namespace, process, lifetime, Processes.Stable())
    else
        missing
    end
    reset!(process)
    run_alloc = @allocated run(process)
    direct_plan_alloc = if has_direct_plan_api
        reset!(process)
        @allocated scalar_replace_direct_plan_loop(process)
    else
        missing
    end

    run_seconds = scalar_replace_best_seconds(() -> reset!(process), () -> run(process), trials)
    direct_plan_seconds = if has_direct_plan_api
        scalar_replace_best_seconds(() -> reset!(process), () -> scalar_replace_direct_plan_loop(process), trials)
    else
        missing
    end
    plain_seconds = scalar_replace_best_seconds(() -> nothing, () -> scalar_replace_plain(steps), trials)

    println("scalar_replace_steps=", steps)
    println("scalar_replace_trials=", trials)
    println("reset_alloc=", reset_alloc)
    println("merge_alloc=", merge_alloc)
    println("stable_step_alloc=", stable_step_alloc)
    println("run_alloc=", run_alloc)
    println("direct_plan_alloc=", direct_plan_alloc)
    @printf("run_seconds=%.9f\n", run_seconds)
    if ismissing(direct_plan_seconds)
        println("direct_plan_seconds=missing")
    else
        @printf("direct_plan_seconds=%.9f\n", direct_plan_seconds)
    end
    @printf("plain_seconds=%.9f\n", plain_seconds)
    @printf("run_ratio=%.3f\n", run_seconds / plain_seconds)
    if ismissing(direct_plan_seconds)
        println("direct_plan_ratio=missing")
    else
        @printf("direct_plan_ratio=%.3f\n", direct_plan_seconds / plain_seconds)
    end

    return (;
        reset_alloc,
        merge_alloc,
        stable_step_alloc,
        run_alloc,
        direct_plan_alloc,
        run_seconds,
        direct_plan_seconds,
        plain_seconds,
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    run_scalar_replace_probe()
end
