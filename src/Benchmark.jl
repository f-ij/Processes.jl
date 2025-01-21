function benchmark(func, rt, trials = 100; loopfunction = nothing, progress = false) 
    p = Process(func; runtime = rt)
    createtask!(p; loopfunction)
    times = []
    for t_idx in 1:trials
        if progress
            println("Trial $t_idx")
        end
        start(p)
        wait(p)
        push!(times, runtime(p))
        display(getargs(p))
    end
    return sum(times) / trials
end
export benchmark