using Test
using Processes

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
    include("SymbolIndexingTest.jl")
    include("InnerTypeFilterTest.jl")
    include("CompositeDSLTest.jl")
    include("ProcessAlgorithmMacroTest.jl")
    include("ContextAnalyzerTest.jl")
end