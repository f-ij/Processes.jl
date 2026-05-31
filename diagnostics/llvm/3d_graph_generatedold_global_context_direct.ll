; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x53f1bf480ecb4f279ef7ae9630e9427b))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.GeneratedOld)
define swiftcc void @julia_loop_9832(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [1 x ptr]], ptr }, [1 x ptr], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(384) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(232) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(560) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(432) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(384) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [18 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 144, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 8
  %2 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %3 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.111366 = alloca [7 x i8], align 1
  %.sroa.101360 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple140" = alloca [1 x i64], align 8
  %.sroa.61338 = alloca [7 x i8], align 1
  %.sroa.101349 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext.sroa.7" = alloca [7 x i64], align 8
  %4 = alloca [48 x i64], align 8
  %.sroa.0952.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0952.sroa.9 = alloca [4 x i64], align 8
  %.sroa.0952.sroa.10 = alloca [8 x i64], align 8
  %.sroa.0952.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0952.sroa.22 = alloca [7 x i8], align 1
  %.sroa.8957 = alloca [7 x i64], align 8
  %"new::SamplerRangeNDL335" = alloca [2 x i64], align 8
  %unionalloca363.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.101313 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1372" = alloca [5 x i64], align 8
  %"new::Tuple395" = alloca [1 x i64], align 8
  %.sroa.61260 = alloca [7 x i8], align 1
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple427.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple427.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext428.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext430.sroa.6" = alloca [7 x i64], align 8
  %.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0.sroa.12 = alloca [8 x i64], align 8
  %.sroa.0.sroa.13 = alloca [4 x i64], align 8
  %.sroa.0.sroa.18.sroa.18 = alloca [7 x i8], align 1
  %.sroa.12 = alloca [7 x i64], align 8
  %.sroa.0933.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0933.sroa.12 = alloca [4 x i64], align 8
  %.sroa.0933.sroa.14 = alloca [8 x i64], align 8
  %.sroa.0933.sroa.16 = alloca [4 x i64], align 8
  %.sroa.0933.sroa.26.sroa.11 = alloca [7 x i8], align 1
  %.sroa.8939 = alloca [7 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4" = alloca [4 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5" = alloca [8 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6" = alloca [4 x i64], align 8
  %"new::Tuple603" = alloca [1 x i64], align 8
  %"new::Tuple606" = alloca [1 x i64], align 8
  %"new::Tuple608" = alloca [1 x i64], align 8
  %"new::Tuple703" = alloca [1 x i64], align 8
  %"new::Tuple706" = alloca [1 x i64], align 8
  %"new::Tuple708" = alloca [1 x i64], align 8
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
  store i8 1, ptr @"jl_global#9835.jit", align 16, !dbg !171, !tbaa !186, !alias.scope !189, !noalias !190
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !191
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !191, !tbaa !156, !alias.scope !161, !noalias !164
  %66 = sext i16 %thread_id to i64, !dbg !195
  %67 = add nsw i64 %66, 1, !dbg !200
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !202
  store i64 %67, ptr %"process::Process.threadid_ptr", align 8, !dbg !202, !tbaa !203, !alias.scope !189, !noalias !190
  %68 = call i64 @jlplt_ijl_hrtime_9837_got.jit(), !dbg !205
  %"process::Process.starttime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 504, !dbg !211
  %"process::Process.starttime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 512, !dbg !211
  store i8 2, ptr %"process::Process.starttime.tindex_ptr", align 1, !dbg !211, !tbaa !203, !alias.scope !189, !noalias !190
  store i64 %68, ptr %"process::Process.starttime_ptr", align 8, !dbg !211, !tbaa !203, !alias.scope !189, !noalias !190
  %ptls_load1975 = load ptr, ptr %ptls_field, align 8, !dbg !212, !tbaa !156
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1975, i32 1120, i32 400, i64 13729564624) #23, !dbg !212
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !212
  store atomic i64 13729564624, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !212, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext" unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %69 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !212
  store atomic ptr %9, ptr %69 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %70 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !212
  store atomic ptr %11, ptr %70 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %71 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !212
  store atomic ptr %13, ptr %71 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %72 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !212
  store atomic ptr %15, ptr %72 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %73 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !212
  %74 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 40, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %73, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %75 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !212
  store atomic ptr %17, ptr %75 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %76 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !212
  store atomic ptr %19, ptr %76 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %77 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !212
  store atomic ptr %21, ptr %77 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %78 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !212
  store atomic ptr %23, ptr %78 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %79 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !212
  store atomic ptr %25, ptr %79 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %80 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !212
  %81 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !212
  %82 = load i64, ptr %81, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %82, ptr %80, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %83 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !212
  store atomic ptr %27, ptr %83 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %84 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !212
  %85 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !212
  %86 = load i64, ptr %85, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %86, ptr %84, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %87 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !212
  store atomic ptr %29, ptr %87 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %88 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !212
  store atomic ptr %31, ptr %88 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %89 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !212
  %90 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 136, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %89, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %91 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !212
  store atomic ptr %33, ptr %91 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %92 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !212
  store atomic ptr %35, ptr %92 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %93 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !212
  store atomic ptr %37, ptr %93 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %94 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !212
  store atomic ptr %39, ptr %94 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %95 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !212
  store atomic ptr %41, ptr %95 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %96 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !212
  %97 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 192, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %96, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %98 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !212
  store atomic ptr %43, ptr %98 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %99 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !212
  %100 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 224, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %99, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %101 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !212
  store atomic ptr %45, ptr %101 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %102 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !212
  %103 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 256, !dbg !212
  %104 = load i64, ptr %103, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %104, ptr %102, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %105 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !212
  store atomic ptr %47, ptr %105 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %106 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !212
  %107 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 272, !dbg !212
  %108 = load i64, ptr %107, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %108, ptr %106, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %109 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !212
  store atomic ptr %49, ptr %109 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %110 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !212
  %111 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 288, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %110, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %112 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !212
  store atomic ptr %51, ptr %112 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %113 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !212
  store atomic ptr %53, ptr %113 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %114 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !212
  store atomic ptr %55, ptr %114 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %115 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !212
  store atomic ptr %57, ptr %115 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %116 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !212
  store atomic ptr %59, ptr %116 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %117 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !212
  store atomic ptr %61, ptr %117 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %118 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !212
  store atomic ptr %63, ptr %118 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %gc_slot_addr_14 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  store ptr %"box::ProcessContext", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !212
  %119 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !212
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !212
  %120 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !212
  store ptr %"box::ProcessContext", ptr %120, align 8, !dbg !212
  %121 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !212
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !212
  %jl_f__compute_sparams_ret = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !212
  store ptr %jl_f__compute_sparams_ret, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret, i64 -1, !dbg !228
  %jl_f__svec_ref_ret.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %122 = and i64 %jl_f__svec_ref_ret.tag, -16, !dbg !228
  %123 = inttoptr i64 %122 to ptr, !dbg !228
  %124 = icmp ult ptr %123, inttoptr (i64 1024 to ptr), !dbg !228
  br i1 %124, label %guard_pass, label %guard_exit, !dbg !228

L20:                                              ; preds = %guard_exit
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load1981 = load ptr, ptr %ptls_field, align 8, !dbg !212, !tbaa !156
  %"box::ProcessContext9" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1981, i32 1120, i32 400, i64 13729564624) #23, !dbg !212
  %"box::ProcessContext9.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext9", i64 -1, !dbg !212
  store atomic i64 13729564624, ptr %"box::ProcessContext9.tag_addr" unordered, align 8, !dbg !212, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext9" unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %125 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 8, !dbg !212
  store atomic ptr %9, ptr %125 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %126 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 16, !dbg !212
  store atomic ptr %11, ptr %126 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %127 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 24, !dbg !212
  store atomic ptr %13, ptr %127 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %128 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 32, !dbg !212
  store atomic ptr %15, ptr %128 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %129 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 40, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %129, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %130 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 56, !dbg !212
  store atomic ptr %17, ptr %130 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %131 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 64, !dbg !212
  store atomic ptr %19, ptr %131 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %132 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 72, !dbg !212
  store atomic ptr %21, ptr %132 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %133 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 80, !dbg !212
  store atomic ptr %23, ptr %133 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %134 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 88, !dbg !212
  store atomic ptr %25, ptr %134 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %135 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 96, !dbg !212
  %136 = load i64, ptr %81, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %136, ptr %135, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %137 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 104, !dbg !212
  store atomic ptr %27, ptr %137 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %138 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 112, !dbg !212
  %139 = load i64, ptr %85, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %139, ptr %138, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %140 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 120, !dbg !212
  store atomic ptr %29, ptr %140 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %141 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 128, !dbg !212
  store atomic ptr %31, ptr %141 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %142 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 136, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %142, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %143 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 152, !dbg !212
  store atomic ptr %33, ptr %143 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %144 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 160, !dbg !212
  store atomic ptr %35, ptr %144 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %145 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 168, !dbg !212
  store atomic ptr %37, ptr %145 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %146 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 176, !dbg !212
  store atomic ptr %39, ptr %146 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %147 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 184, !dbg !212
  store atomic ptr %41, ptr %147 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %148 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 192, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %148, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %149 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 216, !dbg !212
  store atomic ptr %43, ptr %149 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %150 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 224, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %150, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %151 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 248, !dbg !212
  store atomic ptr %45, ptr %151 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %152 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 256, !dbg !212
  %153 = load i64, ptr %103, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %153, ptr %152, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %154 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 264, !dbg !212
  store atomic ptr %47, ptr %154 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %155 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 272, !dbg !212
  %156 = load i64, ptr %107, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %156, ptr %155, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %157 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 280, !dbg !212
  store atomic ptr %49, ptr %157 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %158 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 288, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %158, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %159 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 328, !dbg !212
  store atomic ptr %51, ptr %159 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %160 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 336, !dbg !212
  store atomic ptr %53, ptr %160 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %161 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 344, !dbg !212
  store atomic ptr %55, ptr %161 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %162 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 352, !dbg !212
  store atomic ptr %57, ptr %162 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %163 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 360, !dbg !212
  store atomic ptr %59, ptr %163 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %164 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 368, !dbg !212
  store atomic ptr %61, ptr %164 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %165 = getelementptr inbounds i8, ptr %"box::ProcessContext9", i64 376, !dbg !212
  store atomic ptr %63, ptr %165 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext9", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !212
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !212
  store ptr %"box::ProcessContext9", ptr %120, align 8, !dbg !212
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !212
  %jl_f__compute_sparams_ret11 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !212
  store ptr %jl_f__compute_sparams_ret11, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret11, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret13 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret13.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret13, i64 -1, !dbg !228
  %jl_f__svec_ref_ret13.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret13.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %166 = and i64 %jl_f__svec_ref_ret13.tag, -16, !dbg !228
  %167 = inttoptr i64 %166 to ptr, !dbg !228
  %168 = icmp ult ptr %167, inttoptr (i64 1024 to ptr), !dbg !228
  br i1 %168, label %guard_pass14, label %guard_exit15, !dbg !228

L23:                                              ; preds = %guard_exit
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret782 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L40:                                              ; preds = %guard_exit15
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret13, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret19 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load1987 = load ptr, ptr %ptls_field, align 8, !dbg !212, !tbaa !156
  %"box::ProcessContext25" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1987, i32 1120, i32 400, i64 13729564624) #23, !dbg !212
  %"box::ProcessContext25.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext25", i64 -1, !dbg !212
  store atomic i64 13729564624, ptr %"box::ProcessContext25.tag_addr" unordered, align 8, !dbg !212, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext25" unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %169 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 8, !dbg !212
  store atomic ptr %9, ptr %169 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %170 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 16, !dbg !212
  store atomic ptr %11, ptr %170 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %171 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 24, !dbg !212
  store atomic ptr %13, ptr %171 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %172 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 32, !dbg !212
  store atomic ptr %15, ptr %172 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %173 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 40, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %173, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %174 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 56, !dbg !212
  store atomic ptr %17, ptr %174 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %175 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 64, !dbg !212
  store atomic ptr %19, ptr %175 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %176 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 72, !dbg !212
  store atomic ptr %21, ptr %176 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %177 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 80, !dbg !212
  store atomic ptr %23, ptr %177 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %178 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 88, !dbg !212
  store atomic ptr %25, ptr %178 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %179 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 96, !dbg !212
  %180 = load i64, ptr %81, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %180, ptr %179, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %181 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 104, !dbg !212
  store atomic ptr %27, ptr %181 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %182 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 112, !dbg !212
  %183 = load i64, ptr %85, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %183, ptr %182, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %184 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 120, !dbg !212
  store atomic ptr %29, ptr %184 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %185 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 128, !dbg !212
  store atomic ptr %31, ptr %185 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %186 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 136, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %186, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %187 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 152, !dbg !212
  store atomic ptr %33, ptr %187 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %188 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 160, !dbg !212
  store atomic ptr %35, ptr %188 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %189 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 168, !dbg !212
  store atomic ptr %37, ptr %189 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %190 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 176, !dbg !212
  store atomic ptr %39, ptr %190 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %191 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 184, !dbg !212
  store atomic ptr %41, ptr %191 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %192 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 192, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %192, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %193 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 216, !dbg !212
  store atomic ptr %43, ptr %193 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %194 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 224, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %194, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %195 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 248, !dbg !212
  store atomic ptr %45, ptr %195 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %196 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 256, !dbg !212
  %197 = load i64, ptr %103, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %197, ptr %196, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %198 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 264, !dbg !212
  store atomic ptr %47, ptr %198 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %199 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 272, !dbg !212
  %200 = load i64, ptr %107, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %200, ptr %199, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %201 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 280, !dbg !212
  store atomic ptr %49, ptr %201 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %202 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 288, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %202, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %203 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 328, !dbg !212
  store atomic ptr %51, ptr %203 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %204 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 336, !dbg !212
  store atomic ptr %53, ptr %204 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %205 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 344, !dbg !212
  store atomic ptr %55, ptr %205 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %206 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 352, !dbg !212
  store atomic ptr %57, ptr %206 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %207 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 360, !dbg !212
  store atomic ptr %59, ptr %207 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %208 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 368, !dbg !212
  store atomic ptr %61, ptr %208 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %209 = getelementptr inbounds i8, ptr %"box::ProcessContext25", i64 376, !dbg !212
  store atomic ptr %63, ptr %209 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext25", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !212
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !212
  store ptr %"box::ProcessContext25", ptr %120, align 8, !dbg !212
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !212
  %jl_f__compute_sparams_ret27 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !212
  store ptr %jl_f__compute_sparams_ret27, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret27, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret29 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret29.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret29, i64 -1, !dbg !228
  %jl_f__svec_ref_ret29.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret29.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %210 = and i64 %jl_f__svec_ref_ret29.tag, -16, !dbg !228
  %211 = inttoptr i64 %210 to ptr, !dbg !228
  %212 = icmp ult ptr %211, inttoptr (i64 1024 to ptr), !dbg !228
  br i1 %212, label %guard_pass30, label %guard_exit31, !dbg !228

L43:                                              ; preds = %guard_exit15
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret13, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret778 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L60:                                              ; preds = %guard_exit31
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret29, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret35 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load1993 = load ptr, ptr %ptls_field, align 8, !dbg !212, !tbaa !156
  %"box::ProcessContext41" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1993, i32 1120, i32 400, i64 13729564624) #23, !dbg !212
  %"box::ProcessContext41.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext41", i64 -1, !dbg !212
  store atomic i64 13729564624, ptr %"box::ProcessContext41.tag_addr" unordered, align 8, !dbg !212, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext41" unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %213 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 8, !dbg !212
  store atomic ptr %9, ptr %213 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %214 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 16, !dbg !212
  store atomic ptr %11, ptr %214 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %215 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 24, !dbg !212
  store atomic ptr %13, ptr %215 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %216 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 32, !dbg !212
  store atomic ptr %15, ptr %216 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %217 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 40, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %217, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %218 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 56, !dbg !212
  store atomic ptr %17, ptr %218 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %219 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 64, !dbg !212
  store atomic ptr %19, ptr %219 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %220 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 72, !dbg !212
  store atomic ptr %21, ptr %220 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %221 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 80, !dbg !212
  store atomic ptr %23, ptr %221 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %222 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 88, !dbg !212
  store atomic ptr %25, ptr %222 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %223 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 96, !dbg !212
  %224 = load i64, ptr %81, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %224, ptr %223, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %225 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 104, !dbg !212
  store atomic ptr %27, ptr %225 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %226 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 112, !dbg !212
  %227 = load i64, ptr %85, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %227, ptr %226, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %228 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 120, !dbg !212
  store atomic ptr %29, ptr %228 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %229 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 128, !dbg !212
  store atomic ptr %31, ptr %229 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %230 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 136, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %230, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %231 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 152, !dbg !212
  store atomic ptr %33, ptr %231 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %232 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 160, !dbg !212
  store atomic ptr %35, ptr %232 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %233 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 168, !dbg !212
  store atomic ptr %37, ptr %233 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %234 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 176, !dbg !212
  store atomic ptr %39, ptr %234 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %235 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 184, !dbg !212
  store atomic ptr %41, ptr %235 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %236 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 192, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %236, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %237 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 216, !dbg !212
  store atomic ptr %43, ptr %237 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %238 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 224, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %238, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %239 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 248, !dbg !212
  store atomic ptr %45, ptr %239 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %240 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 256, !dbg !212
  %241 = load i64, ptr %103, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %241, ptr %240, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %242 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 264, !dbg !212
  store atomic ptr %47, ptr %242 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %243 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 272, !dbg !212
  %244 = load i64, ptr %107, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %244, ptr %243, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %245 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 280, !dbg !212
  store atomic ptr %49, ptr %245 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %246 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 288, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %246, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %247 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 328, !dbg !212
  store atomic ptr %51, ptr %247 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %248 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 336, !dbg !212
  store atomic ptr %53, ptr %248 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %249 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 344, !dbg !212
  store atomic ptr %55, ptr %249 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %250 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 352, !dbg !212
  store atomic ptr %57, ptr %250 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %251 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 360, !dbg !212
  store atomic ptr %59, ptr %251 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %252 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 368, !dbg !212
  store atomic ptr %61, ptr %252 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %253 = getelementptr inbounds i8, ptr %"box::ProcessContext41", i64 376, !dbg !212
  store atomic ptr %63, ptr %253 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext41", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !212
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !212
  store ptr %"box::ProcessContext41", ptr %120, align 8, !dbg !212
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !212
  %jl_f__compute_sparams_ret43 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !212
  store ptr %jl_f__compute_sparams_ret43, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret43, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret45 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret45.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret45, i64 -1, !dbg !228
  %jl_f__svec_ref_ret45.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret45.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %254 = and i64 %jl_f__svec_ref_ret45.tag, -16, !dbg !228
  %255 = inttoptr i64 %254 to ptr, !dbg !228
  %256 = icmp ult ptr %255, inttoptr (i64 1024 to ptr), !dbg !228
  br i1 %256, label %guard_pass46, label %guard_exit47, !dbg !228

