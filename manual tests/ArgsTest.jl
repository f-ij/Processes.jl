using Processes
struct Algo <: ProcessAlgorithm end

function Processes.init(::Algo, args)
    (;a,b,c) = args
    return (;a = a^2,b = b^3,c = c^4)
end

function Algo(args)
    (;a,b,c) = args
    return a + b + c
end

p = Process(Algo, a = 1, b = 2, c = 3)
start(p)