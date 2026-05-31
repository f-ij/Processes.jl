; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algo, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x42d40b58, 0x1ac1c56c, 0xf4ebc672, 0x7013e468, 0xf1097cdf), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algo, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x42d40b58, 0x1ac1c56c, 0xf4ebc672, 0x7013e468, 0xf1097cdf), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algo, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x42d40b58, 0x1ac1c56c, 0xf4ebc672, 0x7013e468, 0xf1097cdf), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algo, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x42d40b58, 0x1ac1c56c, 0xf4ebc672, 0x7013e468, 0xf1097cdf), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algo, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x42d40b58, 0x1ac1c56c, 0xf4ebc672, 0x7013e468, 0xf1097cdf), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xded9cf5972a849928106c42c438f3c5f))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.RuntimeGenerated)
define swiftcc void @julia_loop_9343(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [1 x ptr]], ptr }, [1 x ptr], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(384) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(232) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(560) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(432) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(384) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [11 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 88, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 7
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %2 = alloca [48 x i64], align 8
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.10647 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple74" = alloca [1 x i64], align 8
  %.sroa.6594 = alloca [7 x i8], align 1
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext.sroa.6" = alloca [7 x i64], align 8
  %.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0.sroa.12 = alloca [8 x i64], align 8
  %.sroa.0.sroa.13 = alloca [4 x i64], align 8
  %.sroa.0.sroa.18.sroa.18 = alloca [7 x i8], align 1
  %.sroa.12 = alloca [7 x i64], align 8
  %.sroa.0404.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0404.sroa.12 = alloca [4 x i64], align 8
  %.sroa.0404.sroa.14 = alloca [8 x i64], align 8
  %.sroa.0404.sroa.16 = alloca [4 x i64], align 8
  %.sroa.0404.sroa.26.sroa.11 = alloca [7 x i8], align 1
  %.sroa.8410 = alloca [7 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4" = alloca [4 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5" = alloca [8 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6" = alloca [4 x i64], align 8
  %"new::Tuple269" = alloca [1 x i64], align 8
  %"new::Tuple272" = alloca [1 x i64], align 8
  %"new::Tuple274" = alloca [1 x i64], align 8
  store i64 36, ptr %gcframe2, align 8, !tbaa !156
  %task.gcstack = load ptr, ptr %pgcstack, align 8
  %frame.prev = getelementptr inbounds ptr, ptr %gcframe2, i64 1
  store ptr %task.gcstack, ptr %frame.prev, align 8, !tbaa !156
  store ptr %gcframe2, ptr %pgcstack, align 8
  call void @llvm.dbg.declare(metadata ptr %"process::Process", metadata !151, metadata !DIExpression()), !dbg !160
  %3 = getelementptr inbounds i8, ptr %.roots.algo, i64 8
  %4 = load ptr, ptr %3, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  call void @llvm.dbg.declare(metadata ptr %"algo::LoopAlgorithm", metadata !152, metadata !DIExpression()), !dbg !160
  %5 = load ptr, ptr %.roots.context, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %6 = getelementptr inbounds i8, ptr %.roots.context, i64 8
  %7 = load ptr, ptr %6, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %8 = getelementptr inbounds i8, ptr %.roots.context, i64 16
  %9 = load ptr, ptr %8, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %10 = getelementptr inbounds i8, ptr %.roots.context, i64 24
  %11 = load ptr, ptr %10, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %12 = getelementptr inbounds i8, ptr %.roots.context, i64 32
  %13 = load ptr, ptr %12, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %14 = getelementptr inbounds i8, ptr %.roots.context, i64 40
  %15 = load ptr, ptr %14, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %16 = getelementptr inbounds i8, ptr %.roots.context, i64 48
  %17 = load ptr, ptr %16, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %18 = getelementptr inbounds i8, ptr %.roots.context, i64 56
  %19 = load ptr, ptr %18, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %20 = getelementptr inbounds i8, ptr %.roots.context, i64 64
  %21 = load ptr, ptr %20, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %22 = getelementptr inbounds i8, ptr %.roots.context, i64 72
  %23 = load ptr, ptr %22, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %24 = getelementptr inbounds i8, ptr %.roots.context, i64 80
  %25 = load ptr, ptr %24, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %26 = getelementptr inbounds i8, ptr %.roots.context, i64 88
  %27 = load ptr, ptr %26, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %28 = getelementptr inbounds i8, ptr %.roots.context, i64 96
  %29 = load ptr, ptr %28, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %30 = getelementptr inbounds i8, ptr %.roots.context, i64 104
  %31 = load ptr, ptr %30, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %32 = getelementptr inbounds i8, ptr %.roots.context, i64 112
  %33 = load ptr, ptr %32, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %34 = getelementptr inbounds i8, ptr %.roots.context, i64 120
  %35 = load ptr, ptr %34, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %36 = getelementptr inbounds i8, ptr %.roots.context, i64 128
  %37 = load ptr, ptr %36, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %38 = getelementptr inbounds i8, ptr %.roots.context, i64 136
  %39 = load ptr, ptr %38, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %40 = getelementptr inbounds i8, ptr %.roots.context, i64 144
  %41 = load ptr, ptr %40, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %42 = getelementptr inbounds i8, ptr %.roots.context, i64 152
  %43 = load ptr, ptr %42, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %44 = getelementptr inbounds i8, ptr %.roots.context, i64 160
  %45 = load ptr, ptr %44, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %46 = getelementptr inbounds i8, ptr %.roots.context, i64 168
  %47 = load ptr, ptr %46, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %48 = getelementptr inbounds i8, ptr %.roots.context, i64 176
  %49 = load ptr, ptr %48, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %50 = getelementptr inbounds i8, ptr %.roots.context, i64 184
  %51 = load ptr, ptr %50, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %52 = getelementptr inbounds i8, ptr %.roots.context, i64 192
  %53 = load ptr, ptr %52, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %54 = getelementptr inbounds i8, ptr %.roots.context, i64 200
  %55 = load ptr, ptr %54, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %56 = getelementptr inbounds i8, ptr %.roots.context, i64 208
  %57 = load ptr, ptr %56, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %58 = getelementptr inbounds i8, ptr %.roots.context, i64 216
  %59 = load ptr, ptr %58, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %60 = getelementptr inbounds i8, ptr %.roots.context, i64 224
  %61 = load ptr, ptr %60, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  call void @llvm.dbg.declare(metadata ptr %"context::ProcessContext", metadata !153, metadata !DIExpression()), !dbg !160
  %ptls_field = getelementptr inbounds i8, ptr %pgcstack, i64 16
  %ptls_load = load ptr, ptr %ptls_field, align 8, !tbaa !156
  %62 = getelementptr inbounds i8, ptr %ptls_load, i64 16
  %safepoint = load ptr, ptr %62, align 8, !tbaa !169, !invariant.load !0
  fence syncscope("singlethread") seq_cst
  %63 = load volatile i64, ptr %safepoint, align 8, !dbg !160
  fence syncscope("singlethread") seq_cst
  store i8 1, ptr @"jl_global#9346.jit", align 16, !dbg !171, !tbaa !181, !alias.scope !184, !noalias !185
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !186
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !186, !tbaa !156, !alias.scope !161, !noalias !164
  %64 = sext i16 %thread_id to i64, !dbg !190
  %65 = add nsw i64 %64, 1, !dbg !195
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !197
  store i64 %65, ptr %"process::Process.threadid_ptr", align 8, !dbg !197, !tbaa !198, !alias.scope !184, !noalias !185
  %66 = call i64 @jlplt_ijl_hrtime_9348_got.jit(), !dbg !200
  %"process::Process.starttime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 504, !dbg !206
  %"process::Process.starttime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 512, !dbg !206
  store i8 2, ptr %"process::Process.starttime.tindex_ptr", align 1, !dbg !206, !tbaa !198, !alias.scope !184, !noalias !185
  store i64 %66, ptr %"process::Process.starttime_ptr", align 8, !dbg !206, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.loopidx_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 472, !dbg !207
  %"process::Process.loopidx" = load i64, ptr %"process::Process.loopidx_ptr", align 8, !dbg !207, !tbaa !198, !alias.scope !184, !noalias !185
  %67 = icmp ugt i64 %"process::Process.loopidx", 100000, !dbg !213
  %68 = add i64 %"process::Process.loopidx", -1, !dbg !218
  %value_phi = select i1 %67, i64 %68, i64 100000, !dbg !218
  %.not.not = icmp ult i64 %value_phi, %"process::Process.loopidx", !dbg !227
  br i1 %.not.not, label %L31.L666_crit_edge, label %L31.L35_crit_edge, !dbg !226

L31.L666_crit_edge:                               ; preds = %top
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !233
  %".sroa.0.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !233
  %.sroa.0.sroa.8.0.copyload = load i64, ptr %".sroa.0.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.9.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !233
  %.sroa.0.sroa.9.0.copyload = load i64, ptr %".sroa.0.sroa.9.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !233
  %.sroa.0.sroa.10.0.copyload = load i64, ptr %".sroa.0.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !233
  %".sroa.0.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !233
  %".sroa.0.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !233
  %".sroa.0.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !233
  %.sroa.0.sroa.14.0.copyload = load i64, ptr %".sroa.0.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.15.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 256, !dbg !233
  %.sroa.0.sroa.15.0.copyload = load i64, ptr %".sroa.0.sroa.15.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !233
  %.sroa.0.sroa.16.0.copyload = load i64, ptr %".sroa.0.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.17.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 272, !dbg !233
  %.sroa.0.sroa.17.0.copyload = load i64, ptr %".sroa.0.sroa.17.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !233
  %.sroa.0.sroa.18.sroa.0.0.copyload = load i64, ptr %".sroa.0.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.sroa.8.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 288, !dbg !233
  %.sroa.0.sroa.18.sroa.8.0.copyload = load i64, ptr %".sroa.0.sroa.18.sroa.8.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.sroa.10.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !233
  %.sroa.0.sroa.18.sroa.10.0.copyload = load float, ptr %".sroa.0.sroa.18.sroa.10.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.sroa.12.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 300, !dbg !233
  %.sroa.0.sroa.18.sroa.12.0.copyload = load float, ptr %".sroa.0.sroa.18.sroa.12.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 4, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.sroa.14.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !233
  %.sroa.0.sroa.18.sroa.14.0.copyload = load i64, ptr %".sroa.0.sroa.18.sroa.14.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.sroa.16.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !233
  %.sroa.0.sroa.18.sroa.16.0.copyload = load i8, ptr %".sroa.0.sroa.18.sroa.16.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0.sroa.18.sroa.18.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0.sroa.18.sroa.18.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", i64 7, i1 false), !dbg !233
  %".sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !233
  %.sroa.8.0.copyload = load float, ptr %".sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !233
  %.sroa.10.0.copyload = load i32, ptr %".sroa.10.0.context::ProcessContext.sroa_idx", align 4, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 328, !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %".sroa.12.0.context::ProcessContext.sroa_idx", i64 56, i1 false), !dbg !233
  br label %L666, !dbg !233

L31.L35_crit_edge:                                ; preds = %top
  %".sroa.0423.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !233
  %".sroa.0423.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !233
  %.sroa.0423.sroa.10.0.copyload660 = load i64, ptr %".sroa.0423.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0423.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !233
  %".sroa.0423.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !233
  %".sroa.0423.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !233
  %".sroa.0423.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !233
  %".sroa.0423.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !233
  %".sroa.0423.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !233
  %".sroa.0423.sroa.20.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !233
  %".sroa.0423.sroa.22.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !233
  %.sroa.0423.sroa.22.0.copyload690 = load i64, ptr %".sroa.0423.sroa.22.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0423.sroa.23.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !233
  %.sroa.0423.sroa.23.0.copyload693 = load i8, ptr %".sroa.0423.sroa.23.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0423.sroa.24.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !233
  %".sroa.6424.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !233
  %.sroa.6424.0.copyload425 = load float, ptr %".sroa.6424.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.7426.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !233
  %.sroa.7426.0.copyload427 = load i32, ptr %".sroa.7426.0.context::ProcessContext.sroa_idx", align 4, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.8428.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 328, !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !226
  %.sroa.0423.sroa.8.0..sroa_idx655 = getelementptr inbounds i8, ptr %2, i64 96, !dbg !226
  %.sroa.0423.sroa.9.0..sroa_idx658 = getelementptr inbounds i8, ptr %2, i64 104, !dbg !226
  %69 = load <2 x i64>, ptr %".sroa.0423.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %69, ptr %.sroa.0423.sroa.8.0..sroa_idx655, align 8, !dbg !226
  %.sroa.0423.sroa.10.0..sroa_idx661 = getelementptr inbounds i8, ptr %2, i64 112, !dbg !226
  store i64 %.sroa.0423.sroa.10.0.copyload660, ptr %.sroa.0423.sroa.10.0..sroa_idx661, align 8, !dbg !226
  %.sroa.0423.sroa.11.0..sroa_idx663 = getelementptr inbounds i8, ptr %2, i64 120, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0423.sroa.11.0..sroa_idx663, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0423.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !226
  %.sroa.0423.sroa.12.0..sroa_idx664 = getelementptr inbounds i8, ptr %2, i64 152, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0423.sroa.12.0..sroa_idx664, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0423.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !226
  %.sroa.0423.sroa.13.0..sroa_idx665 = getelementptr inbounds i8, ptr %2, i64 216, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0423.sroa.13.0..sroa_idx665, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0423.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !226
  %.sroa.0423.sroa.14.0..sroa_idx667 = getelementptr inbounds i8, ptr %2, i64 248, !dbg !226
  %.sroa.0423.sroa.15.0..sroa_idx670 = getelementptr inbounds i8, ptr %2, i64 256, !dbg !226
  %70 = load <2 x i64>, ptr %".sroa.0423.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %70, ptr %.sroa.0423.sroa.14.0..sroa_idx667, align 8, !dbg !226
  %.sroa.0423.sroa.16.0..sroa_idx673 = getelementptr inbounds i8, ptr %2, i64 264, !dbg !226
  %.sroa.0423.sroa.17.0..sroa_idx676 = getelementptr inbounds i8, ptr %2, i64 272, !dbg !226
  %71 = load <2 x i64>, ptr %".sroa.0423.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %71, ptr %.sroa.0423.sroa.16.0..sroa_idx673, align 8, !dbg !226
  %.sroa.0423.sroa.18.0..sroa_idx679 = getelementptr inbounds i8, ptr %2, i64 280, !dbg !226
  %.sroa.0423.sroa.19.0..sroa_idx682 = getelementptr inbounds i8, ptr %2, i64 288, !dbg !226
  %72 = load <2 x i64>, ptr %".sroa.0423.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %72, ptr %.sroa.0423.sroa.18.0..sroa_idx679, align 8, !dbg !226
  %.sroa.0423.sroa.20.0..sroa_idx685 = getelementptr inbounds i8, ptr %2, i64 296, !dbg !226
  %.sroa.0423.sroa.21.0..sroa_idx688 = getelementptr inbounds i8, ptr %2, i64 300, !dbg !226
  %73 = load <2 x float>, ptr %".sroa.0423.sroa.20.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x float> %73, ptr %.sroa.0423.sroa.20.0..sroa_idx685, align 8, !dbg !226
  %.sroa.0423.sroa.22.0..sroa_idx691 = getelementptr inbounds i8, ptr %2, i64 304, !dbg !226
  store i64 %.sroa.0423.sroa.22.0.copyload690, ptr %.sroa.0423.sroa.22.0..sroa_idx691, align 8, !dbg !226
  %.sroa.0423.sroa.23.0..sroa_idx694 = getelementptr inbounds i8, ptr %2, i64 312, !dbg !226
  store i8 %.sroa.0423.sroa.23.0.copyload693, ptr %.sroa.0423.sroa.23.0..sroa_idx694, align 8, !dbg !226
  %.sroa.0423.sroa.24.0..sroa_idx696 = getelementptr inbounds i8, ptr %2, i64 313, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0423.sroa.24.0..sroa_idx696, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0423.sroa.24.0.context::ProcessContext.sroa_idx", i64 7, i1 false), !dbg !226
  %.sroa.6424.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 320, !dbg !226
  store float %.sroa.6424.0.copyload425, ptr %.sroa.6424.0..sroa_idx, align 8, !dbg !226
  %.sroa.7426.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 324, !dbg !226
  store i32 %.sroa.7426.0.copyload427, ptr %.sroa.7426.0..sroa_idx, align 4, !dbg !226
  %.sroa.8428.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 328, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8428.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %".sroa.8428.0.context::ProcessContext.sroa_idx", i64 56, i1 false), !dbg !226
  %74 = getelementptr inbounds i8, ptr %2, i64 136, !dbg !238
  %.stop_ptr = getelementptr inbounds i8, ptr %2, i64 144, !dbg !276
  %.stop_ptr.unbox514 = load i64, ptr %.stop_ptr, align 8, !dbg !297, !tbaa !299, !alias.scope !301, !noalias !302
  %.unbox515 = load i64, ptr %74, align 8, !dbg !297, !tbaa !299, !alias.scope !301, !noalias !302
  %.not516 = icmp slt i64 %.stop_ptr.unbox514, %.unbox515, !dbg !297
  %75 = extractelement <2 x i64> %71, i64 1, !dbg !280
  %76 = bitcast i64 %75 to double, !dbg !280
  %77 = bitcast <2 x i64> %69 to i128, !dbg !280
  %78 = trunc i128 %77 to i64, !dbg !280
  %79 = extractelement <2 x i64> %69, i64 1, !dbg !280
  %80 = extractelement <2 x i64> %70, i64 0, !dbg !280
  %81 = extractelement <2 x i64> %70, i64 1, !dbg !280
  %82 = extractelement <2 x i64> %71, i64 0, !dbg !280
  br i1 %.not516, label %L63, label %L66.lr.ph, !dbg !280

