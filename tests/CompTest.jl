include("FibLucDef.jl")

# function Processes.prepare(::Fib, args)
#     fiblist = Int[0, 1]
#     processsizehint!(args, fiblist)
#     println("This algo is: ", Processes.this_algo(args))
#     println("It will be repeated: ", num_calls(args))
#     return (;fiblist)
# end

FibLuc = CompositeAlgorithm( (Fib, Luc), (1,2) )
p = Process(FibLuc; lifetime = 1000000)
start(p)
benchmark(FibLuc, 1000000)

 