L63:                                              ; preds = %guard_exit31
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret29, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret774 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L80:                                              ; preds = %guard_exit47
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret45, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret51 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load1999 = load ptr, ptr %ptls_field, align 8, !dbg !235, !tbaa !156
  %"box::ProcessContext57" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1999, i32 1120, i32 400, i64 13729564624) #23, !dbg !235
  %"box::ProcessContext57.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext57", i64 -1, !dbg !235
  store atomic i64 13729564624, ptr %"box::ProcessContext57.tag_addr" unordered, align 8, !dbg !235, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext57" unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %257 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 8, !dbg !235
  store atomic ptr %9, ptr %257 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %258 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 16, !dbg !235
  store atomic ptr %11, ptr %258 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %259 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 24, !dbg !235
  store atomic ptr %13, ptr %259 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %260 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 32, !dbg !235
  store atomic ptr %15, ptr %260 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %261 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 40, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %261, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %262 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 56, !dbg !235
  store atomic ptr %17, ptr %262 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %263 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 64, !dbg !235
  store atomic ptr %19, ptr %263 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %264 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 72, !dbg !235
  store atomic ptr %21, ptr %264 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %265 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 80, !dbg !235
  store atomic ptr %23, ptr %265 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %266 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 88, !dbg !235
  store atomic ptr %25, ptr %266 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %267 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 96, !dbg !235
  %268 = load i64, ptr %81, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %268, ptr %267, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %269 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 104, !dbg !235
  store atomic ptr %27, ptr %269 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %270 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 112, !dbg !235
  %271 = load i64, ptr %85, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %271, ptr %270, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %272 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 120, !dbg !235
  store atomic ptr %29, ptr %272 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %273 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 128, !dbg !235
  store atomic ptr %31, ptr %273 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %274 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 136, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %274, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %275 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 152, !dbg !235
  store atomic ptr %33, ptr %275 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %276 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 160, !dbg !235
  store atomic ptr %35, ptr %276 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %277 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 168, !dbg !235
  store atomic ptr %37, ptr %277 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %278 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 176, !dbg !235
  store atomic ptr %39, ptr %278 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %279 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 184, !dbg !235
  store atomic ptr %41, ptr %279 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %280 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 192, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %280, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %281 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 216, !dbg !235
  store atomic ptr %43, ptr %281 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %282 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 224, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %282, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %283 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 248, !dbg !235
  store atomic ptr %45, ptr %283 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %284 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 256, !dbg !235
  %285 = load i64, ptr %103, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %285, ptr %284, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %286 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 264, !dbg !235
  store atomic ptr %47, ptr %286 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %287 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 272, !dbg !235
  %288 = load i64, ptr %107, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %288, ptr %287, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %289 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 280, !dbg !235
  store atomic ptr %49, ptr %289 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %290 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 288, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %290, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %291 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 328, !dbg !235
  store atomic ptr %51, ptr %291 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %292 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 336, !dbg !235
  store atomic ptr %53, ptr %292 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %293 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 344, !dbg !235
  store atomic ptr %55, ptr %293 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %294 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 352, !dbg !235
  store atomic ptr %57, ptr %294 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %295 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 360, !dbg !235
  store atomic ptr %59, ptr %295 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %296 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 368, !dbg !235
  store atomic ptr %61, ptr %296 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %297 = getelementptr inbounds i8, ptr %"box::ProcessContext57", i64 376, !dbg !235
  store atomic ptr %63, ptr %297 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext57", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !235
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !235
  store ptr %"box::ProcessContext57", ptr %120, align 8, !dbg !235
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !235
  %jl_f__compute_sparams_ret59 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !235
  store ptr %jl_f__compute_sparams_ret59, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret59, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret61 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret61.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret61, i64 -1, !dbg !228
  %jl_f__svec_ref_ret61.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret61.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %298 = and i64 %jl_f__svec_ref_ret61.tag, -16, !dbg !228
  %299 = inttoptr i64 %298 to ptr, !dbg !228
  %300 = icmp ult ptr %299, inttoptr (i64 1024 to ptr), !dbg !228
  br i1 %300, label %guard_pass62, label %guard_exit63, !dbg !228

L83:                                              ; preds = %guard_exit47
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret45, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret770 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L99:                                              ; preds = %guard_exit63
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret61, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret67 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2005 = load ptr, ptr %ptls_field, align 8, !dbg !235, !tbaa !156
  %"box::ProcessContext73" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2005, i32 1120, i32 400, i64 13729564624) #23, !dbg !235
  %"box::ProcessContext73.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext73", i64 -1, !dbg !235
  store atomic i64 13729564624, ptr %"box::ProcessContext73.tag_addr" unordered, align 8, !dbg !235, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext73" unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %301 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 8, !dbg !235
  store atomic ptr %9, ptr %301 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %302 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 16, !dbg !235
  store atomic ptr %11, ptr %302 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %303 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 24, !dbg !235
  store atomic ptr %13, ptr %303 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %304 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 32, !dbg !235
  store atomic ptr %15, ptr %304 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %305 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 40, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %305, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %306 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 56, !dbg !235
  store atomic ptr %17, ptr %306 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %307 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 64, !dbg !235
  store atomic ptr %19, ptr %307 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %308 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 72, !dbg !235
  store atomic ptr %21, ptr %308 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %309 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 80, !dbg !235
  store atomic ptr %23, ptr %309 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %310 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 88, !dbg !235
  store atomic ptr %25, ptr %310 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %311 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 96, !dbg !235
  %312 = load i64, ptr %81, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %312, ptr %311, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %313 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 104, !dbg !235
  store atomic ptr %27, ptr %313 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %314 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 112, !dbg !235
  %315 = load i64, ptr %85, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %315, ptr %314, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %316 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 120, !dbg !235
  store atomic ptr %29, ptr %316 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %317 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 128, !dbg !235
  store atomic ptr %31, ptr %317 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %318 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 136, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %318, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %319 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 152, !dbg !235
  store atomic ptr %33, ptr %319 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %320 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 160, !dbg !235
  store atomic ptr %35, ptr %320 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %321 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 168, !dbg !235
  store atomic ptr %37, ptr %321 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %322 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 176, !dbg !235
  store atomic ptr %39, ptr %322 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %323 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 184, !dbg !235
  store atomic ptr %41, ptr %323 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %324 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 192, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %324, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %325 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 216, !dbg !235
  store atomic ptr %43, ptr %325 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %326 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 224, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %326, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %327 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 248, !dbg !235
  store atomic ptr %45, ptr %327 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %328 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 256, !dbg !235
  %329 = load i64, ptr %103, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %329, ptr %328, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %330 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 264, !dbg !235
  store atomic ptr %47, ptr %330 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %331 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 272, !dbg !235
  %332 = load i64, ptr %107, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %332, ptr %331, align 8, !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %333 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 280, !dbg !235
  store atomic ptr %49, ptr %333 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %334 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 288, !dbg !235
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %334, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !235, !tbaa !225, !alias.scope !226, !noalias !227
  %335 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 328, !dbg !235
  store atomic ptr %51, ptr %335 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %336 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 336, !dbg !235
  store atomic ptr %53, ptr %336 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %337 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 344, !dbg !235
  store atomic ptr %55, ptr %337 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %338 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 352, !dbg !235
  store atomic ptr %57, ptr %338 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %339 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 360, !dbg !235
  store atomic ptr %59, ptr %339 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %340 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 368, !dbg !235
  store atomic ptr %61, ptr %340 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  %341 = getelementptr inbounds i8, ptr %"box::ProcessContext73", i64 376, !dbg !235
  store atomic ptr %63, ptr %341 unordered, align 8, !dbg !235, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext73", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !235
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !235
  store ptr %"box::ProcessContext73", ptr %120, align 8, !dbg !235
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !235
  %jl_f__compute_sparams_ret75 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !235
  store ptr %jl_f__compute_sparams_ret75, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret75, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret77 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret77.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret77, i64 -1, !dbg !228
  %jl_f__svec_ref_ret77.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret77.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %342 = and i64 %jl_f__svec_ref_ret77.tag, -16, !dbg !228
  %343 = inttoptr i64 %342 to ptr, !dbg !228
  %344 = icmp ult ptr %343, inttoptr (i64 1024 to ptr), !dbg !228
  br i1 %344, label %guard_pass78, label %guard_exit79, !dbg !228

L102:                                             ; preds = %guard_exit63
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret61, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret766 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L116:                                             ; preds = %guard_exit79
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret77, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret83 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2011 = load ptr, ptr %ptls_field, align 8, !dbg !212, !tbaa !156
  %"box::ProcessContext89" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2011, i32 1120, i32 400, i64 13729564624) #23, !dbg !212
  %"box::ProcessContext89.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext89", i64 -1, !dbg !212
  store atomic i64 13729564624, ptr %"box::ProcessContext89.tag_addr" unordered, align 8, !dbg !212, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext89" unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %345 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 8, !dbg !212
  store atomic ptr %9, ptr %345 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %346 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 16, !dbg !212
  store atomic ptr %11, ptr %346 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %347 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 24, !dbg !212
  store atomic ptr %13, ptr %347 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %348 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 32, !dbg !212
  store atomic ptr %15, ptr %348 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %349 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 40, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %349, ptr noundef nonnull align 8 dereferenceable(16) %74, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %350 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 56, !dbg !212
  store atomic ptr %17, ptr %350 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %351 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 64, !dbg !212
  store atomic ptr %19, ptr %351 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %352 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 72, !dbg !212
  store atomic ptr %21, ptr %352 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %353 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 80, !dbg !212
  store atomic ptr %23, ptr %353 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %354 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 88, !dbg !212
  store atomic ptr %25, ptr %354 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %355 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 96, !dbg !212
  %356 = load i64, ptr %81, align 8, !dbg !212
  store i64 %356, ptr %355, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %357 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 104, !dbg !212
  store atomic ptr %27, ptr %357 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %358 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 112, !dbg !212
  %359 = load i64, ptr %85, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %359, ptr %358, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %360 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 120, !dbg !212
  store atomic ptr %29, ptr %360 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %361 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 128, !dbg !212
  store atomic ptr %31, ptr %361 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %362 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 136, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %362, ptr noundef nonnull align 8 dereferenceable(16) %90, i64 16, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %363 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 152, !dbg !212
  store atomic ptr %33, ptr %363 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %364 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 160, !dbg !212
  store atomic ptr %35, ptr %364 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %365 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 168, !dbg !212
  store atomic ptr %37, ptr %365 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %366 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 176, !dbg !212
  store atomic ptr %39, ptr %366 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %367 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 184, !dbg !212
  store atomic ptr %41, ptr %367 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %368 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 192, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %368, ptr noundef nonnull align 8 dereferenceable(24) %97, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %369 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 216, !dbg !212
  store atomic ptr %43, ptr %369 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %370 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 224, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %370, ptr noundef nonnull align 8 dereferenceable(24) %100, i64 24, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %371 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 248, !dbg !212
  store atomic ptr %45, ptr %371 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %372 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 256, !dbg !212
  %373 = load i64, ptr %103, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %373, ptr %372, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %374 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 264, !dbg !212
  store atomic ptr %47, ptr %374 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %375 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 272, !dbg !212
  %376 = load i64, ptr %107, align 8, !dbg !212
  store i64 %376, ptr %375, align 8, !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %377 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 280, !dbg !212
  store atomic ptr %49, ptr %377 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %378 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 288, !dbg !212
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %378, ptr noundef nonnull align 8 dereferenceable(40) %111, i64 40, i1 false), !dbg !212, !tbaa !225, !alias.scope !226, !noalias !227
  %379 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 328, !dbg !212
  store atomic ptr %51, ptr %379 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %380 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 336, !dbg !212
  store atomic ptr %53, ptr %380 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %381 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 344, !dbg !212
  store atomic ptr %55, ptr %381 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %382 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 352, !dbg !212
  store atomic ptr %57, ptr %382 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %383 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 360, !dbg !212
  store atomic ptr %59, ptr %383 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %384 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 368, !dbg !212
  store atomic ptr %61, ptr %384 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  %385 = getelementptr inbounds i8, ptr %"box::ProcessContext89", i64 376, !dbg !212
  store atomic ptr %63, ptr %385 unordered, align 8, !dbg !212, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext89", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !212
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !212
  store ptr %"box::ProcessContext89", ptr %120, align 8, !dbg !212
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !212
  %jl_f__compute_sparams_ret91 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !212
  store ptr %jl_f__compute_sparams_ret91, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret91, ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !228
  %jl_f__svec_ref_ret93 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !228
  %jl_f__svec_ref_ret93.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret93, i64 -1, !dbg !228
  %jl_f__svec_ref_ret93.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret93.tag_addr unordered, align 8, !dbg !228, !tbaa !221, !range !231
  %386 = and i64 %jl_f__svec_ref_ret93.tag, -16, !dbg !228
  %387 = inttoptr i64 %386 to ptr, !dbg !228
  %388 = icmp ult ptr %387, inttoptr (i64 1024 to ptr), !dbg !228
  %389 = bitcast i64 %376 to double, !dbg !228
  %390 = trunc i64 %356 to i32, !dbg !228
  %391 = bitcast i32 %390 to float, !dbg !228
  br i1 %388, label %guard_pass94, label %guard_exit95, !dbg !228

L119:                                             ; preds = %guard_exit79
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret77, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret762 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L134:                                             ; preds = %guard_exit95
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !232
  store ptr %jl_f__svec_ref_ret93, ptr %119, align 8, !dbg !232
  %jl_f_isdefined_ret99 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !232
  %392 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !236
  %.stop_ptr = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 144, !dbg !240
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !266, !tbaa !169, !alias.scope !271, !noalias !272
  %.unbox = load i64, ptr %90, align 8, !dbg !266, !tbaa !225, !alias.scope !273, !noalias !274
  %.not965 = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !266
  br i1 %.not965, label %L148, label %L151, !dbg !246

L137:                                             ; preds = %guard_exit95
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !228
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !228
  store ptr %jl_f__svec_ref_ret93, ptr %120, align 8, !dbg !228
  %jl_f_throw_methoderror_ret758 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !228
  call void @llvm.trap(), !dbg !228
  unreachable, !dbg !228

L148:                                             ; preds = %L134
  store ptr null, ptr %gc_slot_addr_14, align 8
  %393 = call swiftcc [1 x ptr] @j_ArgumentError_9844(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9845.jit"), !dbg !246
  %394 = extractvalue [1 x ptr] %393, 0, !dbg !246
  store ptr %394, ptr %gc_slot_addr_14, align 8
  %ptls_load2018 = load ptr, ptr %ptls_field, align 8, !dbg !246, !tbaa !156
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load2018, i32 424, i32 16, i64 4869212144) #23, !dbg !246
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !246
  store atomic i64 4869212144, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !246, !tbaa !221
  store ptr %394, ptr %"box::ArgumentError", align 8, !dbg !246, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr null, ptr %gc_slot_addr_14, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !246
  unreachable, !dbg !246

L151:                                             ; preds = %L134
  %395 = add i64 %.stop_ptr.unbox, 1, !dbg !275
  %396 = sub i64 %395, %.unbox, !dbg !278
  store i64 %.unbox, ptr %"new::SamplerRangeNDL", align 8, !dbg !279, !tbaa !225, !alias.scope !273, !noalias !274
  %397 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8, !dbg !279
  store i64 %396, ptr %397, align 8, !dbg !279, !tbaa !281, !alias.scope !283, !noalias !284
  store ptr null, ptr %gc_slot_addr_14, align 8
  %398 = call swiftcc i64 @j_rand_9847(ptr nonnull swiftself %pgcstack, ptr %49, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !254
  %.fr1536 = freeze i64 %398
  %.state = load atomic ptr, ptr %47 unordered, align 8, !dbg !285, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %.state.size_ptr = getelementptr inbounds i8, ptr %.state, i64 16, !dbg !292
  %.state.size.0.copyload = load i64, ptr %.state.size_ptr, align 8, !dbg !292, !tbaa !225, !alias.scope !298, !noalias !299
  %.not966 = icmp eq i64 %.state.size.0.copyload, 100000, !dbg !300
  br i1 %.not966, label %L177, label %L172, !dbg !295

L172:                                             ; preds = %L151
  call swiftcc void @j_throw_dmrsa_9848(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %.state.size.0.copyload) #10, !dbg !305
  unreachable, !dbg !305

L177:                                             ; preds = %L151
  %399 = load ptr, ptr %.state, align 8, !dbg !306, !tbaa !308, !alias.scope !311, !noalias !312
  %memoryref_offset = shl i64 %.fr1536, 2, !dbg !313
  %400 = getelementptr i8, ptr %399, i64 %memoryref_offset, !dbg !313
  %memoryref_data108 = getelementptr i8, ptr %400, i64 -4, !dbg !313
  %401 = load float, ptr %memoryref_data108, align 4, !dbg !313, !tbaa !316, !alias.scope !189, !noalias !190
  %402 = icmp slt i64 %.fr1536, 100001
  br i1 %402, label %L223, label %L336, !dbg !318

L223:                                             ; preds = %L177
  %403 = call double @llvm.fabs.f64(double %389), !dbg !325
  %404 = fcmp oeq double %389, 0.000000e+00, !dbg !337
  br i1 %404, label %guard_pass818, label %L228, !dbg !339

L228:                                             ; preds = %L223
  %.idxF_ptr712 = getelementptr inbounds i8, ptr %49, i64 32, !dbg !340
  %.idxF713 = load i64, ptr %.idxF_ptr712, align 8, !dbg !340, !tbaa !203, !alias.scope !189, !noalias !190
  %.not971 = icmp eq i64 %.idxF713, 1002, !dbg !359
  br i1 %.not971, label %L231, label %L233, !dbg !344

L231:                                             ; preds = %L228
  %405 = call swiftcc i64 @j_gen_rand_9856(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !344
  %.idxF717.pre = load i64, ptr %.idxF_ptr712, align 8, !dbg !360, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L233, !dbg !344

L233:                                             ; preds = %L231, %L228
  %.idxF717 = phi i64 [ %.idxF713, %L228 ], [ %.idxF717.pre, %L231 ], !dbg !360
  %.vals_ptr714 = getelementptr inbounds i8, ptr %49, i64 16, !dbg !360
  %.vals715 = load atomic ptr, ptr %.vals_ptr714 unordered, align 8, !dbg !360, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %406 = add i64 %.idxF717, 1, !dbg !367
  store i64 %406, ptr %.idxF_ptr712, align 8, !dbg !368, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data720 = load ptr, ptr %.vals715, align 8, !dbg !369, !tbaa !308, !alias.scope !311, !noalias !312
  %memoryref_byteoffset723 = shl i64 %.idxF717, 3, !dbg !369
  %memoryref_data728 = getelementptr inbounds i8, ptr %memoryref_data720, i64 %memoryref_byteoffset723, !dbg !369
  %407 = load i64, ptr %memoryref_data728, align 8, !dbg !369, !tbaa !316, !alias.scope !189, !noalias !190
  %408 = trunc i64 %407 to i32, !dbg !370
  %409 = and i32 %408, 8388607, !dbg !371
  %410 = or disjoint i32 %409, 1065353216, !dbg !373
  %bitcast_coercion730 = bitcast i32 %410 to float, !dbg !375
  %411 = fadd float %bitcast_coercion730, -1.000000e+00, !dbg !377
  %412 = fmul float %411, 2.000000e+00, !dbg !381
  %413 = fadd float %412, -1.000000e+00, !dbg !385
  %414 = fpext float %413 to double, !dbg !386
  %415 = fmul double %403, %414, !dbg !381
  %416 = fpext float %401 to double, !dbg !395
  %417 = fadd double %415, %416, !dbg !401
  %418 = fadd double %417, 1.000000e+00, !dbg !403
  %419 = fsub double %418, %418, !dbg !408
  %420 = fcmp uno double %419, 0.000000e+00, !dbg !417
  %421 = fcmp oeq double %418, 0.000000e+00
  %or.cond = or i1 %420, %421, !dbg !411
  %422 = call double @llvm.fabs.f64(double %418), !dbg !421
  br i1 %or.cond, label %L293, label %L289, !dbg !411

L289:                                             ; preds = %L233
  %423 = call swiftcc double @j_rem_internal_9860(ptr nonnull swiftself %pgcstack, double %422, double 4.000000e+00), !dbg !422
  %424 = call double @llvm.copysign.f64(double %423, double %418), !dbg !423
  br label %L301, !dbg !426

L293:                                             ; preds = %L233
  %425 = bitcast double %422 to i64, !dbg !429
  %.not972 = icmp eq i64 %425, 9218868437227405312, !dbg !429
  br i1 %.not972, label %L308, label %L301, !dbg !431

L301:                                             ; preds = %L293, %L289
  %value_phi731 = phi double [ %424, %L289 ], [ %418, %L293 ]
  %426 = fcmp une double %value_phi731, 0.000000e+00, !dbg !432
  br i1 %426, label %L308, label %L306, !dbg !434

L306:                                             ; preds = %L301
  %427 = call double @llvm.fabs.f64(double %value_phi731), !dbg !435
  br label %guard_pass823, !dbg !426

L308:                                             ; preds = %L301, %L293
  %value_phi7311015 = phi double [ %value_phi731, %L301 ], [ 0x7FF8000000000000, %L293 ]
  %428 = fcmp ogt double %value_phi7311015, 0.000000e+00, !dbg !437
  %429 = fadd double %value_phi7311015, 4.000000e+00
  %spec.select895 = select i1 %428, double %value_phi7311015, double %429, !dbg !441
  br label %guard_pass823, !dbg !441

L336:                                             ; preds = %L177
  %jl_nothing738 = load ptr, ptr @jl_nothing, align 8, !dbg !442, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  %box_Float32739 = call ptr @ijl_box_float32(float %401), !dbg !442
  %gc_slot_addr_15 = getelementptr inbounds ptr, ptr %gcframe2, i64 17
  store ptr %box_Float32739, ptr %gc_slot_addr_15, align 8
  %ptls_load2024 = load ptr, ptr %ptls_field, align 8, !dbg !442, !tbaa !156
  %"box::Float64743" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load2024, i32 424, i32 16, i64 4869791888) #23, !dbg !442
  %"box::Float64743.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64743", i64 -1, !dbg !442
  store atomic i64 4869791888, ptr %"box::Float64743.tag_addr" unordered, align 8, !dbg !442, !tbaa !221
  %430 = load i64, ptr %107, align 8, !dbg !442, !tbaa !225, !alias.scope !226, !noalias !227
  store i64 %430, ptr %"box::Float64743", align 8, !dbg !442, !tbaa !225, !alias.scope !226, !noalias !227
  store ptr %"box::Float64743", ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9861.jit", ptr %jlcallframe1, align 8, !dbg !442
  store ptr %49, ptr %119, align 8, !dbg !442
  store ptr %jl_nothing738, ptr %120, align 8, !dbg !442
  store ptr %box_Float32739, ptr %121, align 8, !dbg !442
  %431 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !442
  store ptr %"box::Float64743", ptr %431, align 8, !dbg !442
  %jl_f_throw_methoderror_ret744 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !442
  call void @llvm.trap(), !dbg !442
  unreachable, !dbg !442

L354:                                             ; preds = %guard_pass823, %guard_pass818
  %.sroa.71354.0 = phi float [ %1139, %guard_pass818 ], [ %1144, %guard_pass823 ], !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111366, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101360, i64 7, i1 false), !dbg !445
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.101360), !dbg !445
  %432 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8, !dbg !446
  store i64 %.fr1536, ptr %432, align 8, !dbg !446, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !446
  store float %401, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !446, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !446
  store float %.sroa.71354.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !446, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !446
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !446, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !446
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !446, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !446
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111366, i64 7, i1 false), !dbg !446
  %.state118 = load atomic ptr, ptr %9 unordered, align 8, !dbg !450, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %433 = add i64 %.fr1536, -1, !dbg !461
  %.size_ptr = getelementptr inbounds i8, ptr %11, i64 16, !dbg !463
  %.size.0.copyload = load i64, ptr %.size_ptr, align 8, !dbg !463, !tbaa !225, !alias.scope !298, !noalias !299
  %.not973 = icmp ult i64 %433, %.size.0.copyload, !dbg !461
  br i1 %.not973, label %L412, label %L409, !dbg !461