L66.lr.ph:                                        ; preds = %L31.L35_crit_edge
  %83 = trunc i128 %77 to i32, !dbg !280
  %84 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8
  %root_phi26.idxF_ptr278 = getelementptr inbounds i8, ptr %47, i64 32
  %root_phi26.vals_ptr280 = getelementptr inbounds i8, ptr %47, i64 16
  %85 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8
  %86 = getelementptr inbounds i8, ptr %2, i64 40
  %root_phi7.size_ptr = getelementptr inbounds i8, ptr %9, i64 16
  %87 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %88 = getelementptr inbounds ptr, ptr %gcframe2, i64 4
  %89 = getelementptr inbounds ptr, ptr %gcframe2, i64 5
  %90 = getelementptr inbounds ptr, ptr %gcframe2, i64 6
  %91 = getelementptr inbounds i8, ptr %2, i64 16
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496
  %"new::Tuple74.promoted" = load i64, ptr %"new::Tuple74", align 1, !tbaa !299, !alias.scope !301, !noalias !302
  br label %L66, !dbg !280

L63:                                              ; preds = %L665, %L31.L35_crit_edge
  %92 = call swiftcc [1 x ptr] @j_ArgumentError_9349(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9350.jit"), !dbg !280
  %gc_slot_addr_7 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %93 = extractvalue [1 x ptr] %92, 0, !dbg !280
  store ptr %93, ptr %gc_slot_addr_7, align 8
  %ptls_load954 = load ptr, ptr %ptls_field, align 8, !dbg !280, !tbaa !156
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load954, i32 424, i32 16, i64 4838868976) #23, !dbg !280
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !280
  store atomic i64 4838868976, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !280, !tbaa !303
  store ptr %93, ptr %"box::ArgumentError", align 8, !dbg !280, !tbaa !305, !alias.scope !184, !noalias !185
  store ptr null, ptr %gc_slot_addr_7, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !280
  unreachable, !dbg !280

