include("_env.jl")

mockcomp = @CompositeAlgorithm begin
    @state num = 0
    num = rand()
    num = sqrt(num)
    println(num)
end

square(x) = x^2

mockroutine = @Routine begin
    @state num = 0
    num = rand()
    num = @repeat 2 square(num)
    println("Num: ", num)
    num = rand()
end

rc = resolve(mockcomp)
rr = resolve(mockroutine)

pc = InlineProcess(mockcomp, repeats = 10)
pr = InlineProcess(mockroutine, repeats = 2)

c1 = run(pc);
c2 = run(pr);

    