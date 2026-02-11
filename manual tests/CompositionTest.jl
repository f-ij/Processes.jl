include("FibLucDef.jl")
import Processes as ps

Fdup = Unique(Fib())
Fdup2 = Unique(Fib)
Ldup = Unique(Luc)

Simple = CompositeAlgorithm(Fib, Fib(), Ldup)
Simple2 = CompositeAlgorithm(Fib, Fib(), Luc)
FibLuc = CompositeAlgorithm(Fib(), Fib, Luc)

C = Routine(Fib, Fib(), FibLuc, (10, 20, 30))

FFluc = CompositeAlgorithm(C, FibLuc, Fdup, Fib, Ldup, (1, 10, 5, 2, 1))
