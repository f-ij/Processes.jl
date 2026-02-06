using Test
using Processes

@testset "Share: shared variables propagate across subcontexts" begin
    # This mirrors `manual tests/ShareTest.jl` and verifies that `Share(...)` makes
    # variables from one subcontext available (and writable) to the other.

    @ProcessAlgorithm function Oscillator(state, velocity, dt, trajectory)
        new_vel = velocity - state * dt
        new_state = state + new_vel * dt
        push!(trajectory, new_state)
        return (; state = new_state, velocity = new_vel)
    end

    function Processes.prepare(::Oscillator, context)
        (; dt) = context
        trajectory = Float64[1.0]
        processsizehint!(trajectory, context)
        return (; state = 1.0, velocity = 0.0, dt, trajectory)
    end

    @ProcessAlgorithm function DampedFollower(state, velocity, damp, trajectory)
        velocity = velocity * (1.0 - damp)
        push!(trajectory, state)
        return (; velocity)
    end

    function Processes.prepare(::DampedFollower, _context)
        return (; damp = 0.05)
    end

    shared_algo = CompositeAlgorithm(
        (Oscillator, DampedFollower),
        (1, 1),
        Share(Oscillator, DampedFollower),
    )

    p = Process(shared_algo, lifetime = 20, Input(Oscillator, :dt => 0.1))
    start(p; threaded = false)
    wait(p)

    actual_traj = p.context[Oscillator].trajectory
    @test length(actual_traj) == 41  # 1 initial + 2 pushes per step for 20 steps

    # Build expected trajectory assuming:
    # - DampedFollower sees Oscillator's `state` and `trajectory`
    # - DampedFollower's returned `velocity` updates the shared velocity used by Oscillator next step
    state = 1.0
    velocity = 0.0
    dt = 0.1
    damp = 0.05
    expected_traj = Float64[1.0]
    for _ in 1:20
        new_vel = velocity - state * dt
        new_state = state + new_vel * dt
        push!(expected_traj, new_state) # Oscillator push
        state = new_state
        velocity = new_vel

        velocity = velocity * (1.0 - damp)
        push!(expected_traj, state) # DampedFollower push (shared trajectory)
    end

    @test isapprox(actual_traj, expected_traj; rtol = 0.0, atol = 1e-12)
end



