"""
Measure root-step overhead for the immutable-fix branch.

The benchmark diagnostics report end-to-end timings. This file keeps a smaller
set of warmed timings that separates public `run`, the resolved root-step path,
and the handwritten plain loop for the scalar dependency workload.
"""
module ImmutableFixRootStepBreakdown

using Printf
using Processes
using RuntimeGeneratedFunctions

const ROOT = normpath(joinpath(@__DIR__, "..", ".."))

include(joinpath(ROOT, "diagnostics", "inline_scalar_dependency_probe.jl"))

"""Parse an integer environment variable with a branch-local default."""
function envint(name::AbstractString, default::Int)
    return parse(Int, get(ENV, name, string(default)))
end

"""Return the best elapsed seconds from repeated warmed samples."""
function best_seconds(setup::S, timed::F, trials::Int) where {S<:Function, F<:Function}
    setup()
    timed()
    GC.gc()

    best_ns = typemax(UInt64)
    for _ in 1:trials
        setup()
        start_ns = time_ns()
        timed()
        best_ns = min(best_ns, time_ns() - start_ns)
    end
    return best_ns / 1e9
end

"""Run the scalar dependency workload through the resolved root step."""
Base.@constprop :aggressive function root_step_loop(process::IP) where {IP<:Processes.InlineProcess}
    algo = @inline Processes.getalgo(process)
    lifetime = @inline Processes.lifetime(process)
    plan = @inline Processes.getplan(algo)
    context = @inline Processes._merge_runtime_inputs(Processes.context(process), (;))
    runtime_inputs = @inline Processes.getruntimeinput(context)
    runtime_globals = @inline Processes.getglobals(context)
    subcontexts = @inline Processes.get_subcontexts(context)
    generated_plan_step = @inline Processes.get_step(algo)
    available_names_val = @inline Processes.step_available_names_val(algo)

    for _ in Processes.loopidx(process):Processes.repeats(lifetime)
        active_subcontexts = @inline Processes.select_subcontexts(subcontexts, available_names_val)
        returned = @inline RuntimeGeneratedFunctions.generated_callfunc(generated_plan_step, plan, process, lifetime, runtime_globals, runtime_inputs, active_subcontexts...)
        runtime_globals = @inline getproperty(returned, :globals)
        returned_subcontexts = @inline Processes.deletekeys(returned, :globals)
        subcontexts = @inline Processes.merge_subcontexts_by_name(subcontexts, returned_subcontexts)
        context = @inline Processes.withruntime_if_changed(context, runtime_globals)
        @inline Processes.inc!(process)
        break_context = @inline Processes.withsubcontexts(context, subcontexts)
        Processes.breakcondition(lifetime, process, break_context) && break
    end

    return @inline Processes.withsubcontexts(context, subcontexts)
end

"""Measure warmed public, root-step, and plain-loop timings."""
function main()
    steps = envint("IMMUTABLE_FIX_BREAKDOWN_STEPS", 100_000)
    trials = envint("IMMUTABLE_FIX_BREAKDOWN_TRIALS", 100)
    process = scalar_dependency_process(steps)

    reset!(process)
    run(process)
    reset!(process)
    root_step_loop(process)
    scalar_dependency_plain(steps)

    run_alloc = begin
        reset!(process)
        @allocated run(process)
    end
    root_step_alloc = begin
        reset!(process)
        @allocated root_step_loop(process)
    end
    plain_alloc = @allocated scalar_dependency_plain(steps)

    run_seconds = best_seconds(() -> reset!(process), () -> run(process), trials)
    root_step_seconds = best_seconds(() -> reset!(process), () -> root_step_loop(process), trials)
    plain_seconds = best_seconds(() -> nothing, () -> scalar_dependency_plain(steps), trials)

    println("immutable_fix_breakdown_steps=", steps)
    println("immutable_fix_breakdown_trials=", trials)
    println("run_alloc=", run_alloc)
    println("root_step_alloc=", root_step_alloc)
    println("plain_alloc=", plain_alloc)
    @printf("run_seconds=%.9f\n", run_seconds)
    @printf("root_step_seconds=%.9f\n", root_step_seconds)
    @printf("plain_seconds=%.9f\n", plain_seconds)
    @printf("run_vs_plain_ratio=%.3f\n", run_seconds / plain_seconds)
    @printf("root_step_vs_plain_ratio=%.3f\n", root_step_seconds / plain_seconds)
    @printf("run_vs_root_step_ratio=%.3f\n", run_seconds / root_step_seconds)
    return nothing
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    ImmutableFixRootStepBreakdown.main()
end
