using Test, Pkg
Pkg.activate((@__DIR__ )*"/..")

@testset "Processes" begin
    include("CompositeCompositionTest.jl")
    include("InlineBenchmarkTest.jl")
    include("InlineProcessConstructorTest.jl")
    include("LifetimeTest.jl")
    include("FibLucProcessTest.jl")
    include("CopyManagerTest.jl")
    include("PackagedAlgoTest.jl")
    include("RouteWalkerTest.jl")
    include("ShareContextTest.jl")
    include("MaterializeLoopAlgorithmTest.jl")
    include("InnerTypeFilterTest.jl")
end
