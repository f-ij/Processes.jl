include("FibLucDef.jl")
import Processes as ps

Fdup = Unique(Fib())
Fdup2 = Unique(Fib)
Ldup = Unique(Luc)


FibLuc = CompositeAlgorithm( (Fib(), Luc), (1,2) )
C = Routine((Fib, Fib(), FibLuc))


FFluc = CompositeAlgorithm( (FibLuc, Fdup, Fib, Ldup), (10,5,2,1) )

ps.flat_tree_property_recursion((FFluc,), (1,)) do el, trait
    if !(el isa CompositeAlgorithm)
        return nothing, nothing
    end
    newels = ps.getfuncs(el)
    newtraits = ps.intervals(el)
    return newels, trait.*newtraits
end

ps.flatten(FibLuc)



# p = Process(FFluc, Input(C, g = 1))
# c = p.context
# i = Input(C, g = 1)

# start(p)