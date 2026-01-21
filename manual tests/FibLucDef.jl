using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using Processes

@ProcessAlgorithm function Fib(fiblist)
    push!(fiblist, fiblist[end] + fiblist[end-1])
    return (;)
end

function Processes.prepare(::Fib, args)
    fiblist = Int[0, 1]
    processsizehint!(args, fiblist)
    return (;fiblist)
end

@ProcessAlgorithm function Luc(luclist)
    push!(luclist, luclist[end] + luclist[end-1])
    return (;)
end

function Processes.prepare(::Luc, args)
    luclist = Int[2, 1]
    processsizehint!(args, luclist)
    return (;luclist)
end


# const naive_luclist = Int[2, 1]
# const naive_fiblist = Int[0, 1]
using Statistics
function NaiveFibluc(num, trials = 100)

    times = Float64[]
    for i in 1:trials
        # empty!(fiblist)
        # empty!(luclist)
        # append!(fiblist, [0, 1])
        # append!(luclist, [2, 1])
        luclist = Int[2, 1]
        fiblist = Int[0, 1]

        sizehint!(fiblist, num+2)
        sizehint!(luclist, num+2)
        t1 = time_ns()
        for iteration in 1:num
            push!(fiblist, fiblist[end] + fiblist[end-1])
            push!(luclist, luclist[end] + luclist[end-1])
        end
        elapsed = (time_ns() - t1) / 1e9
        push!(times, elapsed)
    end
    return mean(times)
end