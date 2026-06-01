using Pkg
Pkg.activate(joinpath(@__DIR__, ".."); io = devnull)
using Processes, Printf, InteractiveUtils
import Processes: loop, Resuming, NonGenerated, RuntimeGenerated, Generated

# Mimic the Ising/Metropolis subcontext: a few LARGE/heterogeneous fields
# (big inline state like an rng, a heap array like the model) plus small scalars,
# with the step returning only a SUBSET of fields (partial update -> reconstruct).
struct BigInlineState   # mimics MersenneTwister-style large inline state
    buf::NTuple{32,Float64}
end
@inline bump(s::BigInlineState, x) = BigInlineState(ntuple(i -> muladd(0.999, s.buf[i], 0.001 * x), Val(32)))

struct Metro <: Processes.ProcessAlgorithm end

function Processes.init(::Metro, ctx)
    return (;
        model = zeros(Float64, 64),            # heap array (the "lattice")
        state = BigInlineState(ntuple(i -> 0.1 * i, Val(32))),  # big inline (the "rng")
        proposal = 0.0,
        energy = 0.0,
        T = 1.5,
    )
end

function Processes.step!(::Metro, ctx)
    model = ctx.model
    state = bump(ctx.state, ctx.proposal + ctx.T)
    @inbounds model[1] = muladd(0.9, model[1], 0.1 * state.buf[1])
    proposal = muladd(0.91, ctx.proposal, 0.03 * state.buf[2] + 0.001)
    energy = muladd(0.95, ctx.energy, 0.05 * (proposal - model[1]))
    T = muladd(0.999, ctx.T, 0.001 * energy)
    # PARTIAL update: model and state are NOT returned -> merge keeps old ones,
    # reconstructing the 5-field NamedTuple (copying model ptr + 256B state inline).
    return (; proposal, energy, T, state)
end

build() = @CompositeAlgorithm begin
    @alias m = Metro()
    m()
end

function memtab(proc, a, ctx, lt, looptype)
    io = IOBuffer()
    try
        code_llvm(io, loop, (typeof(proc), typeof(a), typeof(ctx), typeof(lt), typeof((;)), Resuming{false}, typeof(looptype)); optimize=true, debuginfo=:none)
    catch e
        return "ERR " * sprint(showerror, e)[1:min(end,70)]
    end
    s = String(take!(io)); t = Dict{Int,Int}()
    for mm in eachmatch(r"memcpy\.[^(]*\(ptr[^,]*,\s*ptr[^,]*,\s*i\d+\s+(\d+)", s); v = parse(Int, mm.captures[1]); t[v] = get(t,v,0)+1; end
    n = sum(values(t); init=0); tot = sum(Int[k*v for (k,v) in t]; init=0)
    join(["$(k)Bx$(t[k])" for k in sort(collect(keys(t)))], " ") * "  [n=$n tot=$(tot)B]"
end

const STEPS = 200000
function measure(algo, looptype)
    proc = Processes.InlineProcess(algo; repeats = STEPS); Processes.reset!(proc)
    a = Processes.getalgo(proc); ctx = Processes.context(proc); lt = Processes.lifetime(proc)
    c() = loop(proc, a, ctx, lt, (;), Resuming{false}(), looptype)
    t0 = time_ns(); c(); comp = (time_ns()-t0)/1e9
    best = Inf
    for _ in 1:20; Processes.reset!(proc); t = time_ns(); c(); best = min(best, (time_ns()-t)/1e9); end
    @printf("%-16s compile=%6.3fs hot=%8.5fs (%5.1f ns/step)  memcpy=%s\n",
        string(typeof(looptype).name.name), comp, best, best/STEPS*1e9, memtab(proc,a,ctx,lt,looptype))
end

algo = build()
println("Metropolis-like: 1 subcontext, big inline state + heap array, partial update")
for lt in (NonGenerated(), Generated(), RuntimeGenerated()); measure(build(), lt); end
