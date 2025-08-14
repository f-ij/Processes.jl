function benchmark(func, rt, trials = 100; loopfunction = nothing, progress = false) 
    p = Process(func; lifetime = rt)
    preparedata!(p)
    times = []
    for t_idx in 1:trials
        if progress
            println("Trial $t_idx")
        end
        start(p)
        wait(p)
        push!(times, runtime(p))
    end
    return sum(times) / trials
end
export benchmark