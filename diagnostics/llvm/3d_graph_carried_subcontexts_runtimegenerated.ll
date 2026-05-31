; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0x185985d0f1a84352a339012ccea7ac23))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.RuntimeGenerated)
define swiftcc void @julia_loop_10321(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [1 x ptr]], ptr }, [1 x ptr], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(384) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(232) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(560) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(432) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(384) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [11 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 88, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 7
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %2 = alloca [41 x i64], align 8
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.10719 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple101" = alloca [1 x i64], align 8
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::NamedTuple135.sroa.0.sroa.24.sroa.9" = alloca [7 x i8], align 1
  %.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0.sroa.12 = alloca [8 x i64], align 8
  %.sroa.0.sroa.13 = alloca [4 x i64], align 8
  %.sroa.0.sroa.18.sroa.18 = alloca [7 x i8], align 1
  %"new::ProcessContext.sroa.21" = alloca [7 x i64], align 8
  %.sroa.0484.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0484.sroa.9 = alloca [4 x i64], align 8
  %.sroa.0484.sroa.10 = alloca [8 x i64], align 8
  %.sroa.0484.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0484.sroa.16.sroa.16 = alloca [7 x i8], align 1
  %.sroa.8489 = alloca [7 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4" = alloca [4 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5" = alloca [8 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6" = alloca [4 x i64], align 8
  %"new::Tuple348" = alloca [1 x i64], align 8
  %"new::Tuple351" = alloca [1 x i64], align 8
  %"new::Tuple353" = alloca [1 x i64], align 8
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
  store i8 1, ptr @"jl_global#10324.jit", align 16, !dbg !171, !tbaa !181, !alias.scope !184, !noalias !185
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !186
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !186, !tbaa !156, !alias.scope !161, !noalias !164
  %64 = sext i16 %thread_id to i64, !dbg !190
  %65 = add nsw i64 %64, 1, !dbg !195
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !197
  store i64 %65, ptr %"process::Process.threadid_ptr", align 8, !dbg !197, !tbaa !198, !alias.scope !184, !noalias !185
  %66 = call i64 @jlplt_ijl_hrtime_10326_got.jit(), !dbg !200
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
  br i1 %.not.not, label %L34.L664_crit_edge, label %L34.L38_crit_edge, !dbg !226

L34.L664_crit_edge:                               ; preds = %top
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
  %.sroa.8.0.copyload457 = load float, ptr %".sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !233
  %.sroa.10.0.copyload458 = load i32, ptr %".sroa.10.0.context::ProcessContext.sroa_idx", align 4, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  br label %L664, !dbg !233

L34.L38_crit_edge:                                ; preds = %top
  %".sroa.0496.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !233
  %".sroa.0496.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !233
  %.sroa.0496.sroa.10.0.copyload732 = load i64, ptr %".sroa.0496.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0496.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !233
  %".sroa.0496.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !233
  %".sroa.0496.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !233
  %".sroa.0496.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !233
  %".sroa.0496.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !233
  %".sroa.0496.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !233
  %".sroa.0496.sroa.20.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !233
  %".sroa.0496.sroa.22.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !233
  %.sroa.0496.sroa.22.0.copyload762 = load i64, ptr %".sroa.0496.sroa.22.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0496.sroa.23.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !233
  %.sroa.0496.sroa.23.0.copyload765 = load i8, ptr %".sroa.0496.sroa.23.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.0496.sroa.24.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !233
  %".sroa.6497.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !233
  %.sroa.6497.0.copyload498 = load float, ptr %".sroa.6497.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  %".sroa.7499.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !233
  %.sroa.7499.0.copyload500 = load i32, ptr %".sroa.7499.0.context::ProcessContext.sroa_idx", align 4, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !226
  %.sroa.0496.sroa.8.0..sroa_idx727 = getelementptr inbounds i8, ptr %2, i64 96, !dbg !226
  %.sroa.0496.sroa.9.0..sroa_idx730 = getelementptr inbounds i8, ptr %2, i64 104, !dbg !226
  %69 = load <2 x i64>, ptr %".sroa.0496.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %69, ptr %.sroa.0496.sroa.8.0..sroa_idx727, align 8, !dbg !226
  %.sroa.0496.sroa.10.0..sroa_idx733 = getelementptr inbounds i8, ptr %2, i64 112, !dbg !226
  store i64 %.sroa.0496.sroa.10.0.copyload732, ptr %.sroa.0496.sroa.10.0..sroa_idx733, align 8, !dbg !226
  %.sroa.0496.sroa.11.0..sroa_idx735 = getelementptr inbounds i8, ptr %2, i64 120, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0496.sroa.11.0..sroa_idx735, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0496.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !226
  %.sroa.0496.sroa.12.0..sroa_idx736 = getelementptr inbounds i8, ptr %2, i64 152, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0496.sroa.12.0..sroa_idx736, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0496.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !226
  %.sroa.0496.sroa.13.0..sroa_idx737 = getelementptr inbounds i8, ptr %2, i64 216, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0496.sroa.13.0..sroa_idx737, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0496.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !226
  %.sroa.0496.sroa.14.0..sroa_idx739 = getelementptr inbounds i8, ptr %2, i64 248, !dbg !226
  %.sroa.0496.sroa.15.0..sroa_idx742 = getelementptr inbounds i8, ptr %2, i64 256, !dbg !226
  %70 = load <2 x i64>, ptr %".sroa.0496.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %70, ptr %.sroa.0496.sroa.14.0..sroa_idx739, align 8, !dbg !226
  %.sroa.0496.sroa.16.0..sroa_idx745 = getelementptr inbounds i8, ptr %2, i64 264, !dbg !226
  %.sroa.0496.sroa.17.0..sroa_idx748 = getelementptr inbounds i8, ptr %2, i64 272, !dbg !226
  %71 = load <2 x i64>, ptr %".sroa.0496.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %71, ptr %.sroa.0496.sroa.16.0..sroa_idx745, align 8, !dbg !226
  %.sroa.0496.sroa.18.0..sroa_idx751 = getelementptr inbounds i8, ptr %2, i64 280, !dbg !226
  %.sroa.0496.sroa.19.0..sroa_idx754 = getelementptr inbounds i8, ptr %2, i64 288, !dbg !226
  %72 = load <2 x i64>, ptr %".sroa.0496.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x i64> %72, ptr %.sroa.0496.sroa.18.0..sroa_idx751, align 8, !dbg !226
  %.sroa.0496.sroa.20.0..sroa_idx757 = getelementptr inbounds i8, ptr %2, i64 296, !dbg !226
  %.sroa.0496.sroa.21.0..sroa_idx760 = getelementptr inbounds i8, ptr %2, i64 300, !dbg !226
  %73 = load <2 x float>, ptr %".sroa.0496.sroa.20.0.context::ProcessContext.sroa_idx", align 8, !dbg !233, !tbaa !235, !alias.scope !236, !noalias !237
  store <2 x float> %73, ptr %.sroa.0496.sroa.20.0..sroa_idx757, align 8, !dbg !226
  %.sroa.0496.sroa.22.0..sroa_idx763 = getelementptr inbounds i8, ptr %2, i64 304, !dbg !226
  store i64 %.sroa.0496.sroa.22.0.copyload762, ptr %.sroa.0496.sroa.22.0..sroa_idx763, align 8, !dbg !226
  %.sroa.0496.sroa.23.0..sroa_idx766 = getelementptr inbounds i8, ptr %2, i64 312, !dbg !226
  store i8 %.sroa.0496.sroa.23.0.copyload765, ptr %.sroa.0496.sroa.23.0..sroa_idx766, align 8, !dbg !226
  %.sroa.0496.sroa.24.0..sroa_idx768 = getelementptr inbounds i8, ptr %2, i64 313, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0496.sroa.24.0..sroa_idx768, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0496.sroa.24.0.context::ProcessContext.sroa_idx", i64 7, i1 false), !dbg !226
  %.sroa.6497.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 320, !dbg !226
  store float %.sroa.6497.0.copyload498, ptr %.sroa.6497.0..sroa_idx, align 8, !dbg !226
  %.sroa.7499.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 324, !dbg !226
  store i32 %.sroa.7499.0.copyload500, ptr %.sroa.7499.0..sroa_idx, align 4, !dbg !226
  %74 = getelementptr inbounds i8, ptr %2, i64 136, !dbg !238
  %.stop_ptr = getelementptr inbounds i8, ptr %2, i64 144, !dbg !262
  %.stop_ptr.unbox586 = load i64, ptr %.stop_ptr, align 8, !dbg !286, !tbaa !288, !alias.scope !290, !noalias !291
  %.unbox587 = load i64, ptr %74, align 8, !dbg !286, !tbaa !288, !alias.scope !290, !noalias !291
  %.not588 = icmp slt i64 %.stop_ptr.unbox586, %.unbox587, !dbg !286
  %75 = extractelement <2 x i64> %71, i64 1, !dbg !266
  %76 = bitcast i64 %75 to double, !dbg !266
  %77 = bitcast <2 x i64> %69 to i128, !dbg !266
  %78 = trunc i128 %77 to i64, !dbg !266
  %79 = extractelement <2 x i64> %69, i64 1, !dbg !266
  %80 = extractelement <2 x i64> %70, i64 0, !dbg !266
  %81 = extractelement <2 x i64> %70, i64 1, !dbg !266
  %82 = extractelement <2 x i64> %71, i64 0, !dbg !266
  br i1 %.not588, label %L58, label %L61.lr.ph, !dbg !266

L61.lr.ph:                                        ; preds = %L34.L38_crit_edge
  %83 = trunc i128 %77 to i32, !dbg !266
  %84 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8
  %root_phi26.idxF_ptr357 = getelementptr inbounds i8, ptr %47, i64 32
  %root_phi26.vals_ptr359 = getelementptr inbounds i8, ptr %47, i64 16
  %85 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8
  %86 = getelementptr inbounds i8, ptr %2, i64 40
  %root_phi7.size_ptr = getelementptr inbounds i8, ptr %9, i64 16
  %87 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %88 = getelementptr inbounds ptr, ptr %gcframe2, i64 4
  %89 = getelementptr inbounds ptr, ptr %gcframe2, i64 5
  %90 = getelementptr inbounds ptr, ptr %gcframe2, i64 6
  %91 = getelementptr inbounds i8, ptr %2, i64 16
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496
  %"new::Tuple101.promoted" = load i64, ptr %"new::Tuple101", align 1, !tbaa !288, !alias.scope !290, !noalias !291
  br label %L61, !dbg !266

L58:                                              ; preds = %L663, %L34.L38_crit_edge
  %92 = call swiftcc [1 x ptr] @j_ArgumentError_10327(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#10328.jit"), !dbg !266
  %gc_slot_addr_7 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %93 = extractvalue [1 x ptr] %92, 0, !dbg !266
  store ptr %93, ptr %gc_slot_addr_7, align 8
  %ptls_load1026 = load ptr, ptr %ptls_field, align 8, !dbg !266, !tbaa !156
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1026, i32 424, i32 16, i64 4839131120) #24, !dbg !266
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !266
  store atomic i64 4839131120, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !266, !tbaa !292
  store ptr %93, ptr %"box::ArgumentError", align 8, !dbg !266, !tbaa !294, !alias.scope !184, !noalias !185
  store ptr null, ptr %gc_slot_addr_7, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !266
  unreachable, !dbg !266

L61:                                              ; preds = %L663, %L61.lr.ph
  %94 = phi i64 [ %"new::Tuple101.promoted", %L61.lr.ph ], [ %.fr855, %L663 ]
  %.unbox591 = phi i64 [ %.unbox587, %L61.lr.ph ], [ %.unbox, %L663 ]
  %.stop_ptr.unbox590 = phi i64 [ %.stop_ptr.unbox586, %L61.lr.ph ], [ %.stop_ptr.unbox, %L663 ]
  %value_phi5589 = phi i64 [ %"process::Process.loopidx", %L61.lr.ph ], [ %202, %L663 ]
  %.unbox100 = bitcast i32 %83 to float, !dbg !266
  %.unbox337 = bitcast i32 %.sroa.7499.0.copyload500 to float, !dbg !266
  %95 = add i64 %.stop_ptr.unbox590, 1, !dbg !296
  %96 = sub i64 %95, %.unbox591, !dbg !299
  store i64 %.unbox591, ptr %"new::SamplerRangeNDL", align 8, !dbg !300, !tbaa !288, !alias.scope !290, !noalias !291
  store i64 %96, ptr %84, align 8, !dbg !300, !tbaa !288, !alias.scope !290, !noalias !291
  %97 = call swiftcc i64 @j_rand_10330(ptr nonnull swiftself %pgcstack, ptr %47, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !274
  %.fr855 = freeze i64 %97
  %root_phi25.state = load atomic ptr, ptr %45 unordered, align 8, !dbg !302, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !307, !align !308
  %root_phi25.state.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state, i64 16, !dbg !309
  %root_phi25.state.size.0.copyload = load i64, ptr %root_phi25.state.size_ptr, align 8, !dbg !309, !tbaa !235, !alias.scope !315, !noalias !316
  %.not501 = icmp eq i64 %root_phi25.state.size.0.copyload, 100000, !dbg !317
  br i1 %.not501, label %L87, label %L82, !dbg !312

L82:                                              ; preds = %L61
  call swiftcc void @j_throw_dmrsa_10331(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state.size.0.copyload) #9, !dbg !322
  unreachable, !dbg !322

L87:                                              ; preds = %L61
  %98 = load ptr, ptr %root_phi25.state, align 8, !dbg !323, !tbaa !325, !alias.scope !328, !noalias !329
  %memoryref_offset = shl i64 %.fr855, 2, !dbg !330
  %99 = getelementptr i8, ptr %98, i64 %memoryref_offset, !dbg !330
  %memoryref_data69 = getelementptr i8, ptr %99, i64 -4, !dbg !330
  %100 = load float, ptr %memoryref_data69, align 4, !dbg !330, !tbaa !333, !alias.scope !184, !noalias !185
  %101 = icmp slt i64 %.fr855, 100001
  br i1 %101, label %L133, label %L246, !dbg !335

L133:                                             ; preds = %L87
  %102 = call double @llvm.fabs.f64(double %76), !dbg !342
  %103 = fcmp oeq double %76, 0.000000e+00, !dbg !354
  br i1 %103, label %guard_pass425, label %L138, !dbg !356

L138:                                             ; preds = %L133
  %root_phi26.idxF358 = load i64, ptr %root_phi26.idxF_ptr357, align 8, !dbg !357, !tbaa !198, !alias.scope !184, !noalias !185
  %.not506 = icmp eq i64 %root_phi26.idxF358, 1002, !dbg !376
  br i1 %.not506, label %L141, label %L143, !dbg !361

L141:                                             ; preds = %L138
  %104 = call swiftcc i64 @j_gen_rand_10338(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !361
  %root_phi26.idxF362.pre = load i64, ptr %root_phi26.idxF_ptr357, align 8, !dbg !377, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L143, !dbg !361

L143:                                             ; preds = %L141, %L138
  %root_phi26.idxF362 = phi i64 [ %root_phi26.idxF358, %L138 ], [ %root_phi26.idxF362.pre, %L141 ], !dbg !377
  %root_phi26.vals360 = load atomic ptr, ptr %root_phi26.vals_ptr359 unordered, align 8, !dbg !377, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !307, !align !308
  %105 = add i64 %root_phi26.idxF362, 1, !dbg !384
  store i64 %105, ptr %root_phi26.idxF_ptr357, align 8, !dbg !385, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data365 = load ptr, ptr %root_phi26.vals360, align 8, !dbg !386, !tbaa !325, !alias.scope !328, !noalias !329
  %memoryref_byteoffset368 = shl i64 %root_phi26.idxF362, 3, !dbg !386
  %memoryref_data373 = getelementptr inbounds i8, ptr %memoryref_data365, i64 %memoryref_byteoffset368, !dbg !386
  %106 = load i64, ptr %memoryref_data373, align 8, !dbg !386, !tbaa !333, !alias.scope !184, !noalias !185
  %107 = trunc i64 %106 to i32, !dbg !387
  %108 = and i32 %107, 8388607, !dbg !388
  %109 = or disjoint i32 %108, 1065353216, !dbg !390
  %bitcast_coercion375 = bitcast i32 %109 to float, !dbg !392
  %110 = fadd float %bitcast_coercion375, -1.000000e+00, !dbg !394
  %111 = fmul float %110, 2.000000e+00, !dbg !398
  %112 = fadd float %111, -1.000000e+00, !dbg !402
  %113 = fpext float %112 to double, !dbg !403
  %114 = fmul double %102, %113, !dbg !398
  %115 = fpext float %100 to double, !dbg !412
  %116 = fadd double %114, %115, !dbg !418
  %117 = fadd double %116, 1.000000e+00, !dbg !420
  %118 = fsub double %117, %117, !dbg !425
  %119 = fcmp uno double %118, 0.000000e+00, !dbg !434
  %120 = fcmp oeq double %117, 0.000000e+00
  %or.cond = or i1 %119, %120, !dbg !428
  %121 = call double @llvm.fabs.f64(double %117), !dbg !438
  br i1 %or.cond, label %L203, label %L199, !dbg !428

L199:                                             ; preds = %L143
  %122 = call swiftcc double @j_rem_internal_10342(ptr nonnull swiftself %pgcstack, double %121, double 4.000000e+00), !dbg !439
  %123 = call double @llvm.copysign.f64(double %122, double %117), !dbg !440
  br label %L211, !dbg !443

L203:                                             ; preds = %L143
  %124 = bitcast double %121 to i64, !dbg !445
  %.not507 = icmp eq i64 %124, 9218868437227405312, !dbg !445
  br i1 %.not507, label %L218, label %L211, !dbg !447

L211:                                             ; preds = %L203, %L199
  %value_phi376 = phi double [ %123, %L199 ], [ %117, %L203 ]
  %125 = fcmp une double %value_phi376, 0.000000e+00, !dbg !448
  br i1 %125, label %L218, label %L216, !dbg !450

L216:                                             ; preds = %L211
  %126 = call double @llvm.fabs.f64(double %value_phi376), !dbg !451
  br label %guard_pass430, !dbg !443

L218:                                             ; preds = %L211, %L203
  %value_phi376523 = phi double [ %value_phi376, %L211 ], [ 0x7FF8000000000000, %L203 ]
  %127 = fcmp ogt double %value_phi376523, 0.000000e+00, !dbg !453
  %128 = fadd double %value_phi376523, 4.000000e+00
  %spec.select448 = select i1 %127, double %value_phi376523, double %128, !dbg !457
  br label %guard_pass430, !dbg !457

L246:                                             ; preds = %L87
  store i64 %94, ptr %"new::Tuple101", align 1, !dbg !458, !tbaa !288, !alias.scope !290, !noalias !291
  %jl_nothing382 = load ptr, ptr @jl_nothing, align 8, !dbg !473, !tbaa !169, !invariant.load !0, !alias.scope !476, !noalias !477, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %100), !dbg !473
  %gc_slot_addr_8 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  store ptr %box_Float32, ptr %gc_slot_addr_8, align 8
  %ptls_load1031 = load ptr, ptr %ptls_field, align 8, !dbg !473, !tbaa !156
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1031, i32 424, i32 16, i64 4839710864) #24, !dbg !473
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !473
  store atomic i64 4839710864, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !473, !tbaa !292
  store i64 %75, ptr %"box::Float64", align 8, !dbg !473, !tbaa !235, !alias.scope !478, !noalias !479
  %gc_slot_addr_71016 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %"box::Float64", ptr %gc_slot_addr_71016, align 8
  store ptr @"jl_global#10343.jit", ptr %jlcallframe1, align 8, !dbg !473
  %129 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !473
  store ptr %47, ptr %129, align 8, !dbg !473
  %130 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !473
  store ptr %jl_nothing382, ptr %130, align 8, !dbg !473
  %131 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !473
  store ptr %box_Float32, ptr %131, align 8, !dbg !473
  %132 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !473
  store ptr %"box::Float64", ptr %132, align 8, !dbg !473
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !473
  call void @llvm.trap(), !dbg !473
  unreachable, !dbg !473

L264:                                             ; preds = %guard_pass430, %guard_pass425
  %.sroa.7713.0 = phi float [ %361, %guard_pass425 ], [ %366, %guard_pass430 ], !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10719, i64 7, i1 false), !dbg !480
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10719), !dbg !480
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !470
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !480, !tbaa !288, !alias.scope !290, !noalias !291
  store i64 %.fr855, ptr %85, align 8, !dbg !470, !tbaa !288, !alias.scope !290, !noalias !291
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !470
  store float %100, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !470, !tbaa !288, !alias.scope !290, !noalias !291
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !470
  store float %.sroa.7713.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !470, !tbaa !288, !alias.scope !290, !noalias !291
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !470
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !470, !tbaa !288, !alias.scope !290, !noalias !291
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !470
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !470, !tbaa !288, !alias.scope !290, !noalias !291
  %133 = add i64 %.fr855, -1, !dbg !481
  %root_phi7.size.0.copyload = load i64, ptr %root_phi7.size_ptr, align 8, !dbg !485, !tbaa !235, !alias.scope !315, !noalias !316
  %.not508 = icmp ult i64 %133, %root_phi7.size.0.copyload, !dbg !481
  br i1 %.not508, label %L322, label %L319, !dbg !481

L319:                                             ; preds = %L264
  store i64 %.fr855, ptr %"new::Tuple353", align 8, !dbg !481, !tbaa !288, !alias.scope !290, !noalias !291
  call swiftcc void @j_throw_boundserror_10340(ptr nonnull swiftself %pgcstack, ptr %9, ptr nocapture nonnull readonly %"new::Tuple353") #9, !dbg !481
  unreachable, !dbg !481

L322:                                             ; preds = %L264
  %root_phi6.state = load atomic ptr, ptr %7 unordered, align 8, !dbg !486, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !307, !align !308
  %memoryref_data80 = load ptr, ptr %9, align 8, !dbg !490, !tbaa !325, !alias.scope !328, !noalias !329
  %134 = getelementptr i8, ptr %memoryref_data80, i64 %memoryref_offset, !dbg !490
  %memoryref_data88 = getelementptr i8, ptr %134, i64 -4, !dbg !490
  %135 = load float, ptr %memoryref_data88, align 4, !dbg !490, !tbaa !333, !alias.scope !184, !noalias !185
  %136 = fpext float %.sroa.7713.0 to double, !dbg !491
  %gc_slot_addr_71017 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %root_phi6.state, ptr %gc_slot_addr_71017, align 8
  %137 = call swiftcc double @"j_#power_by_squaring#401_10334"(ptr nonnull swiftself %pgcstack, double %136, i64 signext 2), !dbg !498
  %root_phi6.state.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state, i64 16, !dbg !485
  %root_phi6.state.size.0.copyload = load i64, ptr %root_phi6.state.size_ptr, align 8, !dbg !485, !tbaa !235, !alias.scope !315, !noalias !316
  %.not509 = icmp ult i64 %133, %root_phi6.state.size.0.copyload, !dbg !481
  br i1 %.not509, label %L347, label %L344, !dbg !481

L344:                                             ; preds = %L322
  store i64 %.fr855, ptr %"new::Tuple351", align 8, !dbg !481, !tbaa !288, !alias.scope !290, !noalias !291
  store ptr %root_phi6.state, ptr %gc_slot_addr_71017, align 8
  call swiftcc void @j_throw_boundserror_10340(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state, ptr nocapture nonnull readonly %"new::Tuple351") #9, !dbg !481
  unreachable, !dbg !481

L347:                                             ; preds = %L322
  %138 = fptrunc double %137 to float, !dbg !501
  %memoryref_data90 = load ptr, ptr %root_phi6.state, align 8, !dbg !490, !tbaa !325, !alias.scope !328, !noalias !329
  %139 = getelementptr i8, ptr %memoryref_data90, i64 %memoryref_offset, !dbg !490
  %memoryref_data98 = getelementptr i8, ptr %139, i64 -4, !dbg !490
  %140 = load float, ptr %memoryref_data98, align 4, !dbg !490, !tbaa !333, !alias.scope !184, !noalias !185
  %141 = fpext float %140 to double, !dbg !491
  store ptr null, ptr %gc_slot_addr_71017, align 8
  %142 = call swiftcc double @"j_#power_by_squaring#401_10334"(ptr nonnull swiftself %pgcstack, double %141, i64 signext 2), !dbg !498
  %143 = fptrunc double %142 to float, !dbg !501
  %144 = fsub float %138, %143, !dbg !506
  %145 = fmul float %135, 0.000000e+00, !dbg !507
  %146 = fmul float %145, %144, !dbg !507
  %147 = fadd float %146, 0.000000e+00, !dbg !510
  store ptr %7, ptr %0, align 8, !dbg !467
  store ptr %15, ptr %1, align 8, !dbg !467
  store ptr %17, ptr %87, align 8, !dbg !467
  store ptr %19, ptr %88, align 8, !dbg !467
  store ptr %21, ptr %89, align 8, !dbg !467
  store ptr %23, ptr %90, align 8, !dbg !467
  %148 = call swiftcc float @"j_#calculate##0_10335"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %0, float %147, ptr nocapture nonnull readonly %86, ptr nocapture nonnull readonly %1), !dbg !467
  %149 = fneg float %.unbox100, !dbg !511
  %.not510 = icmp ult i64 %133, %.sroa.0496.sroa.10.0.copyload732, !dbg !512
  br i1 %.not510, label %L405, label %L402, !dbg !518

