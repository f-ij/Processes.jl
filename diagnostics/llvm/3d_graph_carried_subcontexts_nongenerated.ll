; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x61f88dbb823b4b09ac70623e8a4028f5))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.NonGenerated)
define swiftcc void @julia_loop_11069(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [1 x ptr]], ptr }, [1 x ptr], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(384) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(232) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(560) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(432) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(384) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [18 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 144, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 11
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %2 = getelementptr inbounds ptr, ptr %gcframe2, i64 4
  %3 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.111191 = alloca [7 x i8], align 1
  %.sroa.101185 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple43" = alloca [1 x i64], align 8
  %.sroa.101174 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %4 = alloca [15 x i64], align 8
  %.sroa.01111 = alloca [10 x i64], align 8
  %.sroa.81132 = alloca [2 x i64], align 8
  %.sroa.5.sroa.0 = alloca [13 x i64], align 8
  %"new::SamplerRangeNDL148" = alloca [2 x i64], align 8
  %unionalloca176.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.101095 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1185" = alloca [5 x i64], align 8
  %"new::Tuple208" = alloca [1 x i64], align 8
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple240.sroa.0.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::SubContext241.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext243.sroa.9" = alloca [7 x i64], align 8
  %.sroa.0775.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0775.sroa.0.sroa.11 = alloca [2 x i64], align 8
  %.sroa.0775.sroa.12.sroa.0 = alloca [13 x i64], align 8
  %.sroa.0775.sroa.16.sroa.18 = alloca [7 x i8], align 1
  %.sroa.10783 = alloca [7 x i64], align 8
  %.sroa.0752.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0752.sroa.0.sroa.9 = alloca [2 x i64], align 8
  %.sroa.0752.sroa.10.sroa.0 = alloca [13 x i64], align 8
  %.sroa.0752.sroa.14.sroa.11 = alloca [7 x i8], align 1
  %.sroa.8759 = alloca [7 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0" = alloca [13 x i64], align 8
  %"new::Tuple469" = alloca [1 x i64], align 8
  %"new::Tuple472" = alloca [1 x i64], align 8
  %"new::Tuple474" = alloca [1 x i64], align 8
  %"new::Tuple542" = alloca [1 x i64], align 8
  %"new::Tuple545" = alloca [1 x i64], align 8
  %"new::Tuple547" = alloca [1 x i64], align 8
  store i64 64, ptr %gcframe2, align 8, !tbaa !156
  %task.gcstack = load ptr, ptr %pgcstack, align 8
  %frame.prev = getelementptr inbounds ptr, ptr %gcframe2, i64 1
  store ptr %task.gcstack, ptr %frame.prev, align 8, !tbaa !156
  store ptr %gcframe2, ptr %pgcstack, align 8
  call void @llvm.dbg.declare(metadata ptr %"process::Process", metadata !151, metadata !DIExpression()), !dbg !160
  %5 = getelementptr inbounds i8, ptr %.roots.algo, i64 8
  %6 = load ptr, ptr %5, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  call void @llvm.dbg.declare(metadata ptr %"algo::LoopAlgorithm", metadata !152, metadata !DIExpression()), !dbg !160
  %7 = load ptr, ptr %.roots.context, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %8 = getelementptr inbounds i8, ptr %.roots.context, i64 8
  %9 = load ptr, ptr %8, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %10 = getelementptr inbounds i8, ptr %.roots.context, i64 16
  %11 = load ptr, ptr %10, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %12 = getelementptr inbounds i8, ptr %.roots.context, i64 24
  %13 = load ptr, ptr %12, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %14 = getelementptr inbounds i8, ptr %.roots.context, i64 32
  %15 = load ptr, ptr %14, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %16 = getelementptr inbounds i8, ptr %.roots.context, i64 40
  %17 = load ptr, ptr %16, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %18 = getelementptr inbounds i8, ptr %.roots.context, i64 48
  %19 = load ptr, ptr %18, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %20 = getelementptr inbounds i8, ptr %.roots.context, i64 56
  %21 = load ptr, ptr %20, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %22 = getelementptr inbounds i8, ptr %.roots.context, i64 64
  %23 = load ptr, ptr %22, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %24 = getelementptr inbounds i8, ptr %.roots.context, i64 72
  %25 = load ptr, ptr %24, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %26 = getelementptr inbounds i8, ptr %.roots.context, i64 80
  %27 = load ptr, ptr %26, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %28 = getelementptr inbounds i8, ptr %.roots.context, i64 88
  %29 = load ptr, ptr %28, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %30 = getelementptr inbounds i8, ptr %.roots.context, i64 96
  %31 = load ptr, ptr %30, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %32 = getelementptr inbounds i8, ptr %.roots.context, i64 104
  %33 = load ptr, ptr %32, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %34 = getelementptr inbounds i8, ptr %.roots.context, i64 112
  %35 = load ptr, ptr %34, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %36 = getelementptr inbounds i8, ptr %.roots.context, i64 120
  %37 = load ptr, ptr %36, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %38 = getelementptr inbounds i8, ptr %.roots.context, i64 128
  %39 = load ptr, ptr %38, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %40 = getelementptr inbounds i8, ptr %.roots.context, i64 136
  %41 = load ptr, ptr %40, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %42 = getelementptr inbounds i8, ptr %.roots.context, i64 144
  %43 = load ptr, ptr %42, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %44 = getelementptr inbounds i8, ptr %.roots.context, i64 152
  %45 = load ptr, ptr %44, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %46 = getelementptr inbounds i8, ptr %.roots.context, i64 160
  %47 = load ptr, ptr %46, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %48 = getelementptr inbounds i8, ptr %.roots.context, i64 168
  %49 = load ptr, ptr %48, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %50 = getelementptr inbounds i8, ptr %.roots.context, i64 176
  %51 = load ptr, ptr %50, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %52 = getelementptr inbounds i8, ptr %.roots.context, i64 184
  %53 = load ptr, ptr %52, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %54 = getelementptr inbounds i8, ptr %.roots.context, i64 192
  %55 = load ptr, ptr %54, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %56 = getelementptr inbounds i8, ptr %.roots.context, i64 200
  %57 = load ptr, ptr %56, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %58 = getelementptr inbounds i8, ptr %.roots.context, i64 208
  %59 = load ptr, ptr %58, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %60 = getelementptr inbounds i8, ptr %.roots.context, i64 216
  %61 = load ptr, ptr %60, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  %62 = getelementptr inbounds i8, ptr %.roots.context, i64 224
  %63 = load ptr, ptr %62, align 8, !tbaa !156, !alias.scope !161, !noalias !164
  call void @llvm.dbg.declare(metadata ptr %"context::ProcessContext", metadata !153, metadata !DIExpression()), !dbg !160
  %ptls_field = getelementptr inbounds i8, ptr %pgcstack, i64 16
  %ptls_load = load ptr, ptr %ptls_field, align 8, !tbaa !156
  %64 = getelementptr inbounds i8, ptr %ptls_load, i64 16
  %safepoint = load ptr, ptr %64, align 8, !tbaa !169, !invariant.load !0
  fence syncscope("singlethread") seq_cst
  %65 = load volatile i64, ptr %safepoint, align 8, !dbg !160
  fence syncscope("singlethread") seq_cst
  store i8 1, ptr @"jl_global#11072.jit", align 16, !dbg !171, !tbaa !181, !alias.scope !184, !noalias !185
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !186
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !186, !tbaa !156, !alias.scope !161, !noalias !164
  %66 = sext i16 %thread_id to i64, !dbg !190
  %67 = add nsw i64 %66, 1, !dbg !195
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !197
  store i64 %67, ptr %"process::Process.threadid_ptr", align 8, !dbg !197, !tbaa !198, !alias.scope !184, !noalias !185
  %68 = call i64 @jlplt_ijl_hrtime_11074_got.jit(), !dbg !200
  %"process::Process.starttime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 504, !dbg !206
  %"process::Process.starttime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 512, !dbg !206
  store i8 2, ptr %"process::Process.starttime.tindex_ptr", align 1, !dbg !206, !tbaa !198, !alias.scope !184, !noalias !185
  store i64 %68, ptr %"process::Process.starttime_ptr", align 8, !dbg !206, !tbaa !198, !alias.scope !184, !noalias !185
  %69 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 136, !dbg !207
  %70 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !207
  %.stop_ptr = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 144, !dbg !240
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !263, !tbaa !169, !alias.scope !268, !noalias !269
  %.unbox = load i64, ptr %69, align 8, !dbg !263, !tbaa !270, !alias.scope !271, !noalias !272
  %.not = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !263
  br i1 %.not, label %L36, label %L39, !dbg !246

L36:                                              ; preds = %top
  %71 = call swiftcc [1 x ptr] @j_ArgumentError_11075(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#11076.jit"), !dbg !246
  %gc_slot_addr_14 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  %72 = extractvalue [1 x ptr] %71, 0, !dbg !246
  store ptr %72, ptr %gc_slot_addr_14, align 8
  %ptls_load1374 = load ptr, ptr %ptls_field, align 8, !dbg !246, !tbaa !156
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1374, i32 424, i32 16, i64 4839131120) #24, !dbg !246
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !246
  store atomic i64 4839131120, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !246, !tbaa !273
  store ptr %72, ptr %"box::ArgumentError", align 8, !dbg !246, !tbaa !275, !alias.scope !184, !noalias !185
  store ptr null, ptr %gc_slot_addr_14, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !246
  unreachable, !dbg !246

L39:                                              ; preds = %top
  %73 = add i64 %.stop_ptr.unbox, 1, !dbg !277
  %74 = sub i64 %73, %.unbox, !dbg !280
  store i64 %.unbox, ptr %"new::SamplerRangeNDL", align 8, !dbg !281, !tbaa !270, !alias.scope !271, !noalias !272
  %75 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8, !dbg !281
  store i64 %74, ptr %75, align 8, !dbg !281, !tbaa !283, !alias.scope !285, !noalias !286
  %76 = call swiftcc i64 @j_rand_11078(ptr nonnull swiftself %pgcstack, ptr %49, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !254
  %.fr1252 = freeze i64 %76
  %.state = load atomic ptr, ptr %47 unordered, align 8, !dbg !287, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %.state.size_ptr = getelementptr inbounds i8, ptr %.state, i64 16, !dbg !294
  %.state.size.0.copyload = load i64, ptr %.state.size_ptr, align 8, !dbg !294, !tbaa !270, !alias.scope !300, !noalias !301
  %.not866 = icmp eq i64 %.state.size.0.copyload, 100000, !dbg !302
  br i1 %.not866, label %L65, label %L60, !dbg !297

L60:                                              ; preds = %L39
  call swiftcc void @j_throw_dmrsa_11079(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %.state.size.0.copyload) #8, !dbg !307
  unreachable, !dbg !307

L65:                                              ; preds = %L39
  %77 = load ptr, ptr %.state, align 8, !dbg !308, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_offset = shl i64 %.fr1252, 2, !dbg !315
  %78 = getelementptr i8, ptr %77, i64 %memoryref_offset, !dbg !315
  %memoryref_data11 = getelementptr i8, ptr %78, i64 -4, !dbg !315
  %79 = load float, ptr %memoryref_data11, align 4, !dbg !315, !tbaa !318, !alias.scope !184, !noalias !185
  %80 = icmp slt i64 %.fr1252, 100001
  %81 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 272, !dbg !320
  br i1 %80, label %L111, label %L224, !dbg !324

L111:                                             ; preds = %L65
  %.unbox15 = load double, ptr %81, align 8, !dbg !330, !tbaa !169, !alias.scope !268, !noalias !269
  %82 = call double @llvm.fabs.f64(double %.unbox15), !dbg !330
  %83 = fcmp oeq double %.unbox15, 0.000000e+00, !dbg !340
  br i1 %83, label %guard_pass627, label %L116, !dbg !342

L116:                                             ; preds = %L111
  %.idxF_ptr551 = getelementptr inbounds i8, ptr %49, i64 32, !dbg !343
  %.idxF552 = load i64, ptr %.idxF_ptr551, align 8, !dbg !343, !tbaa !198, !alias.scope !184, !noalias !185
  %.not871 = icmp eq i64 %.idxF552, 1002, !dbg !362
  br i1 %.not871, label %L119, label %L121, !dbg !347

L119:                                             ; preds = %L116
  %84 = call swiftcc i64 @j_gen_rand_11087(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !347
  %.idxF556.pre = load i64, ptr %.idxF_ptr551, align 8, !dbg !363, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L121, !dbg !347

L121:                                             ; preds = %L119, %L116
  %.idxF556 = phi i64 [ %.idxF552, %L116 ], [ %.idxF556.pre, %L119 ], !dbg !363
  %.vals_ptr553 = getelementptr inbounds i8, ptr %49, i64 16, !dbg !363
  %.vals554 = load atomic ptr, ptr %.vals_ptr553 unordered, align 8, !dbg !363, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %85 = add i64 %.idxF556, 1, !dbg !370
  store i64 %85, ptr %.idxF_ptr551, align 8, !dbg !371, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data559 = load ptr, ptr %.vals554, align 8, !dbg !372, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset562 = shl i64 %.idxF556, 3, !dbg !372
  %memoryref_data567 = getelementptr inbounds i8, ptr %memoryref_data559, i64 %memoryref_byteoffset562, !dbg !372
  %86 = load i64, ptr %memoryref_data567, align 8, !dbg !372, !tbaa !318, !alias.scope !184, !noalias !185
  %87 = trunc i64 %86 to i32, !dbg !373
  %88 = and i32 %87, 8388607, !dbg !374
  %89 = or disjoint i32 %88, 1065353216, !dbg !376
  %bitcast_coercion569 = bitcast i32 %89 to float, !dbg !378
  %90 = fadd float %bitcast_coercion569, -1.000000e+00, !dbg !380
  %91 = fmul float %90, 2.000000e+00, !dbg !384
  %92 = fadd float %91, -1.000000e+00, !dbg !388
  %93 = fpext float %92 to double, !dbg !389
  %94 = fmul double %82, %93, !dbg !384
  %95 = fpext float %79 to double, !dbg !398
  %96 = fadd double %94, %95, !dbg !404
  %97 = fadd double %96, 1.000000e+00, !dbg !406
  %98 = fsub double %97, %97, !dbg !411
  %99 = fcmp uno double %98, 0.000000e+00, !dbg !420
  %100 = fcmp oeq double %97, 0.000000e+00
  %or.cond = or i1 %99, %100, !dbg !414
  %101 = call double @llvm.fabs.f64(double %97), !dbg !424
  br i1 %or.cond, label %L181, label %L177, !dbg !414

L177:                                             ; preds = %L121
  %102 = call swiftcc double @j_rem_internal_11091(ptr nonnull swiftself %pgcstack, double %101, double 4.000000e+00), !dbg !425
  %103 = call double @llvm.copysign.f64(double %102, double %97), !dbg !426
  br label %L189, !dbg !429

L181:                                             ; preds = %L121
  %104 = bitcast double %101 to i64, !dbg !432
  %.not872 = icmp eq i64 %104, 9218868437227405312, !dbg !432
  br i1 %.not872, label %L196, label %L189, !dbg !434

L189:                                             ; preds = %L181, %L177
  %value_phi570 = phi double [ %103, %L177 ], [ %97, %L181 ]
  %105 = fcmp une double %value_phi570, 0.000000e+00, !dbg !435
  br i1 %105, label %L196, label %L194, !dbg !437

L194:                                             ; preds = %L189
  %106 = call double @llvm.fabs.f64(double %value_phi570), !dbg !438
  br label %guard_pass632, !dbg !429

L196:                                             ; preds = %L189, %L181
  %value_phi570908 = phi double [ %value_phi570, %L189 ], [ 0x7FF8000000000000, %L181 ]
  %107 = fcmp ogt double %value_phi570908, 0.000000e+00, !dbg !440
  %108 = fadd double %value_phi570908, 4.000000e+00
  %spec.select712 = select i1 %107, double %value_phi570908, double %108, !dbg !444
  br label %guard_pass632, !dbg !444

L224:                                             ; preds = %L65
  %jl_nothing577 = load ptr, ptr @jl_nothing, align 8, !dbg !445, !tbaa !169, !invariant.load !0, !alias.scope !268, !noalias !269, !nonnull !0
  %box_Float32578 = call ptr @ijl_box_float32(float %79), !dbg !445
  %gc_slot_addr_15 = getelementptr inbounds ptr, ptr %gcframe2, i64 17
  store ptr %box_Float32578, ptr %gc_slot_addr_15, align 8
  %ptls_load1379 = load ptr, ptr %ptls_field, align 8, !dbg !445, !tbaa !156
  %"box::Float64582" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1379, i32 424, i32 16, i64 4839710864) #24, !dbg !445
  %"box::Float64582.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64582", i64 -1, !dbg !445
  store atomic i64 4839710864, ptr %"box::Float64582.tag_addr" unordered, align 8, !dbg !445, !tbaa !273
  %109 = load i64, ptr %81, align 8, !dbg !445, !tbaa !270, !alias.scope !448, !noalias !449
  store i64 %109, ptr %"box::Float64582", align 8, !dbg !445, !tbaa !270, !alias.scope !448, !noalias !449
  %gc_slot_addr_141357 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  store ptr %"box::Float64582", ptr %gc_slot_addr_141357, align 8
  store ptr @"jl_global#11092.jit", ptr %jlcallframe1, align 8, !dbg !445
  %110 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !445
  store ptr %49, ptr %110, align 8, !dbg !445
  %111 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !445
  store ptr %jl_nothing577, ptr %111, align 8, !dbg !445
  %112 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !445
  store ptr %box_Float32578, ptr %112, align 8, !dbg !445
  %113 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !445
  store ptr %"box::Float64582", ptr %113, align 8, !dbg !445
  %jl_f_throw_methoderror_ret583 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !445
  call void @llvm.trap(), !dbg !445
  unreachable, !dbg !445

L242:                                             ; preds = %guard_pass632, %guard_pass627
  %.sroa.71179.0 = phi float [ %474, %guard_pass627 ], [ %479, %guard_pass632 ], !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111191, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101185, i64 7, i1 false), !dbg !450
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.101185), !dbg !450
  %114 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8, !dbg !451
  store i64 %.fr1252, ptr %114, align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !451
  store float %79, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !451
  store float %.sroa.71179.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !451
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !451
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !451
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111191, i64 7, i1 false), !dbg !451
  %115 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 40, !dbg !455
  %116 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !455
  %.state21 = load atomic ptr, ptr %9 unordered, align 8, !dbg !463, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %117 = add i64 %.fr1252, -1, !dbg !474
  %.size_ptr = getelementptr inbounds i8, ptr %11, i64 16, !dbg !476
  %.size.0.copyload = load i64, ptr %.size_ptr, align 8, !dbg !476, !tbaa !270, !alias.scope !300, !noalias !301
  %.not873 = icmp ult i64 %117, %.size.0.copyload, !dbg !474
  br i1 %.not873, label %L300, label %L297, !dbg !474

