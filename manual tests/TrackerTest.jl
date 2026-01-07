include("FibLucDef.jl")
import Processes as P

struct CountCall <: ProcessAlgorithm end

Processes.prepare(::CountCall, args) = (;count = Ref(0))

function (::CountCall)(args)
    (;count) = args
    count[] += 1
end


FibLucComp = CompositeAlgorithm( (Fib, Luc, CountCall), (1,2,1) )

LastComp = CompositeAlgorithm( (FibLucComp, CountCall), (1,1) )

r = Routine((FibLucComp, CountCall, LastComp), (2,3,4))
p = Process(r, lifetime = 2)
num_calls(p, CountCall)
start(p)

ph = PrepereHelper(r)