L402:                                             ; preds = %L347
  %150 = getelementptr inbounds ptr, ptr %gcframe2, i64 8
  store i64 %.fr855, ptr %"new::Tuple101", align 1, !dbg !458, !tbaa !288, !alias.scope !290, !noalias !291
  store ptr %25, ptr %150, align 8, !dbg !518
  call swiftcc void @j_throw_boundserror_10341(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.0496.sroa.9.0..sroa_idx730, ptr nocapture nonnull readonly %150, ptr nocapture nonnull readonly %"new::Tuple101") #9, !dbg !518
  unreachable, !dbg !518

L405:                                             ; preds = %L347
  %root_phi6.state99 = load atomic ptr, ptr %7 unordered, align 8, !dbg !519, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !307, !align !308
  %root_phi6.state99.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state99, i64 16, !dbg !521
  %root_phi6.state99.size.0.copyload = load i64, ptr %root_phi6.state99.size_ptr, align 8, !dbg !521, !tbaa !235, !alias.scope !315, !noalias !316
  %.not511 = icmp ult i64 %133, %root_phi6.state99.size.0.copyload, !dbg !522
  br i1 %.not511, label %L422, label %L419, !dbg !522

L419:                                             ; preds = %L405
  store i64 %.fr855, ptr %"new::Tuple348", align 8, !dbg !522, !tbaa !288, !alias.scope !290, !noalias !291
  store ptr %root_phi6.state99, ptr %gc_slot_addr_71017, align 8
  call swiftcc void @j_throw_boundserror_10340(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state99, ptr nocapture nonnull readonly %"new::Tuple348") #9, !dbg !522
  unreachable, !dbg !522

