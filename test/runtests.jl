using Test
using Processes

@testset "Processes" begin
    include("CompositeCompositionTest.jl")
    include("InlineBenchmarkTest.jl")
    include("InlineProcessConstructorTest.jl")
    include("LifetimeTest.jl")
    include("FibLucProcessTest.jl")
    include("CopyManagerTest.jl")
    include("ProcessManagerTest.jl")
    include("RuntimeInputsLifecycleTest.jl")
    include("PackageTest.jl")
    include("RouteWalkerTest.jl")
    include("ShareContextTest.jl")
    include("RoutingWiringTest.jl")
    include("MaterializeLoopAlgorithmTest.jl")
    include("LoopAlgorithmEditTest.jl")
    include("SymbolIndexingTest.jl")
    include("InnerTypeFilterTest.jl")
    include("ContextShowingTest.jl")
    include("ContextExchangeTest.jl")
    include("CompositeDSLTest.jl")
    include("ProcessAlgorithmMacroTest.jl")
    include("ContextAnalyzerTest.jl")
    include("InspectionTest.jl")
end
