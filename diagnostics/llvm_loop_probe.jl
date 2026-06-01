using Pkg
Pkg.activate(joinpath(@__DIR__, ".."); io = devnull)
using Processes
using InteractiveUtils
import Processes: _step!, getplan, getwiring, get_step, Namespace, Stable, tick!, inc!

include("scaling_probe_defs.jl")

const N = 8

setup(lt) = begin
    a = eval(:(@CompositeAlgorithm $(build_expr(N))))
    proc = Processes.InlineProcess(a; repeats = 100)
    Processes.reset!(proc)
    (proc, Processes.getalgo(proc), Processes.context(proc), Processes.lifetime(proc))
end

# Minimal hot loops: carry context across the backedge, like the real loop.
@inline function hotloop_nongen(plan, ctx, wiring, proc, lt, n::Int)
    @inbounds for _ in 1:n
        ctx = _step!(plan, ctx, wiring, Namespace{nothing}(), proc, lt, Stable())
    end
    return ctx
end

@inline function hotloop_rtgen(step, algo, ctx, proc, lt, n::Int)
    @inbounds for _ in 1:n
        ctx = step(algo, ctx, proc, lt)
    end
    return ctx
end

function memstats(s)
    lines = count(==('\n'), s)
    sizes = Int[]
    for m in eachmatch(r"@llvm\.memcpy\.[^(]*\(ptr[^,]*,\s*ptr[^,]*,\s*i\d+\s+(\d+)", s)
        push!(sizes, parse(Int, m.captures[1]))
    end
    return lines, sizes
end

function report(name, s)
    lines, sizes = memstats(s)
    tab = Dict{Int,Int}()
    for sz in sizes; tab[sz] = get(tab,sz,0)+1; end
    println("=== $name : $lines lines, $(length(sizes)) memcpys, total=$(sum(sizes))B ===")
    for sz in sort(collect(keys(tab))); println("  $(lpad(sz,4))B x$(tab[sz])"); end
end

let (proc, algo, ctx, lt) = setup(Processes.NonGenerated())
    plan = getplan(algo); wiring = getwiring(plan)
    io = IOBuffer()
    code_llvm(io, hotloop_nongen, (typeof(plan), typeof(ctx), typeof(wiring), typeof(proc), typeof(lt), Int); optimize=true, debuginfo=:none)
    report("NonGenerated loop", String(take!(io)))
end

let (proc, algo, ctx, lt) = setup(Processes.RuntimeGenerated())
    step = get_step(algo)
    io = IOBuffer()
    code_llvm(io, hotloop_rtgen, (typeof(step), typeof(algo), typeof(ctx), typeof(proc), typeof(lt), Int); optimize=true, debuginfo=:none)
    report("RuntimeGenerated loop", String(take!(io)))
end