L422:                                             ; preds = %L405
  %root_phi15.x = load float, ptr %25, align 4, !dbg !523, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data104 = load ptr, ptr %root_phi6.state99, align 8, !dbg !527, !tbaa !325, !alias.scope !328, !noalias !329
  %151 = getelementptr i8, ptr %memoryref_data104, i64 %memoryref_offset, !dbg !527
  %memoryref_data112 = getelementptr i8, ptr %151, i64 -4, !dbg !527
  %152 = load float, ptr %memoryref_data112, align 4, !dbg !527, !tbaa !333, !alias.scope !184, !noalias !185
  %153 = fsub float %.sroa.7713.0, %152, !dbg !528
  %154 = fmul float %root_phi15.x, %149, !dbg !529
  %155 = fmul float %154, %153, !dbg !529
  %156 = fadd float %148, %155, !dbg !510
  %157 = fcmp ugt float %156, 0.000000e+00, !dbg !531
  br i1 %157, label %L437, label %L554, !dbg !533

L437:                                             ; preds = %L422
  %root_phi26.idxF = load i64, ptr %root_phi26.idxF_ptr357, align 8, !dbg !534, !tbaa !198, !alias.scope !184, !noalias !185
  %.not512 = icmp eq i64 %root_phi26.idxF, 1002, !dbg !547
  br i1 %.not512, label %L440, label %L442, !dbg !536

