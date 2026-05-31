; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xc717d2293eed4322ac39301e2bc7365a))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.Generated)
define swiftcc void @julia_loop_9819(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [1 x ptr]], ptr }, [1 x ptr], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(384) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(232) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(560) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(432) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(384) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [11 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 88, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 8
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %2 = alloca [41 x i64], align 8
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.10649 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple67" = alloca [1 x i64], align 8
  %.sroa.6602 = alloca [7 x i8], align 1
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0.sroa.12 = alloca [8 x i64], align 8
  %.sroa.0.sroa.13 = alloca [4 x i64], align 8
  %.sroa.0.sroa.18.sroa.18 = alloca [7 x i8], align 1
  %"new::ProcessContext.sroa.21" = alloca [7 x i64], align 8
  %.sroa.0421.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0421.sroa.9 = alloca [4 x i64], align 8
  %.sroa.0421.sroa.10 = alloca [8 x i64], align 8
  %.sroa.0421.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0421.sroa.16.sroa.16 = alloca [7 x i8], align 1
  %.sroa.8426 = alloca [7 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4" = alloca [4 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5" = alloca [8 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6" = alloca [4 x i64], align 8
  %"new::Tuple285" = alloca [1 x i64], align 8
  %"new::Tuple288" = alloca [1 x i64], align 8
  %"new::Tuple290" = alloca [1 x i64], align 8
  store i64 36, ptr %gcframe2, align 8, !tbaa !157
  %task.gcstack = load ptr, ptr %pgcstack, align 8
  %frame.prev = getelementptr inbounds ptr, ptr %gcframe2, i64 1
  store ptr %task.gcstack, ptr %frame.prev, align 8, !tbaa !157
  store ptr %gcframe2, ptr %pgcstack, align 8
  call void @llvm.dbg.declare(metadata ptr %"process::Process", metadata !151, metadata !DIExpression()), !dbg !161
  %3 = getelementptr inbounds i8, ptr %.roots.algo, i64 8
  %4 = load ptr, ptr %3, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  call void @llvm.dbg.declare(metadata ptr %"algo::LoopAlgorithm", metadata !152, metadata !DIExpression()), !dbg !161
  %5 = load ptr, ptr %.roots.context, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %6 = getelementptr inbounds i8, ptr %.roots.context, i64 8
  %7 = load ptr, ptr %6, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %8 = getelementptr inbounds i8, ptr %.roots.context, i64 16
  %9 = load ptr, ptr %8, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %10 = getelementptr inbounds i8, ptr %.roots.context, i64 24
  %11 = load ptr, ptr %10, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %12 = getelementptr inbounds i8, ptr %.roots.context, i64 32
  %13 = load ptr, ptr %12, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %14 = getelementptr inbounds i8, ptr %.roots.context, i64 40
  %15 = load ptr, ptr %14, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %16 = getelementptr inbounds i8, ptr %.roots.context, i64 48
  %17 = load ptr, ptr %16, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %18 = getelementptr inbounds i8, ptr %.roots.context, i64 56
  %19 = load ptr, ptr %18, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %20 = getelementptr inbounds i8, ptr %.roots.context, i64 64
  %21 = load ptr, ptr %20, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %22 = getelementptr inbounds i8, ptr %.roots.context, i64 72
  %23 = load ptr, ptr %22, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %24 = getelementptr inbounds i8, ptr %.roots.context, i64 80
  %25 = load ptr, ptr %24, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %26 = getelementptr inbounds i8, ptr %.roots.context, i64 88
  %27 = load ptr, ptr %26, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %28 = getelementptr inbounds i8, ptr %.roots.context, i64 96
  %29 = load ptr, ptr %28, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %30 = getelementptr inbounds i8, ptr %.roots.context, i64 104
  %31 = load ptr, ptr %30, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %32 = getelementptr inbounds i8, ptr %.roots.context, i64 112
  %33 = load ptr, ptr %32, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %34 = getelementptr inbounds i8, ptr %.roots.context, i64 120
  %35 = load ptr, ptr %34, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %36 = getelementptr inbounds i8, ptr %.roots.context, i64 128
  %37 = load ptr, ptr %36, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %38 = getelementptr inbounds i8, ptr %.roots.context, i64 136
  %39 = load ptr, ptr %38, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %40 = getelementptr inbounds i8, ptr %.roots.context, i64 144
  %41 = load ptr, ptr %40, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %42 = getelementptr inbounds i8, ptr %.roots.context, i64 152
  %43 = load ptr, ptr %42, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %44 = getelementptr inbounds i8, ptr %.roots.context, i64 160
  %45 = load ptr, ptr %44, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %46 = getelementptr inbounds i8, ptr %.roots.context, i64 168
  %47 = load ptr, ptr %46, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %48 = getelementptr inbounds i8, ptr %.roots.context, i64 176
  %49 = load ptr, ptr %48, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %50 = getelementptr inbounds i8, ptr %.roots.context, i64 184
  %51 = load ptr, ptr %50, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %52 = getelementptr inbounds i8, ptr %.roots.context, i64 192
  %53 = load ptr, ptr %52, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %54 = getelementptr inbounds i8, ptr %.roots.context, i64 200
  %55 = load ptr, ptr %54, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %56 = getelementptr inbounds i8, ptr %.roots.context, i64 208
  %57 = load ptr, ptr %56, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %58 = getelementptr inbounds i8, ptr %.roots.context, i64 216
  %59 = load ptr, ptr %58, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  %60 = getelementptr inbounds i8, ptr %.roots.context, i64 224
  %61 = load ptr, ptr %60, align 8, !tbaa !157, !alias.scope !162, !noalias !165
  call void @llvm.dbg.declare(metadata ptr %"context::ProcessContext", metadata !153, metadata !DIExpression()), !dbg !161
  %ptls_field = getelementptr inbounds i8, ptr %pgcstack, i64 16
  %ptls_load = load ptr, ptr %ptls_field, align 8, !tbaa !157
  %62 = getelementptr inbounds i8, ptr %ptls_load, i64 16
  %safepoint = load ptr, ptr %62, align 8, !tbaa !170, !invariant.load !0
  fence syncscope("singlethread") seq_cst
  %63 = load volatile i64, ptr %safepoint, align 8, !dbg !161
  fence syncscope("singlethread") seq_cst
  store i8 1, ptr @"jl_global#9822.jit", align 32, !dbg !172, !tbaa !187, !alias.scope !190, !noalias !191
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !192
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !192, !tbaa !157, !alias.scope !162, !noalias !165
  %64 = sext i16 %thread_id to i64, !dbg !196
  %65 = add nsw i64 %64, 1, !dbg !201
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !203
  store i64 %65, ptr %"process::Process.threadid_ptr", align 8, !dbg !203, !tbaa !204, !alias.scope !190, !noalias !191
  %66 = call i64 @jlplt_ijl_hrtime_9824_got.jit(), !dbg !206
  %"process::Process.starttime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 504, !dbg !212
  %"process::Process.starttime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 512, !dbg !212
  store i8 2, ptr %"process::Process.starttime.tindex_ptr", align 1, !dbg !212, !tbaa !204, !alias.scope !190, !noalias !191
  store i64 %66, ptr %"process::Process.starttime_ptr", align 8, !dbg !212, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.loopidx_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 472, !dbg !213
  %"process::Process.loopidx" = load i64, ptr %"process::Process.loopidx_ptr", align 8, !dbg !213, !tbaa !204, !alias.scope !190, !noalias !191
  %67 = icmp ugt i64 %"process::Process.loopidx", 100000, !dbg !218
  %68 = add i64 %"process::Process.loopidx", -1, !dbg !223
  %value_phi = select i1 %67, i64 %68, i64 100000, !dbg !223
  %.not.not = icmp ult i64 %value_phi, %"process::Process.loopidx", !dbg !232
  br i1 %.not.not, label %L34.L650_crit_edge, label %L34.L38_crit_edge, !dbg !231

L34.L650_crit_edge:                               ; preds = %top
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !238
  %".sroa.0.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !238
  %.sroa.0.sroa.8.0.copyload = load i64, ptr %".sroa.0.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.9.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !238
  %.sroa.0.sroa.9.0.copyload = load i64, ptr %".sroa.0.sroa.9.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !238
  %.sroa.0.sroa.10.0.copyload = load i64, ptr %".sroa.0.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !238
  %".sroa.0.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !238
  %".sroa.0.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !238
  %".sroa.0.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !238
  %.sroa.0.sroa.14.0.copyload = load i64, ptr %".sroa.0.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.15.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 256, !dbg !238
  %.sroa.0.sroa.15.0.copyload = load i64, ptr %".sroa.0.sroa.15.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !238
  %.sroa.0.sroa.16.0.copyload = load i64, ptr %".sroa.0.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.17.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 272, !dbg !238
  %.sroa.0.sroa.17.0.copyload = load i64, ptr %".sroa.0.sroa.17.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !238
  %.sroa.0.sroa.18.sroa.0.0.copyload = load i64, ptr %".sroa.0.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.sroa.8.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 288, !dbg !238
  %.sroa.0.sroa.18.sroa.8.0.copyload = load i64, ptr %".sroa.0.sroa.18.sroa.8.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.sroa.10.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !238
  %.sroa.0.sroa.18.sroa.10.0.copyload = load float, ptr %".sroa.0.sroa.18.sroa.10.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.sroa.12.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 300, !dbg !238
  %.sroa.0.sroa.18.sroa.12.0.copyload = load float, ptr %".sroa.0.sroa.18.sroa.12.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 4, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.sroa.14.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !238
  %.sroa.0.sroa.18.sroa.14.0.copyload = load i64, ptr %".sroa.0.sroa.18.sroa.14.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.sroa.16.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !238
  %.sroa.0.sroa.18.sroa.16.0.copyload = load i8, ptr %".sroa.0.sroa.18.sroa.16.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0.sroa.18.sroa.18.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0.sroa.18.sroa.18.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", i64 7, i1 false), !dbg !238
  %".sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !238
  %.sroa.8.0.copyload393 = load float, ptr %".sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !238
  %.sroa.10.0.copyload394 = load i32, ptr %".sroa.10.0.context::ProcessContext.sroa_idx", align 4, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  br label %L659, !dbg !238

L34.L38_crit_edge:                                ; preds = %top
  %".sroa.0433.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !238
  %".sroa.0433.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !238
  %.sroa.0433.sroa.10.0.copyload662 = load i64, ptr %".sroa.0433.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0433.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !238
  %".sroa.0433.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !238
  %".sroa.0433.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !238
  %".sroa.0433.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !238
  %".sroa.0433.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !238
  %".sroa.0433.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !238
  %".sroa.0433.sroa.20.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !238
  %".sroa.0433.sroa.22.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !238
  %.sroa.0433.sroa.22.0.copyload692 = load i64, ptr %".sroa.0433.sroa.22.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0433.sroa.23.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !238
  %.sroa.0433.sroa.23.0.copyload695 = load i8, ptr %".sroa.0433.sroa.23.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.0433.sroa.24.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !238
  %".sroa.6434.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !238
  %.sroa.6434.0.copyload435 = load float, ptr %".sroa.6434.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  %".sroa.7436.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !238
  %.sroa.7436.0.copyload437 = load i32, ptr %".sroa.7436.0.context::ProcessContext.sroa_idx", align 4, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !231
  %.sroa.0433.sroa.8.0..sroa_idx657 = getelementptr inbounds i8, ptr %2, i64 96, !dbg !231
  %.sroa.0433.sroa.9.0..sroa_idx660 = getelementptr inbounds i8, ptr %2, i64 104, !dbg !231
  %69 = load <2 x i64>, ptr %".sroa.0433.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  store <2 x i64> %69, ptr %.sroa.0433.sroa.8.0..sroa_idx657, align 8, !dbg !231
  %.sroa.0433.sroa.10.0..sroa_idx663 = getelementptr inbounds i8, ptr %2, i64 112, !dbg !231
  store i64 %.sroa.0433.sroa.10.0.copyload662, ptr %.sroa.0433.sroa.10.0..sroa_idx663, align 8, !dbg !231
  %.sroa.0433.sroa.11.0..sroa_idx665 = getelementptr inbounds i8, ptr %2, i64 120, !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.11.0..sroa_idx665, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0433.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !231
  %.sroa.0433.sroa.12.0..sroa_idx666 = getelementptr inbounds i8, ptr %2, i64 152, !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0433.sroa.12.0..sroa_idx666, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0433.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !231
  %.sroa.0433.sroa.13.0..sroa_idx667 = getelementptr inbounds i8, ptr %2, i64 216, !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.13.0..sroa_idx667, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0433.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !231
  %.sroa.0433.sroa.14.0..sroa_idx669 = getelementptr inbounds i8, ptr %2, i64 248, !dbg !231
  %.sroa.0433.sroa.15.0..sroa_idx672 = getelementptr inbounds i8, ptr %2, i64 256, !dbg !231
  %70 = load <2 x i64>, ptr %".sroa.0433.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  store <2 x i64> %70, ptr %.sroa.0433.sroa.14.0..sroa_idx669, align 8, !dbg !231
  %.sroa.0433.sroa.16.0..sroa_idx675 = getelementptr inbounds i8, ptr %2, i64 264, !dbg !231
  %.sroa.0433.sroa.17.0..sroa_idx678 = getelementptr inbounds i8, ptr %2, i64 272, !dbg !231
  %71 = load <2 x i64>, ptr %".sroa.0433.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  store <2 x i64> %71, ptr %.sroa.0433.sroa.16.0..sroa_idx675, align 8, !dbg !231
  %.sroa.0433.sroa.18.0..sroa_idx681 = getelementptr inbounds i8, ptr %2, i64 280, !dbg !231
  %.sroa.0433.sroa.19.0..sroa_idx684 = getelementptr inbounds i8, ptr %2, i64 288, !dbg !231
  %72 = load <2 x i64>, ptr %".sroa.0433.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  store <2 x i64> %72, ptr %.sroa.0433.sroa.18.0..sroa_idx681, align 8, !dbg !231
  %.sroa.0433.sroa.20.0..sroa_idx687 = getelementptr inbounds i8, ptr %2, i64 296, !dbg !231
  %.sroa.0433.sroa.21.0..sroa_idx690 = getelementptr inbounds i8, ptr %2, i64 300, !dbg !231
  %73 = load <2 x float>, ptr %".sroa.0433.sroa.20.0.context::ProcessContext.sroa_idx", align 8, !dbg !238, !tbaa !240, !alias.scope !241, !noalias !242
  store <2 x float> %73, ptr %.sroa.0433.sroa.20.0..sroa_idx687, align 8, !dbg !231
  %.sroa.0433.sroa.22.0..sroa_idx693 = getelementptr inbounds i8, ptr %2, i64 304, !dbg !231
  store i64 %.sroa.0433.sroa.22.0.copyload692, ptr %.sroa.0433.sroa.22.0..sroa_idx693, align 8, !dbg !231
  %.sroa.0433.sroa.23.0..sroa_idx696 = getelementptr inbounds i8, ptr %2, i64 312, !dbg !231
  store i8 %.sroa.0433.sroa.23.0.copyload695, ptr %.sroa.0433.sroa.23.0..sroa_idx696, align 8, !dbg !231
  %.sroa.0433.sroa.24.0..sroa_idx698 = getelementptr inbounds i8, ptr %2, i64 313, !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0433.sroa.24.0..sroa_idx698, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0433.sroa.24.0.context::ProcessContext.sroa_idx", i64 7, i1 false), !dbg !231
  %.sroa.6434.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 320, !dbg !231
  store float %.sroa.6434.0.copyload435, ptr %.sroa.6434.0..sroa_idx, align 8, !dbg !231
  %.sroa.7436.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 324, !dbg !231
  store i32 %.sroa.7436.0.copyload437, ptr %.sroa.7436.0..sroa_idx, align 4, !dbg !231
  %74 = getelementptr inbounds i8, ptr %2, i64 136, !dbg !243
  %.stop_ptr = getelementptr inbounds i8, ptr %2, i64 144, !dbg !251
  %.stop_ptr.unbox523 = load i64, ptr %.stop_ptr, align 8, !dbg !275, !tbaa !277, !alias.scope !279, !noalias !280
  %.unbox524 = load i64, ptr %74, align 8, !dbg !275, !tbaa !277, !alias.scope !279, !noalias !280
  %.not525 = icmp slt i64 %.stop_ptr.unbox523, %.unbox524, !dbg !275
  %75 = extractelement <2 x i64> %71, i64 1, !dbg !255
  %76 = bitcast i64 %75 to double, !dbg !255
  %77 = bitcast <2 x i64> %69 to i128, !dbg !255
  %78 = trunc i128 %77 to i64, !dbg !255
  %79 = extractelement <2 x i64> %69, i64 1, !dbg !255
  %80 = extractelement <2 x i64> %70, i64 0, !dbg !255
  %81 = extractelement <2 x i64> %70, i64 1, !dbg !255
  %82 = extractelement <2 x i64> %71, i64 0, !dbg !255
  br i1 %.not525, label %L56, label %L59.lr.ph, !dbg !255

L59.lr.ph:                                        ; preds = %L34.L38_crit_edge
  %83 = trunc i128 %77 to i32, !dbg !255
  %84 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8
  %root_phi26.idxF_ptr294 = getelementptr inbounds i8, ptr %47, i64 32
  %root_phi26.vals_ptr296 = getelementptr inbounds i8, ptr %47, i64 16
  %85 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8
  %86 = getelementptr inbounds i8, ptr %2, i64 40
  %root_phi7.size_ptr = getelementptr inbounds i8, ptr %9, i64 16
  %87 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %88 = getelementptr inbounds ptr, ptr %gcframe2, i64 4
  %89 = getelementptr inbounds ptr, ptr %gcframe2, i64 5
  %90 = getelementptr inbounds ptr, ptr %gcframe2, i64 6
  %91 = getelementptr inbounds i8, ptr %2, i64 16
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496
  %"new::Tuple67.promoted" = load i64, ptr %"new::Tuple67", align 1, !tbaa !277, !alias.scope !279, !noalias !280
  br label %L59, !dbg !255

L56:                                              ; preds = %L649, %L34.L38_crit_edge
  %92 = call swiftcc [1 x ptr] @j_ArgumentError_9825(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9826.jit"), !dbg !255
  %gc_slot_addr_7 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %93 = extractvalue [1 x ptr] %92, 0, !dbg !255
  store ptr %93, ptr %gc_slot_addr_7, align 8
  %ptls_load956 = load ptr, ptr %ptls_field, align 8, !dbg !255, !tbaa !157
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load956, i32 424, i32 16, i64 4909254640) #23, !dbg !255
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !255
  store atomic i64 4909254640, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !255, !tbaa !281
  store ptr %93, ptr %"box::ArgumentError", align 8, !dbg !255, !tbaa !283, !alias.scope !190, !noalias !191
  store ptr null, ptr %gc_slot_addr_7, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !255
  unreachable, !dbg !255

L59:                                              ; preds = %L649, %L59.lr.ph
  %94 = phi i64 [ %"new::Tuple67.promoted", %L59.lr.ph ], [ %.fr785, %L649 ]
  %.unbox528 = phi i64 [ %.unbox524, %L59.lr.ph ], [ %.unbox, %L649 ]
  %.stop_ptr.unbox527 = phi i64 [ %.stop_ptr.unbox523, %L59.lr.ph ], [ %.stop_ptr.unbox, %L649 ]
  %value_phi5526 = phi i64 [ %"process::Process.loopidx", %L59.lr.ph ], [ %198, %L649 ]
  %.unbox66 = bitcast i32 %83 to float, !dbg !255
  %.unbox274 = bitcast i32 %.sroa.7436.0.copyload437 to float, !dbg !255
  %95 = add i64 %.stop_ptr.unbox527, 1, !dbg !285
  %96 = sub i64 %95, %.unbox528, !dbg !288
  store i64 %.unbox528, ptr %"new::SamplerRangeNDL", align 8, !dbg !289, !tbaa !277, !alias.scope !279, !noalias !280
  store i64 %96, ptr %84, align 8, !dbg !289, !tbaa !277, !alias.scope !279, !noalias !280
  %97 = call swiftcc i64 @j_rand_9828(ptr nonnull swiftself %pgcstack, ptr %47, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !263
  %.fr785 = freeze i64 %97
  %root_phi25.state = load atomic ptr, ptr %45 unordered, align 8, !dbg !291, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !296, !align !297
  %root_phi25.state.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state, i64 16, !dbg !298
  %root_phi25.state.size.0.copyload = load i64, ptr %root_phi25.state.size_ptr, align 8, !dbg !298, !tbaa !240, !alias.scope !304, !noalias !305
  %.not438 = icmp eq i64 %root_phi25.state.size.0.copyload, 100000, !dbg !306
  br i1 %.not438, label %L85, label %L80, !dbg !301

L80:                                              ; preds = %L59
  call swiftcc void @j_throw_dmrsa_9829(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state.size.0.copyload) #9, !dbg !311
  unreachable, !dbg !311

L85:                                              ; preds = %L59
  %98 = load ptr, ptr %root_phi25.state, align 8, !dbg !312, !tbaa !314, !alias.scope !317, !noalias !318
  %memoryref_offset = shl i64 %.fr785, 2, !dbg !319
  %99 = getelementptr i8, ptr %98, i64 %memoryref_offset, !dbg !319
  %memoryref_data35 = getelementptr i8, ptr %99, i64 -4, !dbg !319
  %100 = load float, ptr %memoryref_data35, align 4, !dbg !319, !tbaa !322, !alias.scope !190, !noalias !191
  %101 = icmp slt i64 %.fr785, 100001
  br i1 %101, label %L131, label %L244, !dbg !324

L131:                                             ; preds = %L85
  %102 = call double @llvm.fabs.f64(double %76), !dbg !331
  %103 = fcmp oeq double %76, 0.000000e+00, !dbg !343
  br i1 %103, label %guard_pass362, label %L136, !dbg !345

L136:                                             ; preds = %L131
  %root_phi26.idxF295 = load i64, ptr %root_phi26.idxF_ptr294, align 8, !dbg !346, !tbaa !204, !alias.scope !190, !noalias !191
  %.not443 = icmp eq i64 %root_phi26.idxF295, 1002, !dbg !365
  br i1 %.not443, label %L139, label %L141, !dbg !350

L139:                                             ; preds = %L136
  %104 = call swiftcc i64 @j_gen_rand_9836(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !350
  %root_phi26.idxF299.pre = load i64, ptr %root_phi26.idxF_ptr294, align 8, !dbg !366, !tbaa !204, !alias.scope !190, !noalias !191
  br label %L141, !dbg !350

L141:                                             ; preds = %L139, %L136
  %root_phi26.idxF299 = phi i64 [ %root_phi26.idxF295, %L136 ], [ %root_phi26.idxF299.pre, %L139 ], !dbg !366
  %root_phi26.vals297 = load atomic ptr, ptr %root_phi26.vals_ptr296 unordered, align 8, !dbg !366, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !296, !align !297
  %105 = add i64 %root_phi26.idxF299, 1, !dbg !373
  store i64 %105, ptr %root_phi26.idxF_ptr294, align 8, !dbg !374, !tbaa !204, !alias.scope !190, !noalias !191
  %memoryref_data302 = load ptr, ptr %root_phi26.vals297, align 8, !dbg !375, !tbaa !314, !alias.scope !317, !noalias !318
  %memoryref_byteoffset305 = shl i64 %root_phi26.idxF299, 3, !dbg !375
  %memoryref_data310 = getelementptr inbounds i8, ptr %memoryref_data302, i64 %memoryref_byteoffset305, !dbg !375
  %106 = load i64, ptr %memoryref_data310, align 8, !dbg !375, !tbaa !322, !alias.scope !190, !noalias !191
  %107 = trunc i64 %106 to i32, !dbg !376
  %108 = and i32 %107, 8388607, !dbg !377
  %109 = or disjoint i32 %108, 1065353216, !dbg !379
  %bitcast_coercion312 = bitcast i32 %109 to float, !dbg !381
  %110 = fadd float %bitcast_coercion312, -1.000000e+00, !dbg !383
  %111 = fmul float %110, 2.000000e+00, !dbg !387
  %112 = fadd float %111, -1.000000e+00, !dbg !391
  %113 = fpext float %112 to double, !dbg !392
  %114 = fmul double %102, %113, !dbg !387
  %115 = fpext float %100 to double, !dbg !401
  %116 = fadd double %114, %115, !dbg !407
  %117 = fadd double %116, 1.000000e+00, !dbg !409
  %118 = fsub double %117, %117, !dbg !414
  %119 = fcmp uno double %118, 0.000000e+00, !dbg !423
  %120 = fcmp oeq double %117, 0.000000e+00
  %or.cond = or i1 %119, %120, !dbg !417
  %121 = call double @llvm.fabs.f64(double %117), !dbg !427
  br i1 %or.cond, label %L201, label %L197, !dbg !417

L197:                                             ; preds = %L141
  %122 = call swiftcc double @j_rem_internal_9840(ptr nonnull swiftself %pgcstack, double %121, double 4.000000e+00), !dbg !428
  %123 = call double @llvm.copysign.f64(double %122, double %117), !dbg !429
  br label %L209, !dbg !432

L201:                                             ; preds = %L141
  %124 = bitcast double %121 to i64, !dbg !434
  %.not444 = icmp eq i64 %124, 9218868437227405312, !dbg !434
  br i1 %.not444, label %L216, label %L209, !dbg !436

L209:                                             ; preds = %L201, %L197
  %value_phi313 = phi double [ %123, %L197 ], [ %117, %L201 ]
  %125 = fcmp une double %value_phi313, 0.000000e+00, !dbg !437
  br i1 %125, label %L216, label %L214, !dbg !439

L214:                                             ; preds = %L209
  %126 = call double @llvm.fabs.f64(double %value_phi313), !dbg !440
  br label %guard_pass367, !dbg !432

L216:                                             ; preds = %L209, %L201
  %value_phi313460 = phi double [ %value_phi313, %L209 ], [ 0x7FF8000000000000, %L201 ]
  %127 = fcmp ogt double %value_phi313460, 0.000000e+00, !dbg !442
  %128 = fadd double %value_phi313460, 4.000000e+00
  %spec.select384 = select i1 %127, double %value_phi313460, double %128, !dbg !446
  br label %guard_pass367, !dbg !446

L244:                                             ; preds = %L85
  store i64 %94, ptr %"new::Tuple67", align 1, !dbg !447, !tbaa !277, !alias.scope !279, !noalias !280
  %jl_nothing319 = load ptr, ptr @jl_nothing, align 8, !dbg !462, !tbaa !170, !invariant.load !0, !alias.scope !465, !noalias !466, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %100), !dbg !462
  %gc_slot_addr_8 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  store ptr %box_Float32, ptr %gc_slot_addr_8, align 8
  %ptls_load961 = load ptr, ptr %ptls_field, align 8, !dbg !462, !tbaa !157
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load961, i32 424, i32 16, i64 4909834384) #23, !dbg !462
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !462
  store atomic i64 4909834384, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !462, !tbaa !281
  store i64 %75, ptr %"box::Float64", align 8, !dbg !462, !tbaa !240, !alias.scope !467, !noalias !468
  %gc_slot_addr_7946 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %"box::Float64", ptr %gc_slot_addr_7946, align 8
  store ptr @"jl_global#9841.jit", ptr %jlcallframe1, align 8, !dbg !462
  %129 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !462
  store ptr %47, ptr %129, align 8, !dbg !462
  %130 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !462
  store ptr %jl_nothing319, ptr %130, align 8, !dbg !462
  %131 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !462
  store ptr %box_Float32, ptr %131, align 8, !dbg !462
  %132 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !462
  store ptr %"box::Float64", ptr %132, align 8, !dbg !462
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !462
  call void @llvm.trap(), !dbg !462
  unreachable, !dbg !462

L262:                                             ; preds = %guard_pass367, %guard_pass362
  %.sroa.7643.0 = phi float [ %361, %guard_pass362 ], [ %366, %guard_pass367 ], !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10649, i64 7, i1 false), !dbg !469
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10649), !dbg !469
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !459
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !469, !tbaa !277, !alias.scope !279, !noalias !280
  store i64 %.fr785, ptr %85, align 8, !dbg !459, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !459
  store float %100, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !459, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !459
  store float %.sroa.7643.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !459, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !459
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !459, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !459
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !459, !tbaa !277, !alias.scope !279, !noalias !280
  %133 = add i64 %.fr785, -1, !dbg !470
  %root_phi7.size.0.copyload = load i64, ptr %root_phi7.size_ptr, align 8, !dbg !474, !tbaa !240, !alias.scope !304, !noalias !305
  %.not445 = icmp ult i64 %133, %root_phi7.size.0.copyload, !dbg !470
  br i1 %.not445, label %L320, label %L317, !dbg !470

