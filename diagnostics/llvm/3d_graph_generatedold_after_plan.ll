; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}}, nothing}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf52117d2af634fce9405ada0794ac1ae))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.GeneratedOld)
define swiftcc void @julia_loop_9451(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [1 x ptr]], ptr }, [1 x ptr], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(384) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(232) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(560) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(432) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(384) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [18 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 144, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 14
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 8
  %2 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %3 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.111014 = alloca [7 x i8], align 1
  %.sroa.101008 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple43" = alloca [1 x i64], align 8
  %.sroa.6986 = alloca [7 x i8], align 1
  %.sroa.10997 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext.sroa.7" = alloca [7 x i64], align 8
  %4 = alloca [48 x i64], align 8
  %"new::SamplerRangeNDL126" = alloca [2 x i64], align 8
  %unionalloca154.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.10931 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1163" = alloca [5 x i64], align 8
  %"new::Tuple186" = alloca [1 x i64], align 8
  %.sroa.6878 = alloca [7 x i8], align 1
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple218.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple218.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext219.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext221.sroa.6" = alloca [7 x i64], align 8
  %.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0.sroa.12 = alloca [8 x i64], align 8
  %.sroa.0.sroa.13 = alloca [4 x i64], align 8
  %.sroa.0.sroa.18.sroa.18 = alloca [7 x i8], align 1
  %.sroa.12 = alloca [7 x i64], align 8
  %.sroa.0663.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0663.sroa.12 = alloca [4 x i64], align 8
  %.sroa.0663.sroa.14 = alloca [8 x i64], align 8
  %.sroa.0663.sroa.16 = alloca [4 x i64], align 8
  %.sroa.0663.sroa.26.sroa.11 = alloca [7 x i8], align 1
  %.sroa.8669 = alloca [7 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4" = alloca [4 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5" = alloca [8 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6" = alloca [4 x i64], align 8
  %"new::Tuple390" = alloca [1 x i64], align 8
  %"new::Tuple393" = alloca [1 x i64], align 8
  %"new::Tuple395" = alloca [1 x i64], align 8
  %"new::Tuple463" = alloca [1 x i64], align 8
  %"new::Tuple466" = alloca [1 x i64], align 8
  %"new::Tuple468" = alloca [1 x i64], align 8
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
  store i8 1, ptr @"jl_global#9454.jit", align 64, !dbg !171, !tbaa !186, !alias.scope !189, !noalias !190
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !191
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !191, !tbaa !156, !alias.scope !161, !noalias !164
  %66 = sext i16 %thread_id to i64, !dbg !195
  %67 = add nsw i64 %66, 1, !dbg !200
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !202
  store i64 %67, ptr %"process::Process.threadid_ptr", align 8, !dbg !202, !tbaa !203, !alias.scope !189, !noalias !190
  %68 = call i64 @jlplt_ijl_hrtime_9456_got.jit(), !dbg !205
  %"process::Process.starttime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 504, !dbg !211
  %"process::Process.starttime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 512, !dbg !211
  store i8 2, ptr %"process::Process.starttime.tindex_ptr", align 1, !dbg !211, !tbaa !203, !alias.scope !189, !noalias !190
  store i64 %68, ptr %"process::Process.starttime_ptr", align 8, !dbg !211, !tbaa !203, !alias.scope !189, !noalias !190
  %69 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 136, !dbg !212
  %70 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !212
  %.stop_ptr = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 144, !dbg !240
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !263, !tbaa !169, !alias.scope !268, !noalias !269
  %.unbox = load i64, ptr %69, align 8, !dbg !263, !tbaa !270, !alias.scope !271, !noalias !272
  %.not = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !263
  br i1 %.not, label %L34, label %L37, !dbg !246

L34:                                              ; preds = %top
  %71 = call swiftcc [1 x ptr] @j_ArgumentError_9457(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9458.jit"), !dbg !246
  %gc_slot_addr_14 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  %72 = extractvalue [1 x ptr] %71, 0, !dbg !246
  store ptr %72, ptr %gc_slot_addr_14, align 8
  %ptls_load1285 = load ptr, ptr %ptls_field, align 8, !dbg !246, !tbaa !156
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1285, i32 424, i32 16, i64 4887103472) #23, !dbg !246
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !246
  store atomic i64 4887103472, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !246, !tbaa !273
  store ptr %72, ptr %"box::ArgumentError", align 8, !dbg !246, !tbaa !275, !alias.scope !189, !noalias !190
  store ptr null, ptr %gc_slot_addr_14, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !246
  unreachable, !dbg !246

L37:                                              ; preds = %top
  %73 = add i64 %.stop_ptr.unbox, 1, !dbg !277
  %74 = sub i64 %73, %.unbox, !dbg !280
  store i64 %.unbox, ptr %"new::SamplerRangeNDL", align 8, !dbg !281, !tbaa !270, !alias.scope !271, !noalias !272
  %75 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8, !dbg !281
  store i64 %74, ptr %75, align 8, !dbg !281, !tbaa !283, !alias.scope !285, !noalias !286
  %76 = call swiftcc i64 @j_rand_9460(ptr nonnull swiftself %pgcstack, ptr %49, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !254
  %.fr1105 = freeze i64 %76
  %.state = load atomic ptr, ptr %47 unordered, align 8, !dbg !287, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %.state.size_ptr = getelementptr inbounds i8, ptr %.state, i64 16, !dbg !294
  %.state.size.0.copyload = load i64, ptr %.state.size_ptr, align 8, !dbg !294, !tbaa !270, !alias.scope !300, !noalias !301
  %.not689 = icmp eq i64 %.state.size.0.copyload, 100000, !dbg !302
  br i1 %.not689, label %L63, label %L58, !dbg !297

L58:                                              ; preds = %L37
  call swiftcc void @j_throw_dmrsa_9461(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %.state.size.0.copyload) #8, !dbg !307
  unreachable, !dbg !307

L63:                                              ; preds = %L37
  %77 = load ptr, ptr %.state, align 8, !dbg !308, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_offset = shl i64 %.fr1105, 2, !dbg !315
  %78 = getelementptr i8, ptr %77, i64 %memoryref_offset, !dbg !315
  %memoryref_data11 = getelementptr i8, ptr %78, i64 -4, !dbg !315
  %79 = load float, ptr %memoryref_data11, align 4, !dbg !315, !tbaa !318, !alias.scope !189, !noalias !190
  %80 = icmp slt i64 %.fr1105, 100001
  %81 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 272, !dbg !320
  br i1 %80, label %L109, label %L222, !dbg !324

L109:                                             ; preds = %L63
  %.unbox15 = load double, ptr %81, align 8, !dbg !330, !tbaa !169, !alias.scope !268, !noalias !269
  %82 = call double @llvm.fabs.f64(double %.unbox15), !dbg !330
  %83 = fcmp oeq double %.unbox15, 0.000000e+00, !dbg !340
  br i1 %83, label %guard_pass548, label %L114, !dbg !342

L114:                                             ; preds = %L109
  %.idxF_ptr472 = getelementptr inbounds i8, ptr %49, i64 32, !dbg !343
  %.idxF473 = load i64, ptr %.idxF_ptr472, align 8, !dbg !343, !tbaa !203, !alias.scope !189, !noalias !190
  %.not694 = icmp eq i64 %.idxF473, 1002, !dbg !362
  br i1 %.not694, label %L117, label %L119, !dbg !347

L117:                                             ; preds = %L114
  %84 = call swiftcc i64 @j_gen_rand_9469(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !347
  %.idxF477.pre = load i64, ptr %.idxF_ptr472, align 8, !dbg !363, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L119, !dbg !347

L119:                                             ; preds = %L117, %L114
  %.idxF477 = phi i64 [ %.idxF473, %L114 ], [ %.idxF477.pre, %L117 ], !dbg !363
  %.vals_ptr474 = getelementptr inbounds i8, ptr %49, i64 16, !dbg !363
  %.vals475 = load atomic ptr, ptr %.vals_ptr474 unordered, align 8, !dbg !363, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %85 = add i64 %.idxF477, 1, !dbg !370
  store i64 %85, ptr %.idxF_ptr472, align 8, !dbg !371, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data480 = load ptr, ptr %.vals475, align 8, !dbg !372, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset483 = shl i64 %.idxF477, 3, !dbg !372
  %memoryref_data488 = getelementptr inbounds i8, ptr %memoryref_data480, i64 %memoryref_byteoffset483, !dbg !372
  %86 = load i64, ptr %memoryref_data488, align 8, !dbg !372, !tbaa !318, !alias.scope !189, !noalias !190
  %87 = trunc i64 %86 to i32, !dbg !373
  %88 = and i32 %87, 8388607, !dbg !374
  %89 = or disjoint i32 %88, 1065353216, !dbg !376
  %bitcast_coercion490 = bitcast i32 %89 to float, !dbg !378
  %90 = fadd float %bitcast_coercion490, -1.000000e+00, !dbg !380
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
  br i1 %or.cond, label %L179, label %L175, !dbg !414

L175:                                             ; preds = %L119
  %102 = call swiftcc double @j_rem_internal_9473(ptr nonnull swiftself %pgcstack, double %101, double 4.000000e+00), !dbg !425
  %103 = call double @llvm.copysign.f64(double %102, double %97), !dbg !426
  br label %L187, !dbg !429

L179:                                             ; preds = %L119
  %104 = bitcast double %101 to i64, !dbg !432
  %.not695 = icmp eq i64 %104, 9218868437227405312, !dbg !432
  br i1 %.not695, label %L194, label %L187, !dbg !434

L187:                                             ; preds = %L179, %L175
  %value_phi491 = phi double [ %103, %L175 ], [ %97, %L179 ]
  %105 = fcmp une double %value_phi491, 0.000000e+00, !dbg !435
  br i1 %105, label %L194, label %L192, !dbg !437

L192:                                             ; preds = %L187
  %106 = call double @llvm.fabs.f64(double %value_phi491), !dbg !438
  br label %guard_pass553, !dbg !429

L194:                                             ; preds = %L187, %L179
  %value_phi491731 = phi double [ %value_phi491, %L187 ], [ 0x7FF8000000000000, %L179 ]
  %107 = fcmp ogt double %value_phi491731, 0.000000e+00, !dbg !440
  %108 = fadd double %value_phi491731, 4.000000e+00
  %spec.select625 = select i1 %107, double %value_phi491731, double %108, !dbg !444
  br label %guard_pass553, !dbg !444

L222:                                             ; preds = %L63
  %jl_nothing498 = load ptr, ptr @jl_nothing, align 8, !dbg !445, !tbaa !169, !invariant.load !0, !alias.scope !268, !noalias !269, !nonnull !0
  %box_Float32499 = call ptr @ijl_box_float32(float %79), !dbg !445
  %gc_slot_addr_15 = getelementptr inbounds ptr, ptr %gcframe2, i64 17
  store ptr %box_Float32499, ptr %gc_slot_addr_15, align 8
  %ptls_load1290 = load ptr, ptr %ptls_field, align 8, !dbg !445, !tbaa !156
  %"box::Float64503" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1290, i32 424, i32 16, i64 4887683216) #23, !dbg !445
  %"box::Float64503.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64503", i64 -1, !dbg !445
  store atomic i64 4887683216, ptr %"box::Float64503.tag_addr" unordered, align 8, !dbg !445, !tbaa !273
  %109 = load i64, ptr %81, align 8, !dbg !445, !tbaa !270, !alias.scope !448, !noalias !449
  store i64 %109, ptr %"box::Float64503", align 8, !dbg !445, !tbaa !270, !alias.scope !448, !noalias !449
  %gc_slot_addr_141268 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  store ptr %"box::Float64503", ptr %gc_slot_addr_141268, align 8
  store ptr @"jl_global#9474.jit", ptr %jlcallframe1, align 8, !dbg !445
  %110 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !445
  store ptr %49, ptr %110, align 8, !dbg !445
  %111 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !445
  store ptr %jl_nothing498, ptr %111, align 8, !dbg !445
  %112 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !445
  store ptr %box_Float32499, ptr %112, align 8, !dbg !445
  %113 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !445
  store ptr %"box::Float64503", ptr %113, align 8, !dbg !445
  %jl_f_throw_methoderror_ret504 = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !445
  call void @llvm.trap(), !dbg !445
  unreachable, !dbg !445

L240:                                             ; preds = %guard_pass553, %guard_pass548
  %.sroa.71002.0 = phi float [ %476, %guard_pass548 ], [ %481, %guard_pass553 ], !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111014, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.101008, i64 7, i1 false), !dbg !450
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.101008), !dbg !450
  %114 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8, !dbg !451
  store i64 %.fr1105, ptr %114, align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !451
  store float %79, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !451
  store float %.sroa.71002.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !451
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !451
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !451, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !451
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111014, i64 7, i1 false), !dbg !451
  %115 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 40, !dbg !455
  %116 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !455
  %.state21 = load atomic ptr, ptr %9 unordered, align 8, !dbg !463, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %117 = add i64 %.fr1105, -1, !dbg !474
  %.size_ptr = getelementptr inbounds i8, ptr %11, i64 16, !dbg !476
  %.size.0.copyload = load i64, ptr %.size_ptr, align 8, !dbg !476, !tbaa !270, !alias.scope !300, !noalias !301
  %.not696 = icmp ult i64 %117, %.size.0.copyload, !dbg !474
  br i1 %.not696, label %L298, label %L295, !dbg !474

L295:                                             ; preds = %L240
  store i64 %.fr1105, ptr %"new::Tuple468", align 8, !dbg !474, !tbaa !283, !alias.scope !285, !noalias !286
  call swiftcc void @j_throw_boundserror_9471(ptr nonnull swiftself %pgcstack, ptr %11, ptr nocapture nonnull readonly %"new::Tuple468") #8, !dbg !474
  unreachable, !dbg !474

L298:                                             ; preds = %L240
  %memoryref_data22 = load ptr, ptr %11, align 8, !dbg !477, !tbaa !310, !alias.scope !313, !noalias !314
  %118 = getelementptr i8, ptr %memoryref_data22, i64 %memoryref_offset, !dbg !477
  %memoryref_data30 = getelementptr i8, ptr %118, i64 -4, !dbg !477
  %119 = load float, ptr %memoryref_data30, align 4, !dbg !477, !tbaa !318, !alias.scope !189, !noalias !190
  %120 = fpext float %.sroa.71002.0 to double, !dbg !478
  %gc_slot_addr_141269 = getelementptr inbounds ptr, ptr %gcframe2, i64 16
  store ptr %.state21, ptr %gc_slot_addr_141269, align 8
  %121 = call swiftcc double @"j_#power_by_squaring#401_9464"(ptr nonnull swiftself %pgcstack, double %120, i64 signext 2), !dbg !485
  %.state21.size_ptr = getelementptr inbounds i8, ptr %.state21, i64 16, !dbg !476
  %.state21.size.0.copyload = load i64, ptr %.state21.size_ptr, align 8, !dbg !476, !tbaa !270, !alias.scope !300, !noalias !301
  %.not697 = icmp ult i64 %117, %.state21.size.0.copyload, !dbg !474
  br i1 %.not697, label %L323, label %L320, !dbg !474

L320:                                             ; preds = %L298
  store i64 %.fr1105, ptr %"new::Tuple466", align 8, !dbg !474, !tbaa !283, !alias.scope !285, !noalias !286
  call swiftcc void @j_throw_boundserror_9471(ptr nonnull swiftself %pgcstack, ptr nonnull %.state21, ptr nocapture nonnull readonly %"new::Tuple466") #8, !dbg !474
  unreachable, !dbg !474

L323:                                             ; preds = %L298
  %122 = fptrunc double %121 to float, !dbg !488
  %memoryref_data32 = load ptr, ptr %.state21, align 8, !dbg !477, !tbaa !310, !alias.scope !313, !noalias !314
  %123 = getelementptr i8, ptr %memoryref_data32, i64 %memoryref_offset, !dbg !477
  %memoryref_data40 = getelementptr i8, ptr %123, i64 -4, !dbg !477
  %124 = load float, ptr %memoryref_data40, align 4, !dbg !477, !tbaa !318, !alias.scope !189, !noalias !190
  %125 = fpext float %124 to double, !dbg !478
  store ptr null, ptr %gc_slot_addr_141269, align 8
  %126 = call swiftcc double @"j_#power_by_squaring#401_9464"(ptr nonnull swiftself %pgcstack, double %125, i64 signext 2), !dbg !485
  %127 = fptrunc double %126 to float, !dbg !488
  %128 = fsub float %122, %127, !dbg !493
  %129 = fmul float %119, 0.000000e+00, !dbg !494
  %130 = fmul float %129, %128, !dbg !494
  %131 = fadd float %130, 0.000000e+00, !dbg !497
  store ptr %9, ptr %3, align 8, !dbg !471
  store ptr %17, ptr %2, align 8, !dbg !471
  %132 = getelementptr inbounds ptr, ptr %gcframe2, i64 4, !dbg !471
  store ptr %19, ptr %132, align 8, !dbg !471
  %133 = getelementptr inbounds ptr, ptr %gcframe2, i64 5, !dbg !471
  store ptr %21, ptr %133, align 8, !dbg !471
  %134 = getelementptr inbounds ptr, ptr %gcframe2, i64 6, !dbg !471
  store ptr %23, ptr %134, align 8, !dbg !471
  %135 = getelementptr inbounds ptr, ptr %gcframe2, i64 7, !dbg !471
  store ptr %25, ptr %135, align 8, !dbg !471
  %136 = call swiftcc float @"j_#calculate##0_9465"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %3, float %131, ptr nocapture nonnull readonly %115, ptr nocapture nonnull readonly %2), !dbg !471
  %.state41 = load atomic ptr, ptr %9 unordered, align 8, !dbg !498, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %.unbox42 = load float, ptr %116, align 4, !dbg !502, !tbaa !169, !alias.scope !268, !noalias !269
  %137 = fneg float %.unbox42, !dbg !502
  store i64 %.fr1105, ptr %"new::Tuple43", align 8, !dbg !504, !tbaa !283, !alias.scope !285, !noalias !286
  %138 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !507
  %bitcast44 = load i64, ptr %138, align 8, !dbg !520, !tbaa !169, !alias.scope !268, !noalias !269
  %.not698 = icmp ult i64 %117, %bitcast44, !dbg !525
  br i1 %.not698, label %L381, label %L378, !dbg !519