L440:                                             ; preds = %L437
  %158 = call swiftcc i64 @j_gen_rand_10338(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !536
  %root_phi26.idxF324.pre = load i64, ptr %root_phi26.idxF_ptr357, align 8, !dbg !548, !tbaa !198, !alias.scope !184, !noalias !185
  br label %L442, !dbg !536

L442:                                             ; preds = %L440, %L437
  %root_phi26.idxF324 = phi i64 [ %root_phi26.idxF, %L437 ], [ %root_phi26.idxF324.pre, %L440 ], !dbg !548
  %root_phi26.vals = load atomic ptr, ptr %root_phi26.vals_ptr359 unordered, align 8, !dbg !548, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !307, !align !308
  %159 = add i64 %root_phi26.idxF324, 1, !dbg !553
  store i64 %159, ptr %root_phi26.idxF_ptr357, align 8, !dbg !554, !tbaa !198, !alias.scope !184, !noalias !185
  %memoryref_data327 = load ptr, ptr %root_phi26.vals, align 8, !dbg !555, !tbaa !325, !alias.scope !328, !noalias !329
  %memoryref_byteoffset330 = shl i64 %root_phi26.idxF324, 3, !dbg !555
  %memoryref_data335 = getelementptr inbounds i8, ptr %memoryref_data327, i64 %memoryref_byteoffset330, !dbg !555
  %160 = load i64, ptr %memoryref_data335, align 8, !dbg !555, !tbaa !333, !alias.scope !184, !noalias !185
  %161 = trunc i64 %160 to i32, !dbg !556
  %162 = and i32 %161, 8388607, !dbg !557
  %163 = or disjoint i32 %162, 1065353216, !dbg !558
  %bitcast_coercion336 = bitcast i32 %163 to float, !dbg !559
  %164 = fadd float %bitcast_coercion336, -1.000000e+00, !dbg !560
  %165 = fneg float %156, !dbg !562
  %166 = fdiv float %165, %.unbox337, !dbg !563
  %167 = fmul float %166, 0x3FF7154760000000, !dbg !565
  %168 = call float @llvm.rint.f32(float %167), !dbg !571
  %169 = fptosi float %168 to i32, !dbg !575
  %170 = freeze i32 %169, !dbg !575
  %171 = fmul contract float %168, 0x3FE62E4000000000, !dbg !578
  %172 = fsub contract float %166, %171, !dbg !578
  %173 = fmul contract float %168, 0x3EB7F7D1C0000000, !dbg !581
  %174 = fsub contract float %172, %173, !dbg !581
  %175 = fmul contract float %174, 0x3F2A1D7140000000, !dbg !583
  %176 = fadd contract float %175, 0x3F56DA7560000000, !dbg !583
  %177 = fmul contract float %174, %176, !dbg !583
  %178 = fadd contract float %177, 0x3F811105C0000000, !dbg !583
  %179 = fmul contract float %174, %178, !dbg !583
  %180 = fadd contract float %179, 0x3FA5554640000000, !dbg !583
  %181 = fmul contract float %174, %180, !dbg !583
  %182 = fadd contract float %181, 0x3FC5555560000000, !dbg !583
  %183 = fmul contract float %174, %182, !dbg !583
  %184 = fadd contract float %183, 5.000000e-01, !dbg !583
  %185 = fmul contract float %174, %184, !dbg !583
  %186 = fadd contract float %185, 1.000000e+00, !dbg !583
  %187 = fmul contract float %174, %186, !dbg !583
  %188 = fadd contract float %187, 1.000000e+00, !dbg !583
  %189 = fcmp ule float %166, 0x40562E4300000000, !dbg !591
  br i1 %189, label %L501, label %L552, !dbg !593

L501:                                             ; preds = %L442
  %190 = fcmp uge float %166, 0xC059FE3680000000, !dbg !594
  br i1 %190, label %L545, label %L552, !dbg !595

L545:                                             ; preds = %L501
  %191 = fcmp ugt float %166, 0xC055D58A00000000, !dbg !596
  %192 = fmul float %188, 0x3E70000000000000, !dbg !597
  %value_phi340 = select i1 %191, float %188, float %192, !dbg !597
  %.not513 = icmp eq i32 %170, 128, !dbg !598
  %193 = fmul float %value_phi340, 2.000000e+00, !dbg !600
  %value_phi342 = select i1 %.not513, float %193, float %value_phi340, !dbg !600
  %value_phi339.v = select i1 %191, i32 127, i32 151, !dbg !597
  %value_phi339 = add i32 %170, %value_phi339.v, !dbg !597
  %194 = sext i1 %.not513 to i32, !dbg !600
  %value_phi341 = add i32 %value_phi339, %194, !dbg !600
  %195 = shl i32 %value_phi341, 23, !dbg !601
  %bitcast_coercion345 = bitcast i32 %195 to float, !dbg !607
  %196 = fmul float %value_phi342, %bitcast_coercion345, !dbg !608
  br label %L552, !dbg !443

L552:                                             ; preds = %L545, %L501, %L442
  %value_phi338 = phi float [ %196, %L545 ], [ 0x7FF0000000000000, %L442 ], [ 0.000000e+00, %L501 ]
  %197 = fcmp olt float %164, %value_phi338, !dbg !609
  br i1 %197, label %L554, label %guard_pass440, !dbg !533

L554:                                             ; preds = %L552, %L422
  %root_phi25.state114 = load atomic ptr, ptr %45 unordered, align 8, !dbg !610, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0, !dereferenceable !307, !align !308
  %root_phi25.state114.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state114, i64 16, !dbg !616
  %root_phi25.state114.size.0.copyload = load i64, ptr %root_phi25.state114.size_ptr, align 8, !dbg !616, !tbaa !235, !alias.scope !315, !noalias !316
  %.not514 = icmp eq i64 %root_phi25.state114.size.0.copyload, 100000, !dbg !618
  br i1 %.not514, label %guard_pass435, label %L562, !dbg !617

L562:                                             ; preds = %L554
  call swiftcc void @j_throw_dmrsa_10331(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state114.size.0.copyload) #9, !dbg !620
  unreachable, !dbg !620

L639:                                             ; preds = %guard_pass440, %guard_pass435
  %.sroa.9.0 = phi i8 [ 1, %guard_pass435 ], [ 0, %guard_pass440 ], !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::NamedTuple135.sroa.0.sroa.24.sroa.9", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !621
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10), !dbg !621
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !622
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %91, i64 80, i1 false), !dbg !622, !tbaa !288, !alias.scope !290, !noalias !291
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0496.sroa.11.0..sroa_idx735, i64 16, i1 false), !dbg !622, !tbaa !288, !alias.scope !290, !noalias !291
  %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 16, !dbg !622
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %74, i64 112, i1 false), !dbg !622, !tbaa !288, !alias.scope !290, !noalias !291
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !632
  %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 32, !dbg !632
  %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 96, !dbg !632
  store i64 1, ptr %4, align 8, !dbg !638, !tbaa !198, !alias.scope !184, !noalias !185
  %198 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !647, !tbaa !198, !alias.scope !184, !noalias !185
  %199 = add <2 x i64> %198, <i64 1, i64 1>, !dbg !652
  store <2 x i64> %199, ptr %"process::Process.loopidx_ptr", align 8, !dbg !653, !tbaa !198, !alias.scope !184, !noalias !185
  %200 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !654, !tbaa !198, !alias.scope !184, !noalias !185
  %201 = and i8 %200, 1, !dbg !654
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %201, 0, !dbg !654
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L653, label %L654, !dbg !660

