include("FibLucDef.jl")
import Processes as ps

Fdup = Unique(Fib())
Fdup2 = Unique(Fib)
Ldup = Unique(Luc)


FibLuc = CompositeAlgorithm( (Fib(), Fib, Luc), (1,1,2) )



C = Routine((Fib, Fib(), FibLuc), (10,20,30))

# FFluc = CompositeAlgorithm( (FibLuc, Fdup, Fib, Ldup), (10,5,2,1) )
# td = ps.TaskData(FFluc)
# c = td.empty_context
# v = view(c, Fdup)
# locs = ps.get_varlocations(v)

# create_merge_tuples


# ps.flatten(FibLuc)



# p = Process(FFluc, Input(C, g = 1))
# c = p.context
# i = Input(C, g = 1)

# start(p)