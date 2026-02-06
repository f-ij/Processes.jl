include("FibLucDef.jl")
import Processes as ps

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,1) )

Pack = ps.PackagedAlgo(FibLuc, "FLPack")
p = Process(Pack, lifetime = 100000)
start(p)

# benchmark(Pack, 100000, 100; print_outer = true)