L653:                                             ; preds = %L639
  store i64 %.fr855, ptr %"new::Tuple101", align 1, !dbg !458, !tbaa !288, !alias.scope !290, !noalias !291
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %"new::NamedTuple135.sroa.0.sroa.24.sroa.9", i64 7, i1 false), !dbg !233
  br label %L664, !dbg !233

L654:                                             ; preds = %L639
  %.not517.not.not = icmp eq i64 %value_phi5589, %value_phi, !dbg !661
  br i1 %.not517.not.not, label %L659.L664_crit_edge, label %L663, !dbg !444

L659.L664_crit_edge:                              ; preds = %L654
  store i64 %.fr855, ptr %"new::Tuple101", align 1, !dbg !458, !tbaa !288, !alias.scope !290, !noalias !291
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %"new::NamedTuple135.sroa.0.sroa.24.sroa.9", i64 7, i1 false), !dbg !233
  br label %L664, !dbg !233

L663:                                             ; preds = %L654
  %202 = add i64 %value_phi5589, 1, !dbg !443
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !226
  store i64 %78, ptr %.sroa.0496.sroa.8.0..sroa_idx727, align 8, !dbg !226
  store i64 %79, ptr %.sroa.0496.sroa.9.0..sroa_idx730, align 8, !dbg !226
  store i64 %.sroa.0496.sroa.10.0.copyload732, ptr %.sroa.0496.sroa.10.0..sroa_idx733, align 8, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0496.sroa.11.0..sroa_idx735, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0496.sroa.12.0..sroa_idx736, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0496.sroa.13.0..sroa_idx737, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !226
  store i64 %80, ptr %.sroa.0496.sroa.14.0..sroa_idx739, align 8, !dbg !226
  store i64 %81, ptr %.sroa.0496.sroa.15.0..sroa_idx742, align 8, !dbg !226
  store i64 %82, ptr %.sroa.0496.sroa.16.0..sroa_idx745, align 8, !dbg !226
  store i64 %75, ptr %.sroa.0496.sroa.17.0..sroa_idx748, align 8, !dbg !226
  store i64 %.fr855, ptr %.sroa.0496.sroa.19.0..sroa_idx754, align 8, !dbg !226
  store float %100, ptr %.sroa.0496.sroa.20.0..sroa_idx757, align 8, !dbg !226
  store float %.sroa.7713.0, ptr %.sroa.0496.sroa.21.0..sroa_idx760, align 4, !dbg !226
  store i64 1, ptr %.sroa.0496.sroa.22.0..sroa_idx763, align 8, !dbg !226
  store i8 %.sroa.9.0, ptr %.sroa.0496.sroa.23.0..sroa_idx766, align 8, !dbg !226
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0496.sroa.24.0..sroa_idx768, ptr noundef nonnull align 1 dereferenceable(7) %"new::NamedTuple135.sroa.0.sroa.24.sroa.9", i64 7, i1 false), !dbg !226
  store float %156, ptr %.sroa.6497.0..sroa_idx, align 8, !dbg !226
  store i32 %.sroa.7499.0.copyload500, ptr %.sroa.7499.0..sroa_idx, align 4, !dbg !226
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !286, !tbaa !288, !alias.scope !290, !noalias !291
  %.unbox = load i64, ptr %74, align 8, !dbg !286, !tbaa !288, !alias.scope !290, !noalias !291
  %.not = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !286
  br i1 %.not, label %L58, label %L61, !dbg !266

L664:                                             ; preds = %L659.L664_crit_edge, %L653, %L34.L664_crit_edge
  %.sroa.0.sroa.8.0 = phi i64 [ %.sroa.0.sroa.8.0.copyload, %L34.L664_crit_edge ], [ %78, %L659.L664_crit_edge ], [ %78, %L653 ], !dbg !233
  %.sroa.0.sroa.9.0 = phi i64 [ %.sroa.0.sroa.9.0.copyload, %L34.L664_crit_edge ], [ %79, %L659.L664_crit_edge ], [ %79, %L653 ], !dbg !233
  %.sroa.0.sroa.10.0 = phi i64 [ %.sroa.0.sroa.10.0.copyload, %L34.L664_crit_edge ], [ %.sroa.0496.sroa.10.0.copyload732, %L659.L664_crit_edge ], [ %.sroa.0496.sroa.10.0.copyload732, %L653 ], !dbg !233
  %.sroa.0.sroa.14.0 = phi i64 [ %.sroa.0.sroa.14.0.copyload, %L34.L664_crit_edge ], [ %80, %L659.L664_crit_edge ], [ %80, %L653 ], !dbg !233
  %.sroa.0.sroa.15.0 = phi i64 [ %.sroa.0.sroa.15.0.copyload, %L34.L664_crit_edge ], [ %81, %L659.L664_crit_edge ], [ %81, %L653 ], !dbg !233
  %.sroa.0.sroa.16.0 = phi i64 [ %.sroa.0.sroa.16.0.copyload, %L34.L664_crit_edge ], [ %82, %L659.L664_crit_edge ], [ %82, %L653 ], !dbg !233
  %.sroa.0.sroa.17.0 = phi i64 [ %.sroa.0.sroa.17.0.copyload, %L34.L664_crit_edge ], [ %75, %L659.L664_crit_edge ], [ %75, %L653 ], !dbg !233
  %.sroa.0.sroa.18.sroa.0.0 = phi i64 [ %.sroa.0.sroa.18.sroa.0.0.copyload, %L34.L664_crit_edge ], [ undef, %L659.L664_crit_edge ], [ undef, %L653 ], !dbg !233
  %.sroa.0.sroa.18.sroa.8.0 = phi i64 [ %.sroa.0.sroa.18.sroa.8.0.copyload, %L34.L664_crit_edge ], [ %.fr855, %L659.L664_crit_edge ], [ %.fr855, %L653 ], !dbg !233
  %.sroa.0.sroa.18.sroa.10.0 = phi float [ %.sroa.0.sroa.18.sroa.10.0.copyload, %L34.L664_crit_edge ], [ %100, %L659.L664_crit_edge ], [ %100, %L653 ], !dbg !233
  %.sroa.0.sroa.18.sroa.12.0 = phi float [ %.sroa.0.sroa.18.sroa.12.0.copyload, %L34.L664_crit_edge ], [ %.sroa.7713.0, %L659.L664_crit_edge ], [ %.sroa.7713.0, %L653 ], !dbg !233
  %.sroa.0.sroa.18.sroa.14.0 = phi i64 [ %.sroa.0.sroa.18.sroa.14.0.copyload, %L34.L664_crit_edge ], [ 1, %L659.L664_crit_edge ], [ 1, %L653 ], !dbg !233
  %.sroa.0.sroa.18.sroa.16.0 = phi i8 [ %.sroa.0.sroa.18.sroa.16.0.copyload, %L34.L664_crit_edge ], [ %.sroa.9.0, %L659.L664_crit_edge ], [ %.sroa.9.0, %L653 ], !dbg !233
  %.sroa.8.0 = phi float [ %.sroa.8.0.copyload457, %L34.L664_crit_edge ], [ %156, %L659.L664_crit_edge ], [ %156, %L653 ], !dbg !233
  %.sroa.10.0 = phi i32 [ %.sroa.10.0.copyload458, %L34.L664_crit_edge ], [ %.sroa.7499.0.copyload500, %L659.L664_crit_edge ], [ %.sroa.7499.0.copyload500, %L653 ], !dbg !233
  %203 = call i64 @jlplt_ijl_hrtime_10326_got.jit(), !dbg !662
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 520, !dbg !668
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528, !dbg !668
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !668, !tbaa !198, !alias.scope !184, !noalias !185
  store i64 %203, ptr %"process::Process.endtime_ptr", align 8, !dbg !668, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !669
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !669, !tbaa !198, !alias.scope !184, !noalias !185, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !670
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !670, !tbaa !292, !range !674
  %204 = and i64 %"process::Process.task.tag", -16, !dbg !670
  %205 = inttoptr i64 %204 to ptr, !dbg !670
  %exactly_isa.not.not = icmp eq ptr %205, @"+Core.Nothing#10336.jit", !dbg !670
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 497, !dbg !670
  %206 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !670
  %207 = and i8 %206, 1, !dbg !673
  %208 = icmp eq i8 %207, 0, !dbg !673
  %.not521 = select i1 %exactly_isa.not.not, i1 true, i1 %208, !dbg !673
  br i1 %.not521, label %L719, label %L701, !dbg !673