L297:                                             ; preds = %L242
  store i64 %.fr1252, ptr %"new::Tuple547", align 8, !dbg !474, !tbaa !283, !alias.scope !285, !noalias !286
  call swiftcc void @j_throw_boundserror_11089(ptr nonnull swiftself %pgcstack, ptr %11, ptr nocapture nonnull readonly %"new::Tuple547") #8, !dbg !474
  unreachable, !dbg !474

L300:                                             ; preds = %L242
  %memoryref_data22 = load ptr, ptr %11, align 8, !dbg !477, !tbaa !310, !alias.scope !313, !noalias !314
  %118 = getelementptr i8, ptr %memoryref_data22, i64 %memoryref_offset, !dbg !477
  %memoryref_data30 = getelementptr i8, ptr %118, i64 -4, !dbg !477
  %119 = load float, ptr %memoryref_data30, align 4, !dbg !477, !tbaa !318, !alias.scope !184, !noalias !185
  %120 = fpext float %.sroa.71179.0 to double, !dbg !478
  %gc_slot_addr_141358 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  store ptr %.state21, ptr %gc_slot_addr_141358, align 8
  %121 = call swiftcc double @"j_#power_by_squaring#401_11082"(ptr nonnull swiftself %pgcstack, double %120, i64 signext 2), !dbg !485
  %.state21.size_ptr = getelementptr inbounds i8, ptr %.state21, i64 16, !dbg !476
  %.state21.size.0.copyload = load i64, ptr %.state21.size_ptr, align 8, !dbg !476, !tbaa !270, !alias.scope !300, !noalias !301
  %.not874 = icmp ult i64 %117, %.state21.size.0.copyload, !dbg !474
  br i1 %.not874, label %L325, label %L322, !dbg !474

L322:                                             ; preds = %L300
  store i64 %.fr1252, ptr %"new::Tuple545", align 8, !dbg !474, !tbaa !283, !alias.scope !285, !noalias !286
  call swiftcc void @j_throw_boundserror_11089(ptr nonnull swiftself %pgcstack, ptr nonnull %.state21, ptr nocapture nonnull readonly %"new::Tuple545") #8, !dbg !474
  unreachable, !dbg !474

L325:                                             ; preds = %L300
  %122 = fptrunc double %121 to float, !dbg !488
  %memoryref_data32 = load ptr, ptr %.state21, align 8, !dbg !477, !tbaa !310, !alias.scope !313, !noalias !314
  %123 = getelementptr i8, ptr %memoryref_data32, i64 %memoryref_offset, !dbg !477
  %memoryref_data40 = getelementptr i8, ptr %123, i64 -4, !dbg !477
  %124 = load float, ptr %memoryref_data40, align 4, !dbg !477, !tbaa !318, !alias.scope !184, !noalias !185
  %125 = fpext float %124 to double, !dbg !478
  store ptr null, ptr %gc_slot_addr_141358, align 8
  %126 = call swiftcc double @"j_#power_by_squaring#401_11082"(ptr nonnull swiftself %pgcstack, double %125, i64 signext 2), !dbg !485
  %127 = fptrunc double %126 to float, !dbg !488
  %128 = fsub float %122, %127, !dbg !493
  %129 = fmul float %119, 0.000000e+00, !dbg !494
  %130 = fmul float %129, %128, !dbg !494
  %131 = fadd float %130, 0.000000e+00, !dbg !497
  store ptr %9, ptr %1, align 8, !dbg !471
  store ptr %17, ptr %2, align 8, !dbg !471
  %132 = getelementptr inbounds ptr, ptr %gcframe2, i64 5, !dbg !471
  store ptr %19, ptr %132, align 8, !dbg !471
  %133 = getelementptr inbounds ptr, ptr %gcframe2, i64 6, !dbg !471
  store ptr %21, ptr %133, align 8, !dbg !471
  %134 = getelementptr inbounds ptr, ptr %gcframe2, i64 7, !dbg !471
  store ptr %23, ptr %134, align 8, !dbg !471
  %135 = getelementptr inbounds ptr, ptr %gcframe2, i64 8, !dbg !471
  store ptr %25, ptr %135, align 8, !dbg !471
  %136 = call swiftcc float @"j_#calculate##0_11083"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %1, float %131, ptr nocapture nonnull readonly %115, ptr nocapture nonnull readonly %2), !dbg !471
  %.state41 = load atomic ptr, ptr %9 unordered, align 8, !dbg !498, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %.unbox42 = load float, ptr %116, align 4, !dbg !502, !tbaa !169, !alias.scope !268, !noalias !269
  %137 = fneg float %.unbox42, !dbg !502
  store i64 %.fr1252, ptr %"new::Tuple43", align 8, !dbg !504, !tbaa !283, !alias.scope !285, !noalias !286
  %138 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !507
  %bitcast44 = load i64, ptr %138, align 8, !dbg !520, !tbaa !169, !alias.scope !268, !noalias !269
  %.not875 = icmp ult i64 %117, %bitcast44, !dbg !525
  br i1 %.not875, label %L383, label %L380, !dbg !519

