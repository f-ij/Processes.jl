using Pkg
Pkg.activate(joinpath(@__DIR__, ".."); io = devnull)
using Processes
using Printf
import Processes: loop, Resuming, NonGenerated, RuntimeGenerated

struct SA <: Processes.ProcessAlgorithm end
struct SB <: Processes.ProcessAlgorithm end
struct SC_ <: Processes.ProcessAlgorithm end
struct SD <: Processes.ProcessAlgorithm end

# All-scalar isbits subcontexts (no arrays) so the carried NamedTuple is a big
# isbits aggregate, like the Metropolis/Ising scalar case.
Processes.init(::SA, ctx) = (; a1 = 0.1, a2 = 0.2, a3 = 0.3, a4 = 0.4)
Processes.init(::SB, ctx) = (; b1 = 0.1, b2 = 0.2, b3 = 0.3, b4 = 0.4)
Processes.init(::SC_, ctx) = (; c1 = 0.1, c2 = 0.2, c3 = 0.3, c4 = 0.4)
Processes.init(::SD, ctx) = (; d1 = 0.1, d2 = 0.2, d3 = 0.3, d4 = 0.4)

function Processes.step!(::SA, ctx)
    a1 = muladd(0.91, ctx.a1, 0.03 * ctx.d4 + 0.001)
    a2 = muladd(0.92, ctx.a2, 0.03 * a1)
    a3 = muladd(0.93, ctx.a3, 0.03 * a2 + 0.01 * ctx.d1)
    a4 = muladd(0.94, ctx.a4, 0.03 * a3)
    return (; a1, a2, a3, a4)
end
function Processes.step!(::SB, ctx)
    b1 = muladd(0.91, ctx.b1, 0.03 * ctx.a4 + 0.001)
    b2 = muladd(0.92, ctx.b2, 0.03 * b1 + 0.01 * ctx.a1)
    b3 = muladd(0.93, ctx.b3, 0.03 * b2)
    b4 = muladd(0.94, ctx.b4, 0.03 * b3 + 0.01 * ctx.a2)
    return (; b1, b2, b3, b4)
end
function Processes.step!(::SC_, ctx)
    c1 = muladd(0.91, ctx.c1, 0.03 * ctx.b4 + 0.001)
    c2 = muladd(0.92, ctx.c2, 0.03 * c1 + 0.01 * ctx.b1)
    c3 = muladd(0.93, ctx.c3, 0.03 * c2)
    c4 = muladd(0.94, ctx.c4, 0.03 * c3 + 0.01 * ctx.b2)
    return (; c1, c2, c3, c4)
end
function Processes.step!(::SD, ctx)
    d1 = muladd(0.91, ctx.d1, 0.03 * ctx.c4 + 0.001)
    d2 = muladd(0.92, ctx.d2, 0.03 * d1 + 0.01 * ctx.c1)
    d3 = muladd(0.93, ctx.d3, 0.03 * d2)
    d4 = muladd(0.94, ctx.d4, 0.03 * d3 + 0.01 * ctx.c2)
    return (; d1, d2, d3, d4)
end

function scalar_only_algorithm()
    return @CompositeAlgorithm begin
        @alias sa = SA()
        @alias sb = SB()
        @alias sc = SC_()
        @alias sd = SD()
        sa(d1 = sd.d1, d4 = sd.d4)
        sb(a1 = sa.a1, a2 = sa.a2, a4 = sa.a4)
        sc(b1 = sb.b1, b2 = sb.b2, b4 = sb.b4)
        sd(c1 = sc.c1, c2 = sc.c2, c4 = sc.c4)
    end
end

const STEPS = 200000
function measure(lt)
    proc = Processes.InlineProcess(scalar_only_algorithm(); repeats = STEPS)
    Processes.reset!(proc)
    algo = Processes.getalgo(proc); ctx = Processes.context(proc); ltf = Processes.lifetime(proc)
    c() = loop(proc, algo, ctx, ltf, (;), Resuming{false}(), lt)
    t0 = time_ns(); c(); comp = (time_ns() - t0) / 1e9
    best = Inf
    for _ in 1:20
        Processes.reset!(proc); t = time_ns(); c(); best = min(best, (time_ns() - t) / 1e9)
    end
    @printf("%-18s compile=%6.3fs  hot=%8.5f s  (%5.2f ns/step)\n",
        string(typeof(lt).name.name), comp, best, best / STEPS * 1e9)
end

println("scalar-only, STEPS=$STEPS")
measure(NonGenerated()); measure(RuntimeGenerated())
measure(NonGenerated()); measure(RuntimeGenerated())