L378:                                             ; preds = %L323
  %139 = getelementptr inbounds ptr, ptr %gcframe2, i64 13
  %140 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !526
  store ptr %27, ptr %139, align 8, !dbg !519
  call swiftcc void @j_throw_boundserror_9472(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %140, ptr nocapture nonnull readonly %139, ptr nocapture nonnull readonly %"new::Tuple43") #8, !dbg !519
  unreachable, !dbg !519

L381:                                             ; preds = %L323
  %.state41.size_ptr = getelementptr inbounds i8, ptr %.state41, i64 16, !dbg !531
  %.state41.size.0.copyload = load i64, ptr %.state41.size_ptr, align 8, !dbg !531, !tbaa !270, !alias.scope !300, !noalias !301
  %.not699 = icmp ult i64 %117, %.state41.size.0.copyload, !dbg !532
  br i1 %.not699, label %L398, label %L395, !dbg !532

L395:                                             ; preds = %L381
  store i64 %.fr1105, ptr %"new::Tuple463", align 8, !dbg !532, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %.state41, ptr %gc_slot_addr_141269, align 8
  call swiftcc void @j_throw_boundserror_9471(ptr nonnull swiftself %pgcstack, ptr nonnull %.state41, ptr nocapture nonnull readonly %"new::Tuple463") #8, !dbg !532
  unreachable, !dbg !532

L398:                                             ; preds = %L381
  %.x = load float, ptr %27, align 4, !dbg !533, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data46 = load ptr, ptr %.state41, align 8, !dbg !537, !tbaa !310, !alias.scope !313, !noalias !314
  %141 = getelementptr i8, ptr %memoryref_data46, i64 %memoryref_offset, !dbg !537
  %memoryref_data54 = getelementptr i8, ptr %141, i64 -4, !dbg !537
  %142 = load float, ptr %memoryref_data54, align 4, !dbg !537, !tbaa !318, !alias.scope !189, !noalias !190
  %143 = fsub float %.sroa.71002.0, %142, !dbg !538
  %144 = fmul float %.x, %137, !dbg !539
  %145 = fmul float %144, %143, !dbg !539
  %146 = fadd float %136, %145, !dbg !497
  %147 = fcmp ugt float %146, 0.000000e+00, !dbg !541
  br i1 %147, label %L413, label %L530, !dbg !543

L413:                                             ; preds = %L398
  %.idxF_ptr = getelementptr inbounds i8, ptr %49, i64 32, !dbg !544
  %.idxF = load i64, ptr %.idxF_ptr, align 8, !dbg !544, !tbaa !203, !alias.scope !189, !noalias !190
  %.not700 = icmp eq i64 %.idxF, 1002, !dbg !557
  br i1 %.not700, label %L416, label %L418, !dbg !546

