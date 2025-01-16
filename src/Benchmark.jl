function benchmark(func, rt, trials = 100; loopfunction = nothing)
    println("Benchmarking with loopfunction = $loopfunction")
    p = Process(func; runtime = rt)
    createtask!(p; loopfunction)
    times = []
    for _ in 1:trials
        start(p)
        wait(p)
        push!(times, runtime(p))
    end
    return sum(times) / trials
end
export benchmark