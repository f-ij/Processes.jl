using Test
using Processes

@NamedProcessAlgorithm FooNS function Foo(x)
    return (;)
end

function Processes.prepare(::Foo, args)
    return (;x = 1)
end

@NamedProcessAlgorithm BarNS function Bar(y)
    return (;)
end

function Processes.prepare(::Bar, args)
    return (;y = 2)
end

@testset "NamedProcessAlgorithm" begin
    comp = CompositeAlgorithm((Foo, Bar), (1, 1))
    args = Processes.prepare(comp, (;lifetime = Processes.Repeat(1)))

    @test haskey(args, :FooNS)
    @test args.FooNS.x == 1
    @test haskey(args, :BarNS)
    @test args.BarNS.y == 2
end