L380:                                             ; preds = %L325
  %139 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %140 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !526
  store ptr %27, ptr %139, align 8, !dbg !519
  call swiftcc void @j_throw_boundserror_11090(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %140, ptr nocapture nonnull readonly %139, ptr nocapture nonnull readonly %"new::Tuple43") #8, !dbg !519
  unreachable, !dbg !519

L383:                                             ; preds = %L325
  %.state41.size_ptr = getelementptr inbounds i8, ptr %.state41, i64 16, !dbg !531
  %.state41.size.0.copyload = load i64, ptr %.state41.size_ptr, align 8, !dbg !531, !tbaa !270, !alias.scope !300, !noalias !301
  %.not876 = icmp ult i64 %117, %.state41.size.0.copyload, !dbg !532
  br i1 %.not876, label %L400, label %L397, !dbg !532

L397:                                             ; preds = %L383
  store i64 %.fr1252, ptr %"new::Tuple542", align 8, !dbg !532, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %.state41, ptr %gc_slot_addr_141358, align 8
  call swiftcc void @j_throw_boundserror_11089(ptr nonnull swiftself %pgcstack, ptr nonnull %.state41, ptr nocapture nonnull readonly %"new::Tuple542") #8, !dbg !532
  unreachable, !dbg !532

L400:                                             ; preds = %L383
  %.x = load float, ptr %27, align 4, !dbg !533, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data46 = load ptr, ptr %.state41, align 8, !dbg !537, !tbaa !310, !alias.scope !313, !noalias !314
  %141 = getelementptr i8, ptr %memoryref_data46, i64 %memoryref_offset, !dbg !537
  %memoryref_data54 = getelementptr i8, ptr %141, i64 -4, !dbg !537
  %142 = load float, ptr %memoryref_data54, align 4, !dbg !537, !tbaa !318, !alias.scope !184, !noalias !185
  %143 = fsub float %.sroa.71179.0, %142, !dbg !538
  %144 = fmul float %.x, %137, !dbg !539
  %145 = fmul float %144, %143, !dbg !539
  %146 = fadd float %136, %145, !dbg !497
  %147 = fcmp ugt float %146, 0.000000e+00, !dbg !541
  br i1 %147, label %L415, label %L532, !dbg !543

L415:                                             ; preds = %L400
  %.idxF_ptr = getelementptr inbounds i8, ptr %49, i64 32, !dbg !544
  %.idxF = load i64, ptr %.idxF_ptr, align 8, !dbg !544, !tbaa !198, !alias.scope !184, !noalias !185
  %.not877 = icmp eq i64 %.idxF, 1002, !dbg !557
  br i1 %.not877, label %L418, label %L420, !dbg !546

L418:                                             ; preds = %L415
  %148 = call swiftcc i64 @j_gen_rand_11087(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !546
  %.idxF517.pre = load i64, ptr %.idxF_ptr, align 8, !dbg !558, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L420, !dbg !546

L420:                                             ; preds = %L418, %L415
  %.idxF517 = phi i64 [ %.idxF, %L415 ], [ %.idxF517.pre, %L418 ], !dbg !558
  %.vals_ptr = getelementptr inbounds i8, ptr %49, i64 16, !dbg !558
  %.vals = load atomic ptr, ptr %.vals_ptr unordered, align 8, !dbg !558, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %149 = add i64 %.idxF517, 1, !dbg !563
  store i64 %149, ptr %.idxF_ptr, align 8, !dbg !564, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data520 = load ptr, ptr %.vals, align 8, !dbg !565, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset523 = shl i64 %.idxF517, 3, !dbg !565
  %memoryref_data528 = getelementptr inbounds i8, ptr %memoryref_data520, i64 %memoryref_byteoffset523, !dbg !565
  %150 = load i64, ptr %memoryref_data528, align 8, !dbg !565, !tbaa !318, !alias.scope !184, !noalias !185
  %151 = trunc i64 %150 to i32, !dbg !566
  %152 = and i32 %151, 8388607, !dbg !567
  %153 = or disjoint i32 %152, 1065353216, !dbg !568
  %bitcast_coercion530 = bitcast i32 %153 to float, !dbg !569
  %154 = fadd float %bitcast_coercion530, -1.000000e+00, !dbg !570
  %155 = fneg float %146, !dbg !572
  %.unbox531 = load float, ptr %70, align 4, !dbg !573, !tbaa !270, !alias.scope !271, !noalias !272
  %156 = fdiv float %155, %.unbox531, !dbg !573
  %157 = fmul float %156, 0x3FF7154760000000, !dbg !575
  %158 = call float @llvm.rint.f32(float %157), !dbg !581
  %159 = fptosi float %158 to i32, !dbg !585
  %160 = freeze i32 %159, !dbg !585
  %161 = fmul contract float %158, 0x3FE62E4000000000, !dbg !588
  %162 = fsub contract float %156, %161, !dbg !588
  %163 = fmul contract float %158, 0x3EB7F7D1C0000000, !dbg !591
  %164 = fsub contract float %162, %163, !dbg !591
  %165 = fmul contract float %164, 0x3F2A1D7140000000, !dbg !593
  %166 = fadd contract float %165, 0x3F56DA7560000000, !dbg !593
  %167 = fmul contract float %164, %166, !dbg !593
  %168 = fadd contract float %167, 0x3F811105C0000000, !dbg !593
  %169 = fmul contract float %164, %168, !dbg !593
  %170 = fadd contract float %169, 0x3FA5554640000000, !dbg !593
  %171 = fmul contract float %164, %170, !dbg !593
  %172 = fadd contract float %171, 0x3FC5555560000000, !dbg !593
  %173 = fmul contract float %164, %172, !dbg !593
  %174 = fadd contract float %173, 5.000000e-01, !dbg !593
  %175 = fmul contract float %164, %174, !dbg !593
  %176 = fadd contract float %175, 1.000000e+00, !dbg !593
  %177 = fmul contract float %164, %176, !dbg !593
  %178 = fadd contract float %177, 1.000000e+00, !dbg !593
  %179 = fcmp ule float %156, 0x40562E4300000000, !dbg !601
  br i1 %179, label %L479, label %L530, !dbg !603

L479:                                             ; preds = %L420
  %180 = fcmp uge float %156, 0xC059FE3680000000, !dbg !604
  br i1 %180, label %L523, label %L530, !dbg !605

L523:                                             ; preds = %L479
  %181 = fcmp ugt float %156, 0xC055D58A00000000, !dbg !606
  %182 = fmul float %178, 0x3E70000000000000, !dbg !607
  %value_phi534 = select i1 %181, float %178, float %182, !dbg !607
  %.not878 = icmp eq i32 %160, 128, !dbg !608
  %183 = fmul float %value_phi534, 2.000000e+00, !dbg !610
  %value_phi536 = select i1 %.not878, float %183, float %value_phi534, !dbg !610
  %value_phi533.v = select i1 %181, i32 127, i32 151, !dbg !607
  %value_phi533 = add i32 %160, %value_phi533.v, !dbg !607
  %184 = sext i1 %.not878 to i32, !dbg !610
  %value_phi535 = add i32 %value_phi533, %184, !dbg !610
  %185 = shl i32 %value_phi535, 23, !dbg !611
  %bitcast_coercion539 = bitcast i32 %185 to float, !dbg !617
  %186 = fmul float %value_phi536, %bitcast_coercion539, !dbg !618
  br label %L530, !dbg !429

L530:                                             ; preds = %L523, %L479, %L420
  %value_phi532 = phi float [ %186, %L523 ], [ 0x7FF0000000000000, %L420 ], [ 0.000000e+00, %L479 ]
  %187 = fcmp olt float %154, %value_phi532, !dbg !619
  br i1 %187, label %L532, label %guard_pass642, !dbg !543

L532:                                             ; preds = %L530, %L400
  %.state56 = load atomic ptr, ptr %47 unordered, align 8, !dbg !620, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %.state56.size_ptr = getelementptr inbounds i8, ptr %.state56, i64 16, !dbg !626
  %.state56.size.0.copyload = load i64, ptr %.state56.size_ptr, align 8, !dbg !626, !tbaa !270, !alias.scope !300, !noalias !301
  %.not879 = icmp eq i64 %.state56.size.0.copyload, 100000, !dbg !628
  br i1 %.not879, label %guard_pass637, label %L540, !dbg !627

L540:                                             ; preds = %L532
  call swiftcc void @j_throw_dmrsa_11079(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %.state56.size.0.copyload) #8, !dbg !630
  unreachable, !dbg !630

L641.L1255_crit_edge:                             ; preds = %pass78
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0775.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0775.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx", i64 16, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0775.sroa.12.sroa.0, ptr noundef nonnull align 8 dereferenceable(104) %"new::NamedTuple.sroa.5.128..sroa_idx", i64 104, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101174, i64 7, i1 false), !dbg !631
  br label %L1255, !dbg !631

L641.L645_crit_edge:                              ; preds = %pass78
  %.sroa.8803.0.copyload805 = load double, ptr %81, align 8, !dbg !631, !tbaa !270, !alias.scope !271, !noalias !272
  %.unbox649 = load float, ptr %70, align 4, !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %4, ptr noundef nonnull align 8 dereferenceable(80) %462, i64 80, i1 false), !dbg !632
  %.sroa.81140.0..sroa_idx1143 = getelementptr inbounds i8, ptr %4, i64 80, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %.sroa.81140.0..sroa_idx1143, align 8, !dbg !632
  %.sroa.91145.0..sroa_idx1148 = getelementptr inbounds i8, ptr %4, i64 88, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.3.8.copyload", ptr %.sroa.91145.0..sroa_idx1148, align 8, !dbg !632
  %.sroa.101150.0..sroa_idx1153 = getelementptr inbounds i8, ptr %4, i64 96, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %.sroa.101150.0..sroa_idx1153, align 8, !dbg !632
  %.sroa.111155.0..sroa_idx1157 = getelementptr inbounds i8, ptr %4, i64 104, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.111155.0..sroa_idx1157, ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx", i64 16, i1 false), !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %.sroa.01111, ptr noundef nonnull align 8 dereferenceable(80) %462, i64 80, i1 false), !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.81132, ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx", i64 16, i1 false), !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.5.sroa.0, ptr noundef nonnull align 8 dereferenceable(104) %"new::NamedTuple.sroa.5.128..sroa_idx", i64 104, i1 false), !dbg !632
  %.not883981 = icmp slt i64 %"new::NamedTuple.sroa.4.128.copyload", %.unbox, !dbg !633
  %188 = trunc i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload" to i32, !dbg !636
  %189 = bitcast i32 %188 to float, !dbg !636
  br i1 %.not883981, label %L663, label %L666.lr.ph, !dbg !636

L666.lr.ph:                                       ; preds = %L641.L645_crit_edge
  %190 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL148", i64 8
  %value_phi87.idxF_ptr478 = getelementptr inbounds i8, ptr %49, i64 32
  %value_phi87.vals_ptr480 = getelementptr inbounds i8, ptr %49, i64 16
  %191 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1185", i64 8
  %192 = getelementptr inbounds i8, ptr %4, i64 24
  %193 = getelementptr inbounds ptr, ptr %gcframe2, i64 12
  %194 = getelementptr inbounds ptr, ptr %gcframe2, i64 13
  %195 = getelementptr inbounds ptr, ptr %gcframe2, i64 14
  %196 = getelementptr inbounds ptr, ptr %gcframe2, i64 15
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496
  %"new::Tuple208.promoted" = load i64, ptr %"new::Tuple208", align 1, !tbaa !283, !alias.scope !285, !noalias !286
  br label %L666, !dbg !636

