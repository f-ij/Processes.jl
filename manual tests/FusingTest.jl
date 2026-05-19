include("FibLucDef.jl")
import Processes as ps
FLSimple = CompositeAlgorithm((Fib,Luc))
FibLuc = fuse(CompositeAlgorithm((Fib,Luc)))