L416:                                             ; preds = %L413
  %148 = call swiftcc i64 @j_gen_rand_9469(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !546
  %.idxF438.pre = load i64, ptr %.idxF_ptr, align 8, !dbg !558, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L418, !dbg !546

L418:                                             ; preds = %L416, %L413
  %.idxF438 = phi i64 [ %.idxF, %L413 ], [ %.idxF438.pre, %L416 ], !dbg !558
  %.vals_ptr = getelementptr inbounds i8, ptr %49, i64 16, !dbg !558
  %.vals = load atomic ptr, ptr %.vals_ptr unordered, align 8, !dbg !558, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %149 = add i64 %.idxF438, 1, !dbg !563
  store i64 %149, ptr %.idxF_ptr, align 8, !dbg !564, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data441 = load ptr, ptr %.vals, align 8, !dbg !565, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset444 = shl i64 %.idxF438, 3, !dbg !565
  %memoryref_data449 = getelementptr inbounds i8, ptr %memoryref_data441, i64 %memoryref_byteoffset444, !dbg !565
  %150 = load i64, ptr %memoryref_data449, align 8, !dbg !565, !tbaa !318, !alias.scope !189, !noalias !190
  %151 = trunc i64 %150 to i32, !dbg !566
  %152 = and i32 %151, 8388607, !dbg !567
  %153 = or disjoint i32 %152, 1065353216, !dbg !568
  %bitcast_coercion451 = bitcast i32 %153 to float, !dbg !569
  %154 = fadd float %bitcast_coercion451, -1.000000e+00, !dbg !570
  %155 = fneg float %146, !dbg !572
  %.unbox452 = load float, ptr %70, align 4, !dbg !573
  %156 = fdiv float %155, %.unbox452, !dbg !573
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
  %180 = bitcast float %.unbox452 to i32, !dbg !603
  br i1 %179, label %L477, label %L528, !dbg !603

L477:                                             ; preds = %L418
  %181 = fcmp uge float %156, 0xC059FE3680000000, !dbg !604
  br i1 %181, label %L521, label %L528, !dbg !605

L521:                                             ; preds = %L477
  %182 = fcmp ugt float %156, 0xC055D58A00000000, !dbg !606
  %183 = fmul float %178, 0x3E70000000000000, !dbg !607
  %value_phi455 = select i1 %182, float %178, float %183, !dbg !607
  %.not701 = icmp eq i32 %160, 128, !dbg !608
  %184 = fmul float %value_phi455, 2.000000e+00, !dbg !610
  %value_phi457 = select i1 %.not701, float %184, float %value_phi455, !dbg !610
  %value_phi454.v = select i1 %182, i32 127, i32 151, !dbg !607
  %value_phi454 = add i32 %160, %value_phi454.v, !dbg !607
  %185 = sext i1 %.not701 to i32, !dbg !610
  %value_phi456 = add i32 %value_phi454, %185, !dbg !610
  %186 = shl i32 %value_phi456, 23, !dbg !611
  %bitcast_coercion460 = bitcast i32 %186 to float, !dbg !617
  %187 = fmul float %value_phi457, %bitcast_coercion460, !dbg !618
  br label %L528, !dbg !429

L528:                                             ; preds = %L521, %L477, %L418
  %value_phi453 = phi float [ %187, %L521 ], [ 0x7FF0000000000000, %L418 ], [ 0.000000e+00, %L477 ]
  %188 = fcmp olt float %154, %value_phi453, !dbg !619
  br i1 %188, label %L530, label %guard_pass563, !dbg !543

L530:                                             ; preds = %L528, %L398
  %.state56 = load atomic ptr, ptr %47 unordered, align 8, !dbg !620, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %.state56.size_ptr = getelementptr inbounds i8, ptr %.state56, i64 16, !dbg !626
  %.state56.size.0.copyload = load i64, ptr %.state56.size_ptr, align 8, !dbg !626, !tbaa !270, !alias.scope !300, !noalias !301
  %.not702 = icmp eq i64 %.state56.size.0.copyload, 100000, !dbg !628
  br i1 %.not702, label %guard_pass558, label %L538, !dbg !627

L538:                                             ; preds = %L530
  call swiftcc void @j_throw_dmrsa_9461(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %.state56.size.0.copyload) #8, !dbg !630
  unreachable, !dbg !630

L639.L1272_crit_edge:                             ; preds = %pass78
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6986, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.7", i64 56, i1 false), !dbg !631
  br label %L1272, !dbg !631

L639.L643_crit_edge:                              ; preds = %pass78
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %4, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !632
  %.sroa.0682.sroa.8.0..sroa_idx939 = getelementptr inbounds i8, ptr %4, i64 96, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %.sroa.0682.sroa.8.0..sroa_idx939, align 8, !dbg !632
  %.sroa.0682.sroa.9.0..sroa_idx942 = getelementptr inbounds i8, ptr %4, i64 104, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.3.8.copyload", ptr %.sroa.0682.sroa.9.0..sroa_idx942, align 8, !dbg !632
  %.sroa.0682.sroa.10.0..sroa_idx945 = getelementptr inbounds i8, ptr %4, i64 112, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %.sroa.0682.sroa.10.0..sroa_idx945, align 8, !dbg !632
  %.sroa.0682.sroa.11.0..sroa_idx947 = getelementptr inbounds i8, ptr %4, i64 120, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0682.sroa.11.0..sroa_idx947, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !632
  %.sroa.0682.sroa.12.0..sroa_idx948 = getelementptr inbounds i8, ptr %4, i64 152, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0682.sroa.12.0..sroa_idx948, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !632
  %.sroa.0682.sroa.13.0..sroa_idx949 = getelementptr inbounds i8, ptr %4, i64 216, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0682.sroa.13.0..sroa_idx949, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !632
  %.sroa.0682.sroa.14.0..sroa_idx951 = getelementptr inbounds i8, ptr %4, i64 248, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.9.128.copyload", ptr %.sroa.0682.sroa.14.0..sroa_idx951, align 8, !dbg !632
  %.sroa.0682.sroa.15.0..sroa_idx954 = getelementptr inbounds i8, ptr %4, i64 256, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.10.128.copyload", ptr %.sroa.0682.sroa.15.0..sroa_idx954, align 8, !dbg !632
  %.sroa.0682.sroa.16.0..sroa_idx957 = getelementptr inbounds i8, ptr %4, i64 264, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.11.128.copyload", ptr %.sroa.0682.sroa.16.0..sroa_idx957, align 8, !dbg !632
  %.sroa.0682.sroa.17.0..sroa_idx960 = getelementptr inbounds i8, ptr %4, i64 272, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload", ptr %.sroa.0682.sroa.17.0..sroa_idx960, align 8, !dbg !632
  %.sroa.0682.sroa.19.0..sroa_idx966 = getelementptr inbounds i8, ptr %4, i64 288, !dbg !632
  store i64 %.fr1105, ptr %.sroa.0682.sroa.19.0..sroa_idx966, align 8, !dbg !632
  %.sroa.0682.sroa.20.0..sroa_idx969 = getelementptr inbounds i8, ptr %4, i64 296, !dbg !632
  store float %79, ptr %.sroa.0682.sroa.20.0..sroa_idx969, align 8, !dbg !632
  %.sroa.0682.sroa.21.0..sroa_idx972 = getelementptr inbounds i8, ptr %4, i64 300, !dbg !632
  store float %.sroa.71002.0, ptr %.sroa.0682.sroa.21.0..sroa_idx972, align 4, !dbg !632
  %.sroa.0682.sroa.22.0..sroa_idx975 = getelementptr inbounds i8, ptr %4, i64 304, !dbg !632
  store i64 1, ptr %.sroa.0682.sroa.22.0..sroa_idx975, align 8, !dbg !632
  %.sroa.0682.sroa.23.0..sroa_idx978 = getelementptr inbounds i8, ptr %4, i64 312, !dbg !632
  store i8 %.sroa.9995.0, ptr %.sroa.0682.sroa.23.0..sroa_idx978, align 8, !dbg !632
  %.sroa.0682.sroa.24.0..sroa_idx980 = getelementptr inbounds i8, ptr %4, i64 313, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0682.sroa.24.0..sroa_idx980, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6986, i64 7, i1 false), !dbg !632
  %.sroa.6683.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 320, !dbg !632
  store float %146, ptr %.sroa.6683.0..sroa_idx, align 8, !dbg !632
  %.sroa.7685.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 324, !dbg !632
  store i32 %"new::NamedTuple.sroa.6.316.copyload", ptr %.sroa.7685.0..sroa_idx, align 4, !dbg !632
  %.sroa.8687.0..sroa_idx = getelementptr inbounds i8, ptr %4, i64 328, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8687.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext.sroa.7", i64 56, i1 false), !dbg !632
  %189 = getelementptr inbounds i8, ptr %4, i64 136, !dbg !633
  %.stop_ptr115 = getelementptr inbounds i8, ptr %4, i64 144, !dbg !647
  %.stop_ptr115.unbox795 = load i64, ptr %.stop_ptr115, align 8, !dbg !657, !tbaa !283, !alias.scope !285, !noalias !286
  %.unbox116796 = load i64, ptr %189, align 8, !dbg !657, !tbaa !283, !alias.scope !285, !noalias !286
  %.not706797 = icmp slt i64 %.stop_ptr115.unbox795, %.unbox116796, !dbg !657
  %190 = bitcast i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload" to double, !dbg !650
  %191 = trunc i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload" to i32, !dbg !650
  %192 = bitcast i32 %191 to float, !dbg !650
  br i1 %.not706797, label %L670, label %L673.lr.ph, !dbg !650

L673.lr.ph:                                       ; preds = %L639.L643_crit_edge
  %193 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL126", i64 8
  %root_phi107.idxF_ptr399 = getelementptr inbounds i8, ptr %49, i64 32
  %root_phi107.vals_ptr401 = getelementptr inbounds i8, ptr %49, i64 16
  %194 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1163", i64 8
  %195 = getelementptr inbounds i8, ptr %4, i64 40
  %196 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %197 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  %198 = getelementptr inbounds ptr, ptr %gcframe2, i64 11
  %199 = getelementptr inbounds ptr, ptr %gcframe2, i64 12
  %200 = getelementptr inbounds i8, ptr %4, i64 16
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496
  %"new::Tuple186.promoted" = load i64, ptr %"new::Tuple186", align 1, !tbaa !283, !alias.scope !285, !noalias !286
  br label %L673, !dbg !650

L670:                                             ; preds = %L1271, %L639.L643_crit_edge
  %201 = call swiftcc [1 x ptr] @j_ArgumentError_9457(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9458.jit"), !dbg !650
  %202 = extractvalue [1 x ptr] %201, 0, !dbg !650
  store ptr %202, ptr %gc_slot_addr_141269, align 8
  %ptls_load1297 = load ptr, ptr %ptls_field, align 8, !dbg !650, !tbaa !156
  %"box::ArgumentError121" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1297, i32 424, i32 16, i64 4887103472) #23, !dbg !650
  %"box::ArgumentError121.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError121", i64 -1, !dbg !650
  store atomic i64 4887103472, ptr %"box::ArgumentError121.tag_addr" unordered, align 8, !dbg !650, !tbaa !273
  store ptr %202, ptr %"box::ArgumentError121", align 8, !dbg !650, !tbaa !275, !alias.scope !189, !noalias !190
  store ptr null, ptr %gc_slot_addr_141269, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError121"), !dbg !650
  unreachable, !dbg !650

L673:                                             ; preds = %L1271, %L673.lr.ph
  %203 = phi i64 [ %"new::Tuple186.promoted", %L673.lr.ph ], [ %.fr, %L1271 ]
  %.unbox116800 = phi i64 [ %.unbox116796, %L673.lr.ph ], [ %.unbox116, %L1271 ]
  %.stop_ptr115.unbox799 = phi i64 [ %.stop_ptr115.unbox795, %L673.lr.ph ], [ %.stop_ptr115.unbox, %L1271 ]
  %value_phi86798 = phi i64 [ %468, %L673.lr.ph ], [ %307, %L1271 ]
  %.unbox379 = bitcast i32 %"new::NamedTuple.sroa.6.316.copyload" to float, !dbg !650
  %204 = add i64 %.stop_ptr115.unbox799, 1, !dbg !659
  %205 = sub i64 %204, %.unbox116800, !dbg !661
  store i64 %.unbox116800, ptr %"new::SamplerRangeNDL126", align 8, !dbg !662, !tbaa !283, !alias.scope !285, !noalias !286
  store i64 %205, ptr %193, align 8, !dbg !662, !tbaa !283, !alias.scope !285, !noalias !286
  %206 = call swiftcc i64 @j_rand_9460(ptr nonnull swiftself %pgcstack, ptr %49, ptr nocapture nonnull readonly %"new::SamplerRangeNDL126"), !dbg !653
  %.fr = freeze i64 %206
  %root_phi106.state = load atomic ptr, ptr %47 unordered, align 8, !dbg !664, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %root_phi106.state.size_ptr = getelementptr inbounds i8, ptr %root_phi106.state, i64 16, !dbg !667
  %root_phi106.state.size.0.copyload = load i64, ptr %root_phi106.state.size_ptr, align 8, !dbg !667, !tbaa !270, !alias.scope !300, !noalias !301
  %.not707 = icmp eq i64 %root_phi106.state.size.0.copyload, 100000, !dbg !669
  br i1 %.not707, label %L699, label %L694, !dbg !668

L694:                                             ; preds = %L673
  call swiftcc void @j_throw_dmrsa_9461(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi106.state.size.0.copyload) #8, !dbg !671
  unreachable, !dbg !671