L317:                                             ; preds = %L262
  store i64 %.fr785, ptr %"new::Tuple290", align 8, !dbg !470, !tbaa !277, !alias.scope !279, !noalias !280
  call swiftcc void @j_throw_boundserror_9838(ptr nonnull swiftself %pgcstack, ptr %9, ptr nocapture nonnull readonly %"new::Tuple290") #9, !dbg !470
  unreachable, !dbg !470

L320:                                             ; preds = %L262
  %root_phi6.state = load atomic ptr, ptr %7 unordered, align 8, !dbg !475, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !296, !align !297
  %memoryref_data46 = load ptr, ptr %9, align 8, !dbg !479, !tbaa !314, !alias.scope !317, !noalias !318
  %134 = getelementptr i8, ptr %memoryref_data46, i64 %memoryref_offset, !dbg !479
  %memoryref_data54 = getelementptr i8, ptr %134, i64 -4, !dbg !479
  %135 = load float, ptr %memoryref_data54, align 4, !dbg !479, !tbaa !322, !alias.scope !190, !noalias !191
  %136 = fpext float %.sroa.7643.0 to double, !dbg !480
  %gc_slot_addr_7947 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %root_phi6.state, ptr %gc_slot_addr_7947, align 8
  %137 = call swiftcc double @"j_#power_by_squaring#401_9832"(ptr nonnull swiftself %pgcstack, double %136, i64 signext 2), !dbg !487
  %root_phi6.state.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state, i64 16, !dbg !474
  %root_phi6.state.size.0.copyload = load i64, ptr %root_phi6.state.size_ptr, align 8, !dbg !474, !tbaa !240, !alias.scope !304, !noalias !305
  %.not446 = icmp ult i64 %133, %root_phi6.state.size.0.copyload, !dbg !470
  br i1 %.not446, label %L345, label %L342, !dbg !470