L409:                                             ; preds = %L354
  store i64 %.fr1536, ptr %"new::Tuple708", align 8, !dbg !461, !tbaa !281, !alias.scope !283, !noalias !284
  call swiftcc void @j_throw_boundserror_9858(ptr nonnull swiftself %pgcstack, ptr %11, ptr nocapture nonnull readonly %"new::Tuple708") #10, !dbg !461
  unreachable, !dbg !461

L412:                                             ; preds = %L354
  %memoryref_data119 = load ptr, ptr %11, align 8, !dbg !464, !tbaa !308, !alias.scope !311, !noalias !312
  %434 = getelementptr i8, ptr %memoryref_data119, i64 %memoryref_offset, !dbg !464
  %memoryref_data127 = getelementptr i8, ptr %434, i64 -4, !dbg !464
  %435 = load float, ptr %memoryref_data127, align 4, !dbg !464, !tbaa !316, !alias.scope !189, !noalias !190
  %436 = fpext float %.sroa.71354.0 to double, !dbg !465
  store ptr %.state118, ptr %gc_slot_addr_14, align 8
  %437 = call swiftcc double @"j_#power_by_squaring#401_9851"(ptr nonnull swiftself %pgcstack, double %436, i64 signext 2), !dbg !472
  %.state118.size_ptr = getelementptr inbounds i8, ptr %.state118, i64 16, !dbg !463
  %.state118.size.0.copyload = load i64, ptr %.state118.size_ptr, align 8, !dbg !463, !tbaa !225, !alias.scope !298, !noalias !299
  %.not974 = icmp ult i64 %433, %.state118.size.0.copyload, !dbg !461
  br i1 %.not974, label %L437, label %L434, !dbg !461

L434:                                             ; preds = %L412
  store i64 %.fr1536, ptr %"new::Tuple706", align 8, !dbg !461, !tbaa !281, !alias.scope !283, !noalias !284
  call swiftcc void @j_throw_boundserror_9858(ptr nonnull swiftself %pgcstack, ptr nonnull %.state118, ptr nocapture nonnull readonly %"new::Tuple706") #10, !dbg !461
  unreachable, !dbg !461

L437:                                             ; preds = %L412
  %438 = fptrunc double %437 to float, !dbg !475
  %memoryref_data129 = load ptr, ptr %.state118, align 8, !dbg !464, !tbaa !308, !alias.scope !311, !noalias !312
  %439 = getelementptr i8, ptr %memoryref_data129, i64 %memoryref_offset, !dbg !464
  %memoryref_data137 = getelementptr i8, ptr %439, i64 -4, !dbg !464
  %440 = load float, ptr %memoryref_data137, align 4, !dbg !464, !tbaa !316, !alias.scope !189, !noalias !190
  %441 = fpext float %440 to double, !dbg !465
  store ptr null, ptr %gc_slot_addr_14, align 8
  %442 = call swiftcc double @"j_#power_by_squaring#401_9851"(ptr nonnull swiftself %pgcstack, double %441, i64 signext 2), !dbg !472
  %443 = fptrunc double %442 to float, !dbg !475
  %444 = fsub float %438, %443, !dbg !480
  %445 = fmul float %435, 0.000000e+00, !dbg !481
  %446 = fmul float %445, %444, !dbg !481
  %447 = fadd float %446, 0.000000e+00, !dbg !484
  store ptr %9, ptr %3, align 8, !dbg !458
  store ptr %17, ptr %2, align 8, !dbg !458
  %448 = getelementptr inbounds ptr, ptr %gcframe2, i64 4, !dbg !458
  store ptr %19, ptr %448, align 8, !dbg !458
  %449 = getelementptr inbounds ptr, ptr %gcframe2, i64 5, !dbg !458
  store ptr %21, ptr %449, align 8, !dbg !458
  %450 = getelementptr inbounds ptr, ptr %gcframe2, i64 6, !dbg !458
  store ptr %23, ptr %450, align 8, !dbg !458
  %451 = getelementptr inbounds ptr, ptr %gcframe2, i64 7, !dbg !458
  store ptr %25, ptr %451, align 8, !dbg !458
  %452 = call swiftcc float @"j_#calculate##0_9852"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %3, float %447, ptr nocapture nonnull readonly %74, ptr nocapture nonnull readonly %2), !dbg !458
  %.state138 = load atomic ptr, ptr %9 unordered, align 8, !dbg !485, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %453 = fneg float %391, !dbg !489
  store i64 %.fr1536, ptr %"new::Tuple140", align 8, !dbg !491, !tbaa !281, !alias.scope !283, !noalias !284
  %.not975 = icmp ult i64 %433, %359, !dbg !494
  br i1 %.not975, label %L495, label %L492, !dbg !500

L492:                                             ; preds = %L437
  %454 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %455 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !501
  store ptr %27, ptr %454, align 8, !dbg !500
  call swiftcc void @j_throw_boundserror_9859(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %455, ptr nocapture nonnull readonly %454, ptr nocapture nonnull readonly %"new::Tuple140") #10, !dbg !500
  unreachable, !dbg !500

L495:                                             ; preds = %L437
  %.state138.size_ptr = getelementptr inbounds i8, ptr %.state138, i64 16, !dbg !506
  %.state138.size.0.copyload = load i64, ptr %.state138.size_ptr, align 8, !dbg !506, !tbaa !225, !alias.scope !298, !noalias !299
  %.not976 = icmp ult i64 %433, %.state138.size.0.copyload, !dbg !507
  br i1 %.not976, label %L512, label %L509, !dbg !507

L509:                                             ; preds = %L495
  store i64 %.fr1536, ptr %"new::Tuple703", align 8, !dbg !507, !tbaa !281, !alias.scope !283, !noalias !284
  store ptr %.state138, ptr %gc_slot_addr_14, align 8
  call swiftcc void @j_throw_boundserror_9858(ptr nonnull swiftself %pgcstack, ptr nonnull %.state138, ptr nocapture nonnull readonly %"new::Tuple703") #10, !dbg !507
  unreachable, !dbg !507

L512:                                             ; preds = %L495
  %.x = load float, ptr %27, align 4, !dbg !508, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data143 = load ptr, ptr %.state138, align 8, !dbg !512, !tbaa !308, !alias.scope !311, !noalias !312
  %456 = getelementptr i8, ptr %memoryref_data143, i64 %memoryref_offset, !dbg !512
  %memoryref_data151 = getelementptr i8, ptr %456, i64 -4, !dbg !512
  %457 = load float, ptr %memoryref_data151, align 4, !dbg !512, !tbaa !316, !alias.scope !189, !noalias !190
  %458 = fsub float %.sroa.71354.0, %457, !dbg !513
  %459 = fmul float %.x, %453, !dbg !514
  %460 = fmul float %459, %458, !dbg !514
  %461 = fadd float %452, %460, !dbg !484
  %462 = fcmp ugt float %461, 0.000000e+00, !dbg !516
  br i1 %462, label %L527, label %L644, !dbg !518

L527:                                             ; preds = %L512
  %.idxF_ptr = getelementptr inbounds i8, ptr %49, i64 32, !dbg !519
  %.idxF = load i64, ptr %.idxF_ptr, align 8, !dbg !519, !tbaa !203, !alias.scope !189, !noalias !190
  %.not977 = icmp eq i64 %.idxF, 1002, !dbg !532
  br i1 %.not977, label %L530, label %L532, !dbg !521

L530:                                             ; preds = %L527
  %463 = call swiftcc i64 @j_gen_rand_9856(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !521
  %.idxF678.pre = load i64, ptr %.idxF_ptr, align 8, !dbg !533, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L532, !dbg !521

L532:                                             ; preds = %L530, %L527
  %.idxF678 = phi i64 [ %.idxF, %L527 ], [ %.idxF678.pre, %L530 ], !dbg !533
  %.vals_ptr = getelementptr inbounds i8, ptr %49, i64 16, !dbg !533
  %.vals = load atomic ptr, ptr %.vals_ptr unordered, align 8, !dbg !533, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %464 = add i64 %.idxF678, 1, !dbg !538
  store i64 %464, ptr %.idxF_ptr, align 8, !dbg !539, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data681 = load ptr, ptr %.vals, align 8, !dbg !540, !tbaa !308, !alias.scope !311, !noalias !312
  %memoryref_byteoffset684 = shl i64 %.idxF678, 3, !dbg !540
  %memoryref_data689 = getelementptr inbounds i8, ptr %memoryref_data681, i64 %memoryref_byteoffset684, !dbg !540
  %465 = load i64, ptr %memoryref_data689, align 8, !dbg !540, !tbaa !316, !alias.scope !189, !noalias !190
  %466 = trunc i64 %465 to i32, !dbg !541
  %467 = and i32 %466, 8388607, !dbg !542
  %468 = or disjoint i32 %467, 1065353216, !dbg !543
  %bitcast_coercion691 = bitcast i32 %468 to float, !dbg !544
  %469 = fadd float %bitcast_coercion691, -1.000000e+00, !dbg !545
  %470 = fneg float %461, !dbg !547
  %.unbox692 = load float, ptr %392, align 4, !dbg !548
  %471 = fdiv float %470, %.unbox692, !dbg !548
  %472 = fmul float %471, 0x3FF7154760000000, !dbg !550
  %473 = call float @llvm.rint.f32(float %472), !dbg !556
  %474 = fptosi float %473 to i32, !dbg !560
  %475 = freeze i32 %474, !dbg !560
  %476 = fmul contract float %473, 0x3FE62E4000000000, !dbg !563
  %477 = fsub contract float %471, %476, !dbg !563
  %478 = fmul contract float %473, 0x3EB7F7D1C0000000, !dbg !566
  %479 = fsub contract float %477, %478, !dbg !566
  %480 = fmul contract float %479, 0x3F2A1D7140000000, !dbg !568
  %481 = fadd contract float %480, 0x3F56DA7560000000, !dbg !568
  %482 = fmul contract float %479, %481, !dbg !568
  %483 = fadd contract float %482, 0x3F811105C0000000, !dbg !568
  %484 = fmul contract float %479, %483, !dbg !568
  %485 = fadd contract float %484, 0x3FA5554640000000, !dbg !568
  %486 = fmul contract float %479, %485, !dbg !568
  %487 = fadd contract float %486, 0x3FC5555560000000, !dbg !568
  %488 = fmul contract float %479, %487, !dbg !568
  %489 = fadd contract float %488, 5.000000e-01, !dbg !568
  %490 = fmul contract float %479, %489, !dbg !568
  %491 = fadd contract float %490, 1.000000e+00, !dbg !568
  %492 = fmul contract float %479, %491, !dbg !568
  %493 = fadd contract float %492, 1.000000e+00, !dbg !568
  %494 = fcmp ule float %471, 0x40562E4300000000, !dbg !576
  %495 = bitcast float %.unbox692 to i32, !dbg !578
  br i1 %494, label %L591, label %L642, !dbg !578

L591:                                             ; preds = %L532
  %496 = fcmp uge float %471, 0xC059FE3680000000, !dbg !579
  br i1 %496, label %L635, label %L642, !dbg !580

L635:                                             ; preds = %L591
  %497 = fcmp ugt float %471, 0xC055D58A00000000, !dbg !581
  %498 = fmul float %493, 0x3E70000000000000, !dbg !582
  %value_phi695 = select i1 %497, float %493, float %498, !dbg !582
  %.not978 = icmp eq i32 %475, 128, !dbg !583
  %499 = fmul float %value_phi695, 2.000000e+00, !dbg !585
  %value_phi697 = select i1 %.not978, float %499, float %value_phi695, !dbg !585
  %value_phi694.v = select i1 %497, i32 127, i32 151, !dbg !582
  %value_phi694 = add i32 %475, %value_phi694.v, !dbg !582
  %500 = sext i1 %.not978 to i32, !dbg !585
  %value_phi696 = add i32 %value_phi694, %500, !dbg !585
  %501 = shl i32 %value_phi696, 23, !dbg !586
  %bitcast_coercion700 = bitcast i32 %501 to float, !dbg !592
  %502 = fmul float %value_phi697, %bitcast_coercion700, !dbg !593
  br label %L642, !dbg !426

L642:                                             ; preds = %L635, %L591, %L532
  %value_phi693 = phi float [ %502, %L635 ], [ 0x7FF0000000000000, %L532 ], [ 0.000000e+00, %L591 ]
  %503 = fcmp olt float %469, %value_phi693, !dbg !594
  br i1 %503, label %L644, label %guard_pass833, !dbg !518

L644:                                             ; preds = %L642, %L512
  %.state153 = load atomic ptr, ptr %47 unordered, align 8, !dbg !595, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %.state153.size_ptr = getelementptr inbounds i8, ptr %.state153, i64 16, !dbg !601
  %.state153.size.0.copyload = load i64, ptr %.state153.size_ptr, align 8, !dbg !601, !tbaa !225, !alias.scope !298, !noalias !299
  %.not979 = icmp eq i64 %.state153.size.0.copyload, 100000, !dbg !603
  br i1 %.not979, label %guard_pass828, label %L652, !dbg !602

L652:                                             ; preds = %L644
  call swiftcc void @j_throw_dmrsa_9848(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %.state153.size.0.copyload) #10, !dbg !605
  unreachable, !dbg !605

L754.L1502_crit_edge:                             ; preds = %pass175
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61338, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.7", i64 56, i1 false), !dbg !606
  br label %L1502, !dbg !606

L754.L758_crit_edge:                              ; preds = %pass175
  call void @llvm.lifetime.start.p0(i64 96, ptr nonnull %.sroa.0952.sroa.0), !dbg !606
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %.sroa.0952.sroa.9), !dbg !606
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %.sroa.0952.sroa.10), !dbg !606
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %.sroa.0952.sroa.11), !dbg !606
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.0952.sroa.22), !dbg !606
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %.sroa.8957), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0952.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.9, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0952.sroa.10, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0952.sroa.22, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61338, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8957, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.7", i64 56, i1 false), !dbg !606, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.6953.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 320
  %.sroa.7955.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 324
  %.sroa.8957.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 328
  %504 = getelementptr inbounds i8, ptr %4, i64 40
  %505 = getelementptr inbounds i8, ptr %4, i64 96
  %506 = getelementptr inbounds i8, ptr %4, i64 112
  %507 = getelementptr inbounds i8, ptr %4, i64 136
  %508 = getelementptr inbounds i8, ptr %4, i64 192
  %509 = getelementptr inbounds i8, ptr %4, i64 224
  %510 = getelementptr inbounds i8, ptr %4, i64 256
  %511 = getelementptr inbounds i8, ptr %4, i64 272
  %512 = getelementptr inbounds i8, ptr %4, i64 288
  %.stop_ptr324 = getelementptr inbounds i8, ptr %4, i64 144
  %513 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL335", i64 8
  %root_phi204.idxF_ptr612 = getelementptr inbounds i8, ptr %49, i64 32
  %root_phi204.vals_ptr614 = getelementptr inbounds i8, ptr %49, i64 16
  %514 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1372", i64 8
  %515 = getelementptr inbounds ptr, ptr %gcframe2, i64 11
  %516 = getelementptr inbounds ptr, ptr %gcframe2, i64 12
  %517 = getelementptr inbounds ptr, ptr %gcframe2, i64 13
  %518 = getelementptr inbounds ptr, ptr %gcframe2, i64 14
  %519 = getelementptr inbounds i8, ptr %4, i64 16
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496
  br label %L758, !dbg !606