L663:                                             ; preds = %L641.L645_crit_edge
  %197 = call swiftcc [1 x ptr] @j_ArgumentError_11075(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#11076.jit"), !dbg !636
  %198 = extractvalue [1 x ptr] %197, 0, !dbg !636
  store ptr %198, ptr %gc_slot_addr_141358, align 8
  %ptls_load1386 = load ptr, ptr %ptls_field, align 8, !dbg !636, !tbaa !156
  %"box::ArgumentError143" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1386, i32 424, i32 16, i64 4839131120) #24, !dbg !636
  %"box::ArgumentError143.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError143", i64 -1, !dbg !636
  store atomic i64 4839131120, ptr %"box::ArgumentError143.tag_addr" unordered, align 8, !dbg !636, !tbaa !273
  store ptr %198, ptr %"box::ArgumentError143", align 8, !dbg !636, !tbaa !275, !alias.scope !184, !noalias !185
  store ptr null, ptr %gc_slot_addr_141358, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError143"), !dbg !636
  unreachable, !dbg !636

L666:                                             ; preds = %L1254, %L666.lr.ph
  %199 = phi i64 [ %"new::Tuple208.promoted", %L666.lr.ph ], [ %.fr, %L1254 ]
  %value_phi86984 = phi i64 [ %466, %L666.lr.ph ], [ %302, %L1254 ]
  %reass.sub = sub i64 %"new::NamedTuple.sroa.4.128.copyload", %.unbox, !dbg !648
  %200 = add i64 %reass.sub, 1, !dbg !648
  store i64 %.unbox, ptr %"new::SamplerRangeNDL148", align 8, !dbg !650, !tbaa !283, !alias.scope !285, !noalias !286
  store i64 %200, ptr %190, align 8, !dbg !650, !tbaa !283, !alias.scope !285, !noalias !286
  %201 = call swiftcc i64 @j_rand_11078(ptr nonnull swiftself %pgcstack, ptr %49, ptr nocapture nonnull readonly %"new::SamplerRangeNDL148"), !dbg !639
  %.fr = freeze i64 %201
  %root_phi106.state = load atomic ptr, ptr %47 unordered, align 8, !dbg !652, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %root_phi106.state.size_ptr = getelementptr inbounds i8, ptr %root_phi106.state, i64 16, !dbg !655
  %root_phi106.state.size.0.copyload = load i64, ptr %root_phi106.state.size_ptr, align 8, !dbg !655, !tbaa !270, !alias.scope !300, !noalias !301
  %.not884 = icmp eq i64 %root_phi106.state.size.0.copyload, 100000, !dbg !657
  br i1 %.not884, label %L692, label %L687, !dbg !656

L687:                                             ; preds = %L666
  call swiftcc void @j_throw_dmrsa_11079(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi106.state.size.0.copyload) #8, !dbg !659
  unreachable, !dbg !659

L692:                                             ; preds = %L666
  %202 = load ptr, ptr %root_phi106.state, align 8, !dbg !660, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_offset159 = shl i64 %.fr, 2, !dbg !662
  %203 = getelementptr i8, ptr %202, i64 %memoryref_offset159, !dbg !662
  %memoryref_data165 = getelementptr i8, ptr %203, i64 -4, !dbg !662
  %204 = load float, ptr %memoryref_data165, align 4, !dbg !662, !tbaa !318, !alias.scope !184, !noalias !185
  %205 = icmp slt i64 %.fr, 100001
  br i1 %205, label %L738, label %L851, !dbg !664

L738:                                             ; preds = %L692
  %206 = call double @llvm.fabs.f64(double %.sroa.8803.0.copyload805), !dbg !667
  %207 = fcmp oeq double %.sroa.8803.0.copyload805, 0.000000e+00, !dbg !673
  br i1 %207, label %guard_pass686, label %L743, !dbg !674

L743:                                             ; preds = %L738
  %value_phi87.idxF479 = load i64, ptr %value_phi87.idxF_ptr478, align 8, !dbg !675, !tbaa !198, !alias.scope !184, !noalias !185
  %.not889 = icmp eq i64 %value_phi87.idxF479, 1002, !dbg !689
  br i1 %.not889, label %L746, label %L748, !dbg !677

L746:                                             ; preds = %L743
  %208 = call swiftcc i64 @j_gen_rand_11087(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !677
  %value_phi87.idxF483.pre = load i64, ptr %value_phi87.idxF_ptr478, align 8, !dbg !690, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L748, !dbg !677

L748:                                             ; preds = %L746, %L743
  %value_phi87.idxF483 = phi i64 [ %value_phi87.idxF479, %L743 ], [ %value_phi87.idxF483.pre, %L746 ], !dbg !690
  %value_phi87.vals481 = load atomic ptr, ptr %value_phi87.vals_ptr480 unordered, align 8, !dbg !690, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %209 = add i64 %value_phi87.idxF483, 1, !dbg !695
  store i64 %209, ptr %value_phi87.idxF_ptr478, align 8, !dbg !696, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data486 = load ptr, ptr %value_phi87.vals481, align 8, !dbg !697, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset489 = shl i64 %value_phi87.idxF483, 3, !dbg !697
  %memoryref_data494 = getelementptr inbounds i8, ptr %memoryref_data486, i64 %memoryref_byteoffset489, !dbg !697
  %210 = load i64, ptr %memoryref_data494, align 8, !dbg !697, !tbaa !318, !alias.scope !184, !noalias !185
  %211 = trunc i64 %210 to i32, !dbg !698
  %212 = and i32 %211, 8388607, !dbg !699
  %213 = or disjoint i32 %212, 1065353216, !dbg !700
  %bitcast_coercion496 = bitcast i32 %213 to float, !dbg !701
  %214 = fadd float %bitcast_coercion496, -1.000000e+00, !dbg !702
  %215 = fmul float %214, 2.000000e+00, !dbg !704
  %216 = fadd float %215, -1.000000e+00, !dbg !706
  %217 = fpext float %216 to double, !dbg !707
  %218 = fmul double %206, %217, !dbg !704
  %219 = fpext float %204 to double, !dbg !711
  %220 = fadd double %218, %219, !dbg !716
  %221 = fadd double %220, 1.000000e+00, !dbg !717
  %222 = fsub double %221, %221, !dbg !721
  %223 = fcmp uno double %222, 0.000000e+00, !dbg !726
  %224 = fcmp oeq double %221, 0.000000e+00
  %or.cond1255 = or i1 %223, %224, !dbg !723
  %225 = call double @llvm.fabs.f64(double %221), !dbg !728
  br i1 %or.cond1255, label %L808, label %L804, !dbg !723

L804:                                             ; preds = %L748
  %226 = call swiftcc double @j_rem_internal_11091(ptr nonnull swiftself %pgcstack, double %225, double 4.000000e+00), !dbg !729
  %227 = call double @llvm.copysign.f64(double %226, double %221), !dbg !730
  br label %L816, !dbg !429

L808:                                             ; preds = %L748
  %228 = bitcast double %225 to i64, !dbg !731
  %.not890 = icmp eq i64 %228, 9218868437227405312, !dbg !731
  br i1 %.not890, label %L823, label %L816, !dbg !732

L816:                                             ; preds = %L808, %L804
  %value_phi497 = phi double [ %227, %L804 ], [ %221, %L808 ]
  %229 = fcmp une double %value_phi497, 0.000000e+00, !dbg !733
  br i1 %229, label %L823, label %L821, !dbg !735

L821:                                             ; preds = %L816
  %230 = call double @llvm.fabs.f64(double %value_phi497), !dbg !736
  br label %guard_pass691, !dbg !429

L823:                                             ; preds = %L816, %L808
  %value_phi497913 = phi double [ %value_phi497, %L816 ], [ 0x7FF8000000000000, %L808 ]
  %231 = fcmp ogt double %value_phi497913, 0.000000e+00, !dbg !738
  %232 = fadd double %value_phi497913, 4.000000e+00
  %spec.select714 = select i1 %231, double %value_phi497913, double %232, !dbg !741
  br label %guard_pass691, !dbg !741

L851:                                             ; preds = %L692
  store i64 %199, ptr %"new::Tuple208", align 1, !dbg !742, !tbaa !283, !alias.scope !285, !noalias !286
  %jl_nothing503 = load ptr, ptr @jl_nothing, align 8, !dbg !749, !tbaa !169, !invariant.load !0, !alias.scope !268, !noalias !269, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %204), !dbg !749
  %gc_slot_addr_151363 = getelementptr inbounds ptr, ptr %gcframe2, i64 17
  store ptr %box_Float32, ptr %gc_slot_addr_151363, align 8
  %ptls_load1391 = load ptr, ptr %ptls_field, align 8, !dbg !749, !tbaa !156
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1391, i32 424, i32 16, i64 4839710864) #24, !dbg !749
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !749
  store atomic i64 4839710864, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !749, !tbaa !273
  store double %.sroa.8803.0.copyload805, ptr %"box::Float64", align 8, !dbg !749, !tbaa !270, !alias.scope !752, !noalias !753
  store ptr %"box::Float64", ptr %gc_slot_addr_141358, align 8
  store ptr @"jl_global#11092.jit", ptr %jlcallframe1, align 8, !dbg !749
  %233 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !749
  store ptr %49, ptr %233, align 8, !dbg !749
  %234 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !749
  store ptr %jl_nothing503, ptr %234, align 8, !dbg !749
  %235 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !749
  store ptr %box_Float32, ptr %235, align 8, !dbg !749
  %236 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !749
  store ptr %"box::Float64", ptr %236, align 8, !dbg !749
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !749
  call void @llvm.trap(), !dbg !749
  unreachable, !dbg !749

L869:                                             ; preds = %guard_pass691, %guard_pass686
  %.sroa.71089.0 = phi float [ %483, %guard_pass686 ], [ %488, %guard_pass691 ], !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101095, i64 7, i1 false), !dbg !754
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.101095), !dbg !754
  %"new::Tuple184.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1185", i64 33, !dbg !747
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple184.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !754, !tbaa !283, !alias.scope !285, !noalias !286
  store i64 %.fr, ptr %191, align 8, !dbg !747, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple184.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1185", i64 16, !dbg !747
  store float %204, ptr %"new::Tuple184.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !747, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple184.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1185", i64 20, !dbg !747
  store float %.sroa.71089.0, ptr %"new::Tuple184.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !747, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple184.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1185", i64 24, !dbg !747
  store i64 1, ptr %"new::Tuple184.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !747, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple184.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1185", i64 32, !dbg !747
  store i8 0, ptr %"new::Tuple184.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !747, !tbaa !283, !alias.scope !285, !noalias !286
  %237 = add i64 %.fr, -1, !dbg !755
  %root_phi.size.0.copyload = load i64, ptr %.size_ptr, align 8, !dbg !757, !tbaa !270, !alias.scope !300, !noalias !301
  %.not891 = icmp ult i64 %237, %root_phi.size.0.copyload, !dbg !755
  br i1 %.not891, label %L927, label %L924, !dbg !755

L924:                                             ; preds = %L869
  store i64 %.fr, ptr %"new::Tuple474", align 8, !dbg !755, !tbaa !283, !alias.scope !285, !noalias !286
  call swiftcc void @j_throw_boundserror_11089(ptr nonnull swiftself %pgcstack, ptr nonnull %11, ptr nocapture nonnull readonly %"new::Tuple474") #8, !dbg !755
  unreachable, !dbg !755

L927:                                             ; preds = %L869
  %value_phi88.state = load atomic ptr, ptr %9 unordered, align 8, !dbg !758, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %memoryref_data187 = load ptr, ptr %11, align 8, !dbg !760, !tbaa !310, !alias.scope !313, !noalias !314
  %238 = getelementptr i8, ptr %memoryref_data187, i64 %memoryref_offset159, !dbg !760
  %memoryref_data195 = getelementptr i8, ptr %238, i64 -4, !dbg !760
  %239 = load float, ptr %memoryref_data195, align 4, !dbg !760, !tbaa !318, !alias.scope !184, !noalias !185
  %240 = fpext float %.sroa.71089.0 to double, !dbg !761
  store ptr %value_phi88.state, ptr %gc_slot_addr_141358, align 8
  %241 = call swiftcc double @"j_#power_by_squaring#401_11082"(ptr nonnull swiftself %pgcstack, double %240, i64 signext 2), !dbg !765
  %value_phi88.state.size_ptr = getelementptr inbounds i8, ptr %value_phi88.state, i64 16, !dbg !757
  %value_phi88.state.size.0.copyload = load i64, ptr %value_phi88.state.size_ptr, align 8, !dbg !757, !tbaa !270, !alias.scope !300, !noalias !301
  %.not892 = icmp ult i64 %237, %value_phi88.state.size.0.copyload, !dbg !755
  br i1 %.not892, label %L952, label %L949, !dbg !755