L342:                                             ; preds = %L320
  store i64 %.fr785, ptr %"new::Tuple288", align 8, !dbg !470, !tbaa !277, !alias.scope !279, !noalias !280
  store ptr %root_phi6.state, ptr %gc_slot_addr_7947, align 8
  call swiftcc void @j_throw_boundserror_9838(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state, ptr nocapture nonnull readonly %"new::Tuple288") #9, !dbg !470
  unreachable, !dbg !470

L345:                                             ; preds = %L320
  %138 = fptrunc double %137 to float, !dbg !490
  %memoryref_data56 = load ptr, ptr %root_phi6.state, align 8, !dbg !479, !tbaa !314, !alias.scope !317, !noalias !318
  %139 = getelementptr i8, ptr %memoryref_data56, i64 %memoryref_offset, !dbg !479
  %memoryref_data64 = getelementptr i8, ptr %139, i64 -4, !dbg !479
  %140 = load float, ptr %memoryref_data64, align 4, !dbg !479, !tbaa !322, !alias.scope !190, !noalias !191
  %141 = fpext float %140 to double, !dbg !480
  store ptr null, ptr %gc_slot_addr_7947, align 8
  %142 = call swiftcc double @"j_#power_by_squaring#401_9832"(ptr nonnull swiftself %pgcstack, double %141, i64 signext 2), !dbg !487
  %143 = fptrunc double %142 to float, !dbg !490
  %144 = fsub float %138, %143, !dbg !495
  %145 = fmul float %135, 0.000000e+00, !dbg !496
  %146 = fmul float %145, %144, !dbg !496
  %147 = fadd float %146, 0.000000e+00, !dbg !499
  store ptr %7, ptr %0, align 8, !dbg !456
  store ptr %15, ptr %1, align 8, !dbg !456
  store ptr %17, ptr %87, align 8, !dbg !456
  store ptr %19, ptr %88, align 8, !dbg !456
  store ptr %21, ptr %89, align 8, !dbg !456
  store ptr %23, ptr %90, align 8, !dbg !456
  %148 = call swiftcc float @"j_#calculate##0_9833"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %0, float %147, ptr nocapture nonnull readonly %86, ptr nocapture nonnull readonly %1), !dbg !456
  %149 = fneg float %.unbox66, !dbg !500
  %.not447 = icmp ult i64 %133, %.sroa.0433.sroa.10.0.copyload662, !dbg !501
  br i1 %.not447, label %L403, label %L400, !dbg !507