L758:                                             ; preds = %L1501, %L754.L758_crit_edge
  %.sroa.0952.sroa.6.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.2.8.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.2.8.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.7.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.3.8.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.3.8.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.8.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.4.8.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.4.8.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.12.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.9.128.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.9.128.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.13.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.10.128.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.10.128.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.14.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.11.128.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.11.128.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.15.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.12.128.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.12.128.copyload", %L1501 ], !dbg !606
  %.sroa.0952.sroa.17.0 = phi i64 [ %.fr1536, %L754.L758_crit_edge ], [ %.fr, %L1501 ], !dbg !606
  %.sroa.0952.sroa.18.0 = phi float [ %401, %L754.L758_crit_edge ], [ %831, %L1501 ], !dbg !606
  %.sroa.0952.sroa.19.0 = phi float [ %.sroa.71354.0, %L754.L758_crit_edge ], [ %.sroa.71307.0, %L1501 ], !dbg !606
  %.sroa.0952.sroa.21.0 = phi i8 [ %.sroa.91347.0, %L754.L758_crit_edge ], [ %.sroa.9.0, %L1501 ], !dbg !606
  %.sroa.6953.0 = phi float [ %461, %L754.L758_crit_edge ], [ %885, %L1501 ], !dbg !606
  %.sroa.7955.0 = phi i32 [ %"new::NamedTuple.sroa.6.316.copyload", %L754.L758_crit_edge ], [ %"new::NamedTuple427.sroa.5.316.copyload", %L1501 ], !dbg !606
  %value_phi183 = phi i64 [ %1110, %L754.L758_crit_edge ], [ %928, %L1501 ]
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %4, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0952.sroa.0, i64 96, i1 false), !dbg !607
  store i64 %.sroa.0952.sroa.6.0, ptr %505, align 8, !dbg !607
  %.sroa.0952.sroa.7.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 104, !dbg !607
  store i64 %.sroa.0952.sroa.7.0, ptr %.sroa.0952.sroa.7.0..sroa_idx, align 8, !dbg !607
  store i64 %.sroa.0952.sroa.8.0, ptr %506, align 8, !dbg !607
  %.sroa.0952.sroa.9.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 120, !dbg !607
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.9.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.9, i64 32, i1 false), !dbg !607
  %.sroa.0952.sroa.10.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 152, !dbg !607
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0952.sroa.10.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0952.sroa.10, i64 64, i1 false), !dbg !607
  %.sroa.0952.sroa.11.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 216, !dbg !607
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.11.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.11, i64 32, i1 false), !dbg !607
  %.sroa.0952.sroa.12.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 248, !dbg !607
  store i64 %.sroa.0952.sroa.12.0, ptr %.sroa.0952.sroa.12.0..sroa_idx, align 8, !dbg !607
  store i64 %.sroa.0952.sroa.13.0, ptr %510, align 8, !dbg !607
  %.sroa.0952.sroa.14.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 264, !dbg !607
  store i64 %.sroa.0952.sroa.14.0, ptr %.sroa.0952.sroa.14.0..sroa_idx, align 8, !dbg !607
  store i64 %.sroa.0952.sroa.15.0, ptr %511, align 8, !dbg !607
  store i64 %.sroa.0952.sroa.17.0, ptr %512, align 8, !dbg !607
  %.sroa.0952.sroa.18.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 296, !dbg !607
  store float %.sroa.0952.sroa.18.0, ptr %.sroa.0952.sroa.18.0..sroa_idx, align 8, !dbg !607
  %.sroa.0952.sroa.19.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 300, !dbg !607
  store float %.sroa.0952.sroa.19.0, ptr %.sroa.0952.sroa.19.0..sroa_idx, align 4, !dbg !607
  %.sroa.0952.sroa.20.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 304, !dbg !607
  store i64 1, ptr %.sroa.0952.sroa.20.0..sroa_idx, align 8, !dbg !607
  %.sroa.0952.sroa.21.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 312, !dbg !607
  store i8 %.sroa.0952.sroa.21.0, ptr %.sroa.0952.sroa.21.0..sroa_idx, align 8, !dbg !607
  %.sroa.0952.sroa.22.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 313, !dbg !607
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0952.sroa.22.0..sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0952.sroa.22, i64 7, i1 false), !dbg !607
  store float %.sroa.6953.0, ptr %.sroa.6953.0..sroa_idx, align 8, !dbg !607
  store i32 %.sroa.7955.0, ptr %.sroa.7955.0..sroa_idx, align 4, !dbg !607
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8957.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8957, i64 56, i1 false), !dbg !607
  call void @llvm.lifetime.end.p0(i64 96, ptr nonnull %.sroa.0952.sroa.0), !dbg !607
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %.sroa.0952.sroa.9), !dbg !607
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %.sroa.0952.sroa.10), !dbg !607
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %.sroa.0952.sroa.11), !dbg !607
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.0952.sroa.22), !dbg !607
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %.sroa.8957), !dbg !607
  %ptls_load2030 = load ptr, ptr %ptls_field, align 8, !dbg !608, !tbaa !156
  %"box::ProcessContext217" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2030, i32 1120, i32 400, i64 13729564624) #23, !dbg !608
  %"box::ProcessContext217.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext217", i64 -1, !dbg !608
  store atomic i64 13729564624, ptr %"box::ProcessContext217.tag_addr" unordered, align 8, !dbg !608, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext217" unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %520 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 8, !dbg !608
  store atomic ptr %9, ptr %520 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %521 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 16, !dbg !608
  store atomic ptr %11, ptr %521 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %522 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 24, !dbg !608
  store atomic ptr %13, ptr %522 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %523 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 32, !dbg !608
  store atomic ptr %15, ptr %523 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %524 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 40, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %524, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %525 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 56, !dbg !608
  store atomic ptr %17, ptr %525 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %526 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 64, !dbg !608
  store atomic ptr %19, ptr %526 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %527 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 72, !dbg !608
  store atomic ptr %21, ptr %527 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %528 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 80, !dbg !608
  store atomic ptr %23, ptr %528 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %529 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 88, !dbg !608
  store atomic ptr %25, ptr %529 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %530 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 96, !dbg !608
  store i64 %.sroa.0952.sroa.6.0, ptr %530, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %531 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 104, !dbg !608
  store atomic ptr %27, ptr %531 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %532 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 112, !dbg !608
  store i64 %.sroa.0952.sroa.8.0, ptr %532, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %533 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 120, !dbg !608
  store atomic ptr %29, ptr %533 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %534 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 128, !dbg !608
  store atomic ptr %31, ptr %534 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %535 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 136, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %535, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %536 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 152, !dbg !608
  store atomic ptr %33, ptr %536 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %537 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 160, !dbg !608
  store atomic ptr %35, ptr %537 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %538 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 168, !dbg !608
  store atomic ptr %37, ptr %538 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %539 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 176, !dbg !608
  store atomic ptr %39, ptr %539 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %540 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 184, !dbg !608
  store atomic ptr %41, ptr %540 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %541 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 192, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %541, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %542 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 216, !dbg !608
  store atomic ptr %43, ptr %542 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %543 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 224, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %543, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %544 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 248, !dbg !608
  store atomic ptr %45, ptr %544 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %545 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 256, !dbg !608
  store i64 %.sroa.0952.sroa.13.0, ptr %545, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %546 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 264, !dbg !608
  store atomic ptr %47, ptr %546 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %547 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 272, !dbg !608
  store i64 %.sroa.0952.sroa.15.0, ptr %547, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %548 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 280, !dbg !608
  store atomic ptr %49, ptr %548 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %549 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 288, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %549, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %550 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 328, !dbg !608
  store atomic ptr %51, ptr %550 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %551 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 336, !dbg !608
  store atomic ptr %53, ptr %551 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %552 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 344, !dbg !608
  store atomic ptr %55, ptr %552 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %553 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 352, !dbg !608
  store atomic ptr %57, ptr %553 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %554 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 360, !dbg !608
  store atomic ptr %59, ptr %554 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %555 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 368, !dbg !608
  store atomic ptr %61, ptr %555 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %556 = getelementptr inbounds i8, ptr %"box::ProcessContext217", i64 376, !dbg !608
  store atomic ptr %63, ptr %556 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext217", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !608
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !608
  store ptr %"box::ProcessContext217", ptr %120, align 8, !dbg !608
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !608
  %jl_f__compute_sparams_ret219 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !608
  store ptr %jl_f__compute_sparams_ret219, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret219, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret221 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret221.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret221, i64 -1, !dbg !614
  %jl_f__svec_ref_ret221.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret221.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %557 = and i64 %jl_f__svec_ref_ret221.tag, -16, !dbg !614
  %558 = inttoptr i64 %557 to ptr, !dbg !614
  %559 = icmp ult ptr %558, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %559, label %guard_pass222, label %guard_exit223, !dbg !614

L771:                                             ; preds = %guard_exit223
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret221, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret227 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2036 = load ptr, ptr %ptls_field, align 8, !dbg !608, !tbaa !156
  %"box::ProcessContext233" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2036, i32 1120, i32 400, i64 13729564624) #23, !dbg !608
  %"box::ProcessContext233.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext233", i64 -1, !dbg !608
  store atomic i64 13729564624, ptr %"box::ProcessContext233.tag_addr" unordered, align 8, !dbg !608, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext233" unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %560 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 8, !dbg !608
  store atomic ptr %9, ptr %560 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %561 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 16, !dbg !608
  store atomic ptr %11, ptr %561 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %562 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 24, !dbg !608
  store atomic ptr %13, ptr %562 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %563 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 32, !dbg !608
  store atomic ptr %15, ptr %563 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %564 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 40, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %564, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %565 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 56, !dbg !608
  store atomic ptr %17, ptr %565 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %566 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 64, !dbg !608
  store atomic ptr %19, ptr %566 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %567 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 72, !dbg !608
  store atomic ptr %21, ptr %567 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %568 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 80, !dbg !608
  store atomic ptr %23, ptr %568 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %569 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 88, !dbg !608
  store atomic ptr %25, ptr %569 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %570 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 96, !dbg !608
  %571 = load i64, ptr %505, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %571, ptr %570, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %572 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 104, !dbg !608
  store atomic ptr %27, ptr %572 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %573 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 112, !dbg !608
  %574 = load i64, ptr %506, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %574, ptr %573, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %575 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 120, !dbg !608
  store atomic ptr %29, ptr %575 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %576 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 128, !dbg !608
  store atomic ptr %31, ptr %576 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %577 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 136, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %577, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %578 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 152, !dbg !608
  store atomic ptr %33, ptr %578 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %579 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 160, !dbg !608
  store atomic ptr %35, ptr %579 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %580 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 168, !dbg !608
  store atomic ptr %37, ptr %580 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %581 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 176, !dbg !608
  store atomic ptr %39, ptr %581 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %582 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 184, !dbg !608
  store atomic ptr %41, ptr %582 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %583 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 192, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %583, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %584 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 216, !dbg !608
  store atomic ptr %43, ptr %584 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %585 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 224, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %585, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %586 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 248, !dbg !608
  store atomic ptr %45, ptr %586 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %587 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 256, !dbg !608
  %588 = load i64, ptr %510, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %588, ptr %587, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %589 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 264, !dbg !608
  store atomic ptr %47, ptr %589 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %590 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 272, !dbg !608
  %591 = load i64, ptr %511, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %591, ptr %590, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %592 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 280, !dbg !608
  store atomic ptr %49, ptr %592 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %593 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 288, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %593, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %594 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 328, !dbg !608
  store atomic ptr %51, ptr %594 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %595 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 336, !dbg !608
  store atomic ptr %53, ptr %595 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %596 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 344, !dbg !608
  store atomic ptr %55, ptr %596 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %597 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 352, !dbg !608
  store atomic ptr %57, ptr %597 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %598 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 360, !dbg !608
  store atomic ptr %59, ptr %598 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %599 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 368, !dbg !608
  store atomic ptr %61, ptr %599 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %600 = getelementptr inbounds i8, ptr %"box::ProcessContext233", i64 376, !dbg !608
  store atomic ptr %63, ptr %600 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext233", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !608
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !608
  store ptr %"box::ProcessContext233", ptr %120, align 8, !dbg !608
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !608
  %jl_f__compute_sparams_ret235 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !608
  store ptr %jl_f__compute_sparams_ret235, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret235, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret237 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret237.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret237, i64 -1, !dbg !614
  %jl_f__svec_ref_ret237.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret237.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %601 = and i64 %jl_f__svec_ref_ret237.tag, -16, !dbg !614
  %602 = inttoptr i64 %601 to ptr, !dbg !614
  %603 = icmp ult ptr %602, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %603, label %guard_pass238, label %guard_exit239, !dbg !614

L774:                                             ; preds = %guard_exit223
  store ptr %jl_f__svec_ref_ret221, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret221, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret673 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L791:                                             ; preds = %guard_exit239
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret237, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret243 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2044 = load ptr, ptr %ptls_field, align 8, !dbg !608, !tbaa !156
  %"box::ProcessContext249" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2044, i32 1120, i32 400, i64 13729564624) #23, !dbg !608
  %"box::ProcessContext249.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext249", i64 -1, !dbg !608
  store atomic i64 13729564624, ptr %"box::ProcessContext249.tag_addr" unordered, align 8, !dbg !608, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext249" unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %604 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 8, !dbg !608
  store atomic ptr %9, ptr %604 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %605 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 16, !dbg !608
  store atomic ptr %11, ptr %605 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %606 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 24, !dbg !608
  store atomic ptr %13, ptr %606 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %607 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 32, !dbg !608
  store atomic ptr %15, ptr %607 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %608 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 40, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %608, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %609 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 56, !dbg !608
  store atomic ptr %17, ptr %609 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %610 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 64, !dbg !608
  store atomic ptr %19, ptr %610 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %611 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 72, !dbg !608
  store atomic ptr %21, ptr %611 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %612 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 80, !dbg !608
  store atomic ptr %23, ptr %612 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %613 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 88, !dbg !608
  store atomic ptr %25, ptr %613 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %614 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 96, !dbg !608
  %615 = load i64, ptr %505, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %615, ptr %614, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %616 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 104, !dbg !608
  store atomic ptr %27, ptr %616 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %617 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 112, !dbg !608
  %618 = load i64, ptr %506, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %618, ptr %617, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %619 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 120, !dbg !608
  store atomic ptr %29, ptr %619 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %620 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 128, !dbg !608
  store atomic ptr %31, ptr %620 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %621 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 136, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %621, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %622 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 152, !dbg !608
  store atomic ptr %33, ptr %622 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %623 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 160, !dbg !608
  store atomic ptr %35, ptr %623 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %624 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 168, !dbg !608
  store atomic ptr %37, ptr %624 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %625 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 176, !dbg !608
  store atomic ptr %39, ptr %625 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %626 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 184, !dbg !608
  store atomic ptr %41, ptr %626 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %627 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 192, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %627, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %628 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 216, !dbg !608
  store atomic ptr %43, ptr %628 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %629 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 224, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %629, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %630 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 248, !dbg !608
  store atomic ptr %45, ptr %630 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %631 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 256, !dbg !608
  %632 = load i64, ptr %510, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %632, ptr %631, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %633 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 264, !dbg !608
  store atomic ptr %47, ptr %633 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %634 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 272, !dbg !608
  %635 = load i64, ptr %511, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %635, ptr %634, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %636 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 280, !dbg !608
  store atomic ptr %49, ptr %636 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %637 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 288, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %637, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %638 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 328, !dbg !608
  store atomic ptr %51, ptr %638 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %639 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 336, !dbg !608
  store atomic ptr %53, ptr %639 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %640 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 344, !dbg !608
  store atomic ptr %55, ptr %640 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %641 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 352, !dbg !608
  store atomic ptr %57, ptr %641 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %642 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 360, !dbg !608
  store atomic ptr %59, ptr %642 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %643 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 368, !dbg !608
  store atomic ptr %61, ptr %643 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %644 = getelementptr inbounds i8, ptr %"box::ProcessContext249", i64 376, !dbg !608
  store atomic ptr %63, ptr %644 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext249", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !608
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !608
  store ptr %"box::ProcessContext249", ptr %120, align 8, !dbg !608
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !608
  %jl_f__compute_sparams_ret251 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !608
  store ptr %jl_f__compute_sparams_ret251, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret251, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret253 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret253.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret253, i64 -1, !dbg !614
  %jl_f__svec_ref_ret253.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret253.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %645 = and i64 %jl_f__svec_ref_ret253.tag, -16, !dbg !614
  %646 = inttoptr i64 %645 to ptr, !dbg !614
  %647 = icmp ult ptr %646, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %647, label %guard_pass254, label %guard_exit255, !dbg !614

L794:                                             ; preds = %guard_exit239
  store ptr %jl_f__svec_ref_ret237, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret237, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret669 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L811:                                             ; preds = %guard_exit255
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret253, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret259 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2052 = load ptr, ptr %ptls_field, align 8, !dbg !608, !tbaa !156
  %"box::ProcessContext265" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2052, i32 1120, i32 400, i64 13729564624) #23, !dbg !608
  %"box::ProcessContext265.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext265", i64 -1, !dbg !608
  store atomic i64 13729564624, ptr %"box::ProcessContext265.tag_addr" unordered, align 8, !dbg !608, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext265" unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %648 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 8, !dbg !608
  store atomic ptr %9, ptr %648 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %649 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 16, !dbg !608
  store atomic ptr %11, ptr %649 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %650 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 24, !dbg !608
  store atomic ptr %13, ptr %650 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %651 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 32, !dbg !608
  store atomic ptr %15, ptr %651 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %652 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 40, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %652, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %653 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 56, !dbg !608
  store atomic ptr %17, ptr %653 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %654 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 64, !dbg !608
  store atomic ptr %19, ptr %654 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %655 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 72, !dbg !608
  store atomic ptr %21, ptr %655 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %656 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 80, !dbg !608
  store atomic ptr %23, ptr %656 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %657 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 88, !dbg !608
  store atomic ptr %25, ptr %657 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %658 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 96, !dbg !608
  %659 = load i64, ptr %505, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %659, ptr %658, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %660 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 104, !dbg !608
  store atomic ptr %27, ptr %660 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %661 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 112, !dbg !608
  %662 = load i64, ptr %506, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %662, ptr %661, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %663 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 120, !dbg !608
  store atomic ptr %29, ptr %663 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %664 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 128, !dbg !608
  store atomic ptr %31, ptr %664 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %665 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 136, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %665, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %666 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 152, !dbg !608
  store atomic ptr %33, ptr %666 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %667 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 160, !dbg !608
  store atomic ptr %35, ptr %667 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %668 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 168, !dbg !608
  store atomic ptr %37, ptr %668 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %669 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 176, !dbg !608
  store atomic ptr %39, ptr %669 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %670 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 184, !dbg !608
  store atomic ptr %41, ptr %670 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %671 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 192, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %671, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %672 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 216, !dbg !608
  store atomic ptr %43, ptr %672 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %673 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 224, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %673, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %674 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 248, !dbg !608
  store atomic ptr %45, ptr %674 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %675 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 256, !dbg !608
  %676 = load i64, ptr %510, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %676, ptr %675, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %677 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 264, !dbg !608
  store atomic ptr %47, ptr %677 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %678 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 272, !dbg !608
  %679 = load i64, ptr %511, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %679, ptr %678, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %680 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 280, !dbg !608
  store atomic ptr %49, ptr %680 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %681 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 288, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %681, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %682 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 328, !dbg !608
  store atomic ptr %51, ptr %682 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %683 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 336, !dbg !608
  store atomic ptr %53, ptr %683 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %684 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 344, !dbg !608
  store atomic ptr %55, ptr %684 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %685 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 352, !dbg !608
  store atomic ptr %57, ptr %685 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %686 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 360, !dbg !608
  store atomic ptr %59, ptr %686 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %687 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 368, !dbg !608
  store atomic ptr %61, ptr %687 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %688 = getelementptr inbounds i8, ptr %"box::ProcessContext265", i64 376, !dbg !608
  store atomic ptr %63, ptr %688 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext265", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !608
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !608
  store ptr %"box::ProcessContext265", ptr %120, align 8, !dbg !608
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !608
  %jl_f__compute_sparams_ret267 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !608
  store ptr %jl_f__compute_sparams_ret267, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret267, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret269 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret269.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret269, i64 -1, !dbg !614
  %jl_f__svec_ref_ret269.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret269.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %689 = and i64 %jl_f__svec_ref_ret269.tag, -16, !dbg !614
  %690 = inttoptr i64 %689 to ptr, !dbg !614
  %691 = icmp ult ptr %690, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %691, label %guard_pass270, label %guard_exit271, !dbg !614

L814:                                             ; preds = %guard_exit255
  store ptr %jl_f__svec_ref_ret253, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret253, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret665 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L831:                                             ; preds = %guard_exit271
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret269, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret275 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2060 = load ptr, ptr %ptls_field, align 8, !dbg !617, !tbaa !156
  %"box::ProcessContext281" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2060, i32 1120, i32 400, i64 13729564624) #23, !dbg !617
  %"box::ProcessContext281.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext281", i64 -1, !dbg !617
  store atomic i64 13729564624, ptr %"box::ProcessContext281.tag_addr" unordered, align 8, !dbg !617, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext281" unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %692 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 8, !dbg !617
  store atomic ptr %9, ptr %692 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %693 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 16, !dbg !617
  store atomic ptr %11, ptr %693 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %694 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 24, !dbg !617
  store atomic ptr %13, ptr %694 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %695 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 32, !dbg !617
  store atomic ptr %15, ptr %695 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %696 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 40, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %696, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %697 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 56, !dbg !617
  store atomic ptr %17, ptr %697 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %698 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 64, !dbg !617
  store atomic ptr %19, ptr %698 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %699 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 72, !dbg !617
  store atomic ptr %21, ptr %699 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %700 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 80, !dbg !617
  store atomic ptr %23, ptr %700 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %701 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 88, !dbg !617
  store atomic ptr %25, ptr %701 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %702 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 96, !dbg !617
  %703 = load i64, ptr %505, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %703, ptr %702, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %704 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 104, !dbg !617
  store atomic ptr %27, ptr %704 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %705 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 112, !dbg !617
  %706 = load i64, ptr %506, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %706, ptr %705, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %707 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 120, !dbg !617
  store atomic ptr %29, ptr %707 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %708 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 128, !dbg !617
  store atomic ptr %31, ptr %708 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %709 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 136, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %709, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %710 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 152, !dbg !617
  store atomic ptr %33, ptr %710 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %711 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 160, !dbg !617
  store atomic ptr %35, ptr %711 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %712 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 168, !dbg !617
  store atomic ptr %37, ptr %712 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %713 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 176, !dbg !617
  store atomic ptr %39, ptr %713 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %714 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 184, !dbg !617
  store atomic ptr %41, ptr %714 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %715 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 192, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %715, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %716 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 216, !dbg !617
  store atomic ptr %43, ptr %716 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %717 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 224, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %717, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %718 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 248, !dbg !617
  store atomic ptr %45, ptr %718 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %719 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 256, !dbg !617
  %720 = load i64, ptr %510, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %720, ptr %719, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %721 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 264, !dbg !617
  store atomic ptr %47, ptr %721 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %722 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 272, !dbg !617
  %723 = load i64, ptr %511, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %723, ptr %722, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %724 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 280, !dbg !617
  store atomic ptr %49, ptr %724 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %725 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 288, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %725, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %726 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 328, !dbg !617
  store atomic ptr %51, ptr %726 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %727 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 336, !dbg !617
  store atomic ptr %53, ptr %727 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %728 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 344, !dbg !617
  store atomic ptr %55, ptr %728 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %729 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 352, !dbg !617
  store atomic ptr %57, ptr %729 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %730 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 360, !dbg !617
  store atomic ptr %59, ptr %730 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %731 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 368, !dbg !617
  store atomic ptr %61, ptr %731 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %732 = getelementptr inbounds i8, ptr %"box::ProcessContext281", i64 376, !dbg !617
  store atomic ptr %63, ptr %732 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext281", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !617
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !617
  store ptr %"box::ProcessContext281", ptr %120, align 8, !dbg !617
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !617
  %jl_f__compute_sparams_ret283 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !617
  store ptr %jl_f__compute_sparams_ret283, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret283, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret285 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret285.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret285, i64 -1, !dbg !614
  %jl_f__svec_ref_ret285.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret285.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %733 = and i64 %jl_f__svec_ref_ret285.tag, -16, !dbg !614
  %734 = inttoptr i64 %733 to ptr, !dbg !614
  %735 = icmp ult ptr %734, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %735, label %guard_pass286, label %guard_exit287, !dbg !614

