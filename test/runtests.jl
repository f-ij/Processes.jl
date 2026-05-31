using Test
using Processes

@testset "Processes" begin
    include("CompositeCompositionTest.jl")
    # Out of scope for immutable_fix_manual while the old generated path is removed.
    # include("InlineBenchmarkTest.jl")
    include("InlineProcessConstructorTest.jl")
    include("LifetimeTest.jl")
    include("FibLucProcessTest.jl")
    include("CopyManagerTest.jl")
    include("ProcessManagerTest.jl")
    include("RuntimeInputsLifecycleTest.jl")
    # Package/SubPackage execution is out of scope for this branch.
    # include("PackageTest.jl")
    include("RouteWalkerTest.jl")
    include("ShareContextTest.jl")
    include("RoutingWiringTest.jl")
    include("MaterializeLoopAlgorithmTest.jl")
    include("LoopAlgorithmEditTest.jl")
    include("SymbolIndexingTest.jl")
    include("InnerTypeFilterTest.jl")
    include("ContextShowingTest.jl")
    # ContextInjector and interactive widget tooling are out of scope for this branch.
    # include("ContextInjectorTest.jl")
    include("CompositeDSLTest.jl")
    include("ProcessAlgorithmMacroTest.jl")
    include("ContextAnalyzerTest.jl")
    include("InspectionTest.jl")
end
