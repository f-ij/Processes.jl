using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using Processes
using Printf
import Processes: loop, Resuming, NonGenerated, RuntimeGenerated, Generated

include(joinpath(@__DIR__, "inline_scalar_dependency_probe.jl"))

const STEPS = 500

# A nested workload closer to the real shape: repeated inner dependency stepping.
function nested_dependency_algorithm()
    return @CompositeAlgorithm begin
        @state top_signal = 0.02
        @state top_metric = 0.0
        @state top_buffer = zeros(Float64, 3)

        @alias source = DependencySource()
        @alias mid = DependencyMid()
        @alias sink = DependencySink()
        @alias topstate = DependencyTopState()
        @alias feedbacker = DependencyFeedback()

        inner = @repeat 4 begin
            source(top_signal = top_signal, top_metric = top_metric)
            mid(@all(source...))
            sink(@all(source...), y = mid.y, mid_buffer = mid.mid_buffer)
            top_signal, top_metric, top_buffer = topstate(
                @all(source...),
                y = mid.y,
                z = sink.z,
                sink_buffer = sink.sink_buffer,
                top_signal = top_signal,
                top_metric = top_metric,
                top_buffer = top_buffer,
            )
            feedbacker(
                @all(source...),
                y = mid.y,
                mid_buffer = mid.mid_buffer,
                z = sink.z,
                sink_buffer = sink.sink_buffer,
                top_signal = top_signal,
                top_metric = top_metric,
                top_buffer = top_buffer,
            )
        end
    end
end

function measure(buildfn, looptype; label = "")
    name = string(typeof(looptype).name.name)
    algo0 = buildfn()
    proc = Processes.InlineProcess(algo0; repeats = STEPS)
    Processes.reset!(proc)
    algo = Processes.getalgo(proc)
    ctx = Processes.context(proc)
    lt = Processes.lifetime(proc)

    callloop() = loop(proc, algo, ctx, lt, (;), Resuming{false}(), looptype)

    t0 = time_ns()
    callloop()
    compile_s = (time_ns() - t0) / 1e9

    best = Inf
    for _ in 1:30
        Processes.reset!(proc)
        t = time_ns()
        callloop()
        best = min(best, (time_ns() - t) / 1e9)
    end

    @printf("%-10s %-18s  first(compile)=%8.3f s   hot=%9.6f s\n", label, name, compile_s, best)
    return nothing
end

println("STEPS=$STEPS")
println("--- flat 5-algo ---")
for lt in (NonGenerated(), RuntimeGenerated())
    measure(scalar_dependency_algorithm, lt; label = "flat")
end
println("--- nested @repeat 4 ---")
for lt in (NonGenerated(), RuntimeGenerated())
    measure(nested_dependency_algorithm, lt; label = "nested")
end