L66:                                              ; preds = %L665, %L66.lr.ph
  %94 = phi i64 [ %"new::Tuple74.promoted", %L66.lr.ph ], [ %.fr783, %L665 ]
  %.unbox519 = phi i64 [ %.unbox515, %L66.lr.ph ], [ %.unbox, %L665 ]
  %.stop_ptr.unbox518 = phi i64 [ %.stop_ptr.unbox514, %L66.lr.ph ], [ %.stop_ptr.unbox, %L665 ]
  %value_phi5517 = phi i64 [ %"process::Process.loopidx", %L66.lr.ph ], [ %198, %L665 ]
  %.unbox73 = bitcast i32 %83 to float, !dbg !280
  %.unbox258 = bitcast i32 %.sroa.7426.0.copyload427 to float, !dbg !280
  %95 = add i64 %.stop_ptr.unbox518, 1, !dbg !307
  %96 = sub i64 %95, %.unbox519, !dbg !310
  store i64 %.unbox519, ptr %"new::SamplerRangeNDL", align 8, !dbg !311, !tbaa !299, !alias.scope !301, !noalias !302
  store i64 %96, ptr %84, align 8, !dbg !311, !tbaa !299, !alias.scope !301, !noalias !302
  %97 = call swiftcc i64 @j_rand_9352(ptr nonnull swiftself %pgcstack, ptr %47, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !288
  %.fr783 = freeze i64 %97
  %root_phi25.state = load atomic ptr, ptr %45 unordered, align 8, !dbg !313, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !318, !align !319
  %root_phi25.state.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state, i64 16, !dbg !320
  %root_phi25.state.size.0.copyload = load i64, ptr %root_phi25.state.size_ptr, align 8, !dbg !320, !tbaa !235, !alias.scope !326, !noalias !327
  %.not429 = icmp eq i64 %root_phi25.state.size.0.copyload, 100000, !dbg !328
  br i1 %.not429, label %L92, label %L87, !dbg !323

L87:                                              ; preds = %L66
  call swiftcc void @j_throw_dmrsa_9353(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state.size.0.copyload) #9, !dbg !333
  unreachable, !dbg !333

L92:                                              ; preds = %L66
  %98 = load ptr, ptr %root_phi25.state, align 8, !dbg !334, !tbaa !336, !alias.scope !339, !noalias !340
  %memoryref_offset = shl i64 %.fr783, 2, !dbg !341
  %99 = getelementptr i8, ptr %98, i64 %memoryref_offset, !dbg !341
  %memoryref_data42 = getelementptr i8, ptr %99, i64 -4, !dbg !341
  %100 = load float, ptr %memoryref_data42, align 4, !dbg !341, !tbaa !344, !alias.scope !184, !noalias !185
  %101 = icmp slt i64 %.fr783, 100001
  br i1 %101, label %L138, label %L251, !dbg !346

L138:                                             ; preds = %L92
  %102 = call double @llvm.fabs.f64(double %76), !dbg !353
  %103 = fcmp oeq double %76, 0.000000e+00, !dbg !365
  br i1 %103, label %guard_pass346, label %L143, !dbg !367

L143:                                             ; preds = %L138
  %root_phi26.idxF279 = load i64, ptr %root_phi26.idxF_ptr278, align 8, !dbg !368, !tbaa !198, !alias.scope !184, !noalias !185
  %.not434 = icmp eq i64 %root_phi26.idxF279, 1002, !dbg !387
  br i1 %.not434, label %L146, label %L148, !dbg !372

L146:                                             ; preds = %L143
  %104 = call swiftcc i64 @j_gen_rand_9360(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !372
  %root_phi26.idxF283.pre = load i64, ptr %root_phi26.idxF_ptr278, align 8, !dbg !388, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L148, !dbg !372

L148:                                             ; preds = %L146, %L143
  %root_phi26.idxF283 = phi i64 [ %root_phi26.idxF279, %L143 ], [ %root_phi26.idxF283.pre, %L146 ], !dbg !388
  %root_phi26.vals281 = load atomic ptr, ptr %root_phi26.vals_ptr280 unordered, align 8, !dbg !388, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !318, !align !319
  %105 = add i64 %root_phi26.idxF283, 1, !dbg !395
  store i64 %105, ptr %root_phi26.idxF_ptr278, align 8, !dbg !396, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data286 = load ptr, ptr %root_phi26.vals281, align 8, !dbg !397, !tbaa !336, !alias.scope !339, !noalias !340
  %memoryref_byteoffset289 = shl i64 %root_phi26.idxF283, 3, !dbg !397
  %memoryref_data294 = getelementptr inbounds i8, ptr %memoryref_data286, i64 %memoryref_byteoffset289, !dbg !397
  %106 = load i64, ptr %memoryref_data294, align 8, !dbg !397, !tbaa !344, !alias.scope !184, !noalias !185
  %107 = trunc i64 %106 to i32, !dbg !398
  %108 = and i32 %107, 8388607, !dbg !399
  %109 = or disjoint i32 %108, 1065353216, !dbg !401
  %bitcast_coercion296 = bitcast i32 %109 to float, !dbg !403
  %110 = fadd float %bitcast_coercion296, -1.000000e+00, !dbg !405
  %111 = fmul float %110, 2.000000e+00, !dbg !409
  %112 = fadd float %111, -1.000000e+00, !dbg !413
  %113 = fpext float %112 to double, !dbg !414
  %114 = fmul double %102, %113, !dbg !409
  %115 = fpext float %100 to double, !dbg !423
  %116 = fadd double %114, %115, !dbg !429
  %117 = fadd double %116, 1.000000e+00, !dbg !431
  %118 = fsub double %117, %117, !dbg !436
  %119 = fcmp uno double %118, 0.000000e+00, !dbg !445
  %120 = fcmp oeq double %117, 0.000000e+00
  %or.cond = or i1 %119, %120, !dbg !439
  %121 = call double @llvm.fabs.f64(double %117), !dbg !449
  br i1 %or.cond, label %L208, label %L204, !dbg !439

L204:                                             ; preds = %L148
  %122 = call swiftcc double @j_rem_internal_9364(ptr nonnull swiftself %pgcstack, double %121, double 4.000000e+00), !dbg !450
  %123 = call double @llvm.copysign.f64(double %122, double %117), !dbg !451
  br label %L216, !dbg !454

L208:                                             ; preds = %L148
  %124 = bitcast double %121 to i64, !dbg !456
  %.not435 = icmp eq i64 %124, 9218868437227405312, !dbg !456
  br i1 %.not435, label %L223, label %L216, !dbg !458

L216:                                             ; preds = %L208, %L204
  %value_phi297 = phi double [ %123, %L204 ], [ %117, %L208 ]
  %125 = fcmp une double %value_phi297, 0.000000e+00, !dbg !459
  br i1 %125, label %L223, label %L221, !dbg !461

L221:                                             ; preds = %L216
  %126 = call double @llvm.fabs.f64(double %value_phi297), !dbg !462
  br label %guard_pass351, !dbg !454

L223:                                             ; preds = %L216, %L208
  %value_phi297451 = phi double [ %value_phi297, %L216 ], [ 0x7FF8000000000000, %L208 ]
  %127 = fcmp ogt double %value_phi297451, 0.000000e+00, !dbg !464
  %128 = fadd double %value_phi297451, 4.000000e+00
  %spec.select368 = select i1 %127, double %value_phi297451, double %128, !dbg !468
  br label %guard_pass351, !dbg !468

L251:                                             ; preds = %L92
  store i64 %94, ptr %"new::Tuple74", align 1, !dbg !469, !tbaa !299, !alias.scope !301, !noalias !302
  %jl_nothing303 = load ptr, ptr @jl_nothing, align 8, !dbg !484, !tbaa !169, !invariant.load !0, !alias.scope !487, !noalias !488, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %100), !dbg !484
  %gc_slot_addr_8 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  store ptr %box_Float32, ptr %gc_slot_addr_8, align 8
  %ptls_load959 = load ptr, ptr %ptls_field, align 8, !dbg !484, !tbaa !156
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load959, i32 424, i32 16, i64 4839448720) #23, !dbg !484
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !484
  store atomic i64 4839448720, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !484, !tbaa !303
  store i64 %75, ptr %"box::Float64", align 8, !dbg !484, !tbaa !235, !alias.scope !489, !noalias !490
  %gc_slot_addr_7944 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %"box::Float64", ptr %gc_slot_addr_7944, align 8
  store ptr @"jl_global#9365.jit", ptr %jlcallframe1, align 8, !dbg !484
  %129 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !484
  store ptr %47, ptr %129, align 8, !dbg !484
  %130 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !484
  store ptr %jl_nothing303, ptr %130, align 8, !dbg !484
  %131 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !484
  store ptr %box_Float32, ptr %131, align 8, !dbg !484
  %132 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !484
  store ptr %"box::Float64", ptr %132, align 8, !dbg !484
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !484
  call void @llvm.trap(), !dbg !484
  unreachable, !dbg !484