L834:                                             ; preds = %guard_exit271
  store ptr %jl_f__svec_ref_ret269, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret269, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret661 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L850:                                             ; preds = %guard_exit287
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret285, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret291 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2068 = load ptr, ptr %ptls_field, align 8, !dbg !617, !tbaa !156
  %"box::ProcessContext297" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2068, i32 1120, i32 400, i64 13729564624) #23, !dbg !617
  %"box::ProcessContext297.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext297", i64 -1, !dbg !617
  store atomic i64 13729564624, ptr %"box::ProcessContext297.tag_addr" unordered, align 8, !dbg !617, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext297" unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %736 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 8, !dbg !617
  store atomic ptr %9, ptr %736 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %737 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 16, !dbg !617
  store atomic ptr %11, ptr %737 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %738 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 24, !dbg !617
  store atomic ptr %13, ptr %738 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %739 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 32, !dbg !617
  store atomic ptr %15, ptr %739 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %740 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 40, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %740, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %741 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 56, !dbg !617
  store atomic ptr %17, ptr %741 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %742 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 64, !dbg !617
  store atomic ptr %19, ptr %742 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %743 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 72, !dbg !617
  store atomic ptr %21, ptr %743 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %744 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 80, !dbg !617
  store atomic ptr %23, ptr %744 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %745 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 88, !dbg !617
  store atomic ptr %25, ptr %745 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %746 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 96, !dbg !617
  %747 = load i64, ptr %505, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %747, ptr %746, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %748 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 104, !dbg !617
  store atomic ptr %27, ptr %748 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %749 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 112, !dbg !617
  %750 = load i64, ptr %506, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %750, ptr %749, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %751 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 120, !dbg !617
  store atomic ptr %29, ptr %751 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %752 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 128, !dbg !617
  store atomic ptr %31, ptr %752 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %753 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 136, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %753, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %754 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 152, !dbg !617
  store atomic ptr %33, ptr %754 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %755 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 160, !dbg !617
  store atomic ptr %35, ptr %755 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %756 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 168, !dbg !617
  store atomic ptr %37, ptr %756 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %757 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 176, !dbg !617
  store atomic ptr %39, ptr %757 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %758 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 184, !dbg !617
  store atomic ptr %41, ptr %758 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %759 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 192, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %759, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %760 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 216, !dbg !617
  store atomic ptr %43, ptr %760 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %761 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 224, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %761, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %762 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 248, !dbg !617
  store atomic ptr %45, ptr %762 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %763 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 256, !dbg !617
  %764 = load i64, ptr %510, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %764, ptr %763, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %765 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 264, !dbg !617
  store atomic ptr %47, ptr %765 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %766 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 272, !dbg !617
  %767 = load i64, ptr %511, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %767, ptr %766, align 8, !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %768 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 280, !dbg !617
  store atomic ptr %49, ptr %768 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %769 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 288, !dbg !617
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %769, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !617, !tbaa !225, !alias.scope !612, !noalias !613
  %770 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 328, !dbg !617
  store atomic ptr %51, ptr %770 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %771 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 336, !dbg !617
  store atomic ptr %53, ptr %771 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %772 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 344, !dbg !617
  store atomic ptr %55, ptr %772 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %773 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 352, !dbg !617
  store atomic ptr %57, ptr %773 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %774 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 360, !dbg !617
  store atomic ptr %59, ptr %774 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %775 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 368, !dbg !617
  store atomic ptr %61, ptr %775 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  %776 = getelementptr inbounds i8, ptr %"box::ProcessContext297", i64 376, !dbg !617
  store atomic ptr %63, ptr %776 unordered, align 8, !dbg !617, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext297", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !617
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !617
  store ptr %"box::ProcessContext297", ptr %120, align 8, !dbg !617
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !617
  %jl_f__compute_sparams_ret299 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !617
  store ptr %jl_f__compute_sparams_ret299, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret299, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret301 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret301.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret301, i64 -1, !dbg !614
  %jl_f__svec_ref_ret301.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret301.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %777 = and i64 %jl_f__svec_ref_ret301.tag, -16, !dbg !614
  %778 = inttoptr i64 %777 to ptr, !dbg !614
  %779 = icmp ult ptr %778, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %779, label %guard_pass302, label %guard_exit303, !dbg !614

L853:                                             ; preds = %guard_exit287
  store ptr %jl_f__svec_ref_ret285, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret285, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret657 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L867:                                             ; preds = %guard_exit303
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret301, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret307 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  store ptr null, ptr %gc_slot_addr_14, align 8
  %ptls_load2076 = load ptr, ptr %ptls_field, align 8, !dbg !608, !tbaa !156
  %"box::ProcessContext313" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2076, i32 1120, i32 400, i64 13729564624) #23, !dbg !608
  %"box::ProcessContext313.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext313", i64 -1, !dbg !608
  store atomic i64 13729564624, ptr %"box::ProcessContext313.tag_addr" unordered, align 8, !dbg !608, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext313" unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %780 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 8, !dbg !608
  store atomic ptr %9, ptr %780 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %781 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 16, !dbg !608
  store atomic ptr %11, ptr %781 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %782 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 24, !dbg !608
  store atomic ptr %13, ptr %782 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %783 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 32, !dbg !608
  store atomic ptr %15, ptr %783 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %784 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 40, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %784, ptr noundef nonnull align 8 dereferenceable(16) %504, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %785 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 56, !dbg !608
  store atomic ptr %17, ptr %785 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %786 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 64, !dbg !608
  store atomic ptr %19, ptr %786 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %787 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 72, !dbg !608
  store atomic ptr %21, ptr %787 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %788 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 80, !dbg !608
  store atomic ptr %23, ptr %788 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %789 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 88, !dbg !608
  store atomic ptr %25, ptr %789 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %790 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 96, !dbg !608
  %791 = load i64, ptr %505, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %791, ptr %790, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %792 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 104, !dbg !608
  store atomic ptr %27, ptr %792 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %793 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 112, !dbg !608
  %794 = load i64, ptr %506, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %794, ptr %793, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %795 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 120, !dbg !608
  store atomic ptr %29, ptr %795 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %796 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 128, !dbg !608
  store atomic ptr %31, ptr %796 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %797 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 136, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %797, ptr noundef nonnull align 8 dereferenceable(16) %507, i64 16, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %798 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 152, !dbg !608
  store atomic ptr %33, ptr %798 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %799 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 160, !dbg !608
  store atomic ptr %35, ptr %799 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %800 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 168, !dbg !608
  store atomic ptr %37, ptr %800 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %801 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 176, !dbg !608
  store atomic ptr %39, ptr %801 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %802 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 184, !dbg !608
  store atomic ptr %41, ptr %802 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %803 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 192, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %803, ptr noundef nonnull align 8 dereferenceable(24) %508, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %804 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 216, !dbg !608
  store atomic ptr %43, ptr %804 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %805 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 224, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %805, ptr noundef nonnull align 8 dereferenceable(24) %509, i64 24, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %806 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 248, !dbg !608
  store atomic ptr %45, ptr %806 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %807 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 256, !dbg !608
  %808 = load i64, ptr %510, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %808, ptr %807, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %809 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 264, !dbg !608
  store atomic ptr %47, ptr %809 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %810 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 272, !dbg !608
  %811 = load i64, ptr %511, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %811, ptr %810, align 8, !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %812 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 280, !dbg !608
  store atomic ptr %49, ptr %812 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %813 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 288, !dbg !608
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(40) %813, ptr noundef nonnull align 8 dereferenceable(40) %512, i64 40, i1 false), !dbg !608, !tbaa !225, !alias.scope !612, !noalias !613
  %814 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 328, !dbg !608
  store atomic ptr %51, ptr %814 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %815 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 336, !dbg !608
  store atomic ptr %53, ptr %815 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %816 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 344, !dbg !608
  store atomic ptr %55, ptr %816 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %817 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 352, !dbg !608
  store atomic ptr %57, ptr %817 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %818 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 360, !dbg !608
  store atomic ptr %59, ptr %818 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %819 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 368, !dbg !608
  store atomic ptr %61, ptr %819 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  %820 = getelementptr inbounds i8, ptr %"box::ProcessContext313", i64 376, !dbg !608
  store atomic ptr %63, ptr %820 unordered, align 8, !dbg !608, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr %"box::ProcessContext313", ptr %gc_slot_addr_14, align 8
  store ptr @"-InteractiveIsing.Processes.get_widened_subcontext#9838.jit", ptr %jlcallframe1, align 8, !dbg !608
  store ptr @"jl_global#9839.jit", ptr %119, align 8, !dbg !608
  store ptr %"box::ProcessContext313", ptr %120, align 8, !dbg !608
  store ptr @"jl_global#9840.jit", ptr %121, align 8, !dbg !608
  %jl_f__compute_sparams_ret315 = call nonnull ptr @jl_f__compute_sparams(ptr null, ptr nonnull %jlcallframe1, i32 4), !dbg !608
  store ptr %jl_f__compute_sparams_ret315, ptr %gc_slot_addr_14, align 8
  store ptr %jl_f__compute_sparams_ret315, ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9841.jit", ptr %119, align 8, !dbg !614
  %jl_f__svec_ref_ret317 = call nonnull ptr @jl_f__svec_ref(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !614
  %jl_f__svec_ref_ret317.tag_addr = getelementptr inbounds i64, ptr %jl_f__svec_ref_ret317, i64 -1, !dbg !614
  %jl_f__svec_ref_ret317.tag = load atomic volatile i64, ptr %jl_f__svec_ref_ret317.tag_addr unordered, align 8, !dbg !614, !tbaa !221, !range !231
  %821 = and i64 %jl_f__svec_ref_ret317.tag, -16, !dbg !614
  %822 = inttoptr i64 %821 to ptr, !dbg !614
  %823 = icmp ult ptr %822, inttoptr (i64 1024 to ptr), !dbg !614
  br i1 %823, label %guard_pass318, label %guard_exit319, !dbg !614

L870:                                             ; preds = %guard_exit303
  store ptr %jl_f__svec_ref_ret301, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret301, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret653 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L885:                                             ; preds = %guard_exit319
  store ptr @"jl_global#9843.jit", ptr %jlcallframe1, align 8, !dbg !616
  store ptr %jl_f__svec_ref_ret317, ptr %119, align 8, !dbg !616
  %jl_f_isdefined_ret323 = call nonnull ptr @jl_f_isdefined(ptr null, ptr nonnull %jlcallframe1, i32 2), !dbg !616
  %.stop_ptr324.unbox = load i64, ptr %.stop_ptr324, align 8, !dbg !618, !tbaa !281, !alias.scope !283, !noalias !284
  %.unbox325 = load i64, ptr %507, align 8, !dbg !618, !tbaa !281, !alias.scope !283, !noalias !284
  %.not990.not = icmp slt i64 %.stop_ptr324.unbox, %.unbox325, !dbg !618
  br i1 %.not990.not, label %L899, label %L902, !dbg !621

L888:                                             ; preds = %guard_exit319
  store ptr %jl_f__svec_ref_ret317, ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9865.jit", ptr %jlcallframe1, align 8, !dbg !614
  store ptr @"jl_global#9843.jit", ptr %119, align 8, !dbg !614
  store ptr %jl_f__svec_ref_ret317, ptr %120, align 8, !dbg !614
  %jl_f_throw_methoderror_ret649 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 3), !dbg !614
  call void @llvm.trap(), !dbg !614
  unreachable, !dbg !614

L899:                                             ; preds = %L885
  store ptr null, ptr %gc_slot_addr_14, align 8
  %824 = call swiftcc [1 x ptr] @j_ArgumentError_9844(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9845.jit"), !dbg !621
  %825 = extractvalue [1 x ptr] %824, 0, !dbg !621
  store ptr %825, ptr %gc_slot_addr_14, align 8
  %ptls_load2087 = load ptr, ptr %ptls_field, align 8, !dbg !621, !tbaa !156
  %"box::ArgumentError330" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load2087, i32 424, i32 16, i64 4869212144) #23, !dbg !621
  %"box::ArgumentError330.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError330", i64 -1, !dbg !621
  store atomic i64 4869212144, ptr %"box::ArgumentError330.tag_addr" unordered, align 8, !dbg !621, !tbaa !221
  store ptr %825, ptr %"box::ArgumentError330", align 8, !dbg !621, !tbaa !223, !alias.scope !189, !noalias !190
  store ptr null, ptr %gc_slot_addr_14, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError330"), !dbg !621
  unreachable, !dbg !621

L902:                                             ; preds = %L885
  %826 = add i64 %.stop_ptr324.unbox, 1, !dbg !629
  %827 = sub i64 %826, %.unbox325, !dbg !631
  store i64 %.unbox325, ptr %"new::SamplerRangeNDL335", align 8, !dbg !632, !tbaa !281, !alias.scope !283, !noalias !284
  store i64 %827, ptr %513, align 8, !dbg !632, !tbaa !281, !alias.scope !283, !noalias !284
  store ptr null, ptr %gc_slot_addr_14, align 8
  %828 = call swiftcc i64 @j_rand_9847(ptr nonnull swiftself %pgcstack, ptr %49, ptr nocapture nonnull readonly %"new::SamplerRangeNDL335"), !dbg !624
  %.fr = freeze i64 %828
  %root_phi203.state = load atomic ptr, ptr %47 unordered, align 8, !dbg !634, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %root_phi203.state.size_ptr = getelementptr inbounds i8, ptr %root_phi203.state, i64 16, !dbg !637
  %root_phi203.state.size.0.copyload = load i64, ptr %root_phi203.state.size_ptr, align 8, !dbg !637, !tbaa !225, !alias.scope !298, !noalias !299
  %.not991 = icmp eq i64 %root_phi203.state.size.0.copyload, 100000, !dbg !639
  br i1 %.not991, label %L928, label %L923, !dbg !638

L923:                                             ; preds = %L902
  call swiftcc void @j_throw_dmrsa_9848(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi203.state.size.0.copyload) #10, !dbg !641
  unreachable, !dbg !641

L928:                                             ; preds = %L902
  %829 = load ptr, ptr %root_phi203.state, align 8, !dbg !642, !tbaa !308, !alias.scope !311, !noalias !312
  %memoryref_offset346 = shl i64 %.fr, 2, !dbg !644
  %830 = getelementptr i8, ptr %829, i64 %memoryref_offset346, !dbg !644
  %memoryref_data352 = getelementptr i8, ptr %830, i64 -4, !dbg !644
  %831 = load float, ptr %memoryref_data352, align 4, !dbg !644, !tbaa !316, !alias.scope !189, !noalias !190
  %832 = icmp slt i64 %.fr, 100001
  br i1 %832, label %L974, label %L1087, !dbg !646

L974:                                             ; preds = %L928
  %.unbox361 = load double, ptr %511, align 8, !dbg !649, !tbaa !281, !alias.scope !283, !noalias !284
  %833 = call double @llvm.fabs.f64(double %.unbox361), !dbg !649
  %834 = fcmp oeq double %.unbox361, 0.000000e+00, !dbg !655
  br i1 %834, label %guard_pass870, label %L979, !dbg !656

L979:                                             ; preds = %L974
  %root_phi204.idxF613 = load i64, ptr %root_phi204.idxF_ptr612, align 8, !dbg !657, !tbaa !203, !alias.scope !189, !noalias !190
  %.not996 = icmp eq i64 %root_phi204.idxF613, 1002, !dbg !671
  br i1 %.not996, label %L982, label %L984, !dbg !659

L982:                                             ; preds = %L979
  %835 = call swiftcc i64 @j_gen_rand_9856(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !659
  %root_phi204.idxF617.pre = load i64, ptr %root_phi204.idxF_ptr612, align 8, !dbg !672, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L984, !dbg !659

L984:                                             ; preds = %L982, %L979
  %root_phi204.idxF617 = phi i64 [ %root_phi204.idxF613, %L979 ], [ %root_phi204.idxF617.pre, %L982 ], !dbg !672
  %root_phi204.vals615 = load atomic ptr, ptr %root_phi204.vals_ptr614 unordered, align 8, !dbg !672, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %836 = add i64 %root_phi204.idxF617, 1, !dbg !677
  store i64 %836, ptr %root_phi204.idxF_ptr612, align 8, !dbg !678, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data620 = load ptr, ptr %root_phi204.vals615, align 8, !dbg !679, !tbaa !308, !alias.scope !311, !noalias !312
  %memoryref_byteoffset623 = shl i64 %root_phi204.idxF617, 3, !dbg !679
  %memoryref_data628 = getelementptr inbounds i8, ptr %memoryref_data620, i64 %memoryref_byteoffset623, !dbg !679
  %837 = load i64, ptr %memoryref_data628, align 8, !dbg !679, !tbaa !316, !alias.scope !189, !noalias !190
  %838 = trunc i64 %837 to i32, !dbg !680
  %839 = and i32 %838, 8388607, !dbg !681
  %840 = or disjoint i32 %839, 1065353216, !dbg !682
  %bitcast_coercion630 = bitcast i32 %840 to float, !dbg !683
  %841 = fadd float %bitcast_coercion630, -1.000000e+00, !dbg !684
  %842 = fmul float %841, 2.000000e+00, !dbg !686
  %843 = fadd float %842, -1.000000e+00, !dbg !688
  %844 = fpext float %843 to double, !dbg !689
  %845 = fmul double %833, %844, !dbg !686
  %846 = fpext float %831 to double, !dbg !693
  %847 = fadd double %845, %846, !dbg !698
  %848 = fadd double %847, 1.000000e+00, !dbg !699
  %849 = fsub double %848, %848, !dbg !703
  %850 = fcmp uno double %849, 0.000000e+00, !dbg !708
  %851 = fcmp oeq double %848, 0.000000e+00
  %or.cond1539 = or i1 %850, %851, !dbg !705
  %852 = call double @llvm.fabs.f64(double %848), !dbg !710
  br i1 %or.cond1539, label %L1044, label %L1040, !dbg !705

L1040:                                            ; preds = %L984
  %853 = call swiftcc double @j_rem_internal_9860(ptr nonnull swiftself %pgcstack, double %852, double 4.000000e+00), !dbg !711
  %854 = call double @llvm.copysign.f64(double %853, double %848), !dbg !712
  br label %L1052, !dbg !426

L1044:                                            ; preds = %L984
  %855 = bitcast double %852 to i64, !dbg !713
  %.not997 = icmp eq i64 %855, 9218868437227405312, !dbg !713
  br i1 %.not997, label %L1059, label %L1052, !dbg !714

L1052:                                            ; preds = %L1044, %L1040
  %value_phi631 = phi double [ %854, %L1040 ], [ %848, %L1044 ]
  %856 = fcmp une double %value_phi631, 0.000000e+00, !dbg !715
  br i1 %856, label %L1059, label %L1057, !dbg !717

L1057:                                            ; preds = %L1052
  %857 = call double @llvm.fabs.f64(double %value_phi631), !dbg !718
  br label %guard_pass875, !dbg !426

L1059:                                            ; preds = %L1052, %L1044
  %value_phi6311020 = phi double [ %value_phi631, %L1052 ], [ 0x7FF8000000000000, %L1044 ]
  %858 = fcmp ogt double %value_phi6311020, 0.000000e+00, !dbg !720
  %859 = fadd double %value_phi6311020, 4.000000e+00
  %spec.select897 = select i1 %858, double %value_phi6311020, double %859, !dbg !723
  br label %guard_pass875, !dbg !723

L1087:                                            ; preds = %L928
  %jl_nothing637 = load ptr, ptr @jl_nothing, align 8, !dbg !724, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %831), !dbg !724
  %gc_slot_addr_151937 = getelementptr inbounds ptr, ptr %gcframe2, i64 17
  store ptr %box_Float32, ptr %gc_slot_addr_151937, align 8
  %ptls_load2093 = load ptr, ptr %ptls_field, align 8, !dbg !724, !tbaa !156
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load2093, i32 424, i32 16, i64 4869791888) #23, !dbg !724
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !724
  store atomic i64 4869791888, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !724, !tbaa !221
  %860 = load i64, ptr %511, align 8, !dbg !724, !tbaa !225, !alias.scope !612, !noalias !613
  store i64 %860, ptr %"box::Float64", align 8, !dbg !724, !tbaa !225, !alias.scope !612, !noalias !613
  store ptr %"box::Float64", ptr %gc_slot_addr_14, align 8
  store ptr @"jl_global#9861.jit", ptr %jlcallframe1, align 8, !dbg !724
  store ptr %49, ptr %119, align 8, !dbg !724
  store ptr %jl_nothing637, ptr %120, align 8, !dbg !724
  store ptr %box_Float32, ptr %121, align 8, !dbg !724
  %861 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !724
  store ptr %"box::Float64", ptr %861, align 8, !dbg !724
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !724
  call void @llvm.trap(), !dbg !724
  unreachable, !dbg !724

