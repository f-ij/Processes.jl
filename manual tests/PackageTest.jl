include("FibLucDef.jl")
import Processes as ps

Fdup = Unique(Fib())
Fdup2 = Unique(Fib)
Ldup = Unique(Luc)


FibLuc = CompositeAlgorithm( (Fib(), Fib, Luc), (1,1,2) )

Pack = ps.PackagedAlgo(FibLuc, "FLPack")
SAPack = ps.SimpleAlgo((Pack,))
p = Process(Pack)