L269:                                             ; preds = %guard_pass351, %guard_pass346
  %.sroa.7641.0 = phi float [ %361, %guard_pass346 ], [ %366, %guard_pass351 ], !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10647, i64 7, i1 false), !dbg !491
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10647), !dbg !491
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !481
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !491, !tbaa !299, !alias.scope !301, !noalias !302
  store i64 %.fr783, ptr %85, align 8, !dbg !481, !tbaa !299, !alias.scope !301, !noalias !302
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !481
  store float %100, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !481, !tbaa !299, !alias.scope !301, !noalias !302
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !481
  store float %.sroa.7641.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !481, !tbaa !299, !alias.scope !301, !noalias !302
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !481
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !481, !tbaa !299, !alias.scope !301, !noalias !302
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !481
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !481, !tbaa !299, !alias.scope !301, !noalias !302
  %133 = add i64 %.fr783, -1, !dbg !492
  %root_phi7.size.0.copyload = load i64, ptr %root_phi7.size_ptr, align 8, !dbg !496, !tbaa !235, !alias.scope !326, !noalias !327
  %.not436 = icmp ult i64 %133, %root_phi7.size.0.copyload, !dbg !492
  br i1 %.not436, label %L327, label %L324, !dbg !492

L324:                                             ; preds = %L269
  store i64 %.fr783, ptr %"new::Tuple274", align 8, !dbg !492, !tbaa !299, !alias.scope !301, !noalias !302
  call swiftcc void @j_throw_boundserror_9362(ptr nonnull swiftself %pgcstack, ptr %9, ptr nocapture nonnull readonly %"new::Tuple274") #9, !dbg !492
  unreachable, !dbg !492

L327:                                             ; preds = %L269
  %root_phi6.state = load atomic ptr, ptr %7 unordered, align 8, !dbg !497, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !318, !align !319
  %memoryref_data53 = load ptr, ptr %9, align 8, !dbg !501, !tbaa !336, !alias.scope !339, !noalias !340
  %134 = getelementptr i8, ptr %memoryref_data53, i64 %memoryref_offset, !dbg !501
  %memoryref_data61 = getelementptr i8, ptr %134, i64 -4, !dbg !501
  %135 = load float, ptr %memoryref_data61, align 4, !dbg !501, !tbaa !344, !alias.scope !184, !noalias !185
  %136 = fpext float %.sroa.7641.0 to double, !dbg !502
  %gc_slot_addr_7945 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %root_phi6.state, ptr %gc_slot_addr_7945, align 8
  %137 = call swiftcc double @"j_#power_by_squaring#401_9356"(ptr nonnull swiftself %pgcstack, double %136, i64 signext 2), !dbg !509
  %root_phi6.state.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state, i64 16, !dbg !496
  %root_phi6.state.size.0.copyload = load i64, ptr %root_phi6.state.size_ptr, align 8, !dbg !496, !tbaa !235, !alias.scope !326, !noalias !327
  %.not437 = icmp ult i64 %133, %root_phi6.state.size.0.copyload, !dbg !492
  br i1 %.not437, label %L352, label %L349, !dbg !492

L349:                                             ; preds = %L327
  store i64 %.fr783, ptr %"new::Tuple272", align 8, !dbg !492, !tbaa !299, !alias.scope !301, !noalias !302
  store ptr %root_phi6.state, ptr %gc_slot_addr_7945, align 8
  call swiftcc void @j_throw_boundserror_9362(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state, ptr nocapture nonnull readonly %"new::Tuple272") #9, !dbg !492
  unreachable, !dbg !492

L352:                                             ; preds = %L327
  %138 = fptrunc double %137 to float, !dbg !512
  %memoryref_data63 = load ptr, ptr %root_phi6.state, align 8, !dbg !501, !tbaa !336, !alias.scope !339, !noalias !340
  %139 = getelementptr i8, ptr %memoryref_data63, i64 %memoryref_offset, !dbg !501
  %memoryref_data71 = getelementptr i8, ptr %139, i64 -4, !dbg !501
  %140 = load float, ptr %memoryref_data71, align 4, !dbg !501, !tbaa !344, !alias.scope !184, !noalias !185
  %141 = fpext float %140 to double, !dbg !502
  store ptr null, ptr %gc_slot_addr_7945, align 8
  %142 = call swiftcc double @"j_#power_by_squaring#401_9356"(ptr nonnull swiftself %pgcstack, double %141, i64 signext 2), !dbg !509
  %143 = fptrunc double %142 to float, !dbg !512
  %144 = fsub float %138, %143, !dbg !517
  %145 = fmul float %135, 0.000000e+00, !dbg !518
  %146 = fmul float %145, %144, !dbg !518
  %147 = fadd float %146, 0.000000e+00, !dbg !521
  store ptr %7, ptr %0, align 8, !dbg !478
  store ptr %15, ptr %1, align 8, !dbg !478
  store ptr %17, ptr %87, align 8, !dbg !478
  store ptr %19, ptr %88, align 8, !dbg !478
  store ptr %21, ptr %89, align 8, !dbg !478
  store ptr %23, ptr %90, align 8, !dbg !478
  %148 = call swiftcc float @"j_#calculate##0_9357"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %0, float %147, ptr nocapture nonnull readonly %86, ptr nocapture nonnull readonly %1), !dbg !478
  %149 = fneg float %.unbox73, !dbg !522
  %.not438 = icmp ult i64 %133, %.sroa.0423.sroa.10.0.copyload660, !dbg !523
  br i1 %.not438, label %L410, label %L407, !dbg !529

L407:                                             ; preds = %L352
  %150 = getelementptr inbounds ptr, ptr %gcframe2, i64 8
  store i64 %.fr783, ptr %"new::Tuple74", align 1, !dbg !469, !tbaa !299, !alias.scope !301, !noalias !302
  store ptr %25, ptr %150, align 8, !dbg !529
  call swiftcc void @j_throw_boundserror_9363(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.0423.sroa.9.0..sroa_idx658, ptr nocapture nonnull readonly %150, ptr nocapture nonnull readonly %"new::Tuple74") #9, !dbg !529
  unreachable, !dbg !529

L410:                                             ; preds = %L352
  %root_phi6.state72 = load atomic ptr, ptr %7 unordered, align 8, !dbg !530, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !318, !align !319
  %root_phi6.state72.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state72, i64 16, !dbg !532
  %root_phi6.state72.size.0.copyload = load i64, ptr %root_phi6.state72.size_ptr, align 8, !dbg !532, !tbaa !235, !alias.scope !326, !noalias !327
  %.not439 = icmp ult i64 %133, %root_phi6.state72.size.0.copyload, !dbg !533
  br i1 %.not439, label %L427, label %L424, !dbg !533

L424:                                             ; preds = %L410
  store i64 %.fr783, ptr %"new::Tuple269", align 8, !dbg !533, !tbaa !299, !alias.scope !301, !noalias !302
  store ptr %root_phi6.state72, ptr %gc_slot_addr_7945, align 8
  call swiftcc void @j_throw_boundserror_9362(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state72, ptr nocapture nonnull readonly %"new::Tuple269") #9, !dbg !533
  unreachable, !dbg !533

L427:                                             ; preds = %L410
  %root_phi15.x = load float, ptr %25, align 4, !dbg !534, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data77 = load ptr, ptr %root_phi6.state72, align 8, !dbg !538, !tbaa !336, !alias.scope !339, !noalias !340
  %151 = getelementptr i8, ptr %memoryref_data77, i64 %memoryref_offset, !dbg !538
  %memoryref_data85 = getelementptr i8, ptr %151, i64 -4, !dbg !538
  %152 = load float, ptr %memoryref_data85, align 4, !dbg !538, !tbaa !344, !alias.scope !184, !noalias !185
  %153 = fsub float %.sroa.7641.0, %152, !dbg !539
  %154 = fmul float %root_phi15.x, %149, !dbg !540
  %155 = fmul float %154, %153, !dbg !540
  %156 = fadd float %148, %155, !dbg !521
  %157 = fcmp ugt float %156, 0.000000e+00, !dbg !542
  br i1 %157, label %L442, label %L559, !dbg !544

L442:                                             ; preds = %L427
  %root_phi26.idxF = load i64, ptr %root_phi26.idxF_ptr278, align 8, !dbg !545, !tbaa !198, !alias.scope !184, !noalias !185
  %.not440 = icmp eq i64 %root_phi26.idxF, 1002, !dbg !558
  br i1 %.not440, label %L445, label %L447, !dbg !547

