include("FibLucDef.jl")
FibLuc = CompositeAlgorithm( (Fib, Luc), (1,1) )
ip = InlineProcess(CompositeAlgorithm((Fib, Luc), (1,1)); lifetime = 1000000)
function inline_bmark(ip::InlineProcess, trials = 100)
    runtimes = Float64[]
    for _ in 1:trials
        reset!(ip)
        start_ns = time_ns()
        @inline run!(ip)
        elapsed = (time_ns() - start_ns) / 1e9
        push!(runtimes, elapsed)
    end
    return mean(runtimes)
end

inline_bmark(ip, 100)
NaiveFibluc(1000000)