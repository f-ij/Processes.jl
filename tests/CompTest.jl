using Processes
struct Fib <: ProcessAlgorithm end

function Fib(args)
    (;fiblist) = args
    push!(fiblist, fiblist[end] + fiblist[end-1])
end

function Processes.prepare(::Fib, args)
    fiblist = Int[0, 1]
    processsizehint!(args, fiblist)
    return (;fiblist)
end

struct Luc <: ProcessAlgorithm end

function Luc(args)
    (;luclist) = args
    push!(luclist, luclist[end] + luclist[end-1])
end

function Processes.prepare(::Luc, args)
    luclist = Int[2, 1]
    processsizehint!(args, luclist)
    return (;luclist)
end

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,2) )

pcomp = Process(FibLuc; lifetime = 1000000)
start(pcomp)
benchmark(FibLuc, 1000000)


