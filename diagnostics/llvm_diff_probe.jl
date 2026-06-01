using Pkg
Pkg.activate(joinpath(@__DIR__, ".."); io = devnull)
using Processes
using InteractiveUtils
import Processes: loop, Resuming, NonGenerated, RuntimeGenerated, _step!, getplan, getwiring, get_step, Namespace, Stable

include("scaling_probe_defs.jl")  # shares the Scaling types

const N = 8
algo_for(lt) = begin
    a = eval(:(@CompositeAlgorithm $(build_expr(N))))
    proc = Processes.InlineProcess(a; repeats = 100)
    Processes.reset!(proc)
    (proc, Processes.getalgo(proc), Processes.context(proc), Processes.lifetime(proc))
end

function memstats(s::String)
    lines = count(==('\n'), s)
    sizes = Int[]
    for m in eachmatch(r"@llvm\.memcpy\.[^(]*\(ptr[^,]*,\s*ptr[^,]*,\s*i\d+\s+(\d+)", s)
        push!(sizes, parse(Int, m.captures[1]))
    end
    return lines, sizes
end

function dump_nongen()
    proc, algo, ctx, lt = algo_for(NonGenerated())
    plan = getplan(algo); wiring = getwiring(plan)
    io = IOBuffer()
    code_llvm(io, _step!, (typeof(plan), typeof(ctx), typeof(wiring), Namespace{nothing}, typeof(proc), typeof(lt), Stable); optimize=true, debuginfo=:none)
    return String(take!(io))
end

function dump_rtgen()
    proc, algo, ctx, lt = algo_for(RuntimeGenerated())
    step = get_step(algo)
    io = IOBuffer()
    code_llvm(io, step, (typeof(algo), typeof(ctx), typeof(proc), typeof(lt)); optimize=true, debuginfo=:none)
    return String(take!(io))
end

for (name, dump) in (("NonGenerated", dump_nongen), ("RuntimeGenerated", dump_rtgen))
    s = dump()
    lines, sizes = memstats(s)
    tab = Dict{Int,Int}()
    for sz in sizes; tab[sz] = get(tab,sz,0)+1; end
    println("=== $name : $lines lines, $(length(sizes)) memcpys, total bytes copied=$(sum(sizes)) ===")
    for sz in sort(collect(keys(tab)))
        println("  $(lpad(sz,4))B  x$(tab[sz])")
    end
end
