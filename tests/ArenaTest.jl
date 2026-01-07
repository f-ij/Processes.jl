using Test
using Processes

@testset "Arena" begin
    a = Arena()
    v1 = AVecAlloc(Int, a, 2)
    push!(v1, 1)
    push!(v1, 2)

    r = ARef(a, 42)

    v2 = AVecAlloc(Int, a, 2)
    push!(v2, 7)
    push!(v2, 8)

    # Force a grow on v1 and ensure later blocks stay intact.
    for i in 3:9
        push!(v1, i)
    end

    @test v1[1] == 1
    @test v1[9] == 9
    @test r[] == 42
    @test v2[1] == 7
    @test v2[2] == 8

    sizehint!(v1, 20)
    push!(v1, 10)

    @test r[] == 42
    @test v2[1] == 7
end
