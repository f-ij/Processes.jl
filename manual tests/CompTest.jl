include("FibLucDef.jl")
import Processes as ps

FibLuc = CompositeAlgorithm( (Fib(), Luc), (1,2) )
Fdup = Unique(Fib())
Fdup2 = Unique(Fib)
Ldup = Unique(Luc)
C = Routine((Fib, Fib(), FibLuc))
FFluc = CompositeAlgorithm( (FibLuc, C, Fdup, Fib, Ldup))


p = Process(FFluc, Input(C, g = 1))
c = p.context
i = Input(C, g = 1)

# start(p)