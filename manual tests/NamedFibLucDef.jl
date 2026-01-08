using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using Processes

@NamedProcessAlgorithm FibLuc function Fib(fiblist)
    push!(fiblist, fiblist[end] + fiblist[end-1])
    return (;)
end

function Processes.prepare(::Fib, args)
    fiblist = Int[0, 1]
    processsizehint!(args, fiblist)
    return (;fiblist)
end

@NamedProcessAlgorithm FibLuc function Luc(luclist)
    push!(luclist, luclist[end] + luclist[end-1])
    return (;)
end

function Processes.prepare(::Luc, args)
    luclist = Int[2, 1]
    processsizehint!(args, luclist)
    return (;luclist)
end

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,1) )
p = Process(FibLuc; lifetime = 1000000)