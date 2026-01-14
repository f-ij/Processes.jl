using BenchmarkTools
args_imm = (fib1 = 0, fib2 = 1)
args_ref = (fib1 = Ref(0), fib2 = Ref(1))

const steps = 100000

function fib_imm(n, args)
    for i in 1:n
        newfib = args.fib1 + args.fib2
        args = (fib1 = args.fib2, fib2 = newfib)
    end
    return args.fib2
end

function fib_ref(n, args)
    for i in 1:n
        newfib = args.fib1[] + args.fib2[]
        args.fib1[] = args.fib2[]
        args.fib2[] = newfib
    end
    return args.fib2[]
end

@inline function fib_functional(n, nmax, fib1, fib2)
    if n == nmax
        return fib2
    else
        return @inline fib_functional(n + 1, nmax, fib2, fib1 + fib2)
    end
end

@inline function fib_returnval(n, fib1, fib2)
    for i in 1:n
        newfib = fib1 + fib2
        fib1, fib2 = fib2, newfib
    end
    return fib2
end

println("Benchmarking Fibonacci implementations for $steps steps:")
println("---------------------------------------------------")
println("Immutable NamedTuple arguments:")
display(@benchmark fib_imm($steps, $args_imm))
println("---------------------------------------------------")
println("Mutable NamedTuple with Refs arguments:")
args_ref.fib1[] = 0
args_ref.fib2[] = 1
display(@benchmark fib_ref($steps, $args_ref))
println("---------------------------------------------------")
println("Functional implementation:")
display(@benchmark fib_functional(0, $steps, 0, 1))
println("---------------------------------------------------")
println("Return value implementation:")
display(@benchmark fib_returnval($steps, 0, 1))
println("---------------------------------------------------")