L445:                                             ; preds = %L442
  %158 = call swiftcc i64 @j_gen_rand_9360(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !547
  %root_phi26.idxF245.pre = load i64, ptr %root_phi26.idxF_ptr278, align 8, !dbg !559, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L447, !dbg !547

L447:                                             ; preds = %L445, %L442
  %root_phi26.idxF245 = phi i64 [ %root_phi26.idxF, %L442 ], [ %root_phi26.idxF245.pre, %L445 ], !dbg !559
  %root_phi26.vals = load atomic ptr, ptr %root_phi26.vals_ptr280 unordered, align 8, !dbg !559, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !318, !align !319
  %159 = add i64 %root_phi26.idxF245, 1, !dbg !564
  store i64 %159, ptr %root_phi26.idxF_ptr278, align 8, !dbg !565, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data248 = load ptr, ptr %root_phi26.vals, align 8, !dbg !566, !tbaa !336, !alias.scope !339, !noalias !340
  %memoryref_byteoffset251 = shl i64 %root_phi26.idxF245, 3, !dbg !566
  %memoryref_data256 = getelementptr inbounds i8, ptr %memoryref_data248, i64 %memoryref_byteoffset251, !dbg !566
  %160 = load i64, ptr %memoryref_data256, align 8, !dbg !566, !tbaa !344, !alias.scope !184, !noalias !185
  %161 = trunc i64 %160 to i32, !dbg !567
  %162 = and i32 %161, 8388607, !dbg !568
  %163 = or disjoint i32 %162, 1065353216, !dbg !569
  %bitcast_coercion257 = bitcast i32 %163 to float, !dbg !570
  %164 = fadd float %bitcast_coercion257, -1.000000e+00, !dbg !571
  %165 = fneg float %156, !dbg !573
  %166 = fdiv float %165, %.unbox258, !dbg !574
  %167 = fmul float %166, 0x3FF7154760000000, !dbg !576
  %168 = call float @llvm.rint.f32(float %167), !dbg !582
  %169 = fptosi float %168 to i32, !dbg !586
  %170 = freeze i32 %169, !dbg !586
  %171 = fmul contract float %168, 0x3FE62E4000000000, !dbg !589
  %172 = fsub contract float %166, %171, !dbg !589
  %173 = fmul contract float %168, 0x3EB7F7D1C0000000, !dbg !592
  %174 = fsub contract float %172, %173, !dbg !592
  %175 = fmul contract float %174, 0x3F2A1D7140000000, !dbg !594
  %176 = fadd contract float %175, 0x3F56DA7560000000, !dbg !594
  %177 = fmul contract float %174, %176, !dbg !594
  %178 = fadd contract float %177, 0x3F811105C0000000, !dbg !594
  %179 = fmul contract float %174, %178, !dbg !594
  %180 = fadd contract float %179, 0x3FA5554640000000, !dbg !594
  %181 = fmul contract float %174, %180, !dbg !594
  %182 = fadd contract float %181, 0x3FC5555560000000, !dbg !594
  %183 = fmul contract float %174, %182, !dbg !594
  %184 = fadd contract float %183, 5.000000e-01, !dbg !594
  %185 = fmul contract float %174, %184, !dbg !594
  %186 = fadd contract float %185, 1.000000e+00, !dbg !594
  %187 = fmul contract float %174, %186, !dbg !594
  %188 = fadd contract float %187, 1.000000e+00, !dbg !594
  %189 = fcmp ule float %166, 0x40562E4300000000, !dbg !602
  br i1 %189, label %L506, label %L557, !dbg !604

L506:                                             ; preds = %L447
  %190 = fcmp uge float %166, 0xC059FE3680000000, !dbg !605
  br i1 %190, label %L550, label %L557, !dbg !606

L550:                                             ; preds = %L506
  %191 = fcmp ugt float %166, 0xC055D58A00000000, !dbg !607
  %192 = fmul float %188, 0x3E70000000000000, !dbg !608
  %value_phi261 = select i1 %191, float %188, float %192, !dbg !608
  %.not441 = icmp eq i32 %170, 128, !dbg !609
  %193 = fmul float %value_phi261, 2.000000e+00, !dbg !611
  %value_phi263 = select i1 %.not441, float %193, float %value_phi261, !dbg !611
  %value_phi260.v = select i1 %191, i32 127, i32 151, !dbg !608
  %value_phi260 = add i32 %170, %value_phi260.v, !dbg !608
  %194 = sext i1 %.not441 to i32, !dbg !611
  %value_phi262 = add i32 %value_phi260, %194, !dbg !611
  %195 = shl i32 %value_phi262, 23, !dbg !612
  %bitcast_coercion266 = bitcast i32 %195 to float, !dbg !618
  %196 = fmul float %value_phi263, %bitcast_coercion266, !dbg !619
  br label %L557, !dbg !454

L557:                                             ; preds = %L550, %L506, %L447
  %value_phi259 = phi float [ %196, %L550 ], [ 0x7FF0000000000000, %L447 ], [ 0.000000e+00, %L506 ]
  %197 = fcmp olt float %164, %value_phi259, !dbg !620
  br i1 %197, label %L559, label %guard_pass361, !dbg !544

L559:                                             ; preds = %L557, %L427
  %root_phi25.state87 = load atomic ptr, ptr %45 unordered, align 8, !dbg !621, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !318, !align !319
  %root_phi25.state87.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state87, i64 16, !dbg !627
  %root_phi25.state87.size.0.copyload = load i64, ptr %root_phi25.state87.size_ptr, align 8, !dbg !627, !tbaa !235, !alias.scope !326, !noalias !327
  %.not442 = icmp eq i64 %root_phi25.state87.size.0.copyload, 100000, !dbg !629
  br i1 %.not442, label %guard_pass356, label %L567, !dbg !628

L567:                                             ; preds = %L559
  call swiftcc void @j_throw_dmrsa_9353(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state87.size.0.copyload) #9, !dbg !631
  unreachable, !dbg !631

L655:                                             ; preds = %pass108
  store i64 %.fr783, ptr %"new::Tuple74", align 1, !dbg !469, !tbaa !299, !alias.scope !301, !noalias !302
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6594, i64 7, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.6", i64 56, i1 false), !dbg !233
  br label %L666, !dbg !233

L656:                                             ; preds = %pass108
  %.not445.not.not = icmp eq i64 %value_phi5517, %value_phi, !dbg !632
  br i1 %.not445.not.not, label %L661.L666_crit_edge, label %L665, !dbg !455

L661.L666_crit_edge:                              ; preds = %L656
  store i64 %.fr783, ptr %"new::Tuple74", align 1, !dbg !469, !tbaa !299, !alias.scope !301, !noalias !302
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6594, i64 7, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.6", i64 56, i1 false), !dbg !233
  br label %L666, !dbg !233

L665:                                             ; preds = %L656
  %198 = add i64 %value_phi5517, 1, !dbg !454
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !226
  store i64 %78, ptr %.sroa.0423.sroa.8.0..sroa_idx655, align 8, !dbg !226
  store i64 %79, ptr %.sroa.0423.sroa.9.0..sroa_idx658, align 8, !dbg !226
  store i64 %.sroa.0423.sroa.10.0.copyload660, ptr %.sroa.0423.sroa.10.0..sroa_idx661, align 8, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0423.sroa.11.0..sroa_idx663, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0423.sroa.12.0..sroa_idx664, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0423.sroa.13.0..sroa_idx665, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !226
  store i64 %80, ptr %.sroa.0423.sroa.14.0..sroa_idx667, align 8, !dbg !226
  store i64 %81, ptr %.sroa.0423.sroa.15.0..sroa_idx670, align 8, !dbg !226
  store i64 %82, ptr %.sroa.0423.sroa.16.0..sroa_idx673, align 8, !dbg !226
  store i64 %75, ptr %.sroa.0423.sroa.17.0..sroa_idx676, align 8, !dbg !226
  store i64 %.fr783, ptr %.sroa.0423.sroa.19.0..sroa_idx682, align 8, !dbg !226
  store float %100, ptr %.sroa.0423.sroa.20.0..sroa_idx685, align 8, !dbg !226
  store float %.sroa.7641.0, ptr %.sroa.0423.sroa.21.0..sroa_idx688, align 4, !dbg !226
  store i64 1, ptr %.sroa.0423.sroa.22.0..sroa_idx691, align 8, !dbg !226
  store i8 %.sroa.9.0, ptr %.sroa.0423.sroa.23.0..sroa_idx694, align 8, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0423.sroa.24.0..sroa_idx696, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6594, i64 7, i1 false), !dbg !226
  store float %156, ptr %.sroa.6424.0..sroa_idx, align 8, !dbg !226
  store i32 %.sroa.7426.0.copyload427, ptr %.sroa.7426.0..sroa_idx, align 4, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8428.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.6", i64 56, i1 false), !dbg !226
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !297, !tbaa !299, !alias.scope !301, !noalias !302
  %.unbox = load i64, ptr %74, align 8, !dbg !297, !tbaa !299, !alias.scope !301, !noalias !302
  %.not = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !297
  br i1 %.not, label %L63, label %L66, !dbg !280