L1105:                                            ; preds = %guard_pass875, %guard_pass870
  %.sroa.71307.0 = phi float [ %1148, %guard_pass870 ], [ %1153, %guard_pass875 ], !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101313, i64 7, i1 false), !dbg !727
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.101313), !dbg !727
  %"new::Tuple371.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1372", i64 33, !dbg !728
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple371.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !727, !tbaa !281, !alias.scope !283, !noalias !284
  store i64 %.fr, ptr %514, align 8, !dbg !728, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple371.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1372", i64 16, !dbg !728
  store float %831, ptr %"new::Tuple371.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !728, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple371.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1372", i64 20, !dbg !728
  store float %.sroa.71307.0, ptr %"new::Tuple371.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !728, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple371.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1372", i64 24, !dbg !728
  store i64 1, ptr %"new::Tuple371.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !728, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::Tuple371.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1372", i64 32, !dbg !728
  store i8 0, ptr %"new::Tuple371.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !728, !tbaa !281, !alias.scope !283, !noalias !284
  %862 = add i64 %.fr, -1, !dbg !730
  %root_phi185.size.0.copyload = load i64, ptr %.size_ptr, align 8, !dbg !735, !tbaa !225, !alias.scope !298, !noalias !299
  %.not998 = icmp ult i64 %862, %root_phi185.size.0.copyload, !dbg !730
  br i1 %.not998, label %L1163, label %L1160, !dbg !730

L1160:                                            ; preds = %L1105
  store i64 %.fr, ptr %"new::Tuple608", align 8, !dbg !730, !tbaa !281, !alias.scope !283, !noalias !284
  call swiftcc void @j_throw_boundserror_9858(ptr nonnull swiftself %pgcstack, ptr nonnull %11, ptr nocapture nonnull readonly %"new::Tuple608") #10, !dbg !730
  unreachable, !dbg !730

L1163:                                            ; preds = %L1105
  %root_phi184.state = load atomic ptr, ptr %9 unordered, align 8, !dbg !736, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %memoryref_data374 = load ptr, ptr %11, align 8, !dbg !738, !tbaa !308, !alias.scope !311, !noalias !312
  %863 = getelementptr i8, ptr %memoryref_data374, i64 %memoryref_offset346, !dbg !738
  %memoryref_data382 = getelementptr i8, ptr %863, i64 -4, !dbg !738
  %864 = load float, ptr %memoryref_data382, align 4, !dbg !738, !tbaa !316, !alias.scope !189, !noalias !190
  %865 = fpext float %.sroa.71307.0 to double, !dbg !739
  store ptr %root_phi184.state, ptr %gc_slot_addr_14, align 8
  %866 = call swiftcc double @"j_#power_by_squaring#401_9851"(ptr nonnull swiftself %pgcstack, double %865, i64 signext 2), !dbg !743
  %root_phi184.state.size_ptr = getelementptr inbounds i8, ptr %root_phi184.state, i64 16, !dbg !735
  %root_phi184.state.size.0.copyload = load i64, ptr %root_phi184.state.size_ptr, align 8, !dbg !735, !tbaa !225, !alias.scope !298, !noalias !299
  %.not999 = icmp ult i64 %862, %root_phi184.state.size.0.copyload, !dbg !730
  br i1 %.not999, label %L1188, label %L1185, !dbg !730

L1185:                                            ; preds = %L1163
  store i64 %.fr, ptr %"new::Tuple606", align 8, !dbg !730, !tbaa !281, !alias.scope !283, !noalias !284
  store ptr %root_phi184.state, ptr %gc_slot_addr_14, align 8
  call swiftcc void @j_throw_boundserror_9858(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi184.state, ptr nocapture nonnull readonly %"new::Tuple606") #10, !dbg !730
  unreachable, !dbg !730

L1188:                                            ; preds = %L1163
  %867 = fptrunc double %866 to float, !dbg !744
  %memoryref_data384 = load ptr, ptr %root_phi184.state, align 8, !dbg !738, !tbaa !308, !alias.scope !311, !noalias !312
  %868 = getelementptr i8, ptr %memoryref_data384, i64 %memoryref_offset346, !dbg !738
  %memoryref_data392 = getelementptr i8, ptr %868, i64 -4, !dbg !738
  %869 = load float, ptr %memoryref_data392, align 4, !dbg !738, !tbaa !316, !alias.scope !189, !noalias !190
  %870 = fpext float %869 to double, !dbg !739
  store ptr null, ptr %gc_slot_addr_14, align 8
  %871 = call swiftcc double @"j_#power_by_squaring#401_9851"(ptr nonnull swiftself %pgcstack, double %870, i64 signext 2), !dbg !743
  %872 = fptrunc double %871 to float, !dbg !744
  %873 = fsub float %867, %872, !dbg !747
  %874 = fmul float %864, 0.000000e+00, !dbg !748
  %875 = fmul float %874, %873, !dbg !748
  %876 = fadd float %875, 0.000000e+00, !dbg !750
  store ptr %9, ptr %1, align 8, !dbg !733
  store ptr %17, ptr %0, align 8, !dbg !733
  store ptr %19, ptr %515, align 8, !dbg !733
  store ptr %21, ptr %516, align 8, !dbg !733
  store ptr %23, ptr %517, align 8, !dbg !733
  store ptr %25, ptr %518, align 8, !dbg !733
  %877 = call swiftcc float @"j_#calculate##0_9852"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1372", ptr nocapture nonnull readonly %1, float %876, ptr nocapture nonnull readonly %504, ptr nocapture nonnull readonly %0), !dbg !733
  %root_phi184.state393 = load atomic ptr, ptr %9 unordered, align 8, !dbg !751, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %.unbox394 = load float, ptr %505, align 4, !dbg !753, !tbaa !281, !alias.scope !283, !noalias !284
  %878 = fneg float %.unbox394, !dbg !753
  store i64 %.fr, ptr %"new::Tuple395", align 8, !dbg !755, !tbaa !281, !alias.scope !283, !noalias !284
  %bitcast396 = load i64, ptr %506, align 8, !dbg !756, !tbaa !281, !alias.scope !283, !noalias !284
  %.not1000 = icmp ult i64 %862, %bitcast396, !dbg !762
  br i1 %.not1000, label %L1246, label %L1243, !dbg !761

L1243:                                            ; preds = %L1188
  %879 = getelementptr inbounds ptr, ptr %gcframe2, i64 15
  store ptr %27, ptr %879, align 8, !dbg !761
  call swiftcc void @j_throw_boundserror_9859(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.0952.sroa.7.0..sroa_idx, ptr nocapture nonnull readonly %879, ptr nocapture nonnull readonly %"new::Tuple395") #10, !dbg !761
  unreachable, !dbg !761

L1246:                                            ; preds = %L1188
  %root_phi184.state393.size_ptr = getelementptr inbounds i8, ptr %root_phi184.state393, i64 16, !dbg !763
  %root_phi184.state393.size.0.copyload = load i64, ptr %root_phi184.state393.size_ptr, align 8, !dbg !763, !tbaa !225, !alias.scope !298, !noalias !299
  %.not1001 = icmp ult i64 %862, %root_phi184.state393.size.0.copyload, !dbg !764
  br i1 %.not1001, label %L1263, label %L1260, !dbg !764

L1260:                                            ; preds = %L1246
  store i64 %.fr, ptr %"new::Tuple603", align 8, !dbg !764, !tbaa !281, !alias.scope !283, !noalias !284
  store ptr %root_phi184.state393, ptr %gc_slot_addr_14, align 8
  call swiftcc void @j_throw_boundserror_9858(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi184.state393, ptr nocapture nonnull readonly %"new::Tuple603") #10, !dbg !764
  unreachable, !dbg !764

L1263:                                            ; preds = %L1246
  %root_phi193.x = load float, ptr %27, align 4, !dbg !765, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data398 = load ptr, ptr %root_phi184.state393, align 8, !dbg !768, !tbaa !308, !alias.scope !311, !noalias !312
  %880 = getelementptr i8, ptr %memoryref_data398, i64 %memoryref_offset346, !dbg !768
  %memoryref_data406 = getelementptr i8, ptr %880, i64 -4, !dbg !768
  %881 = load float, ptr %memoryref_data406, align 4, !dbg !768, !tbaa !316, !alias.scope !189, !noalias !190
  %882 = fsub float %.sroa.71307.0, %881, !dbg !769
  %883 = fmul float %root_phi193.x, %878, !dbg !770
  %884 = fmul float %883, %882, !dbg !770
  %885 = fadd float %877, %884, !dbg !750
  %886 = fcmp ugt float %885, 0.000000e+00, !dbg !772
  br i1 %886, label %L1278, label %L1395, !dbg !773

L1278:                                            ; preds = %L1263
  %root_phi204.idxF = load i64, ptr %root_phi204.idxF_ptr612, align 8, !dbg !774, !tbaa !203, !alias.scope !189, !noalias !190
  %.not1002 = icmp eq i64 %root_phi204.idxF, 1002, !dbg !787
  br i1 %.not1002, label %L1281, label %L1283, !dbg !776

L1281:                                            ; preds = %L1278
  %887 = call swiftcc i64 @j_gen_rand_9856(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !776
  %root_phi204.idxF579.pre = load i64, ptr %root_phi204.idxF_ptr612, align 8, !dbg !788, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L1283, !dbg !776

L1283:                                            ; preds = %L1281, %L1278
  %root_phi204.idxF579 = phi i64 [ %root_phi204.idxF, %L1278 ], [ %root_phi204.idxF579.pre, %L1281 ], !dbg !788
  %root_phi204.vals = load atomic ptr, ptr %root_phi204.vals_ptr614 unordered, align 8, !dbg !788, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %888 = add i64 %root_phi204.idxF579, 1, !dbg !793
  store i64 %888, ptr %root_phi204.idxF_ptr612, align 8, !dbg !794, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data582 = load ptr, ptr %root_phi204.vals, align 8, !dbg !795, !tbaa !308, !alias.scope !311, !noalias !312
  %memoryref_byteoffset585 = shl i64 %root_phi204.idxF579, 3, !dbg !795
  %memoryref_data590 = getelementptr inbounds i8, ptr %memoryref_data582, i64 %memoryref_byteoffset585, !dbg !795
  %889 = load i64, ptr %memoryref_data590, align 8, !dbg !795, !tbaa !316, !alias.scope !189, !noalias !190
  %890 = trunc i64 %889 to i32, !dbg !796
  %891 = and i32 %890, 8388607, !dbg !797
  %892 = or disjoint i32 %891, 1065353216, !dbg !798
  %bitcast_coercion591 = bitcast i32 %892 to float, !dbg !799
  %893 = fadd float %bitcast_coercion591, -1.000000e+00, !dbg !800
  %894 = fneg float %885, !dbg !802
  %.unbox592 = load float, ptr %.sroa.7955.0..sroa_idx, align 4, !dbg !803
  %895 = fdiv float %894, %.unbox592, !dbg !803
  %896 = fmul float %895, 0x3FF7154760000000, !dbg !804
  %897 = call float @llvm.rint.f32(float %896), !dbg !807
  %898 = fptosi float %897 to i32, !dbg !809
  %899 = freeze i32 %898, !dbg !809
  %900 = fmul contract float %897, 0x3FE62E4000000000, !dbg !811
  %901 = fsub contract float %895, %900, !dbg !811
  %902 = fmul contract float %897, 0x3EB7F7D1C0000000, !dbg !813
  %903 = fsub contract float %901, %902, !dbg !813
  %904 = fmul contract float %903, 0x3F2A1D7140000000, !dbg !815
  %905 = fadd contract float %904, 0x3F56DA7560000000, !dbg !815
  %906 = fmul contract float %903, %905, !dbg !815
  %907 = fadd contract float %906, 0x3F811105C0000000, !dbg !815
  %908 = fmul contract float %903, %907, !dbg !815
  %909 = fadd contract float %908, 0x3FA5554640000000, !dbg !815
  %910 = fmul contract float %903, %909, !dbg !815
  %911 = fadd contract float %910, 0x3FC5555560000000, !dbg !815
  %912 = fmul contract float %903, %911, !dbg !815
  %913 = fadd contract float %912, 5.000000e-01, !dbg !815
  %914 = fmul contract float %903, %913, !dbg !815
  %915 = fadd contract float %914, 1.000000e+00, !dbg !815
  %916 = fmul contract float %903, %915, !dbg !815
  %917 = fadd contract float %916, 1.000000e+00, !dbg !815
  %918 = fcmp ule float %895, 0x40562E4300000000, !dbg !820
  %919 = bitcast float %.unbox592 to i32, !dbg !822
  br i1 %918, label %L1342, label %L1393, !dbg !822

L1342:                                            ; preds = %L1283
  %920 = fcmp uge float %895, 0xC059FE3680000000, !dbg !823
  br i1 %920, label %L1386, label %L1393, !dbg !824

L1386:                                            ; preds = %L1342
  %921 = fcmp ugt float %895, 0xC055D58A00000000, !dbg !825
  %922 = fmul float %917, 0x3E70000000000000, !dbg !826
  %value_phi595 = select i1 %921, float %917, float %922, !dbg !826
  %.not1003 = icmp eq i32 %899, 128, !dbg !827
  %923 = fmul float %value_phi595, 2.000000e+00, !dbg !829
  %value_phi597 = select i1 %.not1003, float %923, float %value_phi595, !dbg !829
  %value_phi594.v = select i1 %921, i32 127, i32 151, !dbg !826
  %value_phi594 = add i32 %899, %value_phi594.v, !dbg !826
  %924 = sext i1 %.not1003 to i32, !dbg !829
  %value_phi596 = add i32 %value_phi594, %924, !dbg !829
  %925 = shl i32 %value_phi596, 23, !dbg !830
  %bitcast_coercion600 = bitcast i32 %925 to float, !dbg !834
  %926 = fmul float %value_phi597, %bitcast_coercion600, !dbg !835
  br label %L1393, !dbg !426

L1393:                                            ; preds = %L1386, %L1342, %L1283
  %value_phi593 = phi float [ %926, %L1386 ], [ 0x7FF0000000000000, %L1283 ], [ 0.000000e+00, %L1342 ]
  %927 = fcmp olt float %893, %value_phi593, !dbg !836
  br i1 %927, label %L1395, label %guard_pass885, !dbg !773

L1395:                                            ; preds = %L1393, %L1263
  %root_phi203.state408 = load atomic ptr, ptr %47 unordered, align 8, !dbg !837, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !290, !align !291
  %root_phi203.state408.size_ptr = getelementptr inbounds i8, ptr %root_phi203.state408, i64 16, !dbg !841
  %root_phi203.state408.size.0.copyload = load i64, ptr %root_phi203.state408.size_ptr, align 8, !dbg !841, !tbaa !225, !alias.scope !298, !noalias !299
  %.not1004 = icmp eq i64 %root_phi203.state408.size.0.copyload, 100000, !dbg !843
  br i1 %.not1004, label %guard_pass880, label %L1403, !dbg !842

L1403:                                            ; preds = %L1395
  call swiftcc void @j_throw_dmrsa_9848(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi203.state408.size.0.copyload) #10, !dbg !845
  unreachable, !dbg !845

L1491:                                            ; preds = %pass435
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext428.sroa.0.sroa.0", i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple427.sroa.0.sroa.5", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple427.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple427.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61260, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext430.sroa.6", i64 56, i1 false), !dbg !606
  br label %L1502, !dbg !606

L1492:                                            ; preds = %pass435
  %.not1007.not.not = icmp eq i64 %value_phi183, %value_phi180, !dbg !846
  br i1 %.not1007.not.not, label %L1497.L1502_crit_edge, label %L1501, !dbg !428

L1497.L1502_crit_edge:                            ; preds = %L1492
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext428.sroa.0.sroa.0", i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple427.sroa.0.sroa.5", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple427.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple427.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61260, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext430.sroa.6", i64 56, i1 false), !dbg !606
  br label %L1502, !dbg !606

L1501:                                            ; preds = %L1492
  %928 = add i64 %value_phi183, 1, !dbg !426
  call void @llvm.lifetime.start.p0(i64 96, ptr nonnull %.sroa.0952.sroa.0), !dbg !606
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %.sroa.0952.sroa.9), !dbg !606
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %.sroa.0952.sroa.10), !dbg !606
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %.sroa.0952.sroa.11), !dbg !606
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.0952.sroa.22), !dbg !606
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %.sroa.8957), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0952.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext428.sroa.0.sroa.0", i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.9, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple427.sroa.0.sroa.5", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0952.sroa.10, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple427.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0952.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple427.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0952.sroa.22, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61260, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8957, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext430.sroa.6", i64 56, i1 false), !dbg !606, !tbaa !281, !alias.scope !283, !noalias !284
  br label %L758, !dbg !606