L699:                                             ; preds = %L673
  %207 = load ptr, ptr %root_phi106.state, align 8, !dbg !672, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_offset137 = shl i64 %.fr, 2, !dbg !674
  %208 = getelementptr i8, ptr %207, i64 %memoryref_offset137, !dbg !674
  %memoryref_data143 = getelementptr i8, ptr %208, i64 -4, !dbg !674
  %209 = load float, ptr %memoryref_data143, align 4, !dbg !674, !tbaa !318, !alias.scope !189, !noalias !190
  %210 = icmp slt i64 %.fr, 100001
  br i1 %210, label %L745, label %L858, !dbg !676

L745:                                             ; preds = %L699
  %211 = call double @llvm.fabs.f64(double %190), !dbg !679
  %212 = fcmp oeq double %190, 0.000000e+00, !dbg !685
  br i1 %212, label %guard_pass600, label %L750, !dbg !686

L750:                                             ; preds = %L745
  %root_phi107.idxF400 = load i64, ptr %root_phi107.idxF_ptr399, align 8, !dbg !687, !tbaa !203, !alias.scope !189, !noalias !190
  %.not712 = icmp eq i64 %root_phi107.idxF400, 1002, !dbg !701
  br i1 %.not712, label %L753, label %L755, !dbg !689

L753:                                             ; preds = %L750
  %213 = call swiftcc i64 @j_gen_rand_9469(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !689
  %root_phi107.idxF404.pre = load i64, ptr %root_phi107.idxF_ptr399, align 8, !dbg !702, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L755, !dbg !689

L755:                                             ; preds = %L753, %L750
  %root_phi107.idxF404 = phi i64 [ %root_phi107.idxF400, %L750 ], [ %root_phi107.idxF404.pre, %L753 ], !dbg !702
  %root_phi107.vals402 = load atomic ptr, ptr %root_phi107.vals_ptr401 unordered, align 8, !dbg !702, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %214 = add i64 %root_phi107.idxF404, 1, !dbg !707
  store i64 %214, ptr %root_phi107.idxF_ptr399, align 8, !dbg !708, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data407 = load ptr, ptr %root_phi107.vals402, align 8, !dbg !709, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset410 = shl i64 %root_phi107.idxF404, 3, !dbg !709
  %memoryref_data415 = getelementptr inbounds i8, ptr %memoryref_data407, i64 %memoryref_byteoffset410, !dbg !709
  %215 = load i64, ptr %memoryref_data415, align 8, !dbg !709, !tbaa !318, !alias.scope !189, !noalias !190
  %216 = trunc i64 %215 to i32, !dbg !710
  %217 = and i32 %216, 8388607, !dbg !711
  %218 = or disjoint i32 %217, 1065353216, !dbg !712
  %bitcast_coercion417 = bitcast i32 %218 to float, !dbg !713
  %219 = fadd float %bitcast_coercion417, -1.000000e+00, !dbg !714
  %220 = fmul float %219, 2.000000e+00, !dbg !716
  %221 = fadd float %220, -1.000000e+00, !dbg !718
  %222 = fpext float %221 to double, !dbg !719
  %223 = fmul double %211, %222, !dbg !716
  %224 = fpext float %209 to double, !dbg !723
  %225 = fadd double %223, %224, !dbg !728
  %226 = fadd double %225, 1.000000e+00, !dbg !729
  %227 = fsub double %226, %226, !dbg !733
  %228 = fcmp uno double %227, 0.000000e+00, !dbg !738
  %229 = fcmp oeq double %226, 0.000000e+00
  %or.cond1108 = or i1 %228, %229, !dbg !735
  %230 = call double @llvm.fabs.f64(double %226), !dbg !740
  br i1 %or.cond1108, label %L815, label %L811, !dbg !735

L811:                                             ; preds = %L755
  %231 = call swiftcc double @j_rem_internal_9473(ptr nonnull swiftself %pgcstack, double %230, double 4.000000e+00), !dbg !741
  %232 = call double @llvm.copysign.f64(double %231, double %226), !dbg !742
  br label %L823, !dbg !429

L815:                                             ; preds = %L755
  %233 = bitcast double %230 to i64, !dbg !743
  %.not713 = icmp eq i64 %233, 9218868437227405312, !dbg !743
  br i1 %.not713, label %L830, label %L823, !dbg !744

L823:                                             ; preds = %L815, %L811
  %value_phi418 = phi double [ %232, %L811 ], [ %226, %L815 ]
  %234 = fcmp une double %value_phi418, 0.000000e+00, !dbg !745
  br i1 %234, label %L830, label %L828, !dbg !747

L828:                                             ; preds = %L823
  %235 = call double @llvm.fabs.f64(double %value_phi418), !dbg !748
  br label %guard_pass605, !dbg !429

L830:                                             ; preds = %L823, %L815
  %value_phi418736 = phi double [ %value_phi418, %L823 ], [ 0x7FF8000000000000, %L815 ]
  %236 = fcmp ogt double %value_phi418736, 0.000000e+00, !dbg !750
  %237 = fadd double %value_phi418736, 4.000000e+00
  %spec.select627 = select i1 %236, double %value_phi418736, double %237, !dbg !753
  br label %guard_pass605, !dbg !753

L858:                                             ; preds = %L699
  store i64 %203, ptr %"new::Tuple186", align 1, !dbg !754, !tbaa !283, !alias.scope !285, !noalias !286
  %jl_nothing424 = load ptr, ptr @jl_nothing, align 8, !dbg !761, !tbaa !169, !invariant.load !0, !alias.scope !268, !noalias !269, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %209), !dbg !761
  %gc_slot_addr_151274 = getelementptr inbounds ptr, ptr %gcframe2, i64 17
  store ptr %box_Float32, ptr %gc_slot_addr_151274, align 8
  %ptls_load1302 = load ptr, ptr %ptls_field, align 8, !dbg !761, !tbaa !156
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load1302, i32 424, i32 16, i64 4887683216) #23, !dbg !761
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !761
  store atomic i64 4887683216, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !761, !tbaa !273
  store i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload", ptr %"box::Float64", align 8, !dbg !761, !tbaa !270, !alias.scope !764, !noalias !765
  store ptr %"box::Float64", ptr %gc_slot_addr_141269, align 8
  store ptr @"jl_global#9474.jit", ptr %jlcallframe1, align 8, !dbg !761
  %238 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !761
  store ptr %49, ptr %238, align 8, !dbg !761
  %239 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !761
  store ptr %jl_nothing424, ptr %239, align 8, !dbg !761
  %240 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !761
  store ptr %box_Float32, ptr %240, align 8, !dbg !761
  %241 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !761
  store ptr %"box::Float64", ptr %241, align 8, !dbg !761
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !761
  call void @llvm.trap(), !dbg !761
  unreachable, !dbg !761

L876:                                             ; preds = %guard_pass605, %guard_pass600
  %.sroa.7925.0 = phi float [ %485, %guard_pass600 ], [ %490, %guard_pass605 ], !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10931, i64 7, i1 false), !dbg !766
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10931), !dbg !766
  %"new::Tuple162.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1163", i64 33, !dbg !759
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple162.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !766, !tbaa !283, !alias.scope !285, !noalias !286
  store i64 %.fr, ptr %194, align 8, !dbg !759, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple162.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1163", i64 16, !dbg !759
  store float %209, ptr %"new::Tuple162.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !759, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple162.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1163", i64 20, !dbg !759
  store float %.sroa.7925.0, ptr %"new::Tuple162.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !759, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple162.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1163", i64 24, !dbg !759
  store i64 1, ptr %"new::Tuple162.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !759, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::Tuple162.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1163", i64 32, !dbg !759
  store i8 0, ptr %"new::Tuple162.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !759, !tbaa !283, !alias.scope !285, !noalias !286
  %242 = add i64 %.fr, -1, !dbg !767
  %root_phi88.size.0.copyload = load i64, ptr %.size_ptr, align 8, !dbg !769, !tbaa !270, !alias.scope !300, !noalias !301
  %.not714 = icmp ult i64 %242, %root_phi88.size.0.copyload, !dbg !767
  br i1 %.not714, label %L934, label %L931, !dbg !767

L931:                                             ; preds = %L876
  store i64 %.fr, ptr %"new::Tuple395", align 8, !dbg !767, !tbaa !283, !alias.scope !285, !noalias !286
  call swiftcc void @j_throw_boundserror_9471(ptr nonnull swiftself %pgcstack, ptr nonnull %11, ptr nocapture nonnull readonly %"new::Tuple395") #8, !dbg !767
  unreachable, !dbg !767

L934:                                             ; preds = %L876
  %root_phi87.state = load atomic ptr, ptr %9 unordered, align 8, !dbg !770, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %memoryref_data165 = load ptr, ptr %11, align 8, !dbg !772, !tbaa !310, !alias.scope !313, !noalias !314
  %243 = getelementptr i8, ptr %memoryref_data165, i64 %memoryref_offset137, !dbg !772
  %memoryref_data173 = getelementptr i8, ptr %243, i64 -4, !dbg !772
  %244 = load float, ptr %memoryref_data173, align 4, !dbg !772, !tbaa !318, !alias.scope !189, !noalias !190
  %245 = fpext float %.sroa.7925.0 to double, !dbg !773
  store ptr %root_phi87.state, ptr %gc_slot_addr_141269, align 8
  %246 = call swiftcc double @"j_#power_by_squaring#401_9464"(ptr nonnull swiftself %pgcstack, double %245, i64 signext 2), !dbg !777
  %root_phi87.state.size_ptr = getelementptr inbounds i8, ptr %root_phi87.state, i64 16, !dbg !769
  %root_phi87.state.size.0.copyload = load i64, ptr %root_phi87.state.size_ptr, align 8, !dbg !769, !tbaa !270, !alias.scope !300, !noalias !301
  %.not715 = icmp ult i64 %242, %root_phi87.state.size.0.copyload, !dbg !767
  br i1 %.not715, label %L959, label %L956, !dbg !767

L956:                                             ; preds = %L934
  store i64 %.fr, ptr %"new::Tuple393", align 8, !dbg !767, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %root_phi87.state, ptr %gc_slot_addr_141269, align 8
  call swiftcc void @j_throw_boundserror_9471(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi87.state, ptr nocapture nonnull readonly %"new::Tuple393") #8, !dbg !767
  unreachable, !dbg !767

L959:                                             ; preds = %L934
  %247 = fptrunc double %246 to float, !dbg !778
  %memoryref_data175 = load ptr, ptr %root_phi87.state, align 8, !dbg !772, !tbaa !310, !alias.scope !313, !noalias !314
  %248 = getelementptr i8, ptr %memoryref_data175, i64 %memoryref_offset137, !dbg !772
  %memoryref_data183 = getelementptr i8, ptr %248, i64 -4, !dbg !772
  %249 = load float, ptr %memoryref_data183, align 4, !dbg !772, !tbaa !318, !alias.scope !189, !noalias !190
  %250 = fpext float %249 to double, !dbg !773
  store ptr null, ptr %gc_slot_addr_141269, align 8
  %251 = call swiftcc double @"j_#power_by_squaring#401_9464"(ptr nonnull swiftself %pgcstack, double %250, i64 signext 2), !dbg !777
  %252 = fptrunc double %251 to float, !dbg !778
  %253 = fsub float %247, %252, !dbg !781
  %254 = fmul float %244, 0.000000e+00, !dbg !782
  %255 = fmul float %254, %253, !dbg !782
  %256 = fadd float %255, 0.000000e+00, !dbg !784
  store ptr %9, ptr %0, align 8, !dbg !757
  store ptr %17, ptr %1, align 8, !dbg !757
  store ptr %19, ptr %196, align 8, !dbg !757
  store ptr %21, ptr %197, align 8, !dbg !757
  store ptr %23, ptr %198, align 8, !dbg !757
  store ptr %25, ptr %199, align 8, !dbg !757
  %257 = call swiftcc float @"j_#calculate##0_9465"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1163", ptr nocapture nonnull readonly %0, float %256, ptr nocapture nonnull readonly %195, ptr nocapture nonnull readonly %1), !dbg !757
  %258 = fneg float %192, !dbg !785
  %.not716 = icmp ult i64 %242, %"new::NamedTuple.sroa.0.sroa.4.8.copyload", !dbg !786
  br i1 %.not716, label %L1017, label %L1014, !dbg !789