L666:                                             ; preds = %L661.L666_crit_edge, %L655, %L31.L666_crit_edge
  %.sroa.0.sroa.8.0 = phi i64 [ %.sroa.0.sroa.8.0.copyload, %L31.L666_crit_edge ], [ %78, %L661.L666_crit_edge ], [ %78, %L655 ], !dbg !233
  %.sroa.0.sroa.9.0 = phi i64 [ %.sroa.0.sroa.9.0.copyload, %L31.L666_crit_edge ], [ %79, %L661.L666_crit_edge ], [ %79, %L655 ], !dbg !233
  %.sroa.0.sroa.10.0 = phi i64 [ %.sroa.0.sroa.10.0.copyload, %L31.L666_crit_edge ], [ %.sroa.0423.sroa.10.0.copyload660, %L661.L666_crit_edge ], [ %.sroa.0423.sroa.10.0.copyload660, %L655 ], !dbg !233
  %.sroa.0.sroa.14.0 = phi i64 [ %.sroa.0.sroa.14.0.copyload, %L31.L666_crit_edge ], [ %80, %L661.L666_crit_edge ], [ %80, %L655 ], !dbg !233
  %.sroa.0.sroa.15.0 = phi i64 [ %.sroa.0.sroa.15.0.copyload, %L31.L666_crit_edge ], [ %81, %L661.L666_crit_edge ], [ %81, %L655 ], !dbg !233
  %.sroa.0.sroa.16.0 = phi i64 [ %.sroa.0.sroa.16.0.copyload, %L31.L666_crit_edge ], [ %82, %L661.L666_crit_edge ], [ %82, %L655 ], !dbg !233
  %.sroa.0.sroa.17.0 = phi i64 [ %.sroa.0.sroa.17.0.copyload, %L31.L666_crit_edge ], [ %75, %L661.L666_crit_edge ], [ %75, %L655 ], !dbg !233
  %.sroa.0.sroa.18.sroa.0.0 = phi i64 [ %.sroa.0.sroa.18.sroa.0.0.copyload, %L31.L666_crit_edge ], [ undef, %L661.L666_crit_edge ], [ undef, %L655 ], !dbg !233
  %.sroa.0.sroa.18.sroa.8.0 = phi i64 [ %.sroa.0.sroa.18.sroa.8.0.copyload, %L31.L666_crit_edge ], [ %.fr783, %L661.L666_crit_edge ], [ %.fr783, %L655 ], !dbg !233
  %.sroa.0.sroa.18.sroa.10.0 = phi float [ %.sroa.0.sroa.18.sroa.10.0.copyload, %L31.L666_crit_edge ], [ %100, %L661.L666_crit_edge ], [ %100, %L655 ], !dbg !233
  %.sroa.0.sroa.18.sroa.12.0 = phi float [ %.sroa.0.sroa.18.sroa.12.0.copyload, %L31.L666_crit_edge ], [ %.sroa.7641.0, %L661.L666_crit_edge ], [ %.sroa.7641.0, %L655 ], !dbg !233
  %.sroa.0.sroa.18.sroa.14.0 = phi i64 [ %.sroa.0.sroa.18.sroa.14.0.copyload, %L31.L666_crit_edge ], [ 1, %L661.L666_crit_edge ], [ 1, %L655 ], !dbg !233
  %.sroa.0.sroa.18.sroa.16.0 = phi i8 [ %.sroa.0.sroa.18.sroa.16.0.copyload, %L31.L666_crit_edge ], [ %.sroa.9.0, %L661.L666_crit_edge ], [ %.sroa.9.0, %L655 ], !dbg !233
  %.sroa.8.0 = phi float [ %.sroa.8.0.copyload, %L31.L666_crit_edge ], [ %156, %L661.L666_crit_edge ], [ %156, %L655 ], !dbg !233
  %.sroa.10.0 = phi i32 [ %.sroa.10.0.copyload, %L31.L666_crit_edge ], [ %.sroa.7426.0.copyload427, %L661.L666_crit_edge ], [ %.sroa.7426.0.copyload427, %L655 ], !dbg !233
  %199 = call i64 @jlplt_ijl_hrtime_9348_got.jit(), !dbg !633
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 520, !dbg !639
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528, !dbg !639
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !639, !tbaa !198, !alias.scope !184, !noalias !185
  store i64 %199, ptr %"process::Process.endtime_ptr", align 8, !dbg !639, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !640
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !640, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !641
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !641, !tbaa !303, !range !645
  %200 = and i64 %"process::Process.task.tag", -16, !dbg !641
  %201 = inttoptr i64 %200 to ptr, !dbg !641
  %exactly_isa.not.not = icmp eq ptr %201, @"+Core.Nothing#9358.jit", !dbg !641
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 497, !dbg !641
  %202 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !641
  %203 = and i8 %202, 1, !dbg !644
  %204 = icmp eq i8 %203, 0, !dbg !644
  %.not449 = select i1 %exactly_isa.not.not, i1 true, i1 %204, !dbg !644
  br i1 %.not449, label %L723, label %L702, !dbg !644

L702:                                             ; preds = %L666
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !646
  %ptls_load967 = load ptr, ptr %ptls_field, align 8, !dbg !646, !tbaa !156
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load967, i32 1120, i32 400, i64 4514070544) #23, !dbg !646
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !646
  store atomic i64 4514070544, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !646, !tbaa !303
  store atomic ptr %5, ptr %"box::ProcessContext" unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %205 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !646
  store atomic ptr %7, ptr %205 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %206 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !646
  store atomic ptr %9, ptr %206 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %207 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !646
  store atomic ptr %11, ptr %207 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %208 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !646
  store atomic ptr %13, ptr %208 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %209 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !646
  %.sroa.0381.sroa.0.40.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.0, i64 40, !dbg !646
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %209, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0381.sroa.0.40.sroa_idx, i64 16, i1 false), !dbg !646
  %210 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !646
  store atomic ptr %15, ptr %210 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %211 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !646
  store atomic ptr %17, ptr %211 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %212 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !646
  store atomic ptr %19, ptr %212 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %213 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !646
  store atomic ptr %21, ptr %213 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %214 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !646
  store atomic ptr %23, ptr %214 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %215 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !646
  store i64 %.sroa.0.sroa.8.0, ptr %215, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %216 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !646
  store atomic ptr %25, ptr %216 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %217 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !646
  store i64 %.sroa.0.sroa.10.0, ptr %217, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %218 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !646
  store atomic ptr %27, ptr %218 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %219 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !646
  store atomic ptr %29, ptr %219 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %220 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !646
  %.sroa.0381.sroa.10.136.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.11, i64 16, !dbg !646
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %220, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0381.sroa.10.136.sroa_idx, i64 16, i1 false), !dbg !646
  %221 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !646
  store atomic ptr %31, ptr %221 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %222 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !646
  store atomic ptr %33, ptr %222 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %223 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !646
  store atomic ptr %35, ptr %223 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %224 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !646
  store atomic ptr %37, ptr %224 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %225 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !646
  store atomic ptr %39, ptr %225 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %226 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !646
  %.sroa.0381.sroa.12.192.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.12, i64 40, !dbg !646
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %226, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0381.sroa.12.192.sroa_idx, i64 24, i1 false), !dbg !646
  %227 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !646
  store atomic ptr %41, ptr %227 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %228 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !646
  %.sroa.0381.sroa.14.224.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.13, i64 8, !dbg !646
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %228, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0381.sroa.14.224.sroa_idx, i64 24, i1 false), !dbg !646
  %229 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !646
  store atomic ptr %43, ptr %229 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %230 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !646
  store i64 %.sroa.0.sroa.15.0, ptr %230, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %231 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !646
  store atomic ptr %45, ptr %231 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %232 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !646
  store i64 %.sroa.0.sroa.17.0, ptr %232, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %233 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !646
  store atomic ptr %47, ptr %233 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %234 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !646
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %234, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %.sroa.0381.sroa.22.sroa.6.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 296, !dbg !646
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0381.sroa.22.sroa.6.8..sroa_idx, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %.sroa.0381.sroa.22.sroa.7.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 300, !dbg !646
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0381.sroa.22.sroa.7.8..sroa_idx, align 4, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %.sroa.0381.sroa.22.sroa.8.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 304, !dbg !646
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %.sroa.0381.sroa.22.sroa.8.8..sroa_idx, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %.sroa.0381.sroa.22.sroa.9.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 312, !dbg !646
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0381.sroa.22.sroa.9.8..sroa_idx, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %.sroa.0381.sroa.22.sroa.10.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 313, !dbg !646
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0381.sroa.22.sroa.10.8..sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !646
  %.sroa.15.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 320, !dbg !646
  store float %.sroa.8.0, ptr %.sroa.15.288..sroa_idx, align 8, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %.sroa.16.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 324, !dbg !646
  store i32 %.sroa.10.0, ptr %.sroa.16.288..sroa_idx, align 4, !dbg !646, !tbaa !235, !alias.scope !489, !noalias !490
  %235 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !646
  store atomic ptr %49, ptr %235 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %236 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !646
  store atomic ptr %51, ptr %236 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %237 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !646
  store atomic ptr %53, ptr %237 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %238 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !646
  store atomic ptr %55, ptr %238 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %239 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !646
  store atomic ptr %57, ptr %239 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %240 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !646
  store atomic ptr %59, ptr %240 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  %241 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !646
  store atomic ptr %61, ptr %241 unordered, align 8, !dbg !646, !tbaa !305, !alias.scope !184, !noalias !185
  store atomic ptr %"box::ProcessContext", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !646, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !646
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !646, !tbaa !303, !range !645
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !646
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !646
  br i1 %parent_old_marked, label %may_trigger_wb, label %242, !dbg !646

may_trigger_wb:                                   ; preds = %L702
  %"box::ProcessContext.tag" = load atomic volatile i64, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !646, !tbaa !303, !range !645
  %child_bit = and i64 %"box::ProcessContext.tag", 1, !dbg !646
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !646
  br i1 %child_not_marked, label %trigger_wb, label %242, !dbg !646, !prof !652

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !646
  br label %242, !dbg !646

242:                                              ; preds = %may_trigger_wb, %trigger_wb, %L702
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0404.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0404.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0404.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0404.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0404.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8410, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, i64 56, i1 false), !dbg !233
  br label %L733, !dbg !233