L949:                                             ; preds = %L927
  store i64 %.fr, ptr %"new::Tuple472", align 8, !dbg !755, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %value_phi88.state, ptr %gc_slot_addr_141358, align 8
  call swiftcc void @j_throw_boundserror_11089(ptr nonnull swiftself %pgcstack, ptr nonnull %value_phi88.state, ptr nocapture nonnull readonly %"new::Tuple472") #8, !dbg !755
  unreachable, !dbg !755

L952:                                             ; preds = %L927
  %242 = fptrunc double %241 to float, !dbg !766
  %memoryref_data197 = load ptr, ptr %value_phi88.state, align 8, !dbg !760, !tbaa !310, !alias.scope !313, !noalias !314
  %243 = getelementptr i8, ptr %memoryref_data197, i64 %memoryref_offset159, !dbg !760
  %memoryref_data205 = getelementptr i8, ptr %243, i64 -4, !dbg !760
  %244 = load float, ptr %memoryref_data205, align 4, !dbg !760, !tbaa !318, !alias.scope !184, !noalias !185
  %245 = fpext float %244 to double, !dbg !761
  store ptr null, ptr %gc_slot_addr_141358, align 8
  %246 = call swiftcc double @"j_#power_by_squaring#401_11082"(ptr nonnull swiftself %pgcstack, double %245, i64 signext 2), !dbg !765
  %247 = fptrunc double %246 to float, !dbg !766
  %248 = fsub float %242, %247, !dbg !769
  %249 = fmul float %239, 0.000000e+00, !dbg !770
  %250 = fmul float %249, %248, !dbg !770
  %251 = fadd float %250, 0.000000e+00, !dbg !772
  store ptr %9, ptr %3, align 8, !dbg !745
  store ptr %17, ptr %0, align 8, !dbg !745
  store ptr %19, ptr %193, align 8, !dbg !745
  store ptr %21, ptr %194, align 8, !dbg !745
  store ptr %23, ptr %195, align 8, !dbg !745
  store ptr %25, ptr %196, align 8, !dbg !745
  %252 = call swiftcc float @"j_#calculate##0_11083"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1185", ptr nocapture nonnull readonly %3, float %251, ptr nocapture nonnull readonly %192, ptr nocapture nonnull readonly %0), !dbg !745
  %253 = fneg float %189, !dbg !773
  %.not893 = icmp ult i64 %237, %"new::NamedTuple.sroa.0.sroa.4.8.copyload", !dbg !774
  br i1 %.not893, label %L1010, label %L1007, !dbg !777

L1007:                                            ; preds = %L952
  %254 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  store i64 %.fr, ptr %"new::Tuple208", align 1, !dbg !742, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %27, ptr %254, align 8, !dbg !777
  call swiftcc void @j_throw_boundserror_11090(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.91145.0..sroa_idx1148, ptr nocapture nonnull readonly %254, ptr nocapture nonnull readonly %"new::Tuple208") #8, !dbg !777
  unreachable, !dbg !777

L1010:                                            ; preds = %L952
  %value_phi88.state206 = load atomic ptr, ptr %9 unordered, align 8, !dbg !778, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %value_phi88.state206.size_ptr = getelementptr inbounds i8, ptr %value_phi88.state206, i64 16, !dbg !780
  %value_phi88.state206.size.0.copyload = load i64, ptr %value_phi88.state206.size_ptr, align 8, !dbg !780, !tbaa !270, !alias.scope !300, !noalias !301
  %.not894 = icmp ult i64 %237, %value_phi88.state206.size.0.copyload, !dbg !781
  br i1 %.not894, label %L1027, label %L1024, !dbg !781

L1024:                                            ; preds = %L1010
  store i64 %.fr, ptr %"new::Tuple469", align 8, !dbg !781, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %value_phi88.state206, ptr %gc_slot_addr_141358, align 8
  call swiftcc void @j_throw_boundserror_11089(ptr nonnull swiftself %pgcstack, ptr nonnull %value_phi88.state206, ptr nocapture nonnull readonly %"new::Tuple469") #8, !dbg !781
  unreachable, !dbg !781

L1027:                                            ; preds = %L1010
  %root_phi96.x = load float, ptr %27, align 4, !dbg !782, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data211 = load ptr, ptr %value_phi88.state206, align 8, !dbg !785, !tbaa !310, !alias.scope !313, !noalias !314
  %255 = getelementptr i8, ptr %memoryref_data211, i64 %memoryref_offset159, !dbg !785
  %memoryref_data219 = getelementptr i8, ptr %255, i64 -4, !dbg !785
  %256 = load float, ptr %memoryref_data219, align 4, !dbg !785, !tbaa !318, !alias.scope !184, !noalias !185
  %257 = fsub float %.sroa.71089.0, %256, !dbg !786
  %258 = fmul float %root_phi96.x, %253, !dbg !787
  %259 = fmul float %258, %257, !dbg !787
  %260 = fadd float %252, %259, !dbg !772
  %261 = fcmp ugt float %260, 0.000000e+00, !dbg !789
  br i1 %261, label %L1042, label %L1159, !dbg !790

L1042:                                            ; preds = %L1027
  %value_phi87.idxF = load i64, ptr %value_phi87.idxF_ptr478, align 8, !dbg !791, !tbaa !198, !alias.scope !184, !noalias !185
  %.not895 = icmp eq i64 %value_phi87.idxF, 1002, !dbg !804
  br i1 %.not895, label %L1045, label %L1047, !dbg !793

L1045:                                            ; preds = %L1042
  %262 = call swiftcc i64 @j_gen_rand_11087(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !793
  %value_phi87.idxF446.pre = load i64, ptr %value_phi87.idxF_ptr478, align 8, !dbg !805, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L1047, !dbg !793

L1047:                                            ; preds = %L1045, %L1042
  %value_phi87.idxF446 = phi i64 [ %value_phi87.idxF, %L1042 ], [ %value_phi87.idxF446.pre, %L1045 ], !dbg !805
  %value_phi87.vals = load atomic ptr, ptr %value_phi87.vals_ptr480 unordered, align 8, !dbg !805, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %263 = add i64 %value_phi87.idxF446, 1, !dbg !810
  store i64 %263, ptr %value_phi87.idxF_ptr478, align 8, !dbg !811, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data449 = load ptr, ptr %value_phi87.vals, align 8, !dbg !812, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset452 = shl i64 %value_phi87.idxF446, 3, !dbg !812
  %memoryref_data457 = getelementptr inbounds i8, ptr %memoryref_data449, i64 %memoryref_byteoffset452, !dbg !812
  %264 = load i64, ptr %memoryref_data457, align 8, !dbg !812, !tbaa !318, !alias.scope !184, !noalias !185
  %265 = trunc i64 %264 to i32, !dbg !813
  %266 = and i32 %265, 8388607, !dbg !814
  %267 = or disjoint i32 %266, 1065353216, !dbg !815
  %bitcast_coercion458 = bitcast i32 %267 to float, !dbg !816
  %268 = fadd float %bitcast_coercion458, -1.000000e+00, !dbg !817
  %269 = fneg float %260, !dbg !819
  %270 = fdiv float %269, %.unbox649, !dbg !820
  %271 = fmul float %270, 0x3FF7154760000000, !dbg !821
  %272 = call float @llvm.rint.f32(float %271), !dbg !824
  %273 = fptosi float %272 to i32, !dbg !826
  %274 = freeze i32 %273, !dbg !826
  %275 = fmul contract float %272, 0x3FE62E4000000000, !dbg !828
  %276 = fsub contract float %270, %275, !dbg !828
  %277 = fmul contract float %272, 0x3EB7F7D1C0000000, !dbg !830
  %278 = fsub contract float %276, %277, !dbg !830
  %279 = fmul contract float %278, 0x3F2A1D7140000000, !dbg !832
  %280 = fadd contract float %279, 0x3F56DA7560000000, !dbg !832
  %281 = fmul contract float %278, %280, !dbg !832
  %282 = fadd contract float %281, 0x3F811105C0000000, !dbg !832
  %283 = fmul contract float %278, %282, !dbg !832
  %284 = fadd contract float %283, 0x3FA5554640000000, !dbg !832
  %285 = fmul contract float %278, %284, !dbg !832
  %286 = fadd contract float %285, 0x3FC5555560000000, !dbg !832
  %287 = fmul contract float %278, %286, !dbg !832
  %288 = fadd contract float %287, 5.000000e-01, !dbg !832
  %289 = fmul contract float %278, %288, !dbg !832
  %290 = fadd contract float %289, 1.000000e+00, !dbg !832
  %291 = fmul contract float %278, %290, !dbg !832
  %292 = fadd contract float %291, 1.000000e+00, !dbg !832
  %293 = fcmp ule float %270, 0x40562E4300000000, !dbg !837
  br i1 %293, label %L1106, label %L1157, !dbg !839

L1106:                                            ; preds = %L1047
  %294 = fcmp uge float %270, 0xC059FE3680000000, !dbg !840
  br i1 %294, label %L1150, label %L1157, !dbg !841

L1150:                                            ; preds = %L1106
  %295 = fcmp ugt float %270, 0xC055D58A00000000, !dbg !842
  %296 = fmul float %292, 0x3E70000000000000, !dbg !843
  %value_phi461 = select i1 %295, float %292, float %296, !dbg !843
  %.not896 = icmp eq i32 %274, 128, !dbg !844
  %297 = fmul float %value_phi461, 2.000000e+00, !dbg !846
  %value_phi463 = select i1 %.not896, float %297, float %value_phi461, !dbg !846
  %value_phi460.v = select i1 %295, i32 127, i32 151, !dbg !843
  %value_phi460 = add i32 %274, %value_phi460.v, !dbg !843
  %298 = sext i1 %.not896 to i32, !dbg !846
  %value_phi462 = add i32 %value_phi460, %298, !dbg !846
  %299 = shl i32 %value_phi462, 23, !dbg !847
  %bitcast_coercion466 = bitcast i32 %299 to float, !dbg !851
  %300 = fmul float %value_phi463, %bitcast_coercion466, !dbg !852
  br label %L1157, !dbg !429

L1157:                                            ; preds = %L1150, %L1106, %L1047
  %value_phi459 = phi float [ %300, %L1150 ], [ 0x7FF0000000000000, %L1047 ], [ 0.000000e+00, %L1106 ]
  %301 = fcmp olt float %268, %value_phi459, !dbg !853
  br i1 %301, label %L1159, label %guard_pass701, !dbg !790

L1159:                                            ; preds = %L1157, %L1027
  %root_phi106.state221 = load atomic ptr, ptr %47 unordered, align 8, !dbg !854, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !292, !align !293
  %root_phi106.state221.size_ptr = getelementptr inbounds i8, ptr %root_phi106.state221, i64 16, !dbg !858
  %root_phi106.state221.size.0.copyload = load i64, ptr %root_phi106.state221.size_ptr, align 8, !dbg !858, !tbaa !270, !alias.scope !300, !noalias !301
  %.not897 = icmp eq i64 %root_phi106.state221.size.0.copyload, 100000, !dbg !860
  br i1 %.not897, label %guard_pass696, label %L1167, !dbg !859

L1167:                                            ; preds = %L1159
  call swiftcc void @j_throw_dmrsa_11079(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi106.state221.size.0.copyload) #8, !dbg !862
  unreachable, !dbg !862

L1244:                                            ; preds = %pass248
  store i64 %.fr, ptr %"new::Tuple208", align 1, !dbg !742, !tbaa !283, !alias.scope !285, !noalias !286
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0775.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext241.sroa.0.sroa.0.sroa.0", i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0775.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.81132, i64 16, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0775.sroa.12.sroa.0, ptr noundef nonnull align 8 dereferenceable(104) %.sroa.5.sroa.0, i64 104, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.10783, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext243.sroa.9", i64 56, i1 false), !dbg !631
  br label %L1255, !dbg !631

