"""
Sample the hot runtime paths for the immutable-fix branch.

This diagnostic profiles already-warmed execution. It is meant to answer where
runtime parity is lost after compile time and allocation have been taken out of
the immediate question.
"""
module ImmutableFixRuntimeProfile

using Profile

const ROOT = normpath(joinpath(@__DIR__, "..", ".."))

include(joinpath(ROOT, "diagnostics", "inline_scalar_dependency_probe.jl"))

"""Parse an integer environment variable with a branch-local default."""
function envint(name::AbstractString, default::Int)
    return parse(Int, get(ENV, name, string(default)))
end

"""Parse a floating point environment variable with a branch-local default."""
function envfloat(name::AbstractString, default::Float64)
    return parse(Float64, get(ENV, name, string(default)))
end

"""Profile warmed generated-process execution for the scalar dependency workload."""
function profile_generated_run(; steps::Int, repetitions::Int, delay::Float64)
    process = scalar_dependency_process(steps)
    reset!(process)
    run(process)

    Profile.init(; n = 10^7, delay)
    Profile.clear()
    @profile for _ in 1:repetitions
        reset!(process)
        run(process)
    end

    println("\n[immutable_fix] generated run profile")
    Profile.print(; format = :flat, sortedby = :count, maxdepth = 30)
    return nothing
end

"""Profile warmed plain-loop execution for the scalar dependency workload."""
function profile_plain_loop(; steps::Int, repetitions::Int, delay::Float64)
    scalar_dependency_plain(steps)

    Profile.init(; n = 10^7, delay)
    Profile.clear()
    @profile for _ in 1:repetitions
        scalar_dependency_plain(steps)
    end

    println("\n[immutable_fix] plain loop profile")
    Profile.print(; format = :flat, sortedby = :count, maxdepth = 30)
    return nothing
end

"""Run both profile samples with environment-controlled sizes."""
function main()
    steps = envint("IMMUTABLE_FIX_PROFILE_STEPS", 100_000)
    generated_repetitions = envint("IMMUTABLE_FIX_PROFILE_GENERATED_REPS", 100)
    plain_repetitions = envint("IMMUTABLE_FIX_PROFILE_PLAIN_REPS", 500)
    delay = envfloat("IMMUTABLE_FIX_PROFILE_DELAY", 0.0001)

    println("immutable_fix_profile_steps=", steps)
    println("immutable_fix_profile_generated_reps=", generated_repetitions)
    println("immutable_fix_profile_plain_reps=", plain_repetitions)
    println("immutable_fix_profile_delay=", delay)

    profile_generated_run(; steps, repetitions = generated_repetitions, delay)
    profile_plain_loop(; steps, repetitions = plain_repetitions, delay)
    return nothing
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    ImmutableFixRuntimeProfile.main()
end
