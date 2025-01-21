using Processes

struct FibPA <: ProcessAlgorithm end

function (::FibPA)(args)
    (;fiblist) = args
    push!(fiblist, fiblist[end] + fiblist[end-1])
end

function Processes.prepare(::FibPA, args)
    (;runtime) = args
    rpts = Processes.repeats(runtime)
    args = (;fiblist = [0, 1])
    sizehint!(args.fiblist, rpts)
    return args
end

struct LucPA <: ProcessAlgorithm end

function (::LucPA)(args)
    (;luclist) = args
    push!(luclist, luclist[end] + luclist[end-1])
end

function Processes.prepare(::LucPA, args)
    (;runtime) = args
    rpts = Processes.repeats(runtime)
    args = (;luclist = [2, 1])
    sizehint!(args.luclist, rpts)
    return args
end


struct FibFunc end

function FibFunc(args)
    (;fiblist) = args
    push!(fiblist, fiblist[end] + fiblist[end-1])
end

Processes.prepare(::Type{FibFunc}, args) = (;fiblist = [0, 1])

struct LucFunc end

function LucFunc(args)
    (;luclist) = args
    push!(luclist, luclist[end] + luclist[end-1])
end

Processes.prepare(::Type{LucFunc}, args) = (;luclist = [2, 1])

FibLucPA = CompositeAlgorithmPA( (FibPA, LucPA), (1,2) ) 
FibLucFunc = CompositeAlgorithmType( (FibFunc, LucFunc), (1,2) )
FibLucInt = Processes.CompositeAlgorithmTypeInt( (FibFunc, LucFunc), (1,2) )

benchmark(FibLucPA, 1000000)
benchmark(FibLucFunc, 1000000)
benchmark(FibLucFunc, 1000000, loopfunction = typeloop)
benchmark(FibLucInt, 1000000, loopfunction = Processes.processloop_int)
# benchmark(FibLucFunc, 1000000, loopfunction = Processes.maploop, progress = true)

# benchmark(FibLucFunc, 10, loopfunction = Processes.maploop, progress = true)



