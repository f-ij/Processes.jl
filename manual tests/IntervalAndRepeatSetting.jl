include("_env.jl")

mockcomp = @CompositeAlgorithm begin
    @state num = 0
    num = rand()
    num = sqrt(num)
    println(num)
end

mockroutine = @Routine begin
    @state num = 0
    num = @repeat 5 sqrt(num)
    println(num)
    num = rand()
end

rc = resolve(mockcomp)
rr = resolve(mockroutine)

pc = Process(mockcomp, lifetime = 10)
pr = InlineProcess(mockcomp, repeats = 2)

run(pc);
run(pr);

    