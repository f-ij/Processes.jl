include("FibLucDef.jl")
import Processes as ps
FLSimple = SimpleAlgo((Fib,Luc))
FibLuc = fuse(SimpleAlgo((Fib,Luc)))