L701:                                             ; preds = %L664
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !675
  %ptls_load1039 = load ptr, ptr %ptls_field, align 8, !dbg !675, !tbaa !156
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1039, i32 1120, i32 400, i64 15438717968) #24, !dbg !675
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !675
  store atomic i64 15438717968, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !675, !tbaa !292
  store atomic ptr %5, ptr %"box::ProcessContext" unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %209 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !675
  store atomic ptr %7, ptr %209 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %210 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !675
  store atomic ptr %9, ptr %210 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %211 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !675
  store atomic ptr %11, ptr %211 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %212 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !675
  store atomic ptr %13, ptr %212 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %213 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !675
  %"new::ProcessContext.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.0, i64 40, !dbg !675
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %213, ptr noundef nonnull align 8 dereferenceable(16) %"new::ProcessContext.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !675
  %214 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !675
  store atomic ptr %15, ptr %214 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %215 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !675
  store atomic ptr %17, ptr %215 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %216 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !675
  store atomic ptr %19, ptr %216 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %217 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !675
  store atomic ptr %21, ptr %217 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %218 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !675
  store atomic ptr %23, ptr %218 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %219 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !675
  store i64 %.sroa.0.sroa.8.0, ptr %219, align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %220 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !675
  store atomic ptr %25, ptr %220 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %221 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !675
  store i64 %.sroa.0.sroa.10.0, ptr %221, align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %222 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !675
  store atomic ptr %27, ptr %222 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %223 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !675
  store atomic ptr %29, ptr %223 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %224 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !675
  %"new::ProcessContext.sroa.0.sroa.10.136.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.11, i64 16, !dbg !675
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %224, ptr noundef nonnull align 8 dereferenceable(16) %"new::ProcessContext.sroa.0.sroa.10.136.sroa_idx", i64 16, i1 false), !dbg !675
  %225 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !675
  store atomic ptr %31, ptr %225 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %226 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !675
  store atomic ptr %33, ptr %226 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %227 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !675
  store atomic ptr %35, ptr %227 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %228 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !675
  store atomic ptr %37, ptr %228 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %229 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !675
  store atomic ptr %39, ptr %229 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %230 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !675
  %"new::ProcessContext.sroa.0.sroa.12.192.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.12, i64 40, !dbg !675
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %230, ptr noundef nonnull align 8 dereferenceable(24) %"new::ProcessContext.sroa.0.sroa.12.192.sroa_idx", i64 24, i1 false), !dbg !675
  %231 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !675
  store atomic ptr %41, ptr %231 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %232 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !675
  %"new::ProcessContext.sroa.0.sroa.14.224.sroa_idx" = getelementptr inbounds i8, ptr %.sroa.0.sroa.13, i64 8, !dbg !675
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %232, ptr noundef nonnull align 8 dereferenceable(24) %"new::ProcessContext.sroa.0.sroa.14.224.sroa_idx", i64 24, i1 false), !dbg !675
  %233 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !675
  store atomic ptr %43, ptr %233 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %234 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !675
  store i64 %.sroa.0.sroa.15.0, ptr %234, align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %235 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !675
  store atomic ptr %45, ptr %235 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %236 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !675
  store i64 %.sroa.0.sroa.17.0, ptr %236, align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %237 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !675
  store atomic ptr %47, ptr %237 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %238 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !675
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %238, align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::ProcessContext.sroa.0.sroa.22.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 296, !dbg !675
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.6.8..sroa_idx", align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::ProcessContext.sroa.0.sroa.22.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 300, !dbg !675
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.7.8..sroa_idx", align 4, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::ProcessContext.sroa.0.sroa.22.sroa.8.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 304, !dbg !675
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.8.8..sroa_idx", align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::ProcessContext.sroa.0.sroa.22.sroa.9.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 312, !dbg !675
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::ProcessContext.sroa.0.sroa.22.sroa.9.8..sroa_idx", align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::ProcessContext.sroa.0.sroa.22.sroa.10.8..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 313, !dbg !675
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::ProcessContext.sroa.0.sroa.22.sroa.10.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !675
  %"new::ProcessContext.sroa.13.288..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 320, !dbg !675
  store float %.sroa.8.0, ptr %"new::ProcessContext.sroa.13.288..sroa_idx", align 8, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::ProcessContext.sroa.17.288..sroa_idx" = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 324, !dbg !675
  store i32 %.sroa.10.0, ptr %"new::ProcessContext.sroa.17.288..sroa_idx", align 4, !dbg !675, !tbaa !235, !alias.scope !478, !noalias !479
  %239 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !675
  store atomic ptr %49, ptr %239 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %240 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !675
  store atomic ptr %51, ptr %240 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %241 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !675
  store atomic ptr %53, ptr %241 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %242 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !675
  store atomic ptr %55, ptr %242 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %243 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !675
  store atomic ptr %57, ptr %243 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %244 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !675
  store atomic ptr %59, ptr %244 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  %245 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !675
  store atomic ptr %61, ptr %245 unordered, align 8, !dbg !675, !tbaa !294, !alias.scope !184, !noalias !185
  store atomic ptr %"box::ProcessContext", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !675, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !675
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !675, !tbaa !292, !range !674
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !675
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !675
  br i1 %parent_old_marked, label %may_trigger_wb, label %246, !dbg !675

may_trigger_wb:                                   ; preds = %L701
  %"box::ProcessContext.tag" = load atomic volatile i64, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !675, !tbaa !292, !range !674
  %child_bit = and i64 %"box::ProcessContext.tag", 1, !dbg !675
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !675
  br i1 %child_not_marked, label %trigger_wb, label %246, !dbg !675, !prof !681

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !675
  br label %246, !dbg !675

246:                                              ; preds = %may_trigger_wb, %trigger_wb, %L701
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0484.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0484.sroa.9, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0484.sroa.10, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0484.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0484.sroa.16.sroa.16, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8489, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.21", i64 56, i1 false), !dbg !233
  br label %L729, !dbg !233