L1245:                                            ; preds = %pass248
  %.not900.not.not = icmp eq i64 %value_phi86984, %value_phi83, !dbg !863
  br i1 %.not900.not.not, label %L1250.L1255_crit_edge, label %L1254, !dbg !431

L1250.L1255_crit_edge:                            ; preds = %L1245
  store i64 %.fr, ptr %"new::Tuple208", align 1, !dbg !742, !tbaa !283, !alias.scope !285, !noalias !286
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0775.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext241.sroa.0.sroa.0.sroa.0", i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0775.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.81132, i64 16, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0775.sroa.12.sroa.0, ptr noundef nonnull align 8 dereferenceable(104) %.sroa.5.sroa.0, i64 104, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.10783, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext243.sroa.9", i64 56, i1 false), !dbg !631
  br label %L1255, !dbg !631

L1254:                                            ; preds = %L1245
  %302 = add i64 %value_phi86984, 1, !dbg !429
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %4, ptr noundef nonnull align 8 dereferenceable(80) %.sroa.01111, i64 80, i1 false), !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %.sroa.81140.0..sroa_idx1143, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.3.8.copyload", ptr %.sroa.91145.0..sroa_idx1148, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %.sroa.101150.0..sroa_idx1153, align 8, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.111155.0..sroa_idx1157, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.81132, i64 16, i1 false), !dbg !632
  br label %L666

L1255:                                            ; preds = %L1250.L1255_crit_edge, %L1244, %L641.L1255_crit_edge
  %.sroa.0775.sroa.16.sroa.8.0 = phi i64 [ %.fr1252, %L641.L1255_crit_edge ], [ %.fr, %L1250.L1255_crit_edge ], [ %.fr, %L1244 ], !dbg !631
  %.sroa.0775.sroa.16.sroa.10.0 = phi float [ %79, %L641.L1255_crit_edge ], [ %204, %L1250.L1255_crit_edge ], [ %204, %L1244 ], !dbg !631
  %.sroa.0775.sroa.16.sroa.12.0 = phi float [ %.sroa.71179.0, %L641.L1255_crit_edge ], [ %.sroa.71089.0, %L1250.L1255_crit_edge ], [ %.sroa.71089.0, %L1244 ], !dbg !631
  %.sroa.0775.sroa.16.sroa.16.0 = phi i8 [ %.sroa.91172.0, %L641.L1255_crit_edge ], [ %.sroa.9.0, %L1250.L1255_crit_edge ], [ %.sroa.9.0, %L1244 ], !dbg !631
  %.sroa.8790.0 = phi float [ %146, %L641.L1255_crit_edge ], [ %260, %L1250.L1255_crit_edge ], [ %260, %L1244 ], !dbg !631
  %.sroa.11.0 = phi float [ %"new::NamedTuple.sroa.11.316.copyload", %L641.L1255_crit_edge ], [ %.unbox649, %L1250.L1255_crit_edge ], [ %.unbox649, %L1244 ], !dbg !631
  %.sroa.0.sroa.17.0 = phi double [ %"new::NamedTuple.sroa.6.128.copyload", %L641.L1255_crit_edge ], [ %.sroa.8803.0.copyload805, %L1250.L1255_crit_edge ], [ %.sroa.8803.0.copyload805, %L1244 ], !dbg !631
  %303 = call i64 @jlplt_ijl_hrtime_11074_got.jit(), !dbg !864
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 520, !dbg !870
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528, !dbg !870
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !870, !tbaa !198, !alias.scope !184, !noalias !185
  store i64 %303, ptr %"process::Process.endtime_ptr", align 8, !dbg !870, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !871
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !871, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !872
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !872, !tbaa !273, !range !876
  %304 = and i64 %"process::Process.task.tag", -16, !dbg !872
  %305 = inttoptr i64 %304 to ptr, !dbg !872
  %exactly_isa.not.not = icmp eq ptr %305, @"+Core.Nothing#11085.jit", !dbg !872
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 497, !dbg !872
  %306 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !872
  %307 = and i8 %306, 1, !dbg !875
  %308 = icmp eq i8 %307, 0, !dbg !875
  %.not904 = select i1 %exactly_isa.not.not, i1 true, i1 %308, !dbg !875
  br i1 %.not904, label %L1312, label %L1294, !dbg !875

L1294:                                            ; preds = %L1255
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !877
  %ptls_load1399 = load ptr, ptr %ptls_field, align 8, !dbg !877, !tbaa !156
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1399, i32 1120, i32 400, i64 15322181584) #24, !dbg !877
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !877
  store atomic i64 15322181584, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !877, !tbaa !273
  store atomic ptr %7, ptr %"box::ProcessContext" unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %309 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !877
  store atomic ptr %9, ptr %309 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %310 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !877
  store atomic ptr %11, ptr %310 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %311 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !877
  store atomic ptr %13, ptr %311 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %312 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !877
  store atomic ptr %15, ptr %312 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %313 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !877
  %.sroa.0741.sroa.0.sroa.0.40.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0775.sroa.0.sroa.0, i64 40, !dbg !877
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %313, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0741.sroa.0.sroa.0.40.sroa_idx, i64 16, i1 false), !dbg !877
  %314 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !877
  store atomic ptr %17, ptr %314 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %315 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !877
  store atomic ptr %19, ptr %315 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %316 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !877
  store atomic ptr %21, ptr %316 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %317 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !877
  store atomic ptr %23, ptr %317 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %318 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !877
  store atomic ptr %25, ptr %318 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %319 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !877
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %319, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %320 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !877
  store atomic ptr %27, ptr %320 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %321 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !877
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %321, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %322 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !877
  store atomic ptr %29, ptr %322 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %323 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !877
  store atomic ptr %31, ptr %323 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %324 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !877
  store i64 %.unbox, ptr %324, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.0741.sroa.9.136..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 144, !dbg !877
  store i64 %"new::NamedTuple.sroa.4.128.copyload", ptr %.sroa.0741.sroa.9.136..sroa_idx, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %325 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !877
  store atomic ptr %33, ptr %325 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %326 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !877
  store atomic ptr %35, ptr %326 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %327 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !877
  store atomic ptr %37, ptr %327 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %328 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !877
  store atomic ptr %39, ptr %328 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %329 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !877
  store atomic ptr %41, ptr %329 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %330 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !877
  %.sroa.0741.sroa.10.sroa.0.40.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0775.sroa.12.sroa.0, i64 40, !dbg !877
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %330, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0741.sroa.10.sroa.0.40.sroa_idx, i64 24, i1 false), !dbg !877
  %331 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !877
  store atomic ptr %43, ptr %331 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %332 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !877
  %.sroa.0741.sroa.10.sroa.0.72.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0775.sroa.12.sroa.0, i64 72, !dbg !877
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %332, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0741.sroa.10.sroa.0.72.sroa_idx, i64 24, i1 false), !dbg !877
  %333 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !877
  store atomic ptr %45, ptr %333 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %334 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !877
  %335 = extractelement <2 x i64> %463, i64 0, !dbg !877
  store i64 %335, ptr %334, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %336 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !877
  store atomic ptr %47, ptr %336 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %337 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !877
  store double %.sroa.0.sroa.17.0, ptr %337, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %338 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !877
  store atomic ptr %49, ptr %338 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %339 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !877
  store i64 %.sroa.0775.sroa.16.sroa.8.0, ptr %339, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.0741.sroa.16.sroa.6.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 296, !dbg !877
  store float %.sroa.0775.sroa.16.sroa.10.0, ptr %.sroa.0741.sroa.16.sroa.6.8..sroa_idx, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.0741.sroa.16.sroa.7.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 300, !dbg !877
  store float %.sroa.0775.sroa.16.sroa.12.0, ptr %.sroa.0741.sroa.16.sroa.7.8..sroa_idx, align 4, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.0741.sroa.16.sroa.8.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 304, !dbg !877
  store i64 1, ptr %.sroa.0741.sroa.16.sroa.8.8..sroa_idx, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.0741.sroa.16.sroa.9.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 312, !dbg !877
  store i8 %.sroa.0775.sroa.16.sroa.16.0, ptr %.sroa.0741.sroa.16.sroa.9.8..sroa_idx, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.0741.sroa.16.sroa.10.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 313, !dbg !877
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0741.sroa.16.sroa.10.8..sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, i64 7, i1 false), !dbg !877
  %.sroa.13.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 320, !dbg !877
  store float %.sroa.8790.0, ptr %.sroa.13.288..sroa_idx, align 8, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %.sroa.14.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 324, !dbg !877
  store float %.sroa.11.0, ptr %.sroa.14.288..sroa_idx, align 4, !dbg !877, !tbaa !270, !alias.scope !752, !noalias !753
  %340 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !877
  store atomic ptr %51, ptr %340 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %341 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !877
  store atomic ptr %53, ptr %341 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %342 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !877
  store atomic ptr %55, ptr %342 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %343 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !877
  store atomic ptr %57, ptr %343 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %344 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !877
  store atomic ptr %59, ptr %344 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %345 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !877
  store atomic ptr %61, ptr %345 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  %346 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !877
  store atomic ptr %63, ptr %346 unordered, align 8, !dbg !877, !tbaa !275, !alias.scope !184, !noalias !185
  store atomic ptr %"box::ProcessContext", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !877, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !877
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !877, !tbaa !273, !range !876
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !877
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !877
  br i1 %parent_old_marked, label %may_trigger_wb, label %347, !dbg !877

may_trigger_wb:                                   ; preds = %L1294
  %"box::ProcessContext.tag" = load atomic volatile i64, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !877, !tbaa !273, !range !876
  %child_bit = and i64 %"box::ProcessContext.tag", 1, !dbg !877
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !877
  br i1 %child_not_marked, label %trigger_wb, label %347, !dbg !877, !prof !883

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !877
  br label %347, !dbg !877

347:                                              ; preds = %may_trigger_wb, %trigger_wb, %L1294
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0752.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0775.sroa.0.sroa.0, i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0752.sroa.0.sroa.9, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0775.sroa.0.sroa.11, i64 16, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0752.sroa.10.sroa.0, ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0775.sroa.12.sroa.0, i64 104, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0752.sroa.14.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8759, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.10783, i64 56, i1 false), !dbg !631
  br label %L1322, !dbg !631

