using Test, Pkg
Pkg.activate((@__DIR__ )*"/..")

@testset "Processes" begin
    include("CompositeCompositionTest.jl")
    include("InlineBenchmarkTest.jl")
    include("FibLucProcessTest.jl")
end