L719:                                             ; preds = %L664
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !233
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !682
  %247 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !682, !tbaa !198, !alias.scope !184, !noalias !185
  %248 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !682
  %249 = load atomic ptr, ptr %248 unordered, align 8, !dbg !682, !tbaa !198, !alias.scope !184, !noalias !185
  %250 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !682
  %251 = load atomic ptr, ptr %250 unordered, align 8, !dbg !682, !tbaa !198, !alias.scope !184, !noalias !185
  %252 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !682
  %253 = load atomic ptr, ptr %252 unordered, align 8, !dbg !682, !tbaa !198, !alias.scope !184, !noalias !185
  %254 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !682
  %255 = load atomic ptr, ptr %254 unordered, align 8, !dbg !682, !tbaa !198, !alias.scope !184, !noalias !185
  %256 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !682
  %257 = load atomic ptr, ptr %256 unordered, align 8, !dbg !682, !tbaa !198, !alias.scope !184, !noalias !185
  %258 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !688
  store atomic ptr %5, ptr %258 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %259 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !688
  store atomic ptr %7, ptr %259 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %260 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !688
  store atomic ptr %9, ptr %260 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %261 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !688
  store atomic ptr %11, ptr %261 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %262 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !688
  store atomic ptr %13, ptr %262 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %263 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !688
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", i64 40, !dbg !688
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %263, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %264 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !688
  store atomic ptr %15, ptr %264 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %265 = getelementptr inbounds i8, ptr %"process::Process", i64 120, !dbg !688
  store atomic ptr %17, ptr %265 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %266 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !688
  store atomic ptr %19, ptr %266 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %267 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !688
  store atomic ptr %21, ptr %267 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %268 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !688
  store atomic ptr %23, ptr %268 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %269 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !688
  store i64 %.sroa.0.sroa.8.0, ptr %269, align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %270 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !688
  store atomic ptr %25, ptr %270 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %271 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !688
  store i64 %.sroa.0.sroa.10.0, ptr %271, align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %272 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !688
  store atomic ptr %27, ptr %272 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %273 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !688
  store atomic ptr %29, ptr %273 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %274 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !688
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", i64 16, !dbg !688
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %274, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx", i64 16, i1 false), !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %275 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !688
  store atomic ptr %31, ptr %275 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %276 = getelementptr inbounds i8, ptr %"process::Process", i64 216, !dbg !688
  store atomic ptr %33, ptr %276 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %277 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !688
  store atomic ptr %35, ptr %277 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %278 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !688
  store atomic ptr %37, ptr %278 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %279 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !688
  store atomic ptr %39, ptr %279 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %280 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !688
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", i64 40, !dbg !688
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %280, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx", i64 24, i1 false), !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %281 = getelementptr inbounds i8, ptr %"process::Process", i64 272, !dbg !688
  store atomic ptr %41, ptr %281 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %282 = getelementptr inbounds i8, ptr %"process::Process", i64 280, !dbg !688
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", i64 8, !dbg !688
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %282, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx", i64 24, i1 false), !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %283 = getelementptr inbounds i8, ptr %"process::Process", i64 304, !dbg !688
  store atomic ptr %43, ptr %283 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %284 = getelementptr inbounds i8, ptr %"process::Process", i64 312, !dbg !688
  store i64 %.sroa.0.sroa.15.0, ptr %284, align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %285 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !688
  store atomic ptr %45, ptr %285 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %286 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !688
  store i64 %.sroa.0.sroa.17.0, ptr %286, align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %287 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !688
  store atomic ptr %47, ptr %287 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %288 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !688
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %288, align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !688
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx", align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 356, !dbg !688
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx", align 4, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !688
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx", align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !688
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx", align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 369, !dbg !688
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !688
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !688
  store float %.sroa.8.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 380, !dbg !688
  store i32 %.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !688, !tbaa !235, !alias.scope !478, !noalias !479
  %289 = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !688
  store atomic ptr %49, ptr %289 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %290 = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !688
  store atomic ptr %51, ptr %290 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %291 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !688
  store atomic ptr %53, ptr %291 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %292 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !688
  store atomic ptr %55, ptr %292 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %293 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !688
  store atomic ptr %57, ptr %293 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %294 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !688
  store atomic ptr %59, ptr %294 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %295 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !688
  store atomic ptr %61, ptr %295 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  store atomic ptr %257, ptr %256 unordered, align 8, !dbg !688, !tbaa !198, !alias.scope !184, !noalias !185
  %"process::Process.tag_addr1041" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !688
  %"process::Process.tag1042" = load atomic volatile i64, ptr %"process::Process.tag_addr1041" unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %parent_bits1043 = and i64 %"process::Process.tag1042", 3, !dbg !688
  %parent_old_marked1044 = icmp eq i64 %parent_bits1043, 3, !dbg !688
  br i1 %parent_old_marked1044, label %may_trigger_wb1045, label %331, !dbg !688

may_trigger_wb1045:                               ; preds = %L719
  %.tag_addr = getelementptr inbounds i64, ptr %247, i64 -1, !dbg !688
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %.tag_addr1048 = getelementptr inbounds i64, ptr %249, i64 -1, !dbg !688
  %.tag1049 = load atomic volatile i64, ptr %.tag_addr1048 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %296 = and i64 %.tag, %.tag1049, !dbg !688
  %.tag_addr1052 = getelementptr inbounds i64, ptr %251, i64 -1, !dbg !688
  %.tag1053 = load atomic volatile i64, ptr %.tag_addr1052 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %297 = and i64 %296, %.tag1053, !dbg !688
  %.tag_addr1056 = getelementptr inbounds i64, ptr %253, i64 -1, !dbg !688
  %.tag1057 = load atomic volatile i64, ptr %.tag_addr1056 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %298 = and i64 %297, %.tag1057, !dbg !688
  %.tag_addr1060 = getelementptr inbounds i64, ptr %255, i64 -1, !dbg !688
  %.tag1061 = load atomic volatile i64, ptr %.tag_addr1060 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %299 = and i64 %298, %.tag1061, !dbg !688
  %.tag_addr1064 = getelementptr inbounds i64, ptr %5, i64 -1, !dbg !688
  %.tag1065 = load atomic volatile i64, ptr %.tag_addr1064 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %300 = and i64 %299, %.tag1065, !dbg !688
  %.tag_addr1068 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !688
  %.tag1069 = load atomic volatile i64, ptr %.tag_addr1068 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %301 = and i64 %300, %.tag1069, !dbg !688
  %.tag_addr1072 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !688
  %.tag1073 = load atomic volatile i64, ptr %.tag_addr1072 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %302 = and i64 %301, %.tag1073, !dbg !688
  %.tag_addr1076 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !688
  %.tag1077 = load atomic volatile i64, ptr %.tag_addr1076 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %303 = and i64 %302, %.tag1077, !dbg !688
  %.tag_addr1080 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !688
  %.tag1081 = load atomic volatile i64, ptr %.tag_addr1080 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %304 = and i64 %303, %.tag1081, !dbg !688
  %.tag_addr1084 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !688
  %.tag1085 = load atomic volatile i64, ptr %.tag_addr1084 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %305 = and i64 %304, %.tag1085, !dbg !688
  %.tag_addr1088 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !688
  %.tag1089 = load atomic volatile i64, ptr %.tag_addr1088 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %306 = and i64 %305, %.tag1089, !dbg !688
  %.tag_addr1092 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !688
  %.tag1093 = load atomic volatile i64, ptr %.tag_addr1092 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %307 = and i64 %306, %.tag1093, !dbg !688
  %.tag_addr1096 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !688
  %.tag1097 = load atomic volatile i64, ptr %.tag_addr1096 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %308 = and i64 %307, %.tag1097, !dbg !688
  %.tag_addr1100 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !688
  %.tag1101 = load atomic volatile i64, ptr %.tag_addr1100 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %309 = and i64 %308, %.tag1101, !dbg !688
  %.tag_addr1104 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !688
  %.tag1105 = load atomic volatile i64, ptr %.tag_addr1104 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %310 = and i64 %309, %.tag1105, !dbg !688
  %.tag_addr1108 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !688
  %.tag1109 = load atomic volatile i64, ptr %.tag_addr1108 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %311 = and i64 %310, %.tag1109, !dbg !688
  %.tag_addr1112 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !688
  %.tag1113 = load atomic volatile i64, ptr %.tag_addr1112 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %312 = and i64 %311, %.tag1113, !dbg !688
  %.tag_addr1116 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !688
  %.tag1117 = load atomic volatile i64, ptr %.tag_addr1116 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %313 = and i64 %312, %.tag1117, !dbg !688
  %.tag_addr1120 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !688
  %.tag1121 = load atomic volatile i64, ptr %.tag_addr1120 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %314 = and i64 %313, %.tag1121, !dbg !688
  %.tag_addr1124 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !688
  %.tag1125 = load atomic volatile i64, ptr %.tag_addr1124 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %315 = and i64 %314, %.tag1125, !dbg !688
  %.tag_addr1128 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !688
  %.tag1129 = load atomic volatile i64, ptr %.tag_addr1128 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %316 = and i64 %315, %.tag1129, !dbg !688
  %.tag_addr1132 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !688
  %.tag1133 = load atomic volatile i64, ptr %.tag_addr1132 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %317 = and i64 %316, %.tag1133, !dbg !688
  %.tag_addr1136 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !688
  %.tag1137 = load atomic volatile i64, ptr %.tag_addr1136 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %318 = and i64 %317, %.tag1137, !dbg !688
  %.tag_addr1140 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !688
  %.tag1141 = load atomic volatile i64, ptr %.tag_addr1140 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %319 = and i64 %318, %.tag1141, !dbg !688
  %.tag_addr1144 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !688
  %.tag1145 = load atomic volatile i64, ptr %.tag_addr1144 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %320 = and i64 %319, %.tag1145, !dbg !688
  %.tag_addr1148 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !688
  %.tag1149 = load atomic volatile i64, ptr %.tag_addr1148 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %321 = and i64 %320, %.tag1149, !dbg !688
  %.tag_addr1152 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !688
  %.tag1153 = load atomic volatile i64, ptr %.tag_addr1152 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %322 = and i64 %321, %.tag1153, !dbg !688
  %.tag_addr1156 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !688
  %.tag1157 = load atomic volatile i64, ptr %.tag_addr1156 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %323 = and i64 %322, %.tag1157, !dbg !688
  %.tag_addr1160 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !688
  %.tag1161 = load atomic volatile i64, ptr %.tag_addr1160 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %324 = and i64 %323, %.tag1161, !dbg !688
  %.tag_addr1164 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !688
  %.tag1165 = load atomic volatile i64, ptr %.tag_addr1164 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %325 = and i64 %324, %.tag1165, !dbg !688
  %.tag_addr1168 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !688
  %.tag1169 = load atomic volatile i64, ptr %.tag_addr1168 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %326 = and i64 %325, %.tag1169, !dbg !688
  %.tag_addr1172 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !688
  %.tag1173 = load atomic volatile i64, ptr %.tag_addr1172 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %327 = and i64 %326, %.tag1173, !dbg !688
  %.tag_addr1176 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !688
  %.tag1177 = load atomic volatile i64, ptr %.tag_addr1176 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %328 = and i64 %327, %.tag1177, !dbg !688
  %.tag_addr1180 = getelementptr inbounds i64, ptr %257, i64 -1, !dbg !688
  %.tag1181 = load atomic volatile i64, ptr %.tag_addr1180 unordered, align 8, !dbg !688, !tbaa !292, !range !674
  %329 = and i64 %328, %.tag1181, !dbg !688
  %330 = and i64 %329, 1, !dbg !688
  %.not3.not = icmp eq i64 %330, 0, !dbg !688
  br i1 %.not3.not, label %trigger_wb1184, label %331, !dbg !688, !prof !681