L1312:                                            ; preds = %L1255
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0775.sroa.0.sroa.0, i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0", ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0775.sroa.12.sroa.0, i64 104, i1 false), !dbg !631
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !884
  %348 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !884, !tbaa !198, !alias.scope !184, !noalias !185
  %349 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !884
  %350 = load atomic ptr, ptr %349 unordered, align 8, !dbg !884, !tbaa !198, !alias.scope !184, !noalias !185
  %351 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !884
  %352 = load atomic ptr, ptr %351 unordered, align 8, !dbg !884, !tbaa !198, !alias.scope !184, !noalias !185
  %353 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !884
  %354 = load atomic ptr, ptr %353 unordered, align 8, !dbg !884, !tbaa !198, !alias.scope !184, !noalias !185
  %355 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !884
  %356 = load atomic ptr, ptr %355 unordered, align 8, !dbg !884, !tbaa !198, !alias.scope !184, !noalias !185
  %357 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !884
  %358 = load atomic ptr, ptr %357 unordered, align 8, !dbg !884, !tbaa !198, !alias.scope !184, !noalias !185
  %359 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !890
  store atomic ptr %7, ptr %359 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %360 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !890
  store atomic ptr %9, ptr %360 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %361 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !890
  store atomic ptr %11, ptr %361 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %362 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !890
  store atomic ptr %13, ptr %362 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %363 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !890
  store atomic ptr %15, ptr %363 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %364 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !890
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.sroa.0", i64 40, !dbg !890
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %364, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %365 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !890
  store atomic ptr %17, ptr %365 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %366 = getelementptr inbounds i8, ptr %"process::Process", i64 120, !dbg !890
  store atomic ptr %19, ptr %366 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %367 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !890
  store atomic ptr %21, ptr %367 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %368 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !890
  store atomic ptr %23, ptr %368 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %369 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !890
  store atomic ptr %25, ptr %369 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %370 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !890
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %370, align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %371 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !890
  store atomic ptr %27, ptr %371 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %372 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !890
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %372, align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %373 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !890
  store atomic ptr %29, ptr %373 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %374 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !890
  store atomic ptr %31, ptr %374 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %375 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !890
  store i64 %.unbox, ptr %375, align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.136..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 200, !dbg !890
  store i64 %"new::NamedTuple.sroa.4.128.copyload", ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.136..sroa_idx", align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %376 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !890
  store atomic ptr %33, ptr %376 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %377 = getelementptr inbounds i8, ptr %"process::Process", i64 216, !dbg !890
  store atomic ptr %35, ptr %377 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %378 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !890
  store atomic ptr %37, ptr %378 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %379 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !890
  store atomic ptr %39, ptr %379 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %380 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !890
  store atomic ptr %41, ptr %380 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %381 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !890
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0", i64 40, !dbg !890
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %381, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0.40.sroa_idx", i64 24, i1 false), !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %382 = getelementptr inbounds i8, ptr %"process::Process", i64 272, !dbg !890
  store atomic ptr %43, ptr %382 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %383 = getelementptr inbounds i8, ptr %"process::Process", i64 280, !dbg !890
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0.72.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0", i64 72, !dbg !890
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %383, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.7.sroa.0.72.sroa_idx", i64 24, i1 false), !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %384 = getelementptr inbounds i8, ptr %"process::Process", i64 304, !dbg !890
  store atomic ptr %45, ptr %384 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %385 = getelementptr inbounds i8, ptr %"process::Process", i64 312, !dbg !890
  %386 = extractelement <2 x i64> %463, i64 0, !dbg !890
  store i64 %386, ptr %385, align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %387 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !890
  store atomic ptr %47, ptr %387 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %388 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !890
  store double %.sroa.0.sroa.17.0, ptr %388, align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %389 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !890
  store atomic ptr %49, ptr %389 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %390 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !890
  store i64 %.sroa.0775.sroa.16.sroa.8.0, ptr %390, align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !890
  store float %.sroa.0775.sroa.16.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.3.8..sroa_idx", align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 356, !dbg !890
  store float %.sroa.0775.sroa.16.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.4.8..sroa_idx", align 4, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !890
  store i64 1, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.5.8..sroa_idx", align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !890
  store i8 %.sroa.0775.sroa.16.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.6.8..sroa_idx", align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 369, !dbg !890
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.13.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, i64 7, i1 false), !dbg !890
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !890
  store float %.sroa.8790.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 380, !dbg !890
  store float %.sroa.11.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !890, !tbaa !270, !alias.scope !752, !noalias !753
  %391 = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !890
  store atomic ptr %51, ptr %391 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %392 = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !890
  store atomic ptr %53, ptr %392 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %393 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !890
  store atomic ptr %55, ptr %393 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %394 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !890
  store atomic ptr %57, ptr %394 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %395 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !890
  store atomic ptr %59, ptr %395 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %396 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !890
  store atomic ptr %61, ptr %396 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %397 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !890
  store atomic ptr %63, ptr %397 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  store atomic ptr %358, ptr %357 unordered, align 8, !dbg !890, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.tag_addr1401" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !890
  %"process::Process.tag1402" = load atomic volatile i64, ptr %"process::Process.tag_addr1401" unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %parent_bits1403 = and i64 %"process::Process.tag1402", 3, !dbg !890
  %parent_old_marked1404 = icmp eq i64 %parent_bits1403, 3, !dbg !890
  br i1 %parent_old_marked1404, label %may_trigger_wb1405, label %433, !dbg !890

may_trigger_wb1405:                               ; preds = %L1312
  %.tag_addr = getelementptr inbounds i64, ptr %348, i64 -1, !dbg !890
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %.tag_addr1408 = getelementptr inbounds i64, ptr %350, i64 -1, !dbg !890
  %.tag1409 = load atomic volatile i64, ptr %.tag_addr1408 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %398 = and i64 %.tag, %.tag1409, !dbg !890
  %.tag_addr1412 = getelementptr inbounds i64, ptr %352, i64 -1, !dbg !890
  %.tag1413 = load atomic volatile i64, ptr %.tag_addr1412 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %399 = and i64 %398, %.tag1413, !dbg !890
  %.tag_addr1416 = getelementptr inbounds i64, ptr %354, i64 -1, !dbg !890
  %.tag1417 = load atomic volatile i64, ptr %.tag_addr1416 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %400 = and i64 %399, %.tag1417, !dbg !890
  %.tag_addr1420 = getelementptr inbounds i64, ptr %356, i64 -1, !dbg !890
  %.tag1421 = load atomic volatile i64, ptr %.tag_addr1420 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %401 = and i64 %400, %.tag1421, !dbg !890
  %.tag_addr1424 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !890
  %.tag1425 = load atomic volatile i64, ptr %.tag_addr1424 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %402 = and i64 %401, %.tag1425, !dbg !890
  %.tag_addr1428 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !890
  %.tag1429 = load atomic volatile i64, ptr %.tag_addr1428 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %403 = and i64 %402, %.tag1429, !dbg !890
  %.tag_addr1432 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !890
  %.tag1433 = load atomic volatile i64, ptr %.tag_addr1432 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %404 = and i64 %403, %.tag1433, !dbg !890
  %.tag_addr1436 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !890
  %.tag1437 = load atomic volatile i64, ptr %.tag_addr1436 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %405 = and i64 %404, %.tag1437, !dbg !890
  %.tag_addr1440 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !890
  %.tag1441 = load atomic volatile i64, ptr %.tag_addr1440 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %406 = and i64 %405, %.tag1441, !dbg !890
  %.tag_addr1444 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !890
  %.tag1445 = load atomic volatile i64, ptr %.tag_addr1444 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %407 = and i64 %406, %.tag1445, !dbg !890
  %.tag_addr1448 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !890
  %.tag1449 = load atomic volatile i64, ptr %.tag_addr1448 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %408 = and i64 %407, %.tag1449, !dbg !890
  %.tag_addr1452 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !890
  %.tag1453 = load atomic volatile i64, ptr %.tag_addr1452 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %409 = and i64 %408, %.tag1453, !dbg !890
  %.tag_addr1456 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !890
  %.tag1457 = load atomic volatile i64, ptr %.tag_addr1456 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %410 = and i64 %409, %.tag1457, !dbg !890
  %.tag_addr1460 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !890
  %.tag1461 = load atomic volatile i64, ptr %.tag_addr1460 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %411 = and i64 %410, %.tag1461, !dbg !890
  %.tag_addr1464 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !890
  %.tag1465 = load atomic volatile i64, ptr %.tag_addr1464 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %412 = and i64 %411, %.tag1465, !dbg !890
  %.tag_addr1468 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !890
  %.tag1469 = load atomic volatile i64, ptr %.tag_addr1468 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %413 = and i64 %412, %.tag1469, !dbg !890
  %.tag_addr1472 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !890
  %.tag1473 = load atomic volatile i64, ptr %.tag_addr1472 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %414 = and i64 %413, %.tag1473, !dbg !890
  %.tag_addr1476 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !890
  %.tag1477 = load atomic volatile i64, ptr %.tag_addr1476 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %415 = and i64 %414, %.tag1477, !dbg !890
  %.tag_addr1480 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !890
  %.tag1481 = load atomic volatile i64, ptr %.tag_addr1480 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %416 = and i64 %415, %.tag1481, !dbg !890
  %.tag_addr1484 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !890
  %.tag1485 = load atomic volatile i64, ptr %.tag_addr1484 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %417 = and i64 %416, %.tag1485, !dbg !890
  %.tag_addr1488 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !890
  %.tag1489 = load atomic volatile i64, ptr %.tag_addr1488 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %418 = and i64 %417, %.tag1489, !dbg !890
  %.tag_addr1492 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !890
  %.tag1493 = load atomic volatile i64, ptr %.tag_addr1492 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %419 = and i64 %418, %.tag1493, !dbg !890
  %.tag_addr1496 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !890
  %.tag1497 = load atomic volatile i64, ptr %.tag_addr1496 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %420 = and i64 %419, %.tag1497, !dbg !890
  %.tag_addr1500 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !890
  %.tag1501 = load atomic volatile i64, ptr %.tag_addr1500 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %421 = and i64 %420, %.tag1501, !dbg !890
  %.tag_addr1504 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !890
  %.tag1505 = load atomic volatile i64, ptr %.tag_addr1504 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %422 = and i64 %421, %.tag1505, !dbg !890
  %.tag_addr1508 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !890
  %.tag1509 = load atomic volatile i64, ptr %.tag_addr1508 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %423 = and i64 %422, %.tag1509, !dbg !890
  %.tag_addr1512 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !890
  %.tag1513 = load atomic volatile i64, ptr %.tag_addr1512 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %424 = and i64 %423, %.tag1513, !dbg !890
  %.tag_addr1516 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !890
  %.tag1517 = load atomic volatile i64, ptr %.tag_addr1516 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %425 = and i64 %424, %.tag1517, !dbg !890
  %.tag_addr1520 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !890
  %.tag1521 = load atomic volatile i64, ptr %.tag_addr1520 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %426 = and i64 %425, %.tag1521, !dbg !890
  %.tag_addr1524 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !890
  %.tag1525 = load atomic volatile i64, ptr %.tag_addr1524 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %427 = and i64 %426, %.tag1525, !dbg !890
  %.tag_addr1528 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !890
  %.tag1529 = load atomic volatile i64, ptr %.tag_addr1528 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %428 = and i64 %427, %.tag1529, !dbg !890
  %.tag_addr1532 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !890
  %.tag1533 = load atomic volatile i64, ptr %.tag_addr1532 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %429 = and i64 %428, %.tag1533, !dbg !890
  %.tag_addr1536 = getelementptr inbounds i64, ptr %63, i64 -1, !dbg !890
  %.tag1537 = load atomic volatile i64, ptr %.tag_addr1536 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %430 = and i64 %429, %.tag1537, !dbg !890
  %.tag_addr1540 = getelementptr inbounds i64, ptr %358, i64 -1, !dbg !890
  %.tag1541 = load atomic volatile i64, ptr %.tag_addr1540 unordered, align 8, !dbg !890, !tbaa !273, !range !876
  %431 = and i64 %430, %.tag1541, !dbg !890
  %432 = and i64 %431, 1, !dbg !890
  %.not3.not = icmp eq i64 %432, 0, !dbg !890
  br i1 %.not3.not, label %trigger_wb1544, label %433, !dbg !890, !prof !883

trigger_wb1544:                                   ; preds = %may_trigger_wb1405
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !890
  br label %433, !dbg !890

433:                                              ; preds = %may_trigger_wb1405, %trigger_wb1544, %L1312
  %"process::Process.runtime_context_ptr439" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !892
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !892, !tbaa !169, !invariant.load !0, !alias.scope !268, !noalias !269, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr439" release, align 8, !dbg !892, !tbaa !198, !alias.scope !184, !noalias !185
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0752.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0775.sroa.0.sroa.0, i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0752.sroa.0.sroa.9, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0775.sroa.0.sroa.11, i64 16, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0752.sroa.10.sroa.0, ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0775.sroa.12.sroa.0, i64 104, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0752.sroa.14.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0775.sroa.16.sroa.18, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8759, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.10783, i64 56, i1 false), !dbg !631
  br label %L1322, !dbg !631

