using Test
using Processes

struct DummyFoo
    a::Int
    b::Vector{Float64}
end

@testset "ProcessState and Destructure" begin
    Processes.@ProcessState function AddOne(value)
        return (;value_plus = value + 1)
    end

    struct DummyAlg <: Processes.ProcessAlgorithm end

    function Processes.prepare(::DummyAlg, input)
        return (;value = 3)
    end

    context = Processes.ProcessContext(DummyAlg())
    context = Processes.merge_into_subcontexts(context, (;DummyAlg = (;value = 3)))
    view = view(context, DummyAlg())

    ps_out = Processes.prepare(AddOne(), view)
    @test ps_out.value_plus == 4

    d = Processes.Destructure(DummyFoo(1, [2.0]))
    d_out = Processes.prepare(d, view)
    @test d_out.a == 1
    @test d_out.b == [2.0]
end
