include("FibLucDef.jl")

# FibLuc = Routine(CompositeAlgorithm( (Fib, Luc), (1,1) ), CompositeAlgorithm( (Fib, Luc), (1,2) ), repeats = (20,30))
FibLuc = CompositeAlgorithm( (Fib, Luc), (1,1) )
# p = Process(FibLuc; lifetime = 1000000)

# preparedata!(p)

# benchmark(FibLuc, 1000000, print_outer = true)

# NaiveFibluc(1000000)


