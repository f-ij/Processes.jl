include("FibLucDef.jl")

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,2) )
p = Process(FibLuc; lifetime = 1000000)
start(p)
benchmark(FibLuc, 1000000)

 
