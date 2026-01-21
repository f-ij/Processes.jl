include("FibLucDef.jl")
import Processes as ps

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,1) )
p = Process( FibLuc; lifetime = 1000000)
benchmark(FibLuc, 1000000)