L400:                                             ; preds = %L345
  %150 = getelementptr inbounds ptr, ptr %gcframe2, i64 7
  store i64 %.fr785, ptr %"new::Tuple67", align 1, !dbg !447, !tbaa !277, !alias.scope !279, !noalias !280
  store ptr %25, ptr %150, align 8, !dbg !507
  call swiftcc void @j_throw_boundserror_9839(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.0433.sroa.9.0..sroa_idx660, ptr nocapture nonnull readonly %150, ptr nocapture nonnull readonly %"new::Tuple67") #9, !dbg !507
  unreachable, !dbg !507

L403:                                             ; preds = %L345
  %root_phi6.state65 = load atomic ptr, ptr %7 unordered, align 8, !dbg !508, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !296, !align !297
  %root_phi6.state65.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state65, i64 16, !dbg !510
  %root_phi6.state65.size.0.copyload = load i64, ptr %root_phi6.state65.size_ptr, align 8, !dbg !510, !tbaa !240, !alias.scope !304, !noalias !305
  %.not448 = icmp ult i64 %133, %root_phi6.state65.size.0.copyload, !dbg !511
  br i1 %.not448, label %L420, label %L417, !dbg !511

L417:                                             ; preds = %L403
  store i64 %.fr785, ptr %"new::Tuple285", align 8, !dbg !511, !tbaa !277, !alias.scope !279, !noalias !280
  store ptr %root_phi6.state65, ptr %gc_slot_addr_7947, align 8
  call swiftcc void @j_throw_boundserror_9838(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state65, ptr nocapture nonnull readonly %"new::Tuple285") #9, !dbg !511
  unreachable, !dbg !511

L420:                                             ; preds = %L403
  %root_phi15.x = load float, ptr %25, align 4, !dbg !512, !tbaa !204, !alias.scope !190, !noalias !191
  %memoryref_data70 = load ptr, ptr %root_phi6.state65, align 8, !dbg !516, !tbaa !314, !alias.scope !317, !noalias !318
  %151 = getelementptr i8, ptr %memoryref_data70, i64 %memoryref_offset, !dbg !516
  %memoryref_data78 = getelementptr i8, ptr %151, i64 -4, !dbg !516
  %152 = load float, ptr %memoryref_data78, align 4, !dbg !516, !tbaa !322, !alias.scope !190, !noalias !191
  %153 = fsub float %.sroa.7643.0, %152, !dbg !517
  %154 = fmul float %root_phi15.x, %149, !dbg !518
  %155 = fmul float %154, %153, !dbg !518
  %156 = fadd float %148, %155, !dbg !499
  %157 = fcmp ugt float %156, 0.000000e+00, !dbg !520
  br i1 %157, label %L435, label %L552, !dbg !522

L435:                                             ; preds = %L420
  %root_phi26.idxF = load i64, ptr %root_phi26.idxF_ptr294, align 8, !dbg !523, !tbaa !204, !alias.scope !190, !noalias !191
  %.not449 = icmp eq i64 %root_phi26.idxF, 1002, !dbg !536
  br i1 %.not449, label %L438, label %L440, !dbg !525

