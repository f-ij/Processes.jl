using Pkg
Pkg.activate(joinpath(@__DIR__, ".."); io = devnull)
using Processes, Printf, InteractiveUtils
import Processes: loop, Resuming, NonGenerated, RuntimeGenerated, Generated
include(joinpath(@__DIR__, "nested_probe_defs.jl"))

const B = parse(Int, get(ENV, "NB", "4"))
const W = parse(Int, get(ENV, "NW", "4"))
const R = parse(Int, get(ENV, "NR", "3"))
const STEPS = 4000

const NESTED = eval(:(@CompositeAlgorithm $(build_nested_expr(B, W, R))))

function memsizes(proc, a, ctx, lt, looptype)
    io = IOBuffer()
    try
        code_llvm(io, loop, (typeof(proc), typeof(a), typeof(ctx), typeof(lt), typeof((;)), Resuming{false}, typeof(looptype)); optimize=true, debuginfo=:none)
    catch e
        return (-1, "ERR " * sprint(showerror, e)[1:min(end,60)])
    end
    s = String(take!(io)); t = Dict{Int,Int}()
    for m in eachmatch(r"memcpy\.[^(]*\(ptr[^,]*,\s*ptr[^,]*,\s*i\d+\s+(\d+)", s); v = parse(Int, m.captures[1]); t[v] = get(t,v,0)+1; end
    lines = count(==('\n'), s)
    return (lines, join(["$(k)Bx$(t[k])" for k in sort(collect(keys(t)))], " "))
end

function measure(looptype)
    proc = Processes.InlineProcess(NESTED; repeats = STEPS); Processes.reset!(proc)
    a = Processes.getalgo(proc); ctx = Processes.context(proc); lt = Processes.lifetime(proc)
    c() = loop(proc, a, ctx, lt, (;), Resuming{false}(), looptype)
    t0 = time_ns(); c(); comp = (time_ns()-t0)/1e9
    best = Inf
    for _ in 1:30; Processes.reset!(proc); t = time_ns(); c(); best = min(best, (time_ns()-t)/1e9); end
    lines, mem = memsizes(proc, a, ctx, lt, looptype)
    @printf("%-16s compile=%6.3fs hot=%8.5fs  llvm_lines=%-5d memcpy=[%s]\n",
        string(typeof(looptype).name.name), comp, best, lines, mem)
end

println("nested B=$B W=$W R=$R  (leaves=$(B*W))  STEPS=$STEPS")
for lt in (NonGenerated(), Generated(), RuntimeGenerated())
    try; measure(lt); catch e; println(string(typeof(lt).name.name), " ERR ", sprint(showerror,e)[1:min(end,80)]); end
end