L1502:                                            ; preds = %L1497.L1502_crit_edge, %L1491, %L754.L1502_crit_edge
  %.sroa.0.sroa.8.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.2.8.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.2.8.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.2.8.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.9.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.3.8.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.3.8.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.3.8.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.10.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.4.8.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.4.8.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.4.8.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.14.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.9.128.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.9.128.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.9.128.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.15.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.10.128.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.10.128.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.10.128.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.16.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.11.128.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.11.128.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.11.128.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.17.0 = phi i64 [ %"new::NamedTuple.sroa.0.sroa.12.128.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.0.sroa.12.128.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.0.sroa.12.128.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.18.sroa.8.0 = phi i64 [ %.fr1536, %L754.L1502_crit_edge ], [ %.fr, %L1491 ], [ %.fr, %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.18.sroa.10.0 = phi float [ %401, %L754.L1502_crit_edge ], [ %831, %L1491 ], [ %831, %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.18.sroa.12.0 = phi float [ %.sroa.71354.0, %L754.L1502_crit_edge ], [ %.sroa.71307.0, %L1491 ], [ %.sroa.71307.0, %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.0.sroa.18.sroa.16.0 = phi i8 [ %.sroa.91347.0, %L754.L1502_crit_edge ], [ %.sroa.9.0, %L1491 ], [ %.sroa.9.0, %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.8.0 = phi float [ %461, %L754.L1502_crit_edge ], [ %885, %L1491 ], [ %885, %L1497.L1502_crit_edge ], !dbg !606
  %.sroa.10.0 = phi i32 [ %"new::NamedTuple.sroa.6.316.copyload", %L754.L1502_crit_edge ], [ %"new::NamedTuple427.sroa.5.316.copyload", %L1491 ], [ %"new::NamedTuple427.sroa.5.316.copyload", %L1497.L1502_crit_edge ], !dbg !606
  %929 = call i64 @jlplt_ijl_hrtime_9837_got.jit(), !dbg !847
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 520, !dbg !853
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528, !dbg !853
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !853, !tbaa !203, !alias.scope !189, !noalias !190
  store i64 %929, ptr %"process::Process.endtime_ptr", align 8, !dbg !853, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !854
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !854, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !855
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !855, !tbaa !221, !range !231
  %930 = and i64 %"process::Process.task.tag", -16, !dbg !855
  %931 = inttoptr i64 %930 to ptr, !dbg !855
  %exactly_isa.not.not = icmp eq ptr %931, @"+Core.Nothing#9854.jit", !dbg !855
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 497, !dbg !855
  %932 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !855
  %933 = and i8 %932, 1, !dbg !858
  %934 = icmp eq i8 %933, 0, !dbg !858
  %.not1011 = select i1 %exactly_isa.not.not, i1 true, i1 %934, !dbg !858
  br i1 %.not1011, label %L1559, label %L1538, !dbg !858

L1538:                                            ; preds = %L1502
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !859
  %ptls_load2101 = load ptr, ptr %ptls_field, align 8, !dbg !859, !tbaa !156
  %"box::ProcessContext480" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load2101, i32 1120, i32 400, i64 13729564624) #23, !dbg !859
  %"box::ProcessContext480.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext480", i64 -1, !dbg !859
  store atomic i64 13729564624, ptr %"box::ProcessContext480.tag_addr" unordered, align 8, !dbg !859, !tbaa !221
  store atomic ptr %7, ptr %"box::ProcessContext480" unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %935 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 8, !dbg !859
  store atomic ptr %9, ptr %935 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %936 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 16, !dbg !859
  store atomic ptr %11, ptr %936 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %937 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 24, !dbg !859
  store atomic ptr %13, ptr %937 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %938 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 32, !dbg !859
  store atomic ptr %15, ptr %938 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %939 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 40, !dbg !859
  %.sroa.0910.sroa.0.40.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.0, i64 40, !dbg !859
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %939, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0910.sroa.0.40.sroa_idx, i64 16, i1 false), !dbg !859
  %940 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 56, !dbg !859
  store atomic ptr %17, ptr %940 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %941 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 64, !dbg !859
  store atomic ptr %19, ptr %941 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %942 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 72, !dbg !859
  store atomic ptr %21, ptr %942 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %943 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 80, !dbg !859
  store atomic ptr %23, ptr %943 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %944 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 88, !dbg !859
  store atomic ptr %25, ptr %944 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %945 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 96, !dbg !859
  store i64 %.sroa.0.sroa.8.0, ptr %945, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %946 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 104, !dbg !859
  store atomic ptr %27, ptr %946 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %947 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 112, !dbg !859
  store i64 %.sroa.0.sroa.10.0, ptr %947, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %948 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 120, !dbg !859
  store atomic ptr %29, ptr %948 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %949 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 128, !dbg !859
  store atomic ptr %31, ptr %949 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %950 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 136, !dbg !859
  %.sroa.0910.sroa.10.136.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.11, i64 16, !dbg !859
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %950, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0910.sroa.10.136.sroa_idx, i64 16, i1 false), !dbg !859
  %951 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 152, !dbg !859
  store atomic ptr %33, ptr %951 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %952 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 160, !dbg !859
  store atomic ptr %35, ptr %952 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %953 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 168, !dbg !859
  store atomic ptr %37, ptr %953 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %954 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 176, !dbg !859
  store atomic ptr %39, ptr %954 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %955 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 184, !dbg !859
  store atomic ptr %41, ptr %955 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %956 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 192, !dbg !859
  %.sroa.0910.sroa.12.192.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.12, i64 40, !dbg !859
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %956, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0910.sroa.12.192.sroa_idx, i64 24, i1 false), !dbg !859
  %957 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 216, !dbg !859
  store atomic ptr %43, ptr %957 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %958 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 224, !dbg !859
  %.sroa.0910.sroa.14.224.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.13, i64 8, !dbg !859
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %958, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0910.sroa.14.224.sroa_idx, i64 24, i1 false), !dbg !859
  %959 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 248, !dbg !859
  store atomic ptr %45, ptr %959 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %960 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 256, !dbg !859
  store i64 %.sroa.0.sroa.15.0, ptr %960, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %961 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 264, !dbg !859
  store atomic ptr %47, ptr %961 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %962 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 272, !dbg !859
  store i64 %.sroa.0.sroa.17.0, ptr %962, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %963 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 280, !dbg !859
  store atomic ptr %49, ptr %963 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %964 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 288, !dbg !859
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %964, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %.sroa.0910.sroa.22.sroa.6.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 296, !dbg !859
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0910.sroa.22.sroa.6.8..sroa_idx, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %.sroa.0910.sroa.22.sroa.7.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 300, !dbg !859
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0910.sroa.22.sroa.7.8..sroa_idx, align 4, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %.sroa.0910.sroa.22.sroa.8.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 304, !dbg !859
  store i64 1, ptr %.sroa.0910.sroa.22.sroa.8.8..sroa_idx, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %.sroa.0910.sroa.22.sroa.9.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 312, !dbg !859
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0910.sroa.22.sroa.9.8..sroa_idx, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %.sroa.0910.sroa.22.sroa.10.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 313, !dbg !859
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0910.sroa.22.sroa.10.8..sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !859
  %.sroa.15.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 320, !dbg !859
  store float %.sroa.8.0, ptr %.sroa.15.288..sroa_idx, align 8, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %.sroa.16.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 324, !dbg !859
  store i32 %.sroa.10.0, ptr %.sroa.16.288..sroa_idx, align 4, !dbg !859, !tbaa !225, !alias.scope !612, !noalias !613
  %965 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 328, !dbg !859
  store atomic ptr %51, ptr %965 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %966 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 336, !dbg !859
  store atomic ptr %53, ptr %966 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %967 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 344, !dbg !859
  store atomic ptr %55, ptr %967 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %968 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 352, !dbg !859
  store atomic ptr %57, ptr %968 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %969 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 360, !dbg !859
  store atomic ptr %59, ptr %969 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %970 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 368, !dbg !859
  store atomic ptr %61, ptr %970 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  %971 = getelementptr inbounds i8, ptr %"box::ProcessContext480", i64 376, !dbg !859
  store atomic ptr %63, ptr %971 unordered, align 8, !dbg !859, !tbaa !223, !alias.scope !189, !noalias !190
  store atomic ptr %"box::ProcessContext480", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !859, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !859
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !859, !tbaa !221, !range !231
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !859
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !859
  br i1 %parent_old_marked, label %may_trigger_wb, label %972, !dbg !859

may_trigger_wb:                                   ; preds = %L1538
  %"box::ProcessContext480.tag" = load atomic volatile i64, ptr %"box::ProcessContext480.tag_addr" unordered, align 8, !dbg !859, !tbaa !221, !range !231
  %child_bit = and i64 %"box::ProcessContext480.tag", 1, !dbg !859
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !859
  br i1 %child_not_marked, label %trigger_wb, label %972, !dbg !859, !prof !865

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !859
  br label %972, !dbg !859

972:                                              ; preds = %may_trigger_wb, %trigger_wb, %L1538
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0933.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0933.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0933.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0933.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0933.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8939, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, i64 56, i1 false), !dbg !606
  br label %L1569, !dbg !606

L1559:                                            ; preds = %L1502
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !606
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !866
  %973 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190
  %974 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !866
  %975 = load atomic ptr, ptr %974 unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190
  %976 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !866
  %977 = load atomic ptr, ptr %976 unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190
  %978 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !866
  %979 = load atomic ptr, ptr %978 unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190
  %980 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !866
  %981 = load atomic ptr, ptr %980 unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190
  %982 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !866
  %983 = load atomic ptr, ptr %982 unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190
  %984 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !872
  store atomic ptr %7, ptr %984 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %985 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !872
  store atomic ptr %9, ptr %985 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %986 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !872
  store atomic ptr %11, ptr %986 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %987 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !872
  store atomic ptr %13, ptr %987 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %988 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !872
  store atomic ptr %15, ptr %988 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %989 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !872
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", i64 40, !dbg !872
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %989, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %990 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !872
  store atomic ptr %17, ptr %990 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %991 = getelementptr inbounds i8, ptr %"process::Process", i64 120, !dbg !872
  store atomic ptr %19, ptr %991 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %992 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !872
  store atomic ptr %21, ptr %992 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %993 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !872
  store atomic ptr %23, ptr %993 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %994 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !872
  store atomic ptr %25, ptr %994 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %995 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !872
  store i64 %.sroa.0.sroa.8.0, ptr %995, align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %996 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !872
  store atomic ptr %27, ptr %996 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %997 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !872
  store i64 %.sroa.0.sroa.10.0, ptr %997, align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %998 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !872
  store atomic ptr %29, ptr %998 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %999 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !872
  store atomic ptr %31, ptr %999 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1000 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !872
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", i64 16, !dbg !872
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %1000, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx", i64 16, i1 false), !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %1001 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !872
  store atomic ptr %33, ptr %1001 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1002 = getelementptr inbounds i8, ptr %"process::Process", i64 216, !dbg !872
  store atomic ptr %35, ptr %1002 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1003 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !872
  store atomic ptr %37, ptr %1003 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1004 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !872
  store atomic ptr %39, ptr %1004 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1005 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !872
  store atomic ptr %41, ptr %1005 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1006 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !872
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", i64 40, !dbg !872
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %1006, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx", i64 24, i1 false), !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %1007 = getelementptr inbounds i8, ptr %"process::Process", i64 272, !dbg !872
  store atomic ptr %43, ptr %1007 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1008 = getelementptr inbounds i8, ptr %"process::Process", i64 280, !dbg !872
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", i64 8, !dbg !872
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %1008, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx", i64 24, i1 false), !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %1009 = getelementptr inbounds i8, ptr %"process::Process", i64 304, !dbg !872
  store atomic ptr %45, ptr %1009 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1010 = getelementptr inbounds i8, ptr %"process::Process", i64 312, !dbg !872
  store i64 %.sroa.0.sroa.15.0, ptr %1010, align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %1011 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !872
  store atomic ptr %47, ptr %1011 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1012 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !872
  store i64 %.sroa.0.sroa.17.0, ptr %1012, align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %1013 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !872
  store atomic ptr %49, ptr %1013 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1014 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !872
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %1014, align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !872
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx", align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 356, !dbg !872
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx", align 4, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !872
  store i64 1, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx", align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !872
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx", align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 369, !dbg !872
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !872
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !872
  store float %.sroa.8.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 380, !dbg !872
  store i32 %.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !872, !tbaa !225, !alias.scope !612, !noalias !613
  %1015 = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !872
  store atomic ptr %51, ptr %1015 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1016 = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !872
  store atomic ptr %53, ptr %1016 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1017 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !872
  store atomic ptr %55, ptr %1017 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1018 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !872
  store atomic ptr %57, ptr %1018 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1019 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !872
  store atomic ptr %59, ptr %1019 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1020 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !872
  store atomic ptr %61, ptr %1020 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %1021 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !872
  store atomic ptr %63, ptr %1021 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  store atomic ptr %983, ptr %982 unordered, align 8, !dbg !872, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.tag_addr2131" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !872
  %"process::Process.tag2132" = load atomic volatile i64, ptr %"process::Process.tag_addr2131" unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %parent_bits2133 = and i64 %"process::Process.tag2132", 3, !dbg !872
  %parent_old_marked2134 = icmp eq i64 %parent_bits2133, 3, !dbg !872
  br i1 %parent_old_marked2134, label %may_trigger_wb2135, label %1057, !dbg !872

may_trigger_wb2135:                               ; preds = %L1559
  %.tag_addr = getelementptr inbounds i64, ptr %973, i64 -1, !dbg !872
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %.tag_addr2138 = getelementptr inbounds i64, ptr %975, i64 -1, !dbg !872
  %.tag2139 = load atomic volatile i64, ptr %.tag_addr2138 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1022 = and i64 %.tag, %.tag2139, !dbg !872
  %.tag_addr2142 = getelementptr inbounds i64, ptr %977, i64 -1, !dbg !872
  %.tag2143 = load atomic volatile i64, ptr %.tag_addr2142 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1023 = and i64 %1022, %.tag2143, !dbg !872
  %.tag_addr2146 = getelementptr inbounds i64, ptr %979, i64 -1, !dbg !872
  %.tag2147 = load atomic volatile i64, ptr %.tag_addr2146 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1024 = and i64 %1023, %.tag2147, !dbg !872
  %.tag_addr2150 = getelementptr inbounds i64, ptr %981, i64 -1, !dbg !872
  %.tag2151 = load atomic volatile i64, ptr %.tag_addr2150 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1025 = and i64 %1024, %.tag2151, !dbg !872
  %.tag_addr2154 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !872
  %.tag2155 = load atomic volatile i64, ptr %.tag_addr2154 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1026 = and i64 %1025, %.tag2155, !dbg !872
  %.tag_addr2158 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !872
  %.tag2159 = load atomic volatile i64, ptr %.tag_addr2158 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1027 = and i64 %1026, %.tag2159, !dbg !872
  %.tag_addr2162 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !872
  %.tag2163 = load atomic volatile i64, ptr %.tag_addr2162 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1028 = and i64 %1027, %.tag2163, !dbg !872
  %.tag_addr2166 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !872
  %.tag2167 = load atomic volatile i64, ptr %.tag_addr2166 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1029 = and i64 %1028, %.tag2167, !dbg !872
  %.tag_addr2170 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !872
  %.tag2171 = load atomic volatile i64, ptr %.tag_addr2170 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1030 = and i64 %1029, %.tag2171, !dbg !872
  %.tag_addr2174 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !872
  %.tag2175 = load atomic volatile i64, ptr %.tag_addr2174 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1031 = and i64 %1030, %.tag2175, !dbg !872
  %.tag_addr2178 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !872
  %.tag2179 = load atomic volatile i64, ptr %.tag_addr2178 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1032 = and i64 %1031, %.tag2179, !dbg !872
  %.tag_addr2182 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !872
  %.tag2183 = load atomic volatile i64, ptr %.tag_addr2182 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1033 = and i64 %1032, %.tag2183, !dbg !872
  %.tag_addr2186 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !872
  %.tag2187 = load atomic volatile i64, ptr %.tag_addr2186 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1034 = and i64 %1033, %.tag2187, !dbg !872
  %.tag_addr2190 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !872
  %.tag2191 = load atomic volatile i64, ptr %.tag_addr2190 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1035 = and i64 %1034, %.tag2191, !dbg !872
  %.tag_addr2194 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !872
  %.tag2195 = load atomic volatile i64, ptr %.tag_addr2194 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1036 = and i64 %1035, %.tag2195, !dbg !872
  %.tag_addr2198 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !872
  %.tag2199 = load atomic volatile i64, ptr %.tag_addr2198 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1037 = and i64 %1036, %.tag2199, !dbg !872
  %.tag_addr2202 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !872
  %.tag2203 = load atomic volatile i64, ptr %.tag_addr2202 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1038 = and i64 %1037, %.tag2203, !dbg !872
  %.tag_addr2206 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !872
  %.tag2207 = load atomic volatile i64, ptr %.tag_addr2206 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1039 = and i64 %1038, %.tag2207, !dbg !872
  %.tag_addr2210 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !872
  %.tag2211 = load atomic volatile i64, ptr %.tag_addr2210 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1040 = and i64 %1039, %.tag2211, !dbg !872
  %.tag_addr2214 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !872
  %.tag2215 = load atomic volatile i64, ptr %.tag_addr2214 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1041 = and i64 %1040, %.tag2215, !dbg !872
  %.tag_addr2218 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !872
  %.tag2219 = load atomic volatile i64, ptr %.tag_addr2218 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1042 = and i64 %1041, %.tag2219, !dbg !872
  %.tag_addr2222 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !872
  %.tag2223 = load atomic volatile i64, ptr %.tag_addr2222 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1043 = and i64 %1042, %.tag2223, !dbg !872
  %.tag_addr2226 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !872
  %.tag2227 = load atomic volatile i64, ptr %.tag_addr2226 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1044 = and i64 %1043, %.tag2227, !dbg !872
  %.tag_addr2230 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !872
  %.tag2231 = load atomic volatile i64, ptr %.tag_addr2230 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1045 = and i64 %1044, %.tag2231, !dbg !872
  %.tag_addr2234 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !872
  %.tag2235 = load atomic volatile i64, ptr %.tag_addr2234 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1046 = and i64 %1045, %.tag2235, !dbg !872
  %.tag_addr2238 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !872
  %.tag2239 = load atomic volatile i64, ptr %.tag_addr2238 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1047 = and i64 %1046, %.tag2239, !dbg !872
  %.tag_addr2242 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !872
  %.tag2243 = load atomic volatile i64, ptr %.tag_addr2242 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1048 = and i64 %1047, %.tag2243, !dbg !872
  %.tag_addr2246 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !872
  %.tag2247 = load atomic volatile i64, ptr %.tag_addr2246 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1049 = and i64 %1048, %.tag2247, !dbg !872
  %.tag_addr2250 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !872
  %.tag2251 = load atomic volatile i64, ptr %.tag_addr2250 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1050 = and i64 %1049, %.tag2251, !dbg !872
  %.tag_addr2254 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !872
  %.tag2255 = load atomic volatile i64, ptr %.tag_addr2254 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1051 = and i64 %1050, %.tag2255, !dbg !872
  %.tag_addr2258 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !872
  %.tag2259 = load atomic volatile i64, ptr %.tag_addr2258 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1052 = and i64 %1051, %.tag2259, !dbg !872
  %.tag_addr2262 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !872
  %.tag2263 = load atomic volatile i64, ptr %.tag_addr2262 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1053 = and i64 %1052, %.tag2263, !dbg !872
  %.tag_addr2266 = getelementptr inbounds i64, ptr %63, i64 -1, !dbg !872
  %.tag2267 = load atomic volatile i64, ptr %.tag_addr2266 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1054 = and i64 %1053, %.tag2267, !dbg !872
  %.tag_addr2270 = getelementptr inbounds i64, ptr %983, i64 -1, !dbg !872
  %.tag2271 = load atomic volatile i64, ptr %.tag_addr2270 unordered, align 8, !dbg !872, !tbaa !221, !range !231
  %1055 = and i64 %1054, %.tag2271, !dbg !872
  %1056 = and i64 %1055, 1, !dbg !872
  %.not3.not = icmp eq i64 %1056, 0, !dbg !872
  br i1 %.not3.not, label %trigger_wb2274, label %1057, !dbg !872, !prof !865

trigger_wb2274:                                   ; preds = %may_trigger_wb2135
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !872
  br label %1057, !dbg !872

1057:                                             ; preds = %may_trigger_wb2135, %trigger_wb2274, %L1559
  %"process::Process.runtime_context_ptr572" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !874
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !874, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr572" release, align 8, !dbg !874, !tbaa !203, !alias.scope !189, !noalias !190
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0933.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0933.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0933.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0933.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0933.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8939, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, i64 56, i1 false), !dbg !606
  br label %L1569, !dbg !606

L1569:                                            ; preds = %1057, %972
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0933.sroa.0, i64 96, i1 false), !dbg !852
  %.sroa.0945.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !852
  store i64 %.sroa.0.sroa.8.0, ptr %.sroa.0945.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !852
  store i64 %.sroa.0.sroa.9.0, ptr %.sroa.0945.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !852
  store i64 %.sroa.0.sroa.10.0, ptr %.sroa.0945.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !852
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0945.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0933.sroa.12, i64 32, i1 false), !dbg !852
  %.sroa.0945.sroa.6.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !852
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0945.sroa.6.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0933.sroa.14, i64 64, i1 false), !dbg !852
  %.sroa.0945.sroa.7.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 216, !dbg !852
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0945.sroa.7.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0933.sroa.16, i64 32, i1 false), !dbg !852
  %.sroa.0945.sroa.8.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 248, !dbg !852
  store i64 %.sroa.0.sroa.14.0, ptr %.sroa.0945.sroa.8.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.9.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !852
  store i64 %.sroa.0.sroa.15.0, ptr %.sroa.0945.sroa.9.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.10.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 264, !dbg !852
  store i64 %.sroa.0.sroa.16.0, ptr %.sroa.0945.sroa.10.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.11.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !852
  store i64 %.sroa.0.sroa.17.0, ptr %.sroa.0945.sroa.11.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.12.sroa.2.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !852
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %.sroa.0945.sroa.12.sroa.2.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.12.sroa.3.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !852
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0945.sroa.12.sroa.3.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.12.sroa.4.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !852
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0945.sroa.12.sroa.4.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.12.sroa.5.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !852
  store i64 1, ptr %.sroa.0945.sroa.12.sroa.5.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.12.sroa.6.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !852
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0945.sroa.12.sroa.6.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.0945.sroa.12.sroa.7.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !852
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0945.sroa.12.sroa.7.0..sroa.0945.sroa.12.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0933.sroa.26.sroa.11, i64 7, i1 false), !dbg !852
  %.sroa.2946.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !852
  store float %.sroa.8.0, ptr %.sroa.2946.0.sret_return.sroa_idx, align 8, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.3947.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !852
  store i32 %.sroa.10.0, ptr %.sroa.3947.0.sret_return.sroa_idx, align 4, !dbg !852, !tbaa !281, !alias.scope !283, !noalias !284
  %.sroa.4948.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !852
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.4948.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8939, i64 56, i1 false), !dbg !852
  store ptr %7, ptr %return_roots, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1058 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !852
  store ptr %9, ptr %1058, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1059 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !852
  store ptr %11, ptr %1059, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1060 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !852
  store ptr %13, ptr %1060, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1061 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !852
  store ptr %15, ptr %1061, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1062 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !852
  store ptr %17, ptr %1062, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1063 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !852
  store ptr %19, ptr %1063, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1064 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !852
  store ptr %21, ptr %1064, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1065 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !852
  store ptr %23, ptr %1065, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1066 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !852
  store ptr %25, ptr %1066, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1067 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !852
  store ptr %27, ptr %1067, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1068 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !852
  store ptr %29, ptr %1068, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1069 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !852
  store ptr %31, ptr %1069, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1070 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !852
  store ptr %33, ptr %1070, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1071 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !852
  store ptr %35, ptr %1071, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1072 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !852
  store ptr %37, ptr %1072, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1073 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !852
  store ptr %39, ptr %1073, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1074 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !852
  store ptr %41, ptr %1074, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1075 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !852
  store ptr %43, ptr %1075, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1076 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !852
  store ptr %45, ptr %1076, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1077 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !852
  store ptr %47, ptr %1077, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1078 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !852
  store ptr %49, ptr %1078, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1079 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !852
  store ptr %51, ptr %1079, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1080 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !852
  store ptr %53, ptr %1080, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1081 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !852
  store ptr %55, ptr %1081, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1082 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !852
  store ptr %57, ptr %1082, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1083 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !852
  store ptr %59, ptr %1083, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1084 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !852
  store ptr %61, ptr %1084, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %1085 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !852
  store ptr %63, ptr %1085, align 8, !dbg !852, !tbaa !156, !alias.scope !161, !noalias !164
  %frame.prev2275 = load ptr, ptr %frame.prev, align 8, !tbaa !156
  store ptr %frame.prev2275, ptr %pgcstack, align 8, !tbaa !156
  ret void, !dbg !852