L438:                                             ; preds = %L435
  %158 = call swiftcc i64 @j_gen_rand_9836(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !525
  %root_phi26.idxF261.pre = load i64, ptr %root_phi26.idxF_ptr294, align 8, !dbg !537, !tbaa !204, !alias.scope !190, !noalias !191
  br label %L440, !dbg !525

L440:                                             ; preds = %L438, %L435
  %root_phi26.idxF261 = phi i64 [ %root_phi26.idxF, %L435 ], [ %root_phi26.idxF261.pre, %L438 ], !dbg !537
  %root_phi26.vals = load atomic ptr, ptr %root_phi26.vals_ptr296 unordered, align 8, !dbg !537, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !296, !align !297
  %159 = add i64 %root_phi26.idxF261, 1, !dbg !542
  store i64 %159, ptr %root_phi26.idxF_ptr294, align 8, !dbg !543, !tbaa !204, !alias.scope !190, !noalias !191
  %memoryref_data264 = load ptr, ptr %root_phi26.vals, align 8, !dbg !544, !tbaa !314, !alias.scope !317, !noalias !318
  %memoryref_byteoffset267 = shl i64 %root_phi26.idxF261, 3, !dbg !544
  %memoryref_data272 = getelementptr inbounds i8, ptr %memoryref_data264, i64 %memoryref_byteoffset267, !dbg !544
  %160 = load i64, ptr %memoryref_data272, align 8, !dbg !544, !tbaa !322, !alias.scope !190, !noalias !191
  %161 = trunc i64 %160 to i32, !dbg !545
  %162 = and i32 %161, 8388607, !dbg !546
  %163 = or disjoint i32 %162, 1065353216, !dbg !547
  %bitcast_coercion273 = bitcast i32 %163 to float, !dbg !548
  %164 = fadd float %bitcast_coercion273, -1.000000e+00, !dbg !549
  %165 = fneg float %156, !dbg !551
  %166 = fdiv float %165, %.unbox274, !dbg !552
  %167 = fmul float %166, 0x3FF7154760000000, !dbg !554
  %168 = call float @llvm.rint.f32(float %167), !dbg !560
  %169 = fptosi float %168 to i32, !dbg !564
  %170 = freeze i32 %169, !dbg !564
  %171 = fmul contract float %168, 0x3FE62E4000000000, !dbg !567
  %172 = fsub contract float %166, %171, !dbg !567
  %173 = fmul contract float %168, 0x3EB7F7D1C0000000, !dbg !570
  %174 = fsub contract float %172, %173, !dbg !570
  %175 = fmul contract float %174, 0x3F2A1D7140000000, !dbg !572
  %176 = fadd contract float %175, 0x3F56DA7560000000, !dbg !572
  %177 = fmul contract float %174, %176, !dbg !572
  %178 = fadd contract float %177, 0x3F811105C0000000, !dbg !572
  %179 = fmul contract float %174, %178, !dbg !572
  %180 = fadd contract float %179, 0x3FA5554640000000, !dbg !572
  %181 = fmul contract float %174, %180, !dbg !572
  %182 = fadd contract float %181, 0x3FC5555560000000, !dbg !572
  %183 = fmul contract float %174, %182, !dbg !572
  %184 = fadd contract float %183, 5.000000e-01, !dbg !572
  %185 = fmul contract float %174, %184, !dbg !572
  %186 = fadd contract float %185, 1.000000e+00, !dbg !572
  %187 = fmul contract float %174, %186, !dbg !572
  %188 = fadd contract float %187, 1.000000e+00, !dbg !572
  %189 = fcmp ule float %166, 0x40562E4300000000, !dbg !580
  br i1 %189, label %L499, label %L550, !dbg !582

L499:                                             ; preds = %L440
  %190 = fcmp uge float %166, 0xC059FE3680000000, !dbg !583
  br i1 %190, label %L543, label %L550, !dbg !584

L543:                                             ; preds = %L499
  %191 = fcmp ugt float %166, 0xC055D58A00000000, !dbg !585
  %192 = fmul float %188, 0x3E70000000000000, !dbg !586
  %value_phi277 = select i1 %191, float %188, float %192, !dbg !586
  %.not450 = icmp eq i32 %170, 128, !dbg !587
  %193 = fmul float %value_phi277, 2.000000e+00, !dbg !589
  %value_phi279 = select i1 %.not450, float %193, float %value_phi277, !dbg !589
  %value_phi276.v = select i1 %191, i32 127, i32 151, !dbg !586
  %value_phi276 = add i32 %170, %value_phi276.v, !dbg !586
  %194 = sext i1 %.not450 to i32, !dbg !589
  %value_phi278 = add i32 %value_phi276, %194, !dbg !589
  %195 = shl i32 %value_phi278, 23, !dbg !590
  %bitcast_coercion282 = bitcast i32 %195 to float, !dbg !596
  %196 = fmul float %value_phi279, %bitcast_coercion282, !dbg !597
  br label %L550, !dbg !432

L550:                                             ; preds = %L543, %L499, %L440
  %value_phi275 = phi float [ %196, %L543 ], [ 0x7FF0000000000000, %L440 ], [ 0.000000e+00, %L499 ]
  %197 = fcmp olt float %164, %value_phi275, !dbg !598
  br i1 %197, label %L552, label %guard_pass377, !dbg !522

L552:                                             ; preds = %L550, %L420
  %root_phi25.state80 = load atomic ptr, ptr %45 unordered, align 8, !dbg !599, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !296, !align !297
  %root_phi25.state80.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state80, i64 16, !dbg !605
  %root_phi25.state80.size.0.copyload = load i64, ptr %root_phi25.state80.size_ptr, align 8, !dbg !605, !tbaa !240, !alias.scope !304, !noalias !305
  %.not451 = icmp eq i64 %root_phi25.state80.size.0.copyload, 100000, !dbg !607
  br i1 %.not451, label %guard_pass372, label %L560, !dbg !606

L560:                                             ; preds = %L552
  call swiftcc void @j_throw_dmrsa_9829(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state80.size.0.copyload) #9, !dbg !609
  unreachable, !dbg !609

L639:                                             ; preds = %pass100
  store i64 %.fr785, ptr %"new::Tuple67", align 1, !dbg !447, !tbaa !277, !alias.scope !279, !noalias !280
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6602, i64 7, i1 false), !dbg !238
  br label %L659, !dbg !238

L640:                                             ; preds = %pass100
  %.not454.not.not = icmp eq i64 %value_phi5526, %value_phi, !dbg !610
  br i1 %.not454.not.not, label %L645.L650_crit_edge, label %L649, !dbg !433

L645.L650_crit_edge:                              ; preds = %L640
  store i64 %.fr785, ptr %"new::Tuple67", align 1, !dbg !447, !tbaa !277, !alias.scope !279, !noalias !280
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6602, i64 7, i1 false), !dbg !238
  br label %L659, !dbg !238

L649:                                             ; preds = %L640
  %198 = add i64 %value_phi5526, 1, !dbg !432
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !231
  store i64 %78, ptr %.sroa.0433.sroa.8.0..sroa_idx657, align 8, !dbg !231
  store i64 %79, ptr %.sroa.0433.sroa.9.0..sroa_idx660, align 8, !dbg !231
  store i64 %.sroa.0433.sroa.10.0.copyload662, ptr %.sroa.0433.sroa.10.0..sroa_idx663, align 8, !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.11.0..sroa_idx665, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0433.sroa.12.0..sroa_idx666, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.13.0..sroa_idx667, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !231
  store i64 %80, ptr %.sroa.0433.sroa.14.0..sroa_idx669, align 8, !dbg !231
  store i64 %81, ptr %.sroa.0433.sroa.15.0..sroa_idx672, align 8, !dbg !231
  store i64 %82, ptr %.sroa.0433.sroa.16.0..sroa_idx675, align 8, !dbg !231
  store i64 %75, ptr %.sroa.0433.sroa.17.0..sroa_idx678, align 8, !dbg !231
  store i64 %.fr785, ptr %.sroa.0433.sroa.19.0..sroa_idx684, align 8, !dbg !231
  store float %100, ptr %.sroa.0433.sroa.20.0..sroa_idx687, align 8, !dbg !231
  store float %.sroa.7643.0, ptr %.sroa.0433.sroa.21.0..sroa_idx690, align 4, !dbg !231
  store i64 1, ptr %.sroa.0433.sroa.22.0..sroa_idx693, align 8, !dbg !231
  store i8 %.sroa.9.0, ptr %.sroa.0433.sroa.23.0..sroa_idx696, align 8, !dbg !231
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0433.sroa.24.0..sroa_idx698, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6602, i64 7, i1 false), !dbg !231
  store float %156, ptr %.sroa.6434.0..sroa_idx, align 8, !dbg !231
  store i32 %.sroa.7436.0.copyload437, ptr %.sroa.7436.0..sroa_idx, align 4, !dbg !231
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !275, !tbaa !277, !alias.scope !279, !noalias !280
  %.unbox = load i64, ptr %74, align 8, !dbg !275, !tbaa !277, !alias.scope !279, !noalias !280
  %.not = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !275
  br i1 %.not, label %L56, label %L59, !dbg !255

