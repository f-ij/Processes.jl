using Processes

struct Fib <: ProcessAlgorithm end

function Fib(args)
    (;fiblist) = args
    push!(fiblist, fiblist[end] + fiblist[end-1])
end

function Processes.init(::Fib, args)
    arena = newallocator(args)
    fiblist = AVecAlloc(Int, arena, 2+recommendsize(args))
    append!(fiblist, [0, 1])
    # return (;fiblist, arena)
    return (;fiblist)
end

struct Luc <: ProcessAlgorithm end

function Luc(args)
    (;luclist) = args
    push!(luclist, luclist[end] + luclist[end-1])
end

function Processes.init(::Luc, args)
    arena = newallocator(args)
    luclist = AVecAlloc(Int, arena, 2+recommendsize(args))
    append!(luclist, [2, 1])
    return (;luclist)
end

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,2))

benchmark(FibLuc, 1000000)
# p = Process(FibLuc; lifetime = 1000000)
# start(p)