L723:                                             ; preds = %L666
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !233
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !653
  %243 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %244 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !653
  %245 = load atomic ptr, ptr %244 unordered, align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %246 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !653
  %247 = load atomic ptr, ptr %246 unordered, align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %248 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !653
  %249 = load atomic ptr, ptr %248 unordered, align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %250 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !653
  %251 = load atomic ptr, ptr %250 unordered, align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %252 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !653
  %253 = load atomic ptr, ptr %252 unordered, align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %254 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !659
  store atomic ptr %5, ptr %254 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %255 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !659
  store atomic ptr %7, ptr %255 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %256 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !659
  store atomic ptr %9, ptr %256 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %257 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !659
  store atomic ptr %11, ptr %257 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %258 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !659
  store atomic ptr %13, ptr %258 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %259 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !659
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", i64 40, !dbg !659
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %259, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %260 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !659
  store atomic ptr %15, ptr %260 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %261 = getelementptr inbounds i8, ptr %"process::Process", i64 120, !dbg !659
  store atomic ptr %17, ptr %261 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %262 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !659
  store atomic ptr %19, ptr %262 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %263 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !659
  store atomic ptr %21, ptr %263 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %264 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !659
  store atomic ptr %23, ptr %264 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %265 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !659
  store i64 %.sroa.0.sroa.8.0, ptr %265, align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %266 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !659
  store atomic ptr %25, ptr %266 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %267 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !659
  store i64 %.sroa.0.sroa.10.0, ptr %267, align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %268 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !659
  store atomic ptr %27, ptr %268 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %269 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !659
  store atomic ptr %29, ptr %269 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %270 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !659
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", i64 16, !dbg !659
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %270, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx", i64 16, i1 false), !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %271 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !659
  store atomic ptr %31, ptr %271 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %272 = getelementptr inbounds i8, ptr %"process::Process", i64 216, !dbg !659
  store atomic ptr %33, ptr %272 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %273 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !659
  store atomic ptr %35, ptr %273 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %274 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !659
  store atomic ptr %37, ptr %274 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %275 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !659
  store atomic ptr %39, ptr %275 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %276 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !659
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", i64 40, !dbg !659
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %276, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx", i64 24, i1 false), !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %277 = getelementptr inbounds i8, ptr %"process::Process", i64 272, !dbg !659
  store atomic ptr %41, ptr %277 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %278 = getelementptr inbounds i8, ptr %"process::Process", i64 280, !dbg !659
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", i64 8, !dbg !659
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %278, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx", i64 24, i1 false), !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %279 = getelementptr inbounds i8, ptr %"process::Process", i64 304, !dbg !659
  store atomic ptr %43, ptr %279 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %280 = getelementptr inbounds i8, ptr %"process::Process", i64 312, !dbg !659
  store i64 %.sroa.0.sroa.15.0, ptr %280, align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %281 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !659
  store atomic ptr %45, ptr %281 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %282 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !659
  store i64 %.sroa.0.sroa.17.0, ptr %282, align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %283 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !659
  store atomic ptr %47, ptr %283 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %284 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !659
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %284, align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !659
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx", align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 356, !dbg !659
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx", align 4, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !659
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx", align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !659
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx", align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 369, !dbg !659
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !659
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !659
  store float %.sroa.8.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 380, !dbg !659
  store i32 %.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !659, !tbaa !235, !alias.scope !489, !noalias !490
  %285 = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !659
  store atomic ptr %49, ptr %285 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %286 = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !659
  store atomic ptr %51, ptr %286 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %287 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !659
  store atomic ptr %53, ptr %287 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %288 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !659
  store atomic ptr %55, ptr %288 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %289 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !659
  store atomic ptr %57, ptr %289 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %290 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !659
  store atomic ptr %59, ptr %290 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %291 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !659
  store atomic ptr %61, ptr %291 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  store atomic ptr %253, ptr %252 unordered, align 8, !dbg !659, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.tag_addr969" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !659
  %"process::Process.tag970" = load atomic volatile i64, ptr %"process::Process.tag_addr969" unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %parent_bits971 = and i64 %"process::Process.tag970", 3, !dbg !659
  %parent_old_marked972 = icmp eq i64 %parent_bits971, 3, !dbg !659
  br i1 %parent_old_marked972, label %may_trigger_wb973, label %327, !dbg !659

may_trigger_wb973:                                ; preds = %L723
  %.tag_addr = getelementptr inbounds i64, ptr %243, i64 -1, !dbg !659
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %.tag_addr976 = getelementptr inbounds i64, ptr %245, i64 -1, !dbg !659
  %.tag977 = load atomic volatile i64, ptr %.tag_addr976 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %292 = and i64 %.tag, %.tag977, !dbg !659
  %.tag_addr980 = getelementptr inbounds i64, ptr %247, i64 -1, !dbg !659
  %.tag981 = load atomic volatile i64, ptr %.tag_addr980 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %293 = and i64 %292, %.tag981, !dbg !659
  %.tag_addr984 = getelementptr inbounds i64, ptr %249, i64 -1, !dbg !659
  %.tag985 = load atomic volatile i64, ptr %.tag_addr984 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %294 = and i64 %293, %.tag985, !dbg !659
  %.tag_addr988 = getelementptr inbounds i64, ptr %251, i64 -1, !dbg !659
  %.tag989 = load atomic volatile i64, ptr %.tag_addr988 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %295 = and i64 %294, %.tag989, !dbg !659
  %.tag_addr992 = getelementptr inbounds i64, ptr %5, i64 -1, !dbg !659
  %.tag993 = load atomic volatile i64, ptr %.tag_addr992 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %296 = and i64 %295, %.tag993, !dbg !659
  %.tag_addr996 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !659
  %.tag997 = load atomic volatile i64, ptr %.tag_addr996 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %297 = and i64 %296, %.tag997, !dbg !659
  %.tag_addr1000 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !659
  %.tag1001 = load atomic volatile i64, ptr %.tag_addr1000 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %298 = and i64 %297, %.tag1001, !dbg !659
  %.tag_addr1004 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !659
  %.tag1005 = load atomic volatile i64, ptr %.tag_addr1004 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %299 = and i64 %298, %.tag1005, !dbg !659
  %.tag_addr1008 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !659
  %.tag1009 = load atomic volatile i64, ptr %.tag_addr1008 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %300 = and i64 %299, %.tag1009, !dbg !659
  %.tag_addr1012 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !659
  %.tag1013 = load atomic volatile i64, ptr %.tag_addr1012 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %301 = and i64 %300, %.tag1013, !dbg !659
  %.tag_addr1016 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !659
  %.tag1017 = load atomic volatile i64, ptr %.tag_addr1016 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %302 = and i64 %301, %.tag1017, !dbg !659
  %.tag_addr1020 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !659
  %.tag1021 = load atomic volatile i64, ptr %.tag_addr1020 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %303 = and i64 %302, %.tag1021, !dbg !659
  %.tag_addr1024 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !659
  %.tag1025 = load atomic volatile i64, ptr %.tag_addr1024 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %304 = and i64 %303, %.tag1025, !dbg !659
  %.tag_addr1028 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !659
  %.tag1029 = load atomic volatile i64, ptr %.tag_addr1028 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %305 = and i64 %304, %.tag1029, !dbg !659
  %.tag_addr1032 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !659
  %.tag1033 = load atomic volatile i64, ptr %.tag_addr1032 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %306 = and i64 %305, %.tag1033, !dbg !659
  %.tag_addr1036 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !659
  %.tag1037 = load atomic volatile i64, ptr %.tag_addr1036 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %307 = and i64 %306, %.tag1037, !dbg !659
  %.tag_addr1040 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !659
  %.tag1041 = load atomic volatile i64, ptr %.tag_addr1040 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %308 = and i64 %307, %.tag1041, !dbg !659
  %.tag_addr1044 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !659
  %.tag1045 = load atomic volatile i64, ptr %.tag_addr1044 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %309 = and i64 %308, %.tag1045, !dbg !659
  %.tag_addr1048 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !659
  %.tag1049 = load atomic volatile i64, ptr %.tag_addr1048 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %310 = and i64 %309, %.tag1049, !dbg !659
  %.tag_addr1052 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !659
  %.tag1053 = load atomic volatile i64, ptr %.tag_addr1052 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %311 = and i64 %310, %.tag1053, !dbg !659
  %.tag_addr1056 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !659
  %.tag1057 = load atomic volatile i64, ptr %.tag_addr1056 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %312 = and i64 %311, %.tag1057, !dbg !659
  %.tag_addr1060 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !659
  %.tag1061 = load atomic volatile i64, ptr %.tag_addr1060 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %313 = and i64 %312, %.tag1061, !dbg !659
  %.tag_addr1064 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !659
  %.tag1065 = load atomic volatile i64, ptr %.tag_addr1064 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %314 = and i64 %313, %.tag1065, !dbg !659
  %.tag_addr1068 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !659
  %.tag1069 = load atomic volatile i64, ptr %.tag_addr1068 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %315 = and i64 %314, %.tag1069, !dbg !659
  %.tag_addr1072 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !659
  %.tag1073 = load atomic volatile i64, ptr %.tag_addr1072 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %316 = and i64 %315, %.tag1073, !dbg !659
  %.tag_addr1076 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !659
  %.tag1077 = load atomic volatile i64, ptr %.tag_addr1076 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %317 = and i64 %316, %.tag1077, !dbg !659
  %.tag_addr1080 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !659
  %.tag1081 = load atomic volatile i64, ptr %.tag_addr1080 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %318 = and i64 %317, %.tag1081, !dbg !659
  %.tag_addr1084 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !659
  %.tag1085 = load atomic volatile i64, ptr %.tag_addr1084 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %319 = and i64 %318, %.tag1085, !dbg !659
  %.tag_addr1088 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !659
  %.tag1089 = load atomic volatile i64, ptr %.tag_addr1088 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %320 = and i64 %319, %.tag1089, !dbg !659
  %.tag_addr1092 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !659
  %.tag1093 = load atomic volatile i64, ptr %.tag_addr1092 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %321 = and i64 %320, %.tag1093, !dbg !659
  %.tag_addr1096 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !659
  %.tag1097 = load atomic volatile i64, ptr %.tag_addr1096 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %322 = and i64 %321, %.tag1097, !dbg !659
  %.tag_addr1100 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !659
  %.tag1101 = load atomic volatile i64, ptr %.tag_addr1100 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %323 = and i64 %322, %.tag1101, !dbg !659
  %.tag_addr1104 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !659
  %.tag1105 = load atomic volatile i64, ptr %.tag_addr1104 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %324 = and i64 %323, %.tag1105, !dbg !659
  %.tag_addr1108 = getelementptr inbounds i64, ptr %253, i64 -1, !dbg !659
  %.tag1109 = load atomic volatile i64, ptr %.tag_addr1108 unordered, align 8, !dbg !659, !tbaa !303, !range !645
  %325 = and i64 %324, %.tag1109, !dbg !659
  %326 = and i64 %325, 1, !dbg !659
  %.not3.not = icmp eq i64 %326, 0, !dbg !659
  br i1 %.not3.not, label %trigger_wb1112, label %327, !dbg !659, !prof !652