L659:                                             ; preds = %L645.L650_crit_edge, %L639, %L34.L650_crit_edge
  %.sroa.0.sroa.8.0 = phi i64 [ %.sroa.0.sroa.8.0.copyload, %L34.L650_crit_edge ], [ %78, %L645.L650_crit_edge ], [ %78, %L639 ], !dbg !238
  %.sroa.0.sroa.9.0 = phi i64 [ %.sroa.0.sroa.9.0.copyload, %L34.L650_crit_edge ], [ %79, %L645.L650_crit_edge ], [ %79, %L639 ], !dbg !238
  %.sroa.0.sroa.10.0 = phi i64 [ %.sroa.0.sroa.10.0.copyload, %L34.L650_crit_edge ], [ %.sroa.0433.sroa.10.0.copyload662, %L645.L650_crit_edge ], [ %.sroa.0433.sroa.10.0.copyload662, %L639 ], !dbg !238
  %.sroa.0.sroa.14.0 = phi i64 [ %.sroa.0.sroa.14.0.copyload, %L34.L650_crit_edge ], [ %80, %L645.L650_crit_edge ], [ %80, %L639 ], !dbg !238
  %.sroa.0.sroa.15.0 = phi i64 [ %.sroa.0.sroa.15.0.copyload, %L34.L650_crit_edge ], [ %81, %L645.L650_crit_edge ], [ %81, %L639 ], !dbg !238
  %.sroa.0.sroa.16.0 = phi i64 [ %.sroa.0.sroa.16.0.copyload, %L34.L650_crit_edge ], [ %82, %L645.L650_crit_edge ], [ %82, %L639 ], !dbg !238
  %.sroa.0.sroa.17.0 = phi i64 [ %.sroa.0.sroa.17.0.copyload, %L34.L650_crit_edge ], [ %75, %L645.L650_crit_edge ], [ %75, %L639 ], !dbg !238
  %.sroa.0.sroa.18.sroa.0.0 = phi i64 [ %.sroa.0.sroa.18.sroa.0.0.copyload, %L34.L650_crit_edge ], [ undef, %L645.L650_crit_edge ], [ undef, %L639 ], !dbg !238
  %.sroa.0.sroa.18.sroa.8.0 = phi i64 [ %.sroa.0.sroa.18.sroa.8.0.copyload, %L34.L650_crit_edge ], [ %.fr785, %L645.L650_crit_edge ], [ %.fr785, %L639 ], !dbg !238
  %.sroa.0.sroa.18.sroa.10.0 = phi float [ %.sroa.0.sroa.18.sroa.10.0.copyload, %L34.L650_crit_edge ], [ %100, %L645.L650_crit_edge ], [ %100, %L639 ], !dbg !238
  %.sroa.0.sroa.18.sroa.12.0 = phi float [ %.sroa.0.sroa.18.sroa.12.0.copyload, %L34.L650_crit_edge ], [ %.sroa.7643.0, %L645.L650_crit_edge ], [ %.sroa.7643.0, %L639 ], !dbg !238
  %.sroa.0.sroa.18.sroa.14.0 = phi i64 [ %.sroa.0.sroa.18.sroa.14.0.copyload, %L34.L650_crit_edge ], [ 1, %L645.L650_crit_edge ], [ 1, %L639 ], !dbg !238
  %.sroa.0.sroa.18.sroa.16.0 = phi i8 [ %.sroa.0.sroa.18.sroa.16.0.copyload, %L34.L650_crit_edge ], [ %.sroa.9.0, %L645.L650_crit_edge ], [ %.sroa.9.0, %L639 ], !dbg !238
  %.sroa.8.0 = phi float [ %.sroa.8.0.copyload393, %L34.L650_crit_edge ], [ %156, %L645.L650_crit_edge ], [ %156, %L639 ], !dbg !238
  %.sroa.10.0 = phi i32 [ %.sroa.10.0.copyload394, %L34.L650_crit_edge ], [ %.sroa.7436.0.copyload437, %L645.L650_crit_edge ], [ %.sroa.7436.0.copyload437, %L639 ], !dbg !238
  %199 = call i64 @jlplt_ijl_hrtime_9824_got.jit(), !dbg !611
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 520, !dbg !617
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528, !dbg !617
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !617, !tbaa !204, !alias.scope !190, !noalias !191
  store i64 %199, ptr %"process::Process.endtime_ptr", align 8, !dbg !617, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !618
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !618, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !619
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !619, !tbaa !281, !range !623
  %200 = and i64 %"process::Process.task.tag", -16, !dbg !619
  %201 = inttoptr i64 %200 to ptr, !dbg !619
  %exactly_isa.not.not = icmp eq ptr %201, @"+Core.Nothing#9834.jit", !dbg !619
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 497, !dbg !619
  %202 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !619
  %203 = and i8 %202, 1, !dbg !622
  %204 = icmp eq i8 %203, 0, !dbg !622
  %.not458 = select i1 %exactly_isa.not.not, i1 true, i1 %204, !dbg !622
  br i1 %.not458, label %L714, label %L696, !dbg !622

L696:                                             ; preds = %L659
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !624
  %ptls_load969 = load ptr, ptr %ptls_field, align 8, !dbg !624, !tbaa !157
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load969, i32 1120, i32 400, i64 5799315088) #23, !dbg !624
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !624
  store atomic i64 5799315088, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !624, !tbaa !281
  store atomic ptr %5, ptr %"box::ProcessContext" unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %205 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !624
  store atomic ptr %7, ptr %205 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %206 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !624
  store atomic ptr %9, ptr %206 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %207 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !624
  store atomic ptr %11, ptr %207 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %208 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !624
  store atomic ptr %13, ptr %208 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %209 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !624
  %"new::ProcessContext.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.0, i64 40, !dbg !624
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %209, ptr noundef nonnull align 8 dereferenceable(16) %"new::ProcessContext.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !624
  %210 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !624
  store atomic ptr %15, ptr %210 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %211 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !624
  store atomic ptr %17, ptr %211 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %212 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !624
  store atomic ptr %19, ptr %212 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %213 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !624
  store atomic ptr %21, ptr %213 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %214 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !624
  store atomic ptr %23, ptr %214 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %215 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !624
  store i64 %.sroa.0.sroa.8.0, ptr %215, align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %216 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !624
  store atomic ptr %25, ptr %216 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %217 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !624
  store i64 %.sroa.0.sroa.10.0, ptr %217, align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %218 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !624
  store atomic ptr %27, ptr %218 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %219 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !624
  store atomic ptr %29, ptr %219 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %220 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !624
  %"new::ProcessContext.sroa.0.sroa.10.136.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.11, i64 16, !dbg !624
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %220, ptr noundef nonnull align 8 dereferenceable(16) %"new::ProcessContext.sroa.0.sroa.10.136.sroa_idx", i64 16, i1 false), !dbg !624
  %221 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !624
  store atomic ptr %31, ptr %221 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %222 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !624
  store atomic ptr %33, ptr %222 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %223 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !624
  store atomic ptr %35, ptr %223 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %224 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !624
  store atomic ptr %37, ptr %224 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %225 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !624
  store atomic ptr %39, ptr %225 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %226 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !624
  %"new::ProcessContext.sroa.0.sroa.12.192.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.12, i64 40, !dbg !624
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %226, ptr noundef nonnull align 8 dereferenceable(24) %"new::ProcessContext.sroa.0.sroa.12.192.sroa_idx", i64 24, i1 false), !dbg !624
  %227 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !624
  store atomic ptr %41, ptr %227 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %228 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !624
  %"new::ProcessContext.sroa.0.sroa.14.224.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.13, i64 8, !dbg !624
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %228, ptr noundef nonnull align 8 dereferenceable(24) %"new::ProcessContext.sroa.0.sroa.14.224.sroa_idx", i64 24, i1 false), !dbg !624
  %229 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !624
  store atomic ptr %43, ptr %229 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %230 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !624
  store i64 %.sroa.0.sroa.15.0, ptr %230, align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %231 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !624
  store atomic ptr %45, ptr %231 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %232 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !624
  store i64 %.sroa.0.sroa.17.0, ptr %232, align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %233 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !624
  store atomic ptr %47, ptr %233 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %234 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !624
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %234, align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::ProcessContext.sroa.0.sroa.22.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 296, !dbg !624
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.6.8..sroa_idx", align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::ProcessContext.sroa.0.sroa.22.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 300, !dbg !624
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.7.8..sroa_idx", align 4, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::ProcessContext.sroa.0.sroa.22.sroa.8.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 304, !dbg !624
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.8.8..sroa_idx", align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::ProcessContext.sroa.0.sroa.22.sroa.9.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 312, !dbg !624
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.9.8..sroa_idx", align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::ProcessContext.sroa.0.sroa.22.sroa.10.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 313, !dbg !624
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::ProcessContext.sroa.0.sroa.22.sroa.10.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !624
  %"new::ProcessContext.sroa.13.288..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 320, !dbg !624
  store float %.sroa.8.0, ptr %"new::ProcessContext.sroa.13.288..sroa_idx", align 8, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::ProcessContext.sroa.17.288..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 324, !dbg !624
  store i32 %.sroa.10.0, ptr %"new::ProcessContext.sroa.17.288..sroa_idx", align 4, !dbg !624, !tbaa !240, !alias.scope !467, !noalias !468
  %235 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !624
  store atomic ptr %49, ptr %235 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %236 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !624
  store atomic ptr %51, ptr %236 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %237 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !624
  store atomic ptr %53, ptr %237 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %238 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !624
  store atomic ptr %55, ptr %238 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %239 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !624
  store atomic ptr %57, ptr %239 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %240 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !624
  store atomic ptr %59, ptr %240 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  %241 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !624
  store atomic ptr %61, ptr %241 unordered, align 8, !dbg !624, !tbaa !283, !alias.scope !190, !noalias !191
  store atomic ptr %"box::ProcessContext", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !624, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !624
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !624, !tbaa !281, !range !623
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !624
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !624
  br i1 %parent_old_marked, label %may_trigger_wb, label %242, !dbg !624

may_trigger_wb:                                   ; preds = %L696
  %"box::ProcessContext.tag" = load atomic volatile i64, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !624, !tbaa !281, !range !623
  %child_bit = and i64 %"box::ProcessContext.tag", 1, !dbg !624
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !624
  br i1 %child_not_marked, label %trigger_wb, label %242, !dbg !624, !prof !630

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !624
  br label %242, !dbg !624

242:                                              ; preds = %may_trigger_wb, %trigger_wb, %L696
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0421.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0421.sroa.9, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0421.sroa.10, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0421.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0421.sroa.16.sroa.16, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8426, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.21", i64 56, i1 false), !dbg !238
  br label %L724, !dbg !238