L1014:                                            ; preds = %L959
  %259 = getelementptr inbounds ptr, ptr %gcframe2, i64 15
  store i64 %.fr, ptr %"new::Tuple186", align 1, !dbg !754, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %27, ptr %259, align 8, !dbg !789
  call swiftcc void @j_throw_boundserror_9472(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.0682.sroa.9.0..sroa_idx942, ptr nocapture nonnull readonly %259, ptr nocapture nonnull readonly %"new::Tuple186") #8, !dbg !789
  unreachable, !dbg !789

L1017:                                            ; preds = %L959
  %root_phi87.state184 = load atomic ptr, ptr %9 unordered, align 8, !dbg !790, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %root_phi87.state184.size_ptr = getelementptr inbounds i8, ptr %root_phi87.state184, i64 16, !dbg !792
  %root_phi87.state184.size.0.copyload = load i64, ptr %root_phi87.state184.size_ptr, align 8, !dbg !792, !tbaa !270, !alias.scope !300, !noalias !301
  %.not717 = icmp ult i64 %242, %root_phi87.state184.size.0.copyload, !dbg !793
  br i1 %.not717, label %L1034, label %L1031, !dbg !793

L1031:                                            ; preds = %L1017
  store i64 %.fr, ptr %"new::Tuple390", align 8, !dbg !793, !tbaa !283, !alias.scope !285, !noalias !286
  store ptr %root_phi87.state184, ptr %gc_slot_addr_141269, align 8
  call swiftcc void @j_throw_boundserror_9471(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi87.state184, ptr nocapture nonnull readonly %"new::Tuple390") #8, !dbg !793
  unreachable, !dbg !793

L1034:                                            ; preds = %L1017
  %root_phi96.x = load float, ptr %27, align 4, !dbg !794, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data189 = load ptr, ptr %root_phi87.state184, align 8, !dbg !797, !tbaa !310, !alias.scope !313, !noalias !314
  %260 = getelementptr i8, ptr %memoryref_data189, i64 %memoryref_offset137, !dbg !797
  %memoryref_data197 = getelementptr i8, ptr %260, i64 -4, !dbg !797
  %261 = load float, ptr %memoryref_data197, align 4, !dbg !797, !tbaa !318, !alias.scope !189, !noalias !190
  %262 = fsub float %.sroa.7925.0, %261, !dbg !798
  %263 = fmul float %root_phi96.x, %258, !dbg !799
  %264 = fmul float %263, %262, !dbg !799
  %265 = fadd float %257, %264, !dbg !784
  %266 = fcmp ugt float %265, 0.000000e+00, !dbg !801
  br i1 %266, label %L1049, label %L1166, !dbg !802

L1049:                                            ; preds = %L1034
  %root_phi107.idxF = load i64, ptr %root_phi107.idxF_ptr399, align 8, !dbg !803, !tbaa !203, !alias.scope !189, !noalias !190
  %.not718 = icmp eq i64 %root_phi107.idxF, 1002, !dbg !816
  br i1 %.not718, label %L1052, label %L1054, !dbg !805

L1052:                                            ; preds = %L1049
  %267 = call swiftcc i64 @j_gen_rand_9469(ptr nonnull swiftself %pgcstack, ptr %49), !dbg !805
  %root_phi107.idxF366.pre = load i64, ptr %root_phi107.idxF_ptr399, align 8, !dbg !817, !tbaa !203, !alias.scope !189, !noalias !190
  br label %L1054, !dbg !805

L1054:                                            ; preds = %L1052, %L1049
  %root_phi107.idxF366 = phi i64 [ %root_phi107.idxF, %L1049 ], [ %root_phi107.idxF366.pre, %L1052 ], !dbg !817
  %root_phi107.vals = load atomic ptr, ptr %root_phi107.vals_ptr401 unordered, align 8, !dbg !817, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %268 = add i64 %root_phi107.idxF366, 1, !dbg !822
  store i64 %268, ptr %root_phi107.idxF_ptr399, align 8, !dbg !823, !tbaa !203, !alias.scope !189, !noalias !190
  %memoryref_data369 = load ptr, ptr %root_phi107.vals, align 8, !dbg !824, !tbaa !310, !alias.scope !313, !noalias !314
  %memoryref_byteoffset372 = shl i64 %root_phi107.idxF366, 3, !dbg !824
  %memoryref_data377 = getelementptr inbounds i8, ptr %memoryref_data369, i64 %memoryref_byteoffset372, !dbg !824
  %269 = load i64, ptr %memoryref_data377, align 8, !dbg !824, !tbaa !318, !alias.scope !189, !noalias !190
  %270 = trunc i64 %269 to i32, !dbg !825
  %271 = and i32 %270, 8388607, !dbg !826
  %272 = or disjoint i32 %271, 1065353216, !dbg !827
  %bitcast_coercion378 = bitcast i32 %272 to float, !dbg !828
  %273 = fadd float %bitcast_coercion378, -1.000000e+00, !dbg !829
  %274 = fneg float %265, !dbg !831
  %275 = fdiv float %274, %.unbox379, !dbg !832
  %276 = fmul float %275, 0x3FF7154760000000, !dbg !833
  %277 = call float @llvm.rint.f32(float %276), !dbg !836
  %278 = fptosi float %277 to i32, !dbg !838
  %279 = freeze i32 %278, !dbg !838
  %280 = fmul contract float %277, 0x3FE62E4000000000, !dbg !840
  %281 = fsub contract float %275, %280, !dbg !840
  %282 = fmul contract float %277, 0x3EB7F7D1C0000000, !dbg !842
  %283 = fsub contract float %281, %282, !dbg !842
  %284 = fmul contract float %283, 0x3F2A1D7140000000, !dbg !844
  %285 = fadd contract float %284, 0x3F56DA7560000000, !dbg !844
  %286 = fmul contract float %283, %285, !dbg !844
  %287 = fadd contract float %286, 0x3F811105C0000000, !dbg !844
  %288 = fmul contract float %283, %287, !dbg !844
  %289 = fadd contract float %288, 0x3FA5554640000000, !dbg !844
  %290 = fmul contract float %283, %289, !dbg !844
  %291 = fadd contract float %290, 0x3FC5555560000000, !dbg !844
  %292 = fmul contract float %283, %291, !dbg !844
  %293 = fadd contract float %292, 5.000000e-01, !dbg !844
  %294 = fmul contract float %283, %293, !dbg !844
  %295 = fadd contract float %294, 1.000000e+00, !dbg !844
  %296 = fmul contract float %283, %295, !dbg !844
  %297 = fadd contract float %296, 1.000000e+00, !dbg !844
  %298 = fcmp ule float %275, 0x40562E4300000000, !dbg !849
  br i1 %298, label %L1113, label %L1164, !dbg !851

L1113:                                            ; preds = %L1054
  %299 = fcmp uge float %275, 0xC059FE3680000000, !dbg !852
  br i1 %299, label %L1157, label %L1164, !dbg !853

L1157:                                            ; preds = %L1113
  %300 = fcmp ugt float %275, 0xC055D58A00000000, !dbg !854
  %301 = fmul float %297, 0x3E70000000000000, !dbg !855
  %value_phi382 = select i1 %300, float %297, float %301, !dbg !855
  %.not719 = icmp eq i32 %279, 128, !dbg !856
  %302 = fmul float %value_phi382, 2.000000e+00, !dbg !858
  %value_phi384 = select i1 %.not719, float %302, float %value_phi382, !dbg !858
  %value_phi381.v = select i1 %300, i32 127, i32 151, !dbg !855
  %value_phi381 = add i32 %279, %value_phi381.v, !dbg !855
  %303 = sext i1 %.not719 to i32, !dbg !858
  %value_phi383 = add i32 %value_phi381, %303, !dbg !858
  %304 = shl i32 %value_phi383, 23, !dbg !859
  %bitcast_coercion387 = bitcast i32 %304 to float, !dbg !863
  %305 = fmul float %value_phi384, %bitcast_coercion387, !dbg !864
  br label %L1164, !dbg !429

L1164:                                            ; preds = %L1157, %L1113, %L1054
  %value_phi380 = phi float [ %305, %L1157 ], [ 0x7FF0000000000000, %L1054 ], [ 0.000000e+00, %L1113 ]
  %306 = fcmp olt float %273, %value_phi380, !dbg !865
  br i1 %306, label %L1166, label %guard_pass615, !dbg !802

L1166:                                            ; preds = %L1164, %L1034
  %root_phi106.state199 = load atomic ptr, ptr %47 unordered, align 8, !dbg !866, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0, !dereferenceable !292, !align !293
  %root_phi106.state199.size_ptr = getelementptr inbounds i8, ptr %root_phi106.state199, i64 16, !dbg !870
  %root_phi106.state199.size.0.copyload = load i64, ptr %root_phi106.state199.size_ptr, align 8, !dbg !870, !tbaa !270, !alias.scope !300, !noalias !301
  %.not720 = icmp eq i64 %root_phi106.state199.size.0.copyload, 100000, !dbg !872
  br i1 %.not720, label %guard_pass610, label %L1174, !dbg !871

L1174:                                            ; preds = %L1166
  call swiftcc void @j_throw_dmrsa_9461(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi106.state199.size.0.copyload) #8, !dbg !874
  unreachable, !dbg !874

L1261:                                            ; preds = %pass226
  store i64 %.fr, ptr %"new::Tuple186", align 1, !dbg !754, !tbaa !283, !alias.scope !285, !noalias !286
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext219.sroa.0.sroa.0", i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple218.sroa.0.sroa.5", i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple218.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple218.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6878, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext221.sroa.6", i64 56, i1 false), !dbg !631
  br label %L1272, !dbg !631

L1262:                                            ; preds = %pass226
  %.not723.not.not = icmp eq i64 %value_phi86798, %value_phi83, !dbg !875
  br i1 %.not723.not.not, label %L1267.L1272_crit_edge, label %L1271, !dbg !431

L1267.L1272_crit_edge:                            ; preds = %L1262
  store i64 %.fr, ptr %"new::Tuple186", align 1, !dbg !754, !tbaa !283, !alias.scope !285, !noalias !286
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext219.sroa.0.sroa.0", i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple218.sroa.0.sroa.5", i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple218.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple218.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6878, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext221.sroa.6", i64 56, i1 false), !dbg !631
  br label %L1272, !dbg !631

