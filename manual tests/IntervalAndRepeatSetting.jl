include("_env.jl")
using BenchmarkTools
mockcomp = @CompositeAlgorithm begin
    @state num = 0
    num = rand()
    num = sqrt(num)
    println(num)
end

square(x) = x^2

mockroutine = @Routine begin
    @state num = 0.0
    @state nums = Float64[]
    num = rand()
    num = @repeat 4 square(num)
    # println("Num: ", num)
    push!(nums, num)
end

rc = resolve(mockcomp)
rr = resolve(mockroutine)

pc = InlineProcess(mockcomp, repeats = 10)
pr = InlineProcess(mockroutine, repeats = 2)


c1 = run(pc);
c2 = run(pr);

e_c = context(pr)
e_c = Processes.makecontext(pr)
e_c = Processes.merge_into_globals(e_c, (; process=pr))

lifetime = Processes.lifetime(pr)
mockroutine = resolve(mockroutine)

Processes.loop(pr, mockroutine, e_c, lifetime)
@code_warntype Processes.loop(pr, mockroutine, e_c, lifetime)
@code_warntype run(pr)

stepc = Processes.step!(rc, e_c, Unstable())


@benchmark Processes.loop($pr, $mockroutine, $e_c, $lifetime)
@benchmark run($pr)
    

function mockroutine_mimic()
    num = 0
    nums = Float64[]
    for i in 1:2
        num = rand()
        for i in 1:4
            num = square(num)
        end
        push!(nums, num)
    end
    return num, nums
end

@benchmark mockroutine_mimic()