L714:                                             ; preds = %L659
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !238
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !631
  %243 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !631, !tbaa !204, !alias.scope !190, !noalias !191
  %244 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !631
  %245 = load atomic ptr, ptr %244 unordered, align 8, !dbg !631, !tbaa !204, !alias.scope !190, !noalias !191
  %246 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !631
  %247 = load atomic ptr, ptr %246 unordered, align 8, !dbg !631, !tbaa !204, !alias.scope !190, !noalias !191
  %248 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !631
  %249 = load atomic ptr, ptr %248 unordered, align 8, !dbg !631, !tbaa !204, !alias.scope !190, !noalias !191
  %250 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !631
  %251 = load atomic ptr, ptr %250 unordered, align 8, !dbg !631, !tbaa !204, !alias.scope !190, !noalias !191
  %252 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !631
  %253 = load atomic ptr, ptr %252 unordered, align 8, !dbg !631, !tbaa !204, !alias.scope !190, !noalias !191
  %254 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !637
  store atomic ptr %5, ptr %254 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %255 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !637
  store atomic ptr %7, ptr %255 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %256 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !637
  store atomic ptr %9, ptr %256 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %257 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !637
  store atomic ptr %11, ptr %257 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %258 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !637
  store atomic ptr %13, ptr %258 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %259 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !637
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", i64 40, !dbg !637
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %259, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %260 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !637
  store atomic ptr %15, ptr %260 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %261 = getelementptr inbounds i8, ptr %"process::Process", i64 120, !dbg !637
  store atomic ptr %17, ptr %261 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %262 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !637
  store atomic ptr %19, ptr %262 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %263 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !637
  store atomic ptr %21, ptr %263 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %264 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !637
  store atomic ptr %23, ptr %264 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %265 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !637
  store i64 %.sroa.0.sroa.8.0, ptr %265, align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %266 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !637
  store atomic ptr %25, ptr %266 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %267 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !637
  store i64 %.sroa.0.sroa.10.0, ptr %267, align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %268 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !637
  store atomic ptr %27, ptr %268 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %269 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !637
  store atomic ptr %29, ptr %269 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %270 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !637
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", i64 16, !dbg !637
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %270, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx", i64 16, i1 false), !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %271 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !637
  store atomic ptr %31, ptr %271 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %272 = getelementptr inbounds i8, ptr %"process::Process", i64 216, !dbg !637
  store atomic ptr %33, ptr %272 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %273 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !637
  store atomic ptr %35, ptr %273 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %274 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !637
  store atomic ptr %37, ptr %274 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %275 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !637
  store atomic ptr %39, ptr %275 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %276 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !637
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", i64 40, !dbg !637
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %276, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx", i64 24, i1 false), !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %277 = getelementptr inbounds i8, ptr %"process::Process", i64 272, !dbg !637
  store atomic ptr %41, ptr %277 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %278 = getelementptr inbounds i8, ptr %"process::Process", i64 280, !dbg !637
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", i64 8, !dbg !637
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %278, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx", i64 24, i1 false), !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %279 = getelementptr inbounds i8, ptr %"process::Process", i64 304, !dbg !637
  store atomic ptr %43, ptr %279 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %280 = getelementptr inbounds i8, ptr %"process::Process", i64 312, !dbg !637
  store i64 %.sroa.0.sroa.15.0, ptr %280, align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %281 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !637
  store atomic ptr %45, ptr %281 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %282 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !637
  store i64 %.sroa.0.sroa.17.0, ptr %282, align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %283 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !637
  store atomic ptr %47, ptr %283 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %284 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !637
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %284, align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !637
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx", align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 356, !dbg !637
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx", align 4, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !637
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx", align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !637
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx", align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 369, !dbg !637
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !637
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !637
  store float %.sroa.8.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 380, !dbg !637
  store i32 %.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !637, !tbaa !240, !alias.scope !467, !noalias !468
  %285 = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !637
  store atomic ptr %49, ptr %285 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %286 = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !637
  store atomic ptr %51, ptr %286 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %287 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !637
  store atomic ptr %53, ptr %287 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %288 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !637
  store atomic ptr %55, ptr %288 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %289 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !637
  store atomic ptr %57, ptr %289 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %290 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !637
  store atomic ptr %59, ptr %290 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %291 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !637
  store atomic ptr %61, ptr %291 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  store atomic ptr %253, ptr %252 unordered, align 8, !dbg !637, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.tag_addr971" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !637
  %"process::Process.tag972" = load atomic volatile i64, ptr %"process::Process.tag_addr971" unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %parent_bits973 = and i64 %"process::Process.tag972", 3, !dbg !637
  %parent_old_marked974 = icmp eq i64 %parent_bits973, 3, !dbg !637
  br i1 %parent_old_marked974, label %may_trigger_wb975, label %327, !dbg !637

may_trigger_wb975:                                ; preds = %L714
  %.tag_addr = getelementptr inbounds i64, ptr %243, i64 -1, !dbg !637
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %.tag_addr978 = getelementptr inbounds i64, ptr %245, i64 -1, !dbg !637
  %.tag979 = load atomic volatile i64, ptr %.tag_addr978 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %292 = and i64 %.tag, %.tag979, !dbg !637
  %.tag_addr982 = getelementptr inbounds i64, ptr %247, i64 -1, !dbg !637
  %.tag983 = load atomic volatile i64, ptr %.tag_addr982 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %293 = and i64 %292, %.tag983, !dbg !637
  %.tag_addr986 = getelementptr inbounds i64, ptr %249, i64 -1, !dbg !637
  %.tag987 = load atomic volatile i64, ptr %.tag_addr986 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %294 = and i64 %293, %.tag987, !dbg !637
  %.tag_addr990 = getelementptr inbounds i64, ptr %251, i64 -1, !dbg !637
  %.tag991 = load atomic volatile i64, ptr %.tag_addr990 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %295 = and i64 %294, %.tag991, !dbg !637
  %.tag_addr994 = getelementptr inbounds i64, ptr %5, i64 -1, !dbg !637
  %.tag995 = load atomic volatile i64, ptr %.tag_addr994 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %296 = and i64 %295, %.tag995, !dbg !637
  %.tag_addr998 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !637
  %.tag999 = load atomic volatile i64, ptr %.tag_addr998 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %297 = and i64 %296, %.tag999, !dbg !637
  %.tag_addr1002 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !637
  %.tag1003 = load atomic volatile i64, ptr %.tag_addr1002 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %298 = and i64 %297, %.tag1003, !dbg !637
  %.tag_addr1006 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !637
  %.tag1007 = load atomic volatile i64, ptr %.tag_addr1006 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %299 = and i64 %298, %.tag1007, !dbg !637
  %.tag_addr1010 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !637
  %.tag1011 = load atomic volatile i64, ptr %.tag_addr1010 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %300 = and i64 %299, %.tag1011, !dbg !637
  %.tag_addr1014 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !637
  %.tag1015 = load atomic volatile i64, ptr %.tag_addr1014 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %301 = and i64 %300, %.tag1015, !dbg !637
  %.tag_addr1018 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !637
  %.tag1019 = load atomic volatile i64, ptr %.tag_addr1018 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %302 = and i64 %301, %.tag1019, !dbg !637
  %.tag_addr1022 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !637
  %.tag1023 = load atomic volatile i64, ptr %.tag_addr1022 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %303 = and i64 %302, %.tag1023, !dbg !637
  %.tag_addr1026 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !637
  %.tag1027 = load atomic volatile i64, ptr %.tag_addr1026 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %304 = and i64 %303, %.tag1027, !dbg !637
  %.tag_addr1030 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !637
  %.tag1031 = load atomic volatile i64, ptr %.tag_addr1030 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %305 = and i64 %304, %.tag1031, !dbg !637
  %.tag_addr1034 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !637
  %.tag1035 = load atomic volatile i64, ptr %.tag_addr1034 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %306 = and i64 %305, %.tag1035, !dbg !637
  %.tag_addr1038 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !637
  %.tag1039 = load atomic volatile i64, ptr %.tag_addr1038 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %307 = and i64 %306, %.tag1039, !dbg !637
  %.tag_addr1042 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !637
  %.tag1043 = load atomic volatile i64, ptr %.tag_addr1042 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %308 = and i64 %307, %.tag1043, !dbg !637
  %.tag_addr1046 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !637
  %.tag1047 = load atomic volatile i64, ptr %.tag_addr1046 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %309 = and i64 %308, %.tag1047, !dbg !637
  %.tag_addr1050 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !637
  %.tag1051 = load atomic volatile i64, ptr %.tag_addr1050 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %310 = and i64 %309, %.tag1051, !dbg !637
  %.tag_addr1054 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !637
  %.tag1055 = load atomic volatile i64, ptr %.tag_addr1054 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %311 = and i64 %310, %.tag1055, !dbg !637
  %.tag_addr1058 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !637
  %.tag1059 = load atomic volatile i64, ptr %.tag_addr1058 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %312 = and i64 %311, %.tag1059, !dbg !637
  %.tag_addr1062 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !637
  %.tag1063 = load atomic volatile i64, ptr %.tag_addr1062 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %313 = and i64 %312, %.tag1063, !dbg !637
  %.tag_addr1066 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !637
  %.tag1067 = load atomic volatile i64, ptr %.tag_addr1066 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %314 = and i64 %313, %.tag1067, !dbg !637
  %.tag_addr1070 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !637
  %.tag1071 = load atomic volatile i64, ptr %.tag_addr1070 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %315 = and i64 %314, %.tag1071, !dbg !637
  %.tag_addr1074 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !637
  %.tag1075 = load atomic volatile i64, ptr %.tag_addr1074 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %316 = and i64 %315, %.tag1075, !dbg !637
  %.tag_addr1078 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !637
  %.tag1079 = load atomic volatile i64, ptr %.tag_addr1078 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %317 = and i64 %316, %.tag1079, !dbg !637
  %.tag_addr1082 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !637
  %.tag1083 = load atomic volatile i64, ptr %.tag_addr1082 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %318 = and i64 %317, %.tag1083, !dbg !637
  %.tag_addr1086 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !637
  %.tag1087 = load atomic volatile i64, ptr %.tag_addr1086 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %319 = and i64 %318, %.tag1087, !dbg !637
  %.tag_addr1090 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !637
  %.tag1091 = load atomic volatile i64, ptr %.tag_addr1090 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %320 = and i64 %319, %.tag1091, !dbg !637
  %.tag_addr1094 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !637
  %.tag1095 = load atomic volatile i64, ptr %.tag_addr1094 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %321 = and i64 %320, %.tag1095, !dbg !637
  %.tag_addr1098 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !637
  %.tag1099 = load atomic volatile i64, ptr %.tag_addr1098 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %322 = and i64 %321, %.tag1099, !dbg !637
  %.tag_addr1102 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !637
  %.tag1103 = load atomic volatile i64, ptr %.tag_addr1102 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %323 = and i64 %322, %.tag1103, !dbg !637
  %.tag_addr1106 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !637
  %.tag1107 = load atomic volatile i64, ptr %.tag_addr1106 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %324 = and i64 %323, %.tag1107, !dbg !637
  %.tag_addr1110 = getelementptr inbounds i64, ptr %253, i64 -1, !dbg !637
  %.tag1111 = load atomic volatile i64, ptr %.tag_addr1110 unordered, align 8, !dbg !637, !tbaa !281, !range !623
  %325 = and i64 %324, %.tag1111, !dbg !637
  %326 = and i64 %325, 1, !dbg !637
  %.not3.not = icmp eq i64 %326, 0, !dbg !637
  br i1 %.not3.not, label %trigger_wb1114, label %327, !dbg !637, !prof !630