L1271:                                            ; preds = %L1262
  %307 = add i64 %value_phi86798, 1, !dbg !429
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %4, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext219.sroa.0.sroa.0", i64 96, i1 false), !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %.sroa.0682.sroa.8.0..sroa_idx939, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.3.8.copyload", ptr %.sroa.0682.sroa.9.0..sroa_idx942, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %.sroa.0682.sroa.10.0..sroa_idx945, align 8, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0682.sroa.11.0..sroa_idx947, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple218.sroa.0.sroa.5", i64 32, i1 false), !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0682.sroa.12.0..sroa_idx948, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple218.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0682.sroa.13.0..sroa_idx949, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple218.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.9.128.copyload", ptr %.sroa.0682.sroa.14.0..sroa_idx951, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.10.128.copyload", ptr %.sroa.0682.sroa.15.0..sroa_idx954, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.11.128.copyload", ptr %.sroa.0682.sroa.16.0..sroa_idx957, align 8, !dbg !632
  store i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload", ptr %.sroa.0682.sroa.17.0..sroa_idx960, align 8, !dbg !632
  store i64 %.fr, ptr %.sroa.0682.sroa.19.0..sroa_idx966, align 8, !dbg !632
  store float %209, ptr %.sroa.0682.sroa.20.0..sroa_idx969, align 8, !dbg !632
  store float %.sroa.7925.0, ptr %.sroa.0682.sroa.21.0..sroa_idx972, align 4, !dbg !632
  store i64 1, ptr %.sroa.0682.sroa.22.0..sroa_idx975, align 8, !dbg !632
  store i8 %.sroa.9.0, ptr %.sroa.0682.sroa.23.0..sroa_idx978, align 8, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0682.sroa.24.0..sroa_idx980, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6878, i64 7, i1 false), !dbg !632
  store float %265, ptr %.sroa.6683.0..sroa_idx, align 8, !dbg !632
  store i32 %"new::NamedTuple.sroa.6.316.copyload", ptr %.sroa.7685.0..sroa_idx, align 4, !dbg !632
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8687.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %"new::ProcessContext221.sroa.6", i64 56, i1 false), !dbg !632
  %.stop_ptr115.unbox = load i64, ptr %.stop_ptr115, align 8, !dbg !657, !tbaa !283, !alias.scope !285, !noalias !286
  %.unbox116 = load i64, ptr %189, align 8, !dbg !657, !tbaa !283, !alias.scope !285, !noalias !286
  %.not706 = icmp slt i64 %.stop_ptr115.unbox, %.unbox116, !dbg !657
  br i1 %.not706, label %L670, label %L673, !dbg !650

L1272:                                            ; preds = %L1267.L1272_crit_edge, %L1261, %L639.L1272_crit_edge
  %.sroa.0.sroa.18.sroa.8.0 = phi i64 [ %.fr1105, %L639.L1272_crit_edge ], [ %.fr, %L1267.L1272_crit_edge ], [ %.fr, %L1261 ], !dbg !631
  %.sroa.0.sroa.18.sroa.10.0 = phi float [ %79, %L639.L1272_crit_edge ], [ %209, %L1267.L1272_crit_edge ], [ %209, %L1261 ], !dbg !631
  %.sroa.0.sroa.18.sroa.12.0 = phi float [ %.sroa.71002.0, %L639.L1272_crit_edge ], [ %.sroa.7925.0, %L1267.L1272_crit_edge ], [ %.sroa.7925.0, %L1261 ], !dbg !631
  %.sroa.0.sroa.18.sroa.16.0 = phi i8 [ %.sroa.9995.0, %L639.L1272_crit_edge ], [ %.sroa.9.0, %L1267.L1272_crit_edge ], [ %.sroa.9.0, %L1261 ], !dbg !631
  %.sroa.8.0 = phi float [ %146, %L639.L1272_crit_edge ], [ %265, %L1267.L1272_crit_edge ], [ %265, %L1261 ], !dbg !631
  %308 = call i64 @jlplt_ijl_hrtime_9456_got.jit(), !dbg !876
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 520, !dbg !882
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528, !dbg !882
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !882, !tbaa !203, !alias.scope !189, !noalias !190
  store i64 %308, ptr %"process::Process.endtime_ptr", align 8, !dbg !882, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !883
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !883, !tbaa !203, !alias.scope !189, !noalias !190, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !884
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !884, !tbaa !273, !range !888
  %309 = and i64 %"process::Process.task.tag", -16, !dbg !884
  %310 = inttoptr i64 %309 to ptr, !dbg !884
  %exactly_isa.not.not = icmp eq ptr %310, @"+Core.Nothing#9467.jit", !dbg !884
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 497, !dbg !884
  %311 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !884
  %312 = and i8 %311, 1, !dbg !887
  %313 = icmp eq i8 %312, 0, !dbg !887
  %.not727 = select i1 %exactly_isa.not.not, i1 true, i1 %313, !dbg !887
  br i1 %.not727, label %L1329, label %L1308, !dbg !887

L1308:                                            ; preds = %L1272
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !889
  %ptls_load1310 = load ptr, ptr %ptls_field, align 8, !dbg !889, !tbaa !156
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(400) ptr @ijl_gc_small_alloc(ptr %ptls_load1310, i32 1120, i32 400, i64 15480375120) #23, !dbg !889
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !889
  store atomic i64 15480375120, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !889, !tbaa !273
  store atomic ptr %7, ptr %"box::ProcessContext" unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %314 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !889
  store atomic ptr %9, ptr %314 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %315 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !889
  store atomic ptr %11, ptr %315 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %316 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !889
  store atomic ptr %13, ptr %316 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %317 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !889
  store atomic ptr %15, ptr %317 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %318 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !889
  %.sroa.0640.sroa.0.40.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.0, i64 40, !dbg !889
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %318, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0640.sroa.0.40.sroa_idx, i64 16, i1 false), !dbg !889
  %319 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !889
  store atomic ptr %17, ptr %319 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %320 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !889
  store atomic ptr %19, ptr %320 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %321 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !889
  store atomic ptr %21, ptr %321 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %322 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !889
  store atomic ptr %23, ptr %322 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %323 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !889
  store atomic ptr %25, ptr %323 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %324 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !889
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %324, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %325 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !889
  store atomic ptr %27, ptr %325 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %326 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !889
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %326, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %327 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !889
  store atomic ptr %29, ptr %327 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %328 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !889
  store atomic ptr %31, ptr %328 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %329 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !889
  %.sroa.0640.sroa.10.136.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.11, i64 16, !dbg !889
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %329, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0640.sroa.10.136.sroa_idx, i64 16, i1 false), !dbg !889
  %330 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !889
  store atomic ptr %33, ptr %330 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %331 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !889
  store atomic ptr %35, ptr %331 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %332 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !889
  store atomic ptr %37, ptr %332 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %333 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !889
  store atomic ptr %39, ptr %333 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %334 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !889
  store atomic ptr %41, ptr %334 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %335 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !889
  %.sroa.0640.sroa.12.192.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.12, i64 40, !dbg !889
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %335, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0640.sroa.12.192.sroa_idx, i64 24, i1 false), !dbg !889
  %336 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !889
  store atomic ptr %43, ptr %336 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %337 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !889
  %.sroa.0640.sroa.14.224.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.13, i64 8, !dbg !889
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %337, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0640.sroa.14.224.sroa_idx, i64 24, i1 false), !dbg !889
  %338 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !889
  store atomic ptr %45, ptr %338 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %339 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !889
  store i64 %"new::NamedTuple.sroa.0.sroa.10.128.copyload", ptr %339, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %340 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !889
  store atomic ptr %47, ptr %340 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %341 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !889
  store i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload", ptr %341, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %342 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !889
  store atomic ptr %49, ptr %342 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %343 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !889
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %343, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %.sroa.0640.sroa.22.sroa.6.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 296, !dbg !889
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0640.sroa.22.sroa.6.8..sroa_idx, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %.sroa.0640.sroa.22.sroa.7.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 300, !dbg !889
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0640.sroa.22.sroa.7.8..sroa_idx, align 4, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %.sroa.0640.sroa.22.sroa.8.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 304, !dbg !889
  store i64 1, ptr %.sroa.0640.sroa.22.sroa.8.8..sroa_idx, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %.sroa.0640.sroa.22.sroa.9.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 312, !dbg !889
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0640.sroa.22.sroa.9.8..sroa_idx, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %.sroa.0640.sroa.22.sroa.10.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 313, !dbg !889
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0640.sroa.22.sroa.10.8..sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !889
  %.sroa.15.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 320, !dbg !889
  store float %.sroa.8.0, ptr %.sroa.15.288..sroa_idx, align 8, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %.sroa.16.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 324, !dbg !889
  store i32 %"new::NamedTuple.sroa.6.316.copyload", ptr %.sroa.16.288..sroa_idx, align 4, !dbg !889, !tbaa !270, !alias.scope !764, !noalias !765
  %344 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !889
  store atomic ptr %51, ptr %344 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %345 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !889
  store atomic ptr %53, ptr %345 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %346 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !889
  store atomic ptr %55, ptr %346 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %347 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !889
  store atomic ptr %57, ptr %347 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %348 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !889
  store atomic ptr %59, ptr %348 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %349 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !889
  store atomic ptr %61, ptr %349 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  %350 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !889
  store atomic ptr %63, ptr %350 unordered, align 8, !dbg !889, !tbaa !275, !alias.scope !189, !noalias !190
  store atomic ptr %"box::ProcessContext", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !889, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !889
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !889, !tbaa !273, !range !888
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !889
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !889
  br i1 %parent_old_marked, label %may_trigger_wb, label %351, !dbg !889

may_trigger_wb:                                   ; preds = %L1308
  %"box::ProcessContext.tag" = load atomic volatile i64, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !889, !tbaa !273, !range !888
  %child_bit = and i64 %"box::ProcessContext.tag", 1, !dbg !889
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !889
  br i1 %child_not_marked, label %trigger_wb, label %351, !dbg !889, !prof !895

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !889
  br label %351, !dbg !889

351:                                              ; preds = %may_trigger_wb, %trigger_wb, %L1308
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0663.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0663.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0663.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0663.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0663.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8669, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, i64 56, i1 false), !dbg !631
  br label %L1339, !dbg !631