L1322:                                            ; preds = %433, %347
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0752.sroa.0.sroa.0, i64 96, i1 false), !dbg !869
  %.sroa.0764.sroa.0.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !869
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %.sroa.0764.sroa.0.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.0.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !869
  store i64 %"new::NamedTuple.sroa.0.sroa.3.8.copyload", ptr %.sroa.0764.sroa.0.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.0.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !869
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %.sroa.0764.sroa.0.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.0.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !869
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0764.sroa.0.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0752.sroa.0.sroa.9, i64 16, i1 false), !dbg !869
  %.sroa.0764.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 136, !dbg !869
  store i64 %.unbox, ptr %.sroa.0764.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 144, !dbg !869
  store i64 %"new::NamedTuple.sroa.4.128.copyload", ptr %.sroa.0764.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !869
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0764.sroa.4.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(104) %.sroa.0752.sroa.10.sroa.0, i64 104, i1 false), !dbg !869
  %.sroa.0764.sroa.4.sroa.2.0..sroa.0764.sroa.4.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !869
  store <2 x i64> %463, ptr %.sroa.0764.sroa.4.sroa.2.0..sroa.0764.sroa.4.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !869
  store double %.sroa.0.sroa.17.0, ptr %.sroa.0764.sroa.5.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.6.sroa.2.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !869
  store i64 %.sroa.0775.sroa.16.sroa.8.0, ptr %.sroa.0764.sroa.6.sroa.2.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.6.sroa.3.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !869
  store float %.sroa.0775.sroa.16.sroa.10.0, ptr %.sroa.0764.sroa.6.sroa.3.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.6.sroa.4.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !869
  store float %.sroa.0775.sroa.16.sroa.12.0, ptr %.sroa.0764.sroa.6.sroa.4.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.6.sroa.5.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !869
  store i64 1, ptr %.sroa.0764.sroa.6.sroa.5.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.6.sroa.6.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !869
  store i8 %.sroa.0775.sroa.16.sroa.16.0, ptr %.sroa.0764.sroa.6.sroa.6.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0764.sroa.6.sroa.7.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !869
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0764.sroa.6.sroa.7.0..sroa.0764.sroa.6.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0752.sroa.14.sroa.11, i64 7, i1 false), !dbg !869
  %.sroa.2765.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !869
  store float %.sroa.8790.0, ptr %.sroa.2765.0.sret_return.sroa_idx, align 8, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.3766.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !869
  store float %.sroa.11.0, ptr %.sroa.3766.0.sret_return.sroa_idx, align 4, !dbg !869, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.4767.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !869
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.4767.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8759, i64 56, i1 false), !dbg !869
  store ptr %7, ptr %return_roots, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %434 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !869
  store ptr %9, ptr %434, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %435 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !869
  store ptr %11, ptr %435, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %436 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !869
  store ptr %13, ptr %436, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %437 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !869
  store ptr %15, ptr %437, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %438 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !869
  store ptr %17, ptr %438, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %439 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !869
  store ptr %19, ptr %439, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %440 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !869
  store ptr %21, ptr %440, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %441 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !869
  store ptr %23, ptr %441, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %442 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !869
  store ptr %25, ptr %442, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %443 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !869
  store ptr %27, ptr %443, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %444 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !869
  store ptr %29, ptr %444, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %445 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !869
  store ptr %31, ptr %445, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %446 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !869
  store ptr %33, ptr %446, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %447 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !869
  store ptr %35, ptr %447, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %448 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !869
  store ptr %37, ptr %448, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %449 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !869
  store ptr %39, ptr %449, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %450 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !869
  store ptr %41, ptr %450, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %451 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !869
  store ptr %43, ptr %451, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %452 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !869
  store ptr %45, ptr %452, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %453 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !869
  store ptr %47, ptr %453, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %454 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !869
  store ptr %49, ptr %454, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %455 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !869
  store ptr %51, ptr %455, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %456 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !869
  store ptr %53, ptr %456, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %457 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !869
  store ptr %55, ptr %457, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %458 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !869
  store ptr %57, ptr %458, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %459 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !869
  store ptr %59, ptr %459, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %460 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !869
  store ptr %61, ptr %460, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %461 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !869
  store ptr %63, ptr %461, align 8, !dbg !869, !tbaa !156, !alias.scope !161, !noalias !164
  %frame.prev1545 = load ptr, ptr %frame.prev, align 8, !tbaa !156
  store ptr %frame.prev1545, ptr %pgcstack, align 8, !tbaa !156
  ret void, !dbg !869

pass78:                                           ; preds = %guard_pass642, %guard_pass637
  %"new::NamedTuple.sroa.11.316.copyload" = phi float [ %"new::NamedTuple.sroa.11.316.copyload.pre", %guard_pass637 ], [ %.unbox531, %guard_pass642 ], !dbg !894
  %.sroa.91172.0 = phi i8 [ 1, %guard_pass637 ], [ 0, %guard_pass642 ], !dbg !160
  %462 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 16, !dbg !897
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !894
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %462, i64 80, i1 false), !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.2.8.copyload" = load i64, ptr %116, align 8, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !894
  %"new::NamedTuple.sroa.0.sroa.3.8.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.3.8..sroa_idx", align 8, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.4.8.copyload" = load i64, ptr %138, align 8, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !894
  %"new::NamedTuple.sroa.4.128.copyload" = load i64, ptr %.stop_ptr, align 8, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.5.128..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !894
  %"new::NamedTuple.sroa.5.sroa.2.0.new::NamedTuple.sroa.5.128..sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 256, !dbg !894
  %463 = load <2 x i64>, ptr %"new::NamedTuple.sroa.5.sroa.2.0.new::NamedTuple.sroa.5.128..sroa_idx.sroa_idx", align 8, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.6.128.copyload" = load double, ptr %81, align 8, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !923
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !923
  store i64 1, ptr %6, align 8, !dbg !922, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.loopidx_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 472, !dbg !929
  %464 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !929, !tbaa !198, !alias.scope !184, !noalias !185
  %465 = add <2 x i64> %464, <i64 1, i64 1>, !dbg !934
  store <2 x i64> %465, ptr %"process::Process.loopidx_ptr", align 8, !dbg !935, !tbaa !198, !alias.scope !184, !noalias !185
  %466 = extractelement <2 x i64> %465, i64 0, !dbg !936
  %467 = icmp ugt i64 %466, 100000, !dbg !939
  %468 = extractelement <2 x i64> %464, i64 0, !dbg !943
  %value_phi83 = select i1 %467, i64 %468, i64 100000, !dbg !943
  %.not882.not = icmp ult i64 %value_phi83, %466, !dbg !936
  br i1 %.not882.not, label %L641.L1255_crit_edge, label %L641.L645_crit_edge, !dbg !632

pass248:                                          ; preds = %guard_pass701, %guard_pass696
  %.sroa.9.0 = phi i8 [ 1, %guard_pass696 ], [ 0, %guard_pass701 ], !dbg !631
  %"new::NamedTuple240.sroa.0.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple240.sroa.0.sroa.0.sroa.0", i64 8, !dbg !950
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple240.sroa.0.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %.sroa.01111, i64 80, i1 false), !dbg !950, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::SubContext241.sroa.0.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext241.sroa.0.sroa.0.sroa.0", i64 8, !dbg !966
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext241.sroa.0.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple240.sroa.0.sroa.0.sroa.0", i64 88, i1 false), !dbg !966
  store i64 1, ptr %6, align 8, !dbg !965, !tbaa !198, !alias.scope !184, !noalias !185
  %469 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !969, !tbaa !198, !alias.scope !184, !noalias !185
  %470 = add <2 x i64> %469, <i64 1, i64 1>, !dbg !972
  store <2 x i64> %470, ptr %"process::Process.loopidx_ptr", align 8, !dbg !973, !tbaa !198, !alias.scope !184, !noalias !185
  %471 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !974, !tbaa !198, !alias.scope !184, !noalias !185
  %472 = and i8 %471, 1, !dbg !974
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %472, 0, !dbg !974
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L1244, label %L1245, !dbg !980

guard_pass627:                                    ; preds = %L111
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !160
  store float %79, ptr %unionalloca.sroa.0, align 8, !tbaa !283, !alias.scope !285, !noalias !286
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload9091253 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !335
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !335
  %473 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload9091253 to i32, !dbg !981
  %474 = bitcast i32 %473 to float, !dbg !981
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101185), !dbg !160
  br label %L242

guard_pass632:                                    ; preds = %L196, %L194
  %value_phi571 = phi double [ %106, %L194 ], [ %spec.select712, %L196 ]
  %475 = fcmp ugt double %value_phi571, 2.000000e+00, !dbg !983
  %476 = fadd double %value_phi571, -1.000000e+00, !dbg !986
  %477 = fadd double %value_phi571, -2.000000e+00, !dbg !986
  %478 = fsub double 1.000000e+00, %477, !dbg !986
  %value_phi573 = select i1 %475, double %478, double %476, !dbg !986
  %479 = fptrunc double %value_phi573 to float, !dbg !987
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101185), !dbg !160
  br label %L242

guard_pass637:                                    ; preds = %L532
  %480 = load ptr, ptr %.state56, align 8, !dbg !989, !tbaa !310, !alias.scope !313, !noalias !314
  %481 = getelementptr i8, ptr %480, i64 %memoryref_offset, !dbg !991
  %memoryref_data73 = getelementptr i8, ptr %481, i64 -4, !dbg !991
  store float %.sroa.71179.0, ptr %memoryref_data73, align 4, !dbg !991, !tbaa !318, !alias.scope !184, !noalias !185
  %"new::NamedTuple.sroa.11.316.copyload.pre" = load float, ptr %70, align 4, !dbg !894, !tbaa !270, !alias.scope !271, !noalias !272
  br label %pass78

guard_pass642:                                    ; preds = %L530
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101174, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111191, i64 7, i1 false), !dbg !160
  br label %pass78

guard_pass686:                                    ; preds = %L738
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca176.sroa.0), !dbg !631
  store float %204, ptr %unionalloca176.sroa.0, align 8, !dbg !631, !tbaa !283, !alias.scope !285, !noalias !286
  %unionalloca176.sroa.0.0.unionalloca176.sroa.0.0.unionalloca176.sroa.0.0.unionalloca176.sroa.0.0.copyload9141254 = load i64, ptr %unionalloca176.sroa.0, align 8, !dbg !669
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca176.sroa.0), !dbg !669
  %482 = trunc i64 %unionalloca176.sroa.0.0.unionalloca176.sroa.0.0.unionalloca176.sroa.0.0.unionalloca176.sroa.0.0.copyload9141254 to i32, !dbg !997
  %483 = bitcast i32 %482 to float, !dbg !997
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101095), !dbg !631
  br label %L869, !dbg !631

guard_pass691:                                    ; preds = %L823, %L821
  %value_phi498 = phi double [ %230, %L821 ], [ %spec.select714, %L823 ]
  %484 = fcmp ugt double %value_phi498, 2.000000e+00, !dbg !998
  %485 = fadd double %value_phi498, -1.000000e+00, !dbg !1000
  %486 = fadd double %value_phi498, -2.000000e+00, !dbg !1000
  %487 = fsub double 1.000000e+00, %486, !dbg !1000
  %value_phi500 = select i1 %484, double %487, double %485, !dbg !1000
  %488 = fptrunc double %value_phi500 to float, !dbg !1001
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101095), !dbg !631
  br label %L869, !dbg !631

guard_pass696:                                    ; preds = %L1159
  %489 = load ptr, ptr %root_phi106.state221, align 8, !dbg !1003, !tbaa !310, !alias.scope !313, !noalias !314
  %490 = getelementptr i8, ptr %489, i64 %memoryref_offset159, !dbg !1005
  %memoryref_data238 = getelementptr i8, ptr %490, i64 -4, !dbg !1005
  store float %.sroa.71089.0, ptr %memoryref_data238, align 4, !dbg !1005, !tbaa !318, !alias.scope !184, !noalias !185
  br label %pass248, !dbg !631

guard_pass701:                                    ; preds = %L1157
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !631
  br label %pass248, !dbg !631
}