trigger_wb1112:                                   ; preds = %may_trigger_wb973
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !659
  br label %327, !dbg !659

327:                                              ; preds = %may_trigger_wb973, %trigger_wb1112, %L723
  %"process::Process.runtime_context_ptr238" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !661
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !661, !tbaa !169, !invariant.load !0, !alias.scope !487, !noalias !488, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr238" release, align 8, !dbg !661, !tbaa !198, !alias.scope !184, !noalias !185
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0404.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0404.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0404.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0404.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0404.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8410, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, i64 56, i1 false), !dbg !233
  br label %L733, !dbg !233

L733:                                             ; preds = %327, %242
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0404.sroa.0, i64 96, i1 false), !dbg !638
  %.sroa.0416.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !638
  store i64 %.sroa.0.sroa.8.0, ptr %.sroa.0416.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !638
  store i64 %.sroa.0.sroa.9.0, ptr %.sroa.0416.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !638
  store i64 %.sroa.0.sroa.10.0, ptr %.sroa.0416.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !638
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0416.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0404.sroa.12, i64 32, i1 false), !dbg !638
  %.sroa.0416.sroa.6.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !638
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0416.sroa.6.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0404.sroa.14, i64 64, i1 false), !dbg !638
  %.sroa.0416.sroa.7.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 216, !dbg !638
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0416.sroa.7.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0404.sroa.16, i64 32, i1 false), !dbg !638
  %.sroa.0416.sroa.8.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 248, !dbg !638
  store i64 %.sroa.0.sroa.14.0, ptr %.sroa.0416.sroa.8.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.9.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !638
  store i64 %.sroa.0.sroa.15.0, ptr %.sroa.0416.sroa.9.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.10.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 264, !dbg !638
  store i64 %.sroa.0.sroa.16.0, ptr %.sroa.0416.sroa.10.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.11.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !638
  store i64 %.sroa.0.sroa.17.0, ptr %.sroa.0416.sroa.11.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 280, !dbg !638
  store i64 %.sroa.0.sroa.18.sroa.0.0, ptr %.sroa.0416.sroa.12.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.sroa.2.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !638
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %.sroa.0416.sroa.12.sroa.2.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.sroa.3.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !638
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0416.sroa.12.sroa.3.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.sroa.4.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !638
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0416.sroa.12.sroa.4.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.sroa.5.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !638
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %.sroa.0416.sroa.12.sroa.5.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.sroa.6.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !638
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0416.sroa.12.sroa.6.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.0416.sroa.12.sroa.7.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !638
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0416.sroa.12.sroa.7.0..sroa.0416.sroa.12.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0404.sroa.26.sroa.11, i64 7, i1 false), !dbg !638
  %.sroa.2417.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !638
  store float %.sroa.8.0, ptr %.sroa.2417.0.sret_return.sroa_idx, align 8, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.3418.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !638
  store i32 %.sroa.10.0, ptr %.sroa.3418.0.sret_return.sroa_idx, align 4, !dbg !638, !tbaa !299, !alias.scope !301, !noalias !302
  %.sroa.4419.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !638
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.4419.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8410, i64 56, i1 false), !dbg !638
  store ptr %5, ptr %return_roots, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %328 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !638
  store ptr %7, ptr %328, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %329 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !638
  store ptr %9, ptr %329, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %330 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !638
  store ptr %11, ptr %330, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %331 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !638
  store ptr %13, ptr %331, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %332 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !638
  store ptr %15, ptr %332, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %333 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !638
  store ptr %17, ptr %333, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %334 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !638
  store ptr %19, ptr %334, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %335 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !638
  store ptr %21, ptr %335, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %336 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !638
  store ptr %23, ptr %336, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %337 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !638
  store ptr %25, ptr %337, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %338 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !638
  store ptr %27, ptr %338, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %339 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !638
  store ptr %29, ptr %339, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %340 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !638
  store ptr %31, ptr %340, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %341 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !638
  store ptr %33, ptr %341, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %342 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !638
  store ptr %35, ptr %342, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %343 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !638
  store ptr %37, ptr %343, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %344 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !638
  store ptr %39, ptr %344, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %345 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !638
  store ptr %41, ptr %345, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %346 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !638
  store ptr %43, ptr %346, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %347 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !638
  store ptr %45, ptr %347, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %348 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !638
  store ptr %47, ptr %348, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %349 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !638
  store ptr %49, ptr %349, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %350 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !638
  store ptr %51, ptr %350, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %351 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !638
  store ptr %53, ptr %351, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %352 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !638
  store ptr %55, ptr %352, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %353 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !638
  store ptr %57, ptr %353, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %354 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !638
  store ptr %59, ptr %354, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %355 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !638
  store ptr %61, ptr %355, align 8, !dbg !638, !tbaa !156, !alias.scope !161, !noalias !164
  %frame.prev1113 = load ptr, ptr %frame.prev, align 8, !tbaa !156
  store ptr %frame.prev1113, ptr %pgcstack, align 8, !tbaa !156
  ret void, !dbg !638

pass108:                                          ; preds = %guard_pass361, %guard_pass356
  %.sroa.9.0 = phi i8 [ 1, %guard_pass356 ], [ 0, %guard_pass361 ], !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6594, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !663
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10), !dbg !663
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !664
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %91, i64 80, i1 false), !dbg !664, !tbaa !299, !alias.scope !301, !noalias !302
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0423.sroa.11.0..sroa_idx663, i64 16, i1 false), !dbg !664, !tbaa !299, !alias.scope !301, !noalias !302
  %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 16, !dbg !664
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %74, i64 112, i1 false), !dbg !664, !tbaa !299, !alias.scope !301, !noalias !302
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !693
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !693
  %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 32, !dbg !693
  %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 96, !dbg !693
  store i64 1, ptr %4, align 8, !dbg !699, !tbaa !198, !alias.scope !184, !noalias !185
  %356 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !708, !tbaa !198, !alias.scope !184, !noalias !185
  %357 = add <2 x i64> %356, <i64 1, i64 1>, !dbg !713
  store <2 x i64> %357, ptr %"process::Process.loopidx_ptr", align 8, !dbg !714, !tbaa !198, !alias.scope !184, !noalias !185
  %358 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !715, !tbaa !198, !alias.scope !184, !noalias !185
  %359 = and i8 %358, 1, !dbg !715
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %359, 0, !dbg !715
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L655, label %L656, !dbg !721

guard_pass346:                                    ; preds = %L138
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !233
  store float %100, ptr %unionalloca.sroa.0, align 8, !dbg !233, !tbaa !299, !alias.scope !301, !noalias !302
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload452784 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !358
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !358
  %360 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload452784 to i32, !dbg !722
  %361 = bitcast i32 %360 to float, !dbg !722
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10647), !dbg !233
  br label %L269, !dbg !233

guard_pass351:                                    ; preds = %L223, %L221
  %value_phi298 = phi double [ %126, %L221 ], [ %spec.select368, %L223 ]
  %362 = fcmp ugt double %value_phi298, 2.000000e+00, !dbg !724
  %363 = fadd double %value_phi298, -1.000000e+00, !dbg !727
  %364 = fadd double %value_phi298, -2.000000e+00, !dbg !727
  %365 = fsub double 1.000000e+00, %364, !dbg !727
  %value_phi300 = select i1 %362, double %365, double %363, !dbg !727
  %366 = fptrunc double %value_phi300 to float, !dbg !728
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10647), !dbg !233
  br label %L269, !dbg !233

guard_pass356:                                    ; preds = %L559
  %367 = load ptr, ptr %root_phi25.state87, align 8, !dbg !730, !tbaa !336, !alias.scope !339, !noalias !340
  %368 = getelementptr i8, ptr %367, i64 %memoryref_offset, !dbg !732
  %memoryref_data104 = getelementptr i8, ptr %368, i64 -4, !dbg !732
  store float %.sroa.7641.0, ptr %memoryref_data104, align 4, !dbg !732, !tbaa !344, !alias.scope !184, !noalias !185
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !233
  br label %pass108, !dbg !233

guard_pass361:                                    ; preds = %L557
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !233, !tbaa !299, !alias.scope !301, !noalias !302
  br label %pass108, !dbg !233
}