L1329:                                            ; preds = %L1272
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !631
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !896
  %352 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !896, !tbaa !203, !alias.scope !189, !noalias !190
  %353 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !896
  %354 = load atomic ptr, ptr %353 unordered, align 8, !dbg !896, !tbaa !203, !alias.scope !189, !noalias !190
  %355 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !896
  %356 = load atomic ptr, ptr %355 unordered, align 8, !dbg !896, !tbaa !203, !alias.scope !189, !noalias !190
  %357 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !896
  %358 = load atomic ptr, ptr %357 unordered, align 8, !dbg !896, !tbaa !203, !alias.scope !189, !noalias !190
  %359 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !896
  %360 = load atomic ptr, ptr %359 unordered, align 8, !dbg !896, !tbaa !203, !alias.scope !189, !noalias !190
  %361 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !896
  %362 = load atomic ptr, ptr %361 unordered, align 8, !dbg !896, !tbaa !203, !alias.scope !189, !noalias !190
  %363 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !902
  store atomic ptr %7, ptr %363 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %364 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !902
  store atomic ptr %9, ptr %364 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %365 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !902
  store atomic ptr %11, ptr %365 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %366 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !902
  store atomic ptr %13, ptr %366 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %367 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !902
  store atomic ptr %15, ptr %367 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %368 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !902
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", i64 40, !dbg !902
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %368, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %369 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !902
  store atomic ptr %17, ptr %369 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %370 = getelementptr inbounds i8, ptr %"process::Process", i64 120, !dbg !902
  store atomic ptr %19, ptr %370 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %371 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !902
  store atomic ptr %21, ptr %371 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %372 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !902
  store atomic ptr %23, ptr %372 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %373 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !902
  store atomic ptr %25, ptr %373 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %374 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !902
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %374, align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %375 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !902
  store atomic ptr %27, ptr %375 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %376 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !902
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %376, align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %377 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !902
  store atomic ptr %29, ptr %377 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %378 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !902
  store atomic ptr %31, ptr %378 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %379 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !902
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", i64 16, !dbg !902
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %379, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx", i64 16, i1 false), !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %380 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !902
  store atomic ptr %33, ptr %380 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %381 = getelementptr inbounds i8, ptr %"process::Process", i64 216, !dbg !902
  store atomic ptr %35, ptr %381 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %382 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !902
  store atomic ptr %37, ptr %382 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %383 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !902
  store atomic ptr %39, ptr %383 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %384 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !902
  store atomic ptr %41, ptr %384 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %385 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !902
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", i64 40, !dbg !902
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %385, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx", i64 24, i1 false), !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %386 = getelementptr inbounds i8, ptr %"process::Process", i64 272, !dbg !902
  store atomic ptr %43, ptr %386 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %387 = getelementptr inbounds i8, ptr %"process::Process", i64 280, !dbg !902
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", i64 8, !dbg !902
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %387, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx", i64 24, i1 false), !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %388 = getelementptr inbounds i8, ptr %"process::Process", i64 304, !dbg !902
  store atomic ptr %45, ptr %388 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %389 = getelementptr inbounds i8, ptr %"process::Process", i64 312, !dbg !902
  store i64 %"new::NamedTuple.sroa.0.sroa.10.128.copyload", ptr %389, align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %390 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !902
  store atomic ptr %47, ptr %390 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %391 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !902
  store i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload", ptr %391, align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %392 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !902
  store atomic ptr %49, ptr %392 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %393 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !902
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %393, align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !902
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx", align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 356, !dbg !902
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx", align 4, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !902
  store i64 1, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx", align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !902
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx", align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 369, !dbg !902
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !902
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !902
  store float %.sroa.8.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 380, !dbg !902
  store i32 %"new::NamedTuple.sroa.6.316.copyload", ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !902, !tbaa !270, !alias.scope !764, !noalias !765
  %394 = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !902
  store atomic ptr %51, ptr %394 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %395 = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !902
  store atomic ptr %53, ptr %395 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %396 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !902
  store atomic ptr %55, ptr %396 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %397 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !902
  store atomic ptr %57, ptr %397 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %398 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !902
  store atomic ptr %59, ptr %398 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %399 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !902
  store atomic ptr %61, ptr %399 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %400 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !902
  store atomic ptr %63, ptr %400 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  store atomic ptr %362, ptr %361 unordered, align 8, !dbg !902, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.tag_addr1312" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !902
  %"process::Process.tag1313" = load atomic volatile i64, ptr %"process::Process.tag_addr1312" unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %parent_bits1314 = and i64 %"process::Process.tag1313", 3, !dbg !902
  %parent_old_marked1315 = icmp eq i64 %parent_bits1314, 3, !dbg !902
  br i1 %parent_old_marked1315, label %may_trigger_wb1316, label %436, !dbg !902

may_trigger_wb1316:                               ; preds = %L1329
  %.tag_addr = getelementptr inbounds i64, ptr %352, i64 -1, !dbg !902
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %.tag_addr1319 = getelementptr inbounds i64, ptr %354, i64 -1, !dbg !902
  %.tag1320 = load atomic volatile i64, ptr %.tag_addr1319 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %401 = and i64 %.tag, %.tag1320, !dbg !902
  %.tag_addr1323 = getelementptr inbounds i64, ptr %356, i64 -1, !dbg !902
  %.tag1324 = load atomic volatile i64, ptr %.tag_addr1323 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %402 = and i64 %401, %.tag1324, !dbg !902
  %.tag_addr1327 = getelementptr inbounds i64, ptr %358, i64 -1, !dbg !902
  %.tag1328 = load atomic volatile i64, ptr %.tag_addr1327 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %403 = and i64 %402, %.tag1328, !dbg !902
  %.tag_addr1331 = getelementptr inbounds i64, ptr %360, i64 -1, !dbg !902
  %.tag1332 = load atomic volatile i64, ptr %.tag_addr1331 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %404 = and i64 %403, %.tag1332, !dbg !902
  %.tag_addr1335 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !902
  %.tag1336 = load atomic volatile i64, ptr %.tag_addr1335 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %405 = and i64 %404, %.tag1336, !dbg !902
  %.tag_addr1339 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !902
  %.tag1340 = load atomic volatile i64, ptr %.tag_addr1339 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %406 = and i64 %405, %.tag1340, !dbg !902
  %.tag_addr1343 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !902
  %.tag1344 = load atomic volatile i64, ptr %.tag_addr1343 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %407 = and i64 %406, %.tag1344, !dbg !902
  %.tag_addr1347 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !902
  %.tag1348 = load atomic volatile i64, ptr %.tag_addr1347 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %408 = and i64 %407, %.tag1348, !dbg !902
  %.tag_addr1351 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !902
  %.tag1352 = load atomic volatile i64, ptr %.tag_addr1351 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %409 = and i64 %408, %.tag1352, !dbg !902
  %.tag_addr1355 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !902
  %.tag1356 = load atomic volatile i64, ptr %.tag_addr1355 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %410 = and i64 %409, %.tag1356, !dbg !902
  %.tag_addr1359 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !902
  %.tag1360 = load atomic volatile i64, ptr %.tag_addr1359 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %411 = and i64 %410, %.tag1360, !dbg !902
  %.tag_addr1363 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !902
  %.tag1364 = load atomic volatile i64, ptr %.tag_addr1363 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %412 = and i64 %411, %.tag1364, !dbg !902
  %.tag_addr1367 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !902
  %.tag1368 = load atomic volatile i64, ptr %.tag_addr1367 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %413 = and i64 %412, %.tag1368, !dbg !902
  %.tag_addr1371 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !902
  %.tag1372 = load atomic volatile i64, ptr %.tag_addr1371 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %414 = and i64 %413, %.tag1372, !dbg !902
  %.tag_addr1375 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !902
  %.tag1376 = load atomic volatile i64, ptr %.tag_addr1375 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %415 = and i64 %414, %.tag1376, !dbg !902
  %.tag_addr1379 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !902
  %.tag1380 = load atomic volatile i64, ptr %.tag_addr1379 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %416 = and i64 %415, %.tag1380, !dbg !902
  %.tag_addr1383 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !902
  %.tag1384 = load atomic volatile i64, ptr %.tag_addr1383 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %417 = and i64 %416, %.tag1384, !dbg !902
  %.tag_addr1387 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !902
  %.tag1388 = load atomic volatile i64, ptr %.tag_addr1387 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %418 = and i64 %417, %.tag1388, !dbg !902
  %.tag_addr1391 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !902
  %.tag1392 = load atomic volatile i64, ptr %.tag_addr1391 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %419 = and i64 %418, %.tag1392, !dbg !902
  %.tag_addr1395 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !902
  %.tag1396 = load atomic volatile i64, ptr %.tag_addr1395 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %420 = and i64 %419, %.tag1396, !dbg !902
  %.tag_addr1399 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !902
  %.tag1400 = load atomic volatile i64, ptr %.tag_addr1399 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %421 = and i64 %420, %.tag1400, !dbg !902
  %.tag_addr1403 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !902
  %.tag1404 = load atomic volatile i64, ptr %.tag_addr1403 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %422 = and i64 %421, %.tag1404, !dbg !902
  %.tag_addr1407 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !902
  %.tag1408 = load atomic volatile i64, ptr %.tag_addr1407 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %423 = and i64 %422, %.tag1408, !dbg !902
  %.tag_addr1411 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !902
  %.tag1412 = load atomic volatile i64, ptr %.tag_addr1411 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %424 = and i64 %423, %.tag1412, !dbg !902
  %.tag_addr1415 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !902
  %.tag1416 = load atomic volatile i64, ptr %.tag_addr1415 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %425 = and i64 %424, %.tag1416, !dbg !902
  %.tag_addr1419 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !902
  %.tag1420 = load atomic volatile i64, ptr %.tag_addr1419 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %426 = and i64 %425, %.tag1420, !dbg !902
  %.tag_addr1423 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !902
  %.tag1424 = load atomic volatile i64, ptr %.tag_addr1423 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %427 = and i64 %426, %.tag1424, !dbg !902
  %.tag_addr1427 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !902
  %.tag1428 = load atomic volatile i64, ptr %.tag_addr1427 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %428 = and i64 %427, %.tag1428, !dbg !902
  %.tag_addr1431 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !902
  %.tag1432 = load atomic volatile i64, ptr %.tag_addr1431 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %429 = and i64 %428, %.tag1432, !dbg !902
  %.tag_addr1435 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !902
  %.tag1436 = load atomic volatile i64, ptr %.tag_addr1435 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %430 = and i64 %429, %.tag1436, !dbg !902
  %.tag_addr1439 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !902
  %.tag1440 = load atomic volatile i64, ptr %.tag_addr1439 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %431 = and i64 %430, %.tag1440, !dbg !902
  %.tag_addr1443 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !902
  %.tag1444 = load atomic volatile i64, ptr %.tag_addr1443 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %432 = and i64 %431, %.tag1444, !dbg !902
  %.tag_addr1447 = getelementptr inbounds i64, ptr %63, i64 -1, !dbg !902
  %.tag1448 = load atomic volatile i64, ptr %.tag_addr1447 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %433 = and i64 %432, %.tag1448, !dbg !902
  %.tag_addr1451 = getelementptr inbounds i64, ptr %362, i64 -1, !dbg !902
  %.tag1452 = load atomic volatile i64, ptr %.tag_addr1451 unordered, align 8, !dbg !902, !tbaa !273, !range !888
  %434 = and i64 %433, %.tag1452, !dbg !902
  %435 = and i64 %434, 1, !dbg !902
  %.not3.not = icmp eq i64 %435, 0, !dbg !902
  br i1 %.not3.not, label %trigger_wb1455, label %436, !dbg !902, !prof !895

trigger_wb1455:                                   ; preds = %may_trigger_wb1316
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !902
  br label %436, !dbg !902

436:                                              ; preds = %may_trigger_wb1316, %trigger_wb1455, %L1329
  %"process::Process.runtime_context_ptr359" = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !904
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !904, !tbaa !169, !invariant.load !0, !alias.scope !268, !noalias !269, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr359" release, align 8, !dbg !904, !tbaa !203, !alias.scope !189, !noalias !190
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0663.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0663.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0663.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0663.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0663.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8669, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.12, i64 56, i1 false), !dbg !631
  br label %L1339, !dbg !631