trigger_wb1114:                                   ; preds = %may_trigger_wb975
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !637
  br label %327, !dbg !637

327:                                              ; preds = %may_trigger_wb975, %trigger_wb1114, %L714
  %"process::Process.runtime_context_ptr253" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !639
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !639, !tbaa !170, !invariant.load !0, !alias.scope !465, !noalias !466, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr253" release, align 8, !dbg !639, !tbaa !204, !alias.scope !190, !noalias !191
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0421.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0421.sroa.9, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0421.sroa.10, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0421.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0421.sroa.16.sroa.16, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8426, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.21", i64 56, i1 false), !dbg !238
  br label %L724, !dbg !238

L724:                                             ; preds = %327, %242
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0421.sroa.0, i64 96, i1 false), !dbg !616
  %.sroa.0427.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !616
  store i64 %.sroa.0.sroa.8.0, ptr %.sroa.0427.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !616
  store i64 %.sroa.0.sroa.9.0, ptr %.sroa.0427.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !616
  store i64 %.sroa.0.sroa.10.0, ptr %.sroa.0427.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !616
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0427.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0421.sroa.9, i64 32, i1 false), !dbg !616
  %.sroa.0427.sroa.6.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !616
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0427.sroa.6.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0421.sroa.10, i64 64, i1 false), !dbg !616
  %.sroa.0427.sroa.7.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 216, !dbg !616
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0427.sroa.7.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0421.sroa.11, i64 32, i1 false), !dbg !616
  %.sroa.0427.sroa.8.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 248, !dbg !616
  store i64 %.sroa.0.sroa.14.0, ptr %.sroa.0427.sroa.8.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.9.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !616
  store i64 %.sroa.0.sroa.15.0, ptr %.sroa.0427.sroa.9.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.10.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 264, !dbg !616
  store i64 %.sroa.0.sroa.16.0, ptr %.sroa.0427.sroa.10.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.11.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !616
  store i64 %.sroa.0.sroa.17.0, ptr %.sroa.0427.sroa.11.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 280, !dbg !616
  store i64 %.sroa.0.sroa.18.sroa.0.0, ptr %.sroa.0427.sroa.12.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.sroa.2.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !616
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %.sroa.0427.sroa.12.sroa.2.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.sroa.3.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !616
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0427.sroa.12.sroa.3.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.sroa.4.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !616
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0427.sroa.12.sroa.4.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.sroa.5.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !616
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %.sroa.0427.sroa.12.sroa.5.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.sroa.6.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !616
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0427.sroa.12.sroa.6.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.0427.sroa.12.sroa.7.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !616
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0427.sroa.12.sroa.7.0..sroa.0427.sroa.12.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0421.sroa.16.sroa.16, i64 7, i1 false), !dbg !616
  %.sroa.2428.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !616
  store float %.sroa.8.0, ptr %.sroa.2428.0.sret_return.sroa_idx, align 8, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.3429.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !616
  store i32 %.sroa.10.0, ptr %.sroa.3429.0.sret_return.sroa_idx, align 4, !dbg !616, !tbaa !277, !alias.scope !279, !noalias !280
  %.sroa.4430.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !616
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.4430.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8426, i64 56, i1 false), !dbg !616
  store ptr %5, ptr %return_roots, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %328 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !616
  store ptr %7, ptr %328, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %329 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !616
  store ptr %9, ptr %329, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %330 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !616
  store ptr %11, ptr %330, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %331 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !616
  store ptr %13, ptr %331, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %332 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !616
  store ptr %15, ptr %332, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %333 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !616
  store ptr %17, ptr %333, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %334 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !616
  store ptr %19, ptr %334, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %335 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !616
  store ptr %21, ptr %335, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %336 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !616
  store ptr %23, ptr %336, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %337 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !616
  store ptr %25, ptr %337, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %338 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !616
  store ptr %27, ptr %338, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %339 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !616
  store ptr %29, ptr %339, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %340 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !616
  store ptr %31, ptr %340, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %341 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !616
  store ptr %33, ptr %341, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %342 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !616
  store ptr %35, ptr %342, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %343 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !616
  store ptr %37, ptr %343, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %344 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !616
  store ptr %39, ptr %344, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %345 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !616
  store ptr %41, ptr %345, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %346 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !616
  store ptr %43, ptr %346, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %347 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !616
  store ptr %45, ptr %347, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %348 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !616
  store ptr %47, ptr %348, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %349 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !616
  store ptr %49, ptr %349, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %350 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !616
  store ptr %51, ptr %350, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %351 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !616
  store ptr %53, ptr %351, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %352 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !616
  store ptr %55, ptr %352, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %353 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !616
  store ptr %57, ptr %353, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %354 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !616
  store ptr %59, ptr %354, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %355 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !616
  store ptr %61, ptr %355, align 8, !dbg !616, !tbaa !157, !alias.scope !162, !noalias !165
  %frame.prev1115 = load ptr, ptr %frame.prev, align 8, !tbaa !157
  store ptr %frame.prev1115, ptr %pgcstack, align 8, !tbaa !157
  ret void, !dbg !616

pass100:                                          ; preds = %guard_pass377, %guard_pass372
  %.sroa.9.0 = phi i8 [ 1, %guard_pass372 ], [ 0, %guard_pass377 ], !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6602, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !641
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10), !dbg !641
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !642
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %91, i64 80, i1 false), !dbg !642, !tbaa !277, !alias.scope !279, !noalias !280
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0433.sroa.11.0..sroa_idx665, i64 16, i1 false), !dbg !642, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 16, !dbg !642
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %74, i64 112, i1 false), !dbg !642, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !658
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !658, !tbaa !277, !alias.scope !279, !noalias !280
  %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 32, !dbg !658
  %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 96, !dbg !658
  store i64 1, ptr %4, align 8, !dbg !664, !tbaa !204, !alias.scope !190, !noalias !191
  %356 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !672, !tbaa !204, !alias.scope !190, !noalias !191
  %357 = add <2 x i64> %356, <i64 1, i64 1>, !dbg !677
  store <2 x i64> %357, ptr %"process::Process.loopidx_ptr", align 8, !dbg !678, !tbaa !204, !alias.scope !190, !noalias !191
  %358 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !679, !tbaa !204, !alias.scope !190, !noalias !191
  %359 = and i8 %358, 1, !dbg !679
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %359, 0, !dbg !679
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L639, label %L640, !dbg !685

guard_pass362:                                    ; preds = %L131
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !238
  store float %100, ptr %unionalloca.sroa.0, align 8, !dbg !238, !tbaa !277, !alias.scope !279, !noalias !280
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload461786 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !336
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !336
  %360 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload461786 to i32, !dbg !686
  %361 = bitcast i32 %360 to float, !dbg !686
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10649), !dbg !238
  br label %L262, !dbg !238

guard_pass367:                                    ; preds = %L216, %L214
  %value_phi314 = phi double [ %126, %L214 ], [ %spec.select384, %L216 ]
  %362 = fcmp ugt double %value_phi314, 2.000000e+00, !dbg !688
  %363 = fadd double %value_phi314, -1.000000e+00, !dbg !691
  %364 = fadd double %value_phi314, -2.000000e+00, !dbg !691
  %365 = fsub double 1.000000e+00, %364, !dbg !691
  %value_phi316 = select i1 %362, double %365, double %363, !dbg !691
  %366 = fptrunc double %value_phi316 to float, !dbg !692
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10649), !dbg !238
  br label %L262, !dbg !238

guard_pass372:                                    ; preds = %L552
  %367 = load ptr, ptr %root_phi25.state80, align 8, !dbg !694, !tbaa !314, !alias.scope !317, !noalias !318
  %368 = getelementptr i8, ptr %367, i64 %memoryref_offset, !dbg !696
  %memoryref_data97 = getelementptr i8, ptr %368, i64 -4, !dbg !696
  store float %.sroa.7643.0, ptr %memoryref_data97, align 4, !dbg !696, !tbaa !322, !alias.scope !190, !noalias !191
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !238
  br label %pass100, !dbg !238

guard_pass377:                                    ; preds = %L550
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !238
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !238, !tbaa !277, !alias.scope !279, !noalias !280
  br label %pass100, !dbg !238
}