trigger_wb1184:                                   ; preds = %may_trigger_wb1045
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !688
  br label %331, !dbg !688

331:                                              ; preds = %may_trigger_wb1045, %trigger_wb1184, %L719
  %"process::Process.runtime_context_ptr316" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !690
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !690, !tbaa !169, !invariant.load !0, !alias.scope !476, !noalias !477, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr316" release, align 8, !dbg !690, !tbaa !198, !alias.scope !184, !noalias !185
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0484.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0484.sroa.9, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0484.sroa.10, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0484.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0484.sroa.16.sroa.16, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8489, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.21", i64 56, i1 false), !dbg !233
  br label %L729, !dbg !233

L729:                                             ; preds = %331, %246
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0484.sroa.0, i64 96, i1 false), !dbg !667
  %.sroa.0490.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !667
  store i64 %.sroa.0.sroa.8.0, ptr %.sroa.0490.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !667
  store i64 %.sroa.0.sroa.9.0, ptr %.sroa.0490.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !667
  store i64 %.sroa.0.sroa.10.0, ptr %.sroa.0490.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !667
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0490.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0484.sroa.9, i64 32, i1 false), !dbg !667
  %.sroa.0490.sroa.6.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !667
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0490.sroa.6.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0484.sroa.10, i64 64, i1 false), !dbg !667
  %.sroa.0490.sroa.7.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 216, !dbg !667
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0490.sroa.7.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0484.sroa.11, i64 32, i1 false), !dbg !667
  %.sroa.0490.sroa.8.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 248, !dbg !667
  store i64 %.sroa.0.sroa.14.0, ptr %.sroa.0490.sroa.8.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.9.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !667
  store i64 %.sroa.0.sroa.15.0, ptr %.sroa.0490.sroa.9.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.10.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 264, !dbg !667
  store i64 %.sroa.0.sroa.16.0, ptr %.sroa.0490.sroa.10.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.11.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !667
  store i64 %.sroa.0.sroa.17.0, ptr %.sroa.0490.sroa.11.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 280, !dbg !667
  store i64 %.sroa.0.sroa.18.sroa.0.0, ptr %.sroa.0490.sroa.12.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.sroa.2.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !667
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %.sroa.0490.sroa.12.sroa.2.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.sroa.3.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !667
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0490.sroa.12.sroa.3.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.sroa.4.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !667
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0490.sroa.12.sroa.4.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.sroa.5.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !667
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %.sroa.0490.sroa.12.sroa.5.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.sroa.6.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !667
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0490.sroa.12.sroa.6.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.0490.sroa.12.sroa.7.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !667
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0490.sroa.12.sroa.7.0..sroa.0490.sroa.12.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0484.sroa.16.sroa.16, i64 7, i1 false), !dbg !667
  %.sroa.2491.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !667
  store float %.sroa.8.0, ptr %.sroa.2491.0.sret_return.sroa_idx, align 8, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.3492.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !667
  store i32 %.sroa.10.0, ptr %.sroa.3492.0.sret_return.sroa_idx, align 4, !dbg !667, !tbaa !288, !alias.scope !290, !noalias !291
  %.sroa.4493.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !667
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.4493.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8489, i64 56, i1 false), !dbg !667
  store ptr %5, ptr %return_roots, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %332 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !667
  store ptr %7, ptr %332, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %333 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !667
  store ptr %9, ptr %333, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %334 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !667
  store ptr %11, ptr %334, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %335 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !667
  store ptr %13, ptr %335, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %336 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !667
  store ptr %15, ptr %336, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %337 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !667
  store ptr %17, ptr %337, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %338 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !667
  store ptr %19, ptr %338, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %339 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !667
  store ptr %21, ptr %339, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %340 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !667
  store ptr %23, ptr %340, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %341 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !667
  store ptr %25, ptr %341, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %342 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !667
  store ptr %27, ptr %342, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %343 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !667
  store ptr %29, ptr %343, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %344 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !667
  store ptr %31, ptr %344, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %345 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !667
  store ptr %33, ptr %345, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %346 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !667
  store ptr %35, ptr %346, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %347 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !667
  store ptr %37, ptr %347, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %348 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !667
  store ptr %39, ptr %348, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %349 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !667
  store ptr %41, ptr %349, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %350 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !667
  store ptr %43, ptr %350, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %351 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !667
  store ptr %45, ptr %351, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %352 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !667
  store ptr %47, ptr %352, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %353 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !667
  store ptr %49, ptr %353, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %354 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !667
  store ptr %51, ptr %354, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %355 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !667
  store ptr %53, ptr %355, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %356 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !667
  store ptr %55, ptr %356, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %357 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !667
  store ptr %57, ptr %357, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %358 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !667
  store ptr %59, ptr %358, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %359 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !667
  store ptr %61, ptr %359, align 8, !dbg !667, !tbaa !156, !alias.scope !161, !noalias !164
  %frame.prev1185 = load ptr, ptr %frame.prev, align 8, !tbaa !156
  store ptr %frame.prev1185, ptr %pgcstack, align 8, !tbaa !156
  ret void, !dbg !667

guard_pass425:                                    ; preds = %L133
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !233
  store float %100, ptr %unionalloca.sroa.0, align 8, !dbg !233, !tbaa !288, !alias.scope !290, !noalias !291
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload524856 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !347
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !347
  %360 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload524856 to i32, !dbg !692
  %361 = bitcast i32 %360 to float, !dbg !692
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10719), !dbg !233
  br label %L264, !dbg !233

guard_pass430:                                    ; preds = %L218, %L216
  %value_phi377 = phi double [ %126, %L216 ], [ %spec.select448, %L218 ]
  %362 = fcmp ugt double %value_phi377, 2.000000e+00, !dbg !694
  %363 = fadd double %value_phi377, -1.000000e+00, !dbg !697
  %364 = fadd double %value_phi377, -2.000000e+00, !dbg !697
  %365 = fsub double 1.000000e+00, %364, !dbg !697
  %value_phi379 = select i1 %362, double %365, double %363, !dbg !697
  %366 = fptrunc double %value_phi379 to float, !dbg !698
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10719), !dbg !233
  br label %L264, !dbg !233

guard_pass435:                                    ; preds = %L554
  %367 = load ptr, ptr %root_phi25.state114, align 8, !dbg !700, !tbaa !325, !alias.scope !328, !noalias !329
  %368 = getelementptr i8, ptr %367, i64 %memoryref_offset, !dbg !702
  %memoryref_data131 = getelementptr i8, ptr %368, i64 -4, !dbg !702
  store float %.sroa.7713.0, ptr %memoryref_data131, align 4, !dbg !702, !tbaa !333, !alias.scope !184, !noalias !185
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !233
  br label %L639, !dbg !233

guard_pass440:                                    ; preds = %L552
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !233
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !233, !tbaa !288, !alias.scope !290, !noalias !291
  br label %L639, !dbg !233
}
