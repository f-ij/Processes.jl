using Test

@testset "Processes" begin
    include("ArenaTest.jl")
    include("NamedProcessAlgorithmTest.jl")
    include("FibLucPerformanceTest.jl")
    include("ProcessesFibLucTest.jl")
    include("ProcessesContextTest.jl")
    include("ProcessesStateTest.jl")
end