L1339:                                            ; preds = %436, %351
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0663.sroa.0, i64 96, i1 false), !dbg !881
  %.sroa.0675.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.2.8.copyload", ptr %.sroa.0675.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.3.8.copyload", ptr %.sroa.0675.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.4.8.copyload", ptr %.sroa.0675.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !881
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0675.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0663.sroa.12, i64 32, i1 false), !dbg !881
  %.sroa.0675.sroa.6.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !881
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0675.sroa.6.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0663.sroa.14, i64 64, i1 false), !dbg !881
  %.sroa.0675.sroa.7.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 216, !dbg !881
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0675.sroa.7.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0663.sroa.16, i64 32, i1 false), !dbg !881
  %.sroa.0675.sroa.8.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 248, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.9.128.copyload", ptr %.sroa.0675.sroa.8.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.9.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.10.128.copyload", ptr %.sroa.0675.sroa.9.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.10.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 264, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.11.128.copyload", ptr %.sroa.0675.sroa.10.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.11.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !881
  store i64 %"new::NamedTuple.sroa.0.sroa.12.128.copyload", ptr %.sroa.0675.sroa.11.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.12.sroa.2.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !881
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %.sroa.0675.sroa.12.sroa.2.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.12.sroa.3.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !881
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0675.sroa.12.sroa.3.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.12.sroa.4.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !881
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0675.sroa.12.sroa.4.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.12.sroa.5.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !881
  store i64 1, ptr %.sroa.0675.sroa.12.sroa.5.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.12.sroa.6.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !881
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0675.sroa.12.sroa.6.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.0675.sroa.12.sroa.7.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !881
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0675.sroa.12.sroa.7.0..sroa.0675.sroa.12.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0663.sroa.26.sroa.11, i64 7, i1 false), !dbg !881
  %.sroa.2676.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !881
  store float %.sroa.8.0, ptr %.sroa.2676.0.sret_return.sroa_idx, align 8, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.3677.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !881
  store i32 %"new::NamedTuple.sroa.6.316.copyload", ptr %.sroa.3677.0.sret_return.sroa_idx, align 4, !dbg !881, !tbaa !283, !alias.scope !285, !noalias !286
  %.sroa.4678.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !881
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.sroa.4678.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(56) %.sroa.8669, i64 56, i1 false), !dbg !881
  store ptr %7, ptr %return_roots, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %437 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !881
  store ptr %9, ptr %437, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %438 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !881
  store ptr %11, ptr %438, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %439 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !881
  store ptr %13, ptr %439, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %440 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !881
  store ptr %15, ptr %440, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %441 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !881
  store ptr %17, ptr %441, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %442 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !881
  store ptr %19, ptr %442, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %443 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !881
  store ptr %21, ptr %443, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %444 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !881
  store ptr %23, ptr %444, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %445 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !881
  store ptr %25, ptr %445, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %446 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !881
  store ptr %27, ptr %446, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %447 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !881
  store ptr %29, ptr %447, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %448 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !881
  store ptr %31, ptr %448, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %449 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !881
  store ptr %33, ptr %449, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %450 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !881
  store ptr %35, ptr %450, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %451 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !881
  store ptr %37, ptr %451, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %452 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !881
  store ptr %39, ptr %452, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %453 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !881
  store ptr %41, ptr %453, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %454 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !881
  store ptr %43, ptr %454, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %455 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !881
  store ptr %45, ptr %455, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %456 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !881
  store ptr %47, ptr %456, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %457 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !881
  store ptr %49, ptr %457, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %458 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !881
  store ptr %51, ptr %458, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %459 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !881
  store ptr %53, ptr %459, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %460 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !881
  store ptr %55, ptr %460, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %461 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !881
  store ptr %57, ptr %461, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %462 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !881
  store ptr %59, ptr %462, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %463 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !881
  store ptr %61, ptr %463, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %464 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !881
  store ptr %63, ptr %464, align 8, !dbg !881, !tbaa !156, !alias.scope !161, !noalias !164
  %frame.prev1456 = load ptr, ptr %frame.prev, align 8, !tbaa !156
  store ptr %frame.prev1456, ptr %pgcstack, align 8, !tbaa !156
  ret void, !dbg !881

pass78:                                           ; preds = %guard_pass563, %guard_pass558
  %"new::NamedTuple.sroa.6.316.copyload" = phi i32 [ %"new::NamedTuple.sroa.6.316.copyload.pre", %guard_pass558 ], [ %180, %guard_pass563 ], !dbg !906
  %.sroa.9995.0 = phi i8 [ 1, %guard_pass558 ], [ 0, %guard_pass563 ], !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6986, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10997, i64 7, i1 false), !dbg !935
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10997), !dbg !935
  %465 = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 16, !dbg !909
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !906
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %465, i64 80, i1 false), !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.2.8.copyload" = load i64, ptr %116, align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !906
  %"new::NamedTuple.sroa.0.sroa.3.8.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.3.8..sroa_idx", align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.4.8.copyload" = load i64, ptr %138, align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !906
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5.8..sroa_idx", i64 16, i1 false), !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 16, !dbg !906
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %69, i64 112, i1 false), !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.9.128..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !906
  %"new::NamedTuple.sroa.0.sroa.9.128.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.9.128..sroa_idx", align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.10.128..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 256, !dbg !906
  %"new::NamedTuple.sroa.0.sroa.10.128.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.10.128..sroa_idx", align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.11.128..sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !906
  %"new::NamedTuple.sroa.0.sroa.11.128.copyload" = load i64, ptr %"new::NamedTuple.sroa.0.sroa.11.128..sroa_idx", align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::NamedTuple.sroa.0.sroa.12.128.copyload" = load i64, ptr %81, align 8, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !936
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !936
  %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 32, !dbg !936
  %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 96, !dbg !936
  store i64 1, ptr %6, align 8, !dbg !942, !tbaa !203, !alias.scope !189, !noalias !190
  %"process::Process.loopidx_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 472, !dbg !950
  %466 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !950, !tbaa !203, !alias.scope !189, !noalias !190
  %467 = add <2 x i64> %466, <i64 1, i64 1>, !dbg !955
  store <2 x i64> %467, ptr %"process::Process.loopidx_ptr", align 8, !dbg !956, !tbaa !203, !alias.scope !189, !noalias !190
  %468 = extractelement <2 x i64> %467, i64 0, !dbg !957
  %469 = icmp ugt i64 %468, 100000, !dbg !960
  %470 = extractelement <2 x i64> %466, i64 0, !dbg !964
  %value_phi83 = select i1 %469, i64 %470, i64 100000, !dbg !964
  %.not705.not = icmp ult i64 %value_phi83, %468, !dbg !957
  br i1 %.not705.not, label %L639.L1272_crit_edge, label %L639.L643_crit_edge, !dbg !632

pass226:                                          ; preds = %guard_pass615, %guard_pass610
  %.sroa.9.0 = phi i8 [ 1, %guard_pass610 ], [ 0, %guard_pass615 ], !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6878, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !971
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10), !dbg !971
  %"new::NamedTuple218.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple218.sroa.0.sroa.0", i64 8, !dbg !972
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple218.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %200, i64 80, i1 false), !dbg !972, !tbaa !283, !alias.scope !285, !noalias !286
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple218.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0682.sroa.11.0..sroa_idx947, i64 16, i1 false), !dbg !972, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::NamedTuple218.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple218.sroa.0.sroa.5", i64 16, !dbg !972
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple218.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %189, i64 112, i1 false), !dbg !972, !tbaa !283, !alias.scope !285, !noalias !286
  %"new::SubContext219.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext219.sroa.0.sroa.0", i64 8, !dbg !988
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext219.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple218.sroa.0.sroa.0", i64 88, i1 false), !dbg !988
  %"new::NamedTuple218.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple218.sroa.0.sroa.5", i64 32, !dbg !988
  %"new::NamedTuple218.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple218.sroa.0.sroa.5", i64 96, !dbg !988
  store i64 1, ptr %6, align 8, !dbg !991, !tbaa !203, !alias.scope !189, !noalias !190
  %471 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !996, !tbaa !203, !alias.scope !189, !noalias !190
  %472 = add <2 x i64> %471, <i64 1, i64 1>, !dbg !999
  store <2 x i64> %472, ptr %"process::Process.loopidx_ptr", align 8, !dbg !1000, !tbaa !203, !alias.scope !189, !noalias !190
  %473 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !1001, !tbaa !203, !alias.scope !189, !noalias !190
  %474 = and i8 %473, 1, !dbg !1001
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %474, 0, !dbg !1001
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L1261, label %L1262, !dbg !1007

guard_pass548:                                    ; preds = %L109
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !160
  store float %79, ptr %unionalloca.sroa.0, align 8, !tbaa !283, !alias.scope !285, !noalias !286
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload7321106 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !335
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !335
  %475 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload7321106 to i32, !dbg !1008
  %476 = bitcast i32 %475 to float, !dbg !1008
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101008), !dbg !160
  br label %L240

guard_pass553:                                    ; preds = %L194, %L192
  %value_phi492 = phi double [ %106, %L192 ], [ %spec.select625, %L194 ]
  %477 = fcmp ugt double %value_phi492, 2.000000e+00, !dbg !1010
  %478 = fadd double %value_phi492, -1.000000e+00, !dbg !1013
  %479 = fadd double %value_phi492, -2.000000e+00, !dbg !1013
  %480 = fsub double 1.000000e+00, %479, !dbg !1013
  %value_phi494 = select i1 %477, double %480, double %478, !dbg !1013
  %481 = fptrunc double %value_phi494 to float, !dbg !1014
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.101008), !dbg !160
  br label %L240

guard_pass558:                                    ; preds = %L530
  %482 = load ptr, ptr %.state56, align 8, !dbg !1016, !tbaa !310, !alias.scope !313, !noalias !314
  %483 = getelementptr i8, ptr %482, i64 %memoryref_offset, !dbg !1018
  %memoryref_data73 = getelementptr i8, ptr %483, i64 -4, !dbg !1018
  store float %.sroa.71002.0, ptr %memoryref_data73, align 4, !dbg !1018, !tbaa !318, !alias.scope !189, !noalias !190
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10997), !dbg !160
  %"new::NamedTuple.sroa.6.316.copyload.pre" = load i32, ptr %70, align 4, !dbg !906, !tbaa !270, !alias.scope !271, !noalias !272
  br label %pass78

guard_pass563:                                    ; preds = %L528
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10997), !dbg !160
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10997, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.111014, i64 7, i1 false), !dbg !160
  br label %pass78

guard_pass600:                                    ; preds = %L745
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca154.sroa.0), !dbg !631
  store float %209, ptr %unionalloca154.sroa.0, align 8, !dbg !631, !tbaa !283, !alias.scope !285, !noalias !286
  %unionalloca154.sroa.0.0.unionalloca154.sroa.0.0.unionalloca154.sroa.0.0.unionalloca154.sroa.0.0.copyload7371107 = load i64, ptr %unionalloca154.sroa.0, align 8, !dbg !681
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca154.sroa.0), !dbg !681
  %484 = trunc i64 %unionalloca154.sroa.0.0.unionalloca154.sroa.0.0.unionalloca154.sroa.0.0.unionalloca154.sroa.0.0.copyload7371107 to i32, !dbg !1024
  %485 = bitcast i32 %484 to float, !dbg !1024
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10931), !dbg !631
  br label %L876, !dbg !631

guard_pass605:                                    ; preds = %L830, %L828
  %value_phi419 = phi double [ %235, %L828 ], [ %spec.select627, %L830 ]
  %486 = fcmp ugt double %value_phi419, 2.000000e+00, !dbg !1025
  %487 = fadd double %value_phi419, -1.000000e+00, !dbg !1027
  %488 = fadd double %value_phi419, -2.000000e+00, !dbg !1027
  %489 = fsub double 1.000000e+00, %488, !dbg !1027
  %value_phi421 = select i1 %486, double %489, double %487, !dbg !1027
  %490 = fptrunc double %value_phi421 to float, !dbg !1028
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10931), !dbg !631
  br label %L876, !dbg !631

guard_pass610:                                    ; preds = %L1166
  %491 = load ptr, ptr %root_phi106.state199, align 8, !dbg !1030, !tbaa !310, !alias.scope !313, !noalias !314
  %492 = getelementptr i8, ptr %491, i64 %memoryref_offset137, !dbg !1032
  %memoryref_data216 = getelementptr i8, ptr %492, i64 -4, !dbg !1032
  store float %.sroa.7925.0, ptr %memoryref_data216, align 4, !dbg !1032, !tbaa !318, !alias.scope !189, !noalias !190
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !631
  br label %pass226, !dbg !631

guard_pass615:                                    ; preds = %L1164
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !631
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !631, !tbaa !283, !alias.scope !285, !noalias !286
  br label %pass226, !dbg !631
}