guard_pass:                                       ; preds = %top
  %1086 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %122, !dbg !228
  %1087 = load ptr, ptr %1086, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit, !dbg !228

guard_exit:                                       ; preds = %guard_pass, %top
  %typeof = phi ptr [ %123, %top ], [ %1087, %guard_pass ], !dbg !228
  store ptr %jl_f__svec_ref_ret, ptr %gc_slot_addr_14, align 8
  %1088 = call i32 @ijl_subtype(ptr nonnull %typeof, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not = icmp eq i32 %1088, 0, !dbg !228
  br i1 %.not, label %L23, label %L20, !dbg !228

guard_pass14:                                     ; preds = %L20
  %1089 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %166, !dbg !228
  %1090 = load ptr, ptr %1089, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit15, !dbg !228

guard_exit15:                                     ; preds = %guard_pass14, %L20
  %typeof16 = phi ptr [ %167, %L20 ], [ %1090, %guard_pass14 ], !dbg !228
  store ptr %jl_f__svec_ref_ret13, ptr %gc_slot_addr_14, align 8
  %1091 = call i32 @ijl_subtype(ptr nonnull %typeof16, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not959 = icmp eq i32 %1091, 0, !dbg !228
  br i1 %.not959, label %L43, label %L40, !dbg !228

guard_pass30:                                     ; preds = %L40
  %1092 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %210, !dbg !228
  %1093 = load ptr, ptr %1092, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit31, !dbg !228

guard_exit31:                                     ; preds = %guard_pass30, %L40
  %typeof32 = phi ptr [ %211, %L40 ], [ %1093, %guard_pass30 ], !dbg !228
  store ptr %jl_f__svec_ref_ret29, ptr %gc_slot_addr_14, align 8
  %1094 = call i32 @ijl_subtype(ptr nonnull %typeof32, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not960 = icmp eq i32 %1094, 0, !dbg !228
  br i1 %.not960, label %L63, label %L60, !dbg !228

guard_pass46:                                     ; preds = %L60
  %1095 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %254, !dbg !228
  %1096 = load ptr, ptr %1095, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit47, !dbg !228

guard_exit47:                                     ; preds = %guard_pass46, %L60
  %typeof48 = phi ptr [ %255, %L60 ], [ %1096, %guard_pass46 ], !dbg !228
  store ptr %jl_f__svec_ref_ret45, ptr %gc_slot_addr_14, align 8
  %1097 = call i32 @ijl_subtype(ptr nonnull %typeof48, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not961 = icmp eq i32 %1097, 0, !dbg !228
  br i1 %.not961, label %L83, label %L80, !dbg !228

guard_pass62:                                     ; preds = %L80
  %1098 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %298, !dbg !228
  %1099 = load ptr, ptr %1098, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit63, !dbg !228

guard_exit63:                                     ; preds = %guard_pass62, %L80
  %typeof64 = phi ptr [ %299, %L80 ], [ %1099, %guard_pass62 ], !dbg !228
  store ptr %jl_f__svec_ref_ret61, ptr %gc_slot_addr_14, align 8
  %1100 = call i32 @ijl_subtype(ptr nonnull %typeof64, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not962 = icmp eq i32 %1100, 0, !dbg !228
  br i1 %.not962, label %L102, label %L99, !dbg !228

guard_pass78:                                     ; preds = %L99
  %1101 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %342, !dbg !228
  %1102 = load ptr, ptr %1101, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit79, !dbg !228

guard_exit79:                                     ; preds = %guard_pass78, %L99
  %typeof80 = phi ptr [ %343, %L99 ], [ %1102, %guard_pass78 ], !dbg !228
  store ptr %jl_f__svec_ref_ret77, ptr %gc_slot_addr_14, align 8
  %1103 = call i32 @ijl_subtype(ptr nonnull %typeof80, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not963 = icmp eq i32 %1103, 0, !dbg !228
  br i1 %.not963, label %L119, label %L116, !dbg !228

guard_pass94:                                     ; preds = %L116
  %1104 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %386, !dbg !228
  %1105 = load ptr, ptr %1104, align 8, !dbg !228, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit95, !dbg !228

guard_exit95:                                     ; preds = %guard_pass94, %L116
  %typeof96 = phi ptr [ %387, %L116 ], [ %1105, %guard_pass94 ], !dbg !228
  store ptr %jl_f__svec_ref_ret93, ptr %gc_slot_addr_14, align 8
  %1106 = call i32 @ijl_subtype(ptr nonnull %typeof96, ptr nonnull @"jl_global#9842.jit"), !dbg !228
  %.not964 = icmp eq i32 %1106, 0, !dbg !228
  br i1 %.not964, label %L137, label %L134, !dbg !228

pass175:                                          ; preds = %guard_pass833, %guard_pass828
  %"new::NamedTuple.sroa.6.316.copyload" = phi i32 [ %"new::NamedTuple.sroa.6.316.copyload.pre", %guard_pass828 ], [ %495, %guard_pass833 ], !dbg !876
  %.sroa.91347.0 = phi i8 [ 1, %guard_pass828 ], [ 0, %guard_pass833 ], !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61338, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101349, i64 7, i1 false), !dbg !884
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.101349), !dbg !884
  %1107 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 16, !dbg !876
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !876
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %1107, i64 80, i1 false), !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.2.8.copyload" = load i64, ptr %81, align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !876
  %"new::NamedTuple.sroa.0.sroa.3.8.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.3.8..sroa_idx", align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.4.8.copyload" = load i64, ptr %85, align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !876
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx", i64 16, i1 false), !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 16, !dbg !876
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %90, i64 112, i1 false), !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.9.128..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !876
  %"new::NamedTuple.sroa.0.sroa.9.128.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.9.128..sroa_idx", align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.10.128.copyload" = load i64, ptr %103, align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.11.128..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !876
  %"new::NamedTuple.sroa.0.sroa.11.128.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.11.128..sroa_idx", align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::NamedTuple.sroa.0.sroa.12.128.copyload" = load i64, ptr %107, align 8, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !876
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !876
  %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 32, !dbg !876
  %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 96, !dbg !876
  store i64 1, ptr %6, align 8, !dbg !885, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.loopidx_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 472, !dbg !893
  %1108 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !893, !tbaa !203, !alias.scope !189, !noalias !190
  %1109 = add <2 x i64> %1108, <i64 1, i64 1>, !dbg !898
  store <2 x i64> %1109, ptr %"process::Process.loopidx_ptr", align 8, !dbg !899, !tbaa !203, !alias.scope !189, !noalias !190
  %1110 = extractelement <2 x i64> %1109, i64 0, !dbg !900
  %1111 = icmp ugt i64 %1110, 100000, !dbg !903
  %1112 = extractelement <2 x i64> %1108, i64 0, !dbg !907
  %value_phi180 = select i1 %1111, i64 %1112, i64 100000, !dbg !907
  %.not982.not = icmp ult i64 %value_phi180, %1110, !dbg !900
  br i1 %.not982.not, label %L754.L1502_crit_edge, label %L754.L758_crit_edge, !dbg !607

guard_pass222:                                    ; preds = %L758
  %1113 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %557, !dbg !614
  %1114 = load ptr, ptr %1113, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit223, !dbg !614

guard_exit223:                                    ; preds = %guard_pass222, %L758
  %typeof224 = phi ptr [ %558, %L758 ], [ %1114, %guard_pass222 ], !dbg !614
  store ptr %jl_f__svec_ref_ret221, ptr %gc_slot_addr_14, align 8
  %1115 = call i32 @ijl_subtype(ptr nonnull %typeof224, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not983.not = icmp eq i32 %1115, 0, !dbg !614
  br i1 %.not983.not, label %L774, label %L771, !dbg !614

guard_pass238:                                    ; preds = %L771
  %1116 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %601, !dbg !614
  %1117 = load ptr, ptr %1116, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit239, !dbg !614

guard_exit239:                                    ; preds = %guard_pass238, %L771
  %typeof240 = phi ptr [ %602, %L771 ], [ %1117, %guard_pass238 ], !dbg !614
  store ptr %jl_f__svec_ref_ret237, ptr %gc_slot_addr_14, align 8
  %1118 = call i32 @ijl_subtype(ptr nonnull %typeof240, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not984.not = icmp eq i32 %1118, 0, !dbg !614
  br i1 %.not984.not, label %L794, label %L791, !dbg !614

guard_pass254:                                    ; preds = %L791
  %1119 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %645, !dbg !614
  %1120 = load ptr, ptr %1119, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit255, !dbg !614

guard_exit255:                                    ; preds = %guard_pass254, %L791
  %typeof256 = phi ptr [ %646, %L791 ], [ %1120, %guard_pass254 ], !dbg !614
  store ptr %jl_f__svec_ref_ret253, ptr %gc_slot_addr_14, align 8
  %1121 = call i32 @ijl_subtype(ptr nonnull %typeof256, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not985.not = icmp eq i32 %1121, 0, !dbg !614
  br i1 %.not985.not, label %L814, label %L811, !dbg !614

guard_pass270:                                    ; preds = %L811
  %1122 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %689, !dbg !614
  %1123 = load ptr, ptr %1122, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit271, !dbg !614

guard_exit271:                                    ; preds = %guard_pass270, %L811
  %typeof272 = phi ptr [ %690, %L811 ], [ %1123, %guard_pass270 ], !dbg !614
  store ptr %jl_f__svec_ref_ret269, ptr %gc_slot_addr_14, align 8
  %1124 = call i32 @ijl_subtype(ptr nonnull %typeof272, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not986.not = icmp eq i32 %1124, 0, !dbg !614
  br i1 %.not986.not, label %L834, label %L831, !dbg !614

guard_pass286:                                    ; preds = %L831
  %1125 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %733, !dbg !614
  %1126 = load ptr, ptr %1125, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit287, !dbg !614

guard_exit287:                                    ; preds = %guard_pass286, %L831
  %typeof288 = phi ptr [ %734, %L831 ], [ %1126, %guard_pass286 ], !dbg !614
  store ptr %jl_f__svec_ref_ret285, ptr %gc_slot_addr_14, align 8
  %1127 = call i32 @ijl_subtype(ptr nonnull %typeof288, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not987.not = icmp eq i32 %1127, 0, !dbg !614
  br i1 %.not987.not, label %L853, label %L850, !dbg !614

guard_pass302:                                    ; preds = %L850
  %1128 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %777, !dbg !614
  %1129 = load ptr, ptr %1128, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit303, !dbg !614

guard_exit303:                                    ; preds = %guard_pass302, %L850
  %typeof304 = phi ptr [ %778, %L850 ], [ %1129, %guard_pass302 ], !dbg !614
  store ptr %jl_f__svec_ref_ret301, ptr %gc_slot_addr_14, align 8
  %1130 = call i32 @ijl_subtype(ptr nonnull %typeof304, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not988.not = icmp eq i32 %1130, 0, !dbg !614
  br i1 %.not988.not, label %L870, label %L867, !dbg !614

guard_pass318:                                    ; preds = %L867
  %1131 = getelementptr inbounds i8, ptr @jl_small_typeof, i64 %821, !dbg !614
  %1132 = load ptr, ptr %1131, align 8, !dbg !614, !tbaa !169, !invariant.load !0, !alias.scope !271, !noalias !272, !nonnull !0
  br label %guard_exit319, !dbg !614

guard_exit319:                                    ; preds = %guard_pass318, %L867
  %typeof320 = phi ptr [ %822, %L867 ], [ %1132, %guard_pass318 ], !dbg !614
  store ptr %jl_f__svec_ref_ret317, ptr %gc_slot_addr_14, align 8
  %1133 = call i32 @ijl_subtype(ptr nonnull %typeof320, ptr nonnull @"jl_global#9842.jit"), !dbg !614
  %.not989.not = icmp eq i32 %1133, 0, !dbg !614
  br i1 %.not989.not, label %L888, label %L885, !dbg !614

pass435:                                          ; preds = %guard_pass885, %guard_pass880
  %"new::NamedTuple427.sroa.5.316.copyload" = phi i32 [ %"new::NamedTuple427.sroa.5.316.copyload.pre", %guard_pass880 ], [ %919, %guard_pass885 ], !dbg !914
  %.sroa.9.0 = phi i8 [ 1, %guard_pass880 ], [ 0, %guard_pass885 ], !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.61260, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !919
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10), !dbg !919
  %"new::NamedTuple427.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple427.sroa.0.sroa.0", i64 8, !dbg !914
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple427.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %519, i64 80, i1 false), !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.2.8.copyload" = load i64, ptr %505, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.3.8.copyload" = load i64, ptr %.sroa.0952.sroa.7.0..sroa_idx, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.4.8.copyload" = load i64, ptr %506, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple427.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0952.sroa.9.0..sroa_idx, i64 16, i1 false), !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple427.sroa.0.sroa.5", i64 16, !dbg !914
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple427.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %507, i64 112, i1 false), !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.9.128.copyload" = load i64, ptr %.sroa.0952.sroa.12.0..sroa_idx, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.10.128.copyload" = load i64, ptr %510, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.11.128.copyload" = load i64, ptr %.sroa.0952.sroa.14.0..sroa_idx, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::NamedTuple427.sroa.0.sroa.12.128.copyload" = load i64, ptr %511, align 8, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  %"new::SubContext428.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext428.sroa.0.sroa.0", i64 8, !dbg !914
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext428.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple427.sroa.0.sroa.0", i64 88, i1 false), !dbg !914
  %"new::NamedTuple427.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple427.sroa.0.sroa.5", i64 32, !dbg !914
  %"new::NamedTuple427.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple427.sroa.0.sroa.5", i64 96, !dbg !914
  store i64 1, ptr %6, align 8, !dbg !920, !tbaa !203, !alias.scope !189, !noalias !190
  %1134 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !925, !tbaa !203, !alias.scope !189, !noalias !190
  %1135 = add <2 x i64> %1134, <i64 1, i64 1>, !dbg !928
  store <2 x i64> %1135, ptr %"process::Process.loopidx_ptr", align 8, !dbg !929, !tbaa !203, !alias.scope !189, !noalias !190
  %1136 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !930, !tbaa !203, !alias.scope !189, !noalias !190
  %1137 = and i8 %1136, 1, !dbg !930
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %1137, 0, !dbg !930
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L1491, label %L1492, !dbg !936

guard_pass818:                                    ; preds = %L223
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !160
  store float %401, ptr %unionalloca.sroa.0, align 8, !tbaa !281, !alias.scope !283, !noalias !284
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload10161537 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !330
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !330
  %1138 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload10161537 to i32, !dbg !937
  %1139 = bitcast i32 %1138 to float, !dbg !937
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101360), !dbg !160
  br label %L354

guard_pass823:                                    ; preds = %L308, %L306
  %value_phi732 = phi double [ %427, %L306 ], [ %spec.select895, %L308 ]
  %1140 = fcmp ugt double %value_phi732, 2.000000e+00, !dbg !939
  %1141 = fadd double %value_phi732, -1.000000e+00, !dbg !942
  %1142 = fadd double %value_phi732, -2.000000e+00, !dbg !942
  %1143 = fsub double 1.000000e+00, %1142, !dbg !942
  %value_phi734 = select i1 %1140, double %1143, double %1141, !dbg !942
  %1144 = fptrunc double %value_phi734 to float, !dbg !943
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101360), !dbg !160
  br label %L354

guard_pass828:                                    ; preds = %L644
  %1145 = load ptr, ptr %.state153, align 8, !dbg !945, !tbaa !308, !alias.scope !311, !noalias !312
  %1146 = getelementptr i8, ptr %1145, i64 %memoryref_offset, !dbg !947
  %memoryref_data170 = getelementptr i8, ptr %1146, i64 -4, !dbg !947
  store float %.sroa.71354.0, ptr %memoryref_data170, align 4, !dbg !947, !tbaa !316, !alias.scope !189, !noalias !190
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101349), !dbg !160
  %"new::NamedTuple.sroa.6.316.copyload.pre" = load i32, ptr %392, align 4, !dbg !876, !tbaa !225, !alias.scope !273, !noalias !274
  br label %pass175

guard_pass833:                                    ; preds = %L642
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101349), !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101349, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111366, i64 7, i1 false), !dbg !160
  br label %pass175

guard_pass870:                                    ; preds = %L974
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca363.sroa.0), !dbg !606
  store float %831, ptr %unionalloca363.sroa.0, align 8, !dbg !606, !tbaa !281, !alias.scope !283, !noalias !284
  %unionalloca363.sroa.0.0.unionalloca363.sroa.0.0.unionalloca363.sroa.0.0.unionalloca363.sroa.0.0.copyload10211538 = load i64, ptr %unionalloca363.sroa.0, align 8, !dbg !651
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca363.sroa.0), !dbg !651
  %1147 = trunc i64 %unionalloca363.sroa.0.0.unionalloca363.sroa.0.0.unionalloca363.sroa.0.0.unionalloca363.sroa.0.0.copyload10211538 to i32, !dbg !953
  %1148 = bitcast i32 %1147 to float, !dbg !953
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101313), !dbg !606
  br label %L1105, !dbg !606

guard_pass875:                                    ; preds = %L1059, %L1057
  %value_phi632 = phi double [ %857, %L1057 ], [ %spec.select897, %L1059 ]
  %1149 = fcmp ugt double %value_phi632, 2.000000e+00, !dbg !954
  %1150 = fadd double %value_phi632, -1.000000e+00, !dbg !956
  %1151 = fadd double %value_phi632, -2.000000e+00, !dbg !956
  %1152 = fsub double 1.000000e+00, %1151, !dbg !956
  %value_phi634 = select i1 %1149, double %1152, double %1150, !dbg !956
  %1153 = fptrunc double %value_phi634 to float, !dbg !957
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101313), !dbg !606
  br label %L1105, !dbg !606

guard_pass880:                                    ; preds = %L1395
  %1154 = load ptr, ptr %root_phi203.state408, align 8, !dbg !959, !tbaa !308, !alias.scope !311, !noalias !312
  %1155 = getelementptr i8, ptr %1154, i64 %memoryref_offset346, !dbg !961
  %memoryref_data425 = getelementptr i8, ptr %1155, i64 -4, !dbg !961
  store float %.sroa.71307.0, ptr %memoryref_data425, align 4, !dbg !961, !tbaa !316, !alias.scope !189, !noalias !190
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !606
  %"new::NamedTuple427.sroa.5.316.copyload.pre" = load i32, ptr %.sroa.7955.0..sroa_idx, align 4, !dbg !914, !tbaa !281, !alias.scope !283, !noalias !284
  br label %pass435, !dbg !606

guard_pass885:                                    ; preds = %L1393
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !606
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !606, !tbaa !281, !alias.scope !283, !noalias !284
  br label %pass435, !dbg !606
}
