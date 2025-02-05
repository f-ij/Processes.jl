using Processes
import Processes as P

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

r = Routine((Fib,Luc), (1000000, 1000000 ÷ 2))
pr = Process(r, lifetime = 1)
start(pr)
benchmark(r, 1)

SFib = SubRoutine(Fib, 1000000)
SLuc = SubRoutine(Luc, 1000000 ÷ 2)
RFibLuc = Routine(SFib, SLuc)

