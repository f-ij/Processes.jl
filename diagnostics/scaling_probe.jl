using Pkg
Pkg.activate(joinpath(@__DIR__, ".."); io = devnull)
using Processes
using Printf
import Processes: loop, Resuming, NonGenerated, RuntimeGenerated

const MAXN = 24

# Define all algorithm types + init/step at top level (avoids world-age issues).
for i in 1:MAXN
    T = Symbol("Scaling$i")
    @eval begin
        struct $T <: Processes.ProcessAlgorithm end
        Processes.init(::$T, ctx) = (;
            $(Symbol("v$(i)_1")) = 0.1, $(Symbol("v$(i)_2")) = 0.2,
            $(Symbol("v$(i)_3")) = 0.3, $(Symbol("v$(i)_4")) = 0.4)
        function Processes.step!(::$T, ctx)
            $(Symbol("v$(i)_1")) = muladd(0.91, ctx.$(Symbol("v$(i)_1")), 0.001)
            $(Symbol("v$(i)_2")) = muladd(0.92, ctx.$(Symbol("v$(i)_2")), 0.03 * $(Symbol("v$(i)_1")))
            $(Symbol("v$(i)_3")) = muladd(0.93, ctx.$(Symbol("v$(i)_3")), 0.03 * $(Symbol("v$(i)_2")))
            $(Symbol("v$(i)_4")) = muladd(0.94, ctx.$(Symbol("v$(i)_4")), 0.03 * $(Symbol("v$(i)_3")))
            return (; $(Symbol("v$(i)_1")), $(Symbol("v$(i)_2")), $(Symbol("v$(i)_3")), $(Symbol("v$(i)_4")))
        end
    end
end

function build_expr(N::Int)
    aliases = [:(@alias $(Symbol("s$i")) = $(Symbol("Scaling$i"))()) for i in 1:N]
    calls = Any[]
    for i in 1:N
        if i == 1
            push!(calls, :($(Symbol("s$i"))()))
        else
            prev = Symbol("s$(i-1)")
            push!(calls, :($(Symbol("s$i"))($(Symbol("v$(i-1)_4")) = $prev.$(Symbol("v$(i-1)_4")))))
        end
    end
    return Expr(:block, aliases..., calls...)
end

# Pre-build all composites at top level.
const ALGOS = Dict{Int,Any}()
for N in (2, 4, 8, 16, 24)
    ALGOS[N] = eval(:(@CompositeAlgorithm $(build_expr(N))))
end

const STEPS = 5000
function measure(algo, lt)
    proc = Processes.InlineProcess(algo; repeats = STEPS)
    Processes.reset!(proc)
    a = Processes.getalgo(proc); ctx = Processes.context(proc); ltf = Processes.lifetime(proc)
    c() = loop(proc, a, ctx, ltf, (;), Resuming{false}(), lt)
    t0 = time_ns(); c(); comp = (time_ns() - t0) / 1e9
    best = Inf
    for _ in 1:10
        Processes.reset!(proc); t = time_ns(); c(); best = min(best, (time_ns() - t) / 1e9)
    end
    return comp, best
end

@printf("%4s | %-13s %-13s | %-13s %-13s\n", "N", "NonGen comp", "NonGen hot", "RTGen comp", "RTGen hot")
for N in (2, 4, 8, 16, 24)
    cn, hn = measure(ALGOS[N], NonGenerated())
    cr, hr = measure(ALGOS[N], RuntimeGenerated())
    @printf("%4d | %11.3fs %10.6fs | %11.3fs %10.6fs\n", N, cn, hn, cr, hr)
end
