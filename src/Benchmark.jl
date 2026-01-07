function benchmark(func, rt, trials = 100; loopfunction = nothing, progress = false, print_outer = false) 
    p = Process(func; lifetime = rt)
    runtimes = []
    outer_times = []
    for t_idx in 1:trials
        if progress
            println("Trial $t_idx")
        end
        preparedata!(p)
        ti = time_ns()
        p()
        wait(p)
        push!(runtimes, runtime(p))
        push!(outer_times, (time_ns() - ti) / 1e9)
    end
    if print_outer
        println("Outer times over $trials trials: ", sum(outer_times)/trials)
    end
    return sum(runtimes) / trials
end
export benchmark