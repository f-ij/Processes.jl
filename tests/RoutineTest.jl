include("FibLucDef.jl")

r = Routine((Fib,Luc), (1000000, 1000000/2))
pr = Process(r, lifetime = 1)
start(pr)
benchmark(r, 1)

# SFib = SubRoutine(Fib, 1000000)
# SLuc = SubRoutine(Luc, 1000000 ÷ 2)
# RFL = Routine(SFib, SLuc)
# p = Process(RFL, lifetime = 1)
# start(p)

