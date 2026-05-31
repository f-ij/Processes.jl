; Function Signature: loop(InteractiveIsing.Processes.Process{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}}}, nothing}, NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x272ef34d, 0x3753bcd3, 0xeb5cf7a2, 0x55fccfa3, 0xb6593f18), Expr}}}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}}}, nothing}, NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x272ef34d, 0x3753bcd3, 0xeb5cf7a2, 0x55fccfa3, 0xb6593f18), Expr}}}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}}, InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}}}, nothing}, NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x272ef34d, 0x3753bcd3, 0xeb5cf7a2, 0x55fccfa3, 0xb6593f18), Expr}}}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}}}, nothing}, NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x272ef34d, 0x3753bcd3, 0xeb5cf7a2, 0x55fccfa3, 0xb6593f18), Expr}}}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, Tuple{InteractiveIsing.Processes.Init{:Metropolis_1, NamedTuple{(:model,), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, Nothing}}, Tuple{}, nothing}, InteractiveIsing.Processes.ProcessContext{NamedTuple{(:Metropolis_1,), Tuple{InteractiveIsing.Processes.SubContext{NamedTuple{(:model, :hamiltonian, :proposer, :rng, :proposal, :ΔE, :T), Tuple{InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, InteractiveIsing.HamiltonianTerms{Tuple{InteractiveIsing.PolynomialHamiltonian{2, InteractiveIsing.Parameters{NamedTuple{(:c, :lp), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.ConstFill{0f0, Float32, 0}}, InteractiveIsing.Parameter{InteractiveIsing.Passed, Array{Float32, 1}}}}, NamedTuple{(:c, :lp), Tuple{String, String}}, NamedTuple{(:c, :lp), Tuple{Nothing, Nothing}}}}, InteractiveIsing.Bilinear{InteractiveIsing.Parameters{NamedTuple{(:J,), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}}}}, NamedTuple{(:J,), Tuple{String}}, NamedTuple{(:J,), Tuple{Nothing}}}}, InteractiveIsing.MagField{InteractiveIsing.Parameters{NamedTuple{(:c, :b), Tuple{InteractiveIsing.Parameter{InteractiveIsing.Defaulted, Float32}, InteractiveIsing.Parameter{InteractiveIsing.Passed, InteractiveIsing.UniformArray{Float32, 1}}}}, NamedTuple{(:c, :b), Tuple{String, String}}, NamedTuple{(:c, :b), Tuple{Nothing, Nothing}}}}}}, InteractiveIsing.LocalProposer{Base.UnitRange{Int64}, Tuple{InteractiveIsing.IsingLayer{InteractiveIsing.Continuous(), 3, InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}}}, InteractiveIsing.IsingGraph{Float32, InteractiveIsing.UndirectedAdjacency{Float32, Int32, SparseArrays.SparseMatrixCSC{Float32, Int32}, InteractiveIsing.OffsetArray{Int64, 1, Array{Int64, 1}}, Nothing}, Tuple{InteractiveIsing.IsingLayerData{InteractiveIsing.Continuous(), (-1f0, 1f0), 3, (100, 100, 10), Base.UnitRange{Int64}(start=1, stop=100000), InteractiveIsing.SquareTopology{InteractiveIsing.PartPeriodic{(1, 2)}, 3, Float64}}}, Array{Float32, 1}, 1, Base.UnitRange{Int64}}, Float64}, Random.MersenneTwister, InteractiveIsing.FlipProposal{Float32}, Float32, Float32}}}}}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, NamedTuple{(:algo, :lifetime), Tuple{InteractiveIsing.Processes.LoopAlgorithm{InteractiveIsing.Processes.CompositeAlgorithm{Tuple{InteractiveIsing.Metropolis}, Tuple{InteractiveIsing.Processes.Interval{1, :end, 0}}, Tuple{InteractiveIsing.Processes.Namespace{:Metropolis_1}}, InteractiveIsing.Processes.PlanWiring{NamedTuple{(), Tuple{}}, Tuple{InteractiveIsing.Processes.Wiring{Tuple{}, Tuple{}}}}, Tuple{NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x226d32fd, 0xdba41edc, 0x9b456395, 0xf40dfbc5, 0x776d06d9), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_algorithm, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x7297aa97, 0x789c97dc, 0x5846fbf6, 0x9d553ffb, 0x858d430f), Expr}}}}, nothing}, NamedTuple{(:patch, :context), Tuple{RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_process, :_lifetime, :_globals, :_inputs, :Metropolis_1), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x51a07ab7, 0xca29ff27, 0x855e6f24, 0xee3025b6, 0xdd038d04), Expr}, RuntimeGeneratedFunctions.RuntimeGeneratedFunction{(:_plan, :_context, :_process, :_lifetime), InteractiveIsing.Processes.var"#_RGF_ModTag", InteractiveIsing.Processes.var"#_RGF_ModTag", (0x272ef34d, 0x3753bcd3, 0xeb5cf7a2, 0x55fccfa3, 0xb6593f18), Expr}}}, Tuple{}, Tuple{}, InteractiveIsing.Processes.NameSpaceRegistry{Tuple{InteractiveIsing.Processes.RegistryTypeEntry{InteractiveIsing.Metropolis, Tuple{InteractiveIsing.Processes.IdentifiableAlgo{InteractiveIsing.Metropolis, InteractiveIsing.Processes.SimpleId{Base.UUID(value=UInt128(0xf64d15ac232c4997b8e61ffc4e4682b0))}(), InteractiveIsing.Processes.VarAliases{NamedTuple(), NamedTuple()}(), nothing, :Metropolis_1}}}}}, Nothing, Tuple{}, Tuple{}, nothing}, InteractiveIsing.Processes.Repeat{100000}}}, NamedTuple{(), Tuple{}}, NamedTuple{(), Tuple{}}}, InteractiveIsing.Processes.Repeat{100000}, NamedTuple{(), Tuple{}}, InteractiveIsing.Processes.Resuming{false}, InteractiveIsing.Processes.RuntimeGeneratedContext)
define swiftcc void @julia_loop_9408(ptr noalias nocapture noundef nonnull sret({ [1 x { ptr, { ptr, [1 x { [1 x { { [1 x ptr] }, [2 x ptr] }], [1 x { [1 x [1 x { { i64, i64, ptr, ptr, ptr }, ptr }]], [1 x ptr] }], [1 x { { [1 x float], [1 x { ptr, [1 x i64] }] }, [2 x ptr] }] }], { [2 x i64], [1 x { { ptr, ptr, ptr, ptr, ptr, { [3 x i64], ptr, [1 x [3 x double]] } }, ptr, i64 }], ptr, double }, ptr, { i64, float, float, i64, i8 }, float, float } }], [1 x [1 x { ptr, ptr }]], { { { [1 x [2 x [1 x ptr]]], ptr }, [2 x [1 x ptr]], [1 x [1 x { ptr, ptr }]] } } }) align 8 dereferenceable(400) %sret_return, ptr noalias nocapture noundef nonnull align 8 dereferenceable(248) %return_roots, ptr nonnull swiftself %pgcstack, ptr noundef nonnull align 16 dereferenceable(592) %"process::Process", ptr nocapture noundef nonnull readonly align 8 dereferenceable(464) %"algo::LoopAlgorithm", ptr nocapture readonly %.roots.algo, ptr nocapture noundef nonnull readonly align 8 dereferenceable(400) %"context::ProcessContext", ptr nocapture readonly %.roots.context) #0 !dbg !5 {
top:
  %jlcallframe1 = alloca [5 x ptr], align 8
  %gcframe2 = alloca [11 x ptr], align 16
  call void @llvm.memset.p0.i64(ptr align 16 %gcframe2, i8 0, i64 88, i1 true)
  %0 = getelementptr inbounds ptr, ptr %gcframe2, i64 7
  %1 = getelementptr inbounds ptr, ptr %gcframe2, i64 2
  %2 = alloca [50 x i64], align 8
  %"new::SamplerRangeNDL" = alloca [2 x i64], align 8
  %unionalloca.sroa.0 = alloca double, align 8
  %.sroa.11 = alloca [7 x i8], align 1
  %.sroa.10657 = alloca [7 x i8], align 1
  %"new::#calculate##0#calculate##1" = alloca [5 x i64], align 8
  %"new::Tuple76" = alloca [1 x i64], align 8
  %.sroa.6604 = alloca [7 x i8], align 1
  %.sroa.10 = alloca [7 x i8], align 1
  %"new::NamedTuple.sroa.0.sroa.0" = alloca [11 x i64], align 8
  %"new::NamedTuple.sroa.0.sroa.5" = alloca [16 x i64], align 8
  %"new::SubContext.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::ProcessContext.sroa.6" = alloca [9 x i64], align 8
  %.sroa.0.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0.sroa.11 = alloca [4 x i64], align 8
  %.sroa.0.sroa.12 = alloca [8 x i64], align 8
  %.sroa.0.sroa.13 = alloca [4 x i64], align 8
  %.sroa.0.sroa.18.sroa.18 = alloca [7 x i8], align 1
  %.sroa.12 = alloca [9 x i64], align 8
  %.sroa.0414.sroa.0 = alloca [12 x i64], align 8
  %.sroa.0414.sroa.12 = alloca [4 x i64], align 8
  %.sroa.0414.sroa.14 = alloca [8 x i64], align 8
  %.sroa.0414.sroa.16 = alloca [4 x i64], align 8
  %.sroa.0414.sroa.26.sroa.11 = alloca [7 x i8], align 1
  %.sroa.8420 = alloca [9 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0" = alloca [12 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4" = alloca [4 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5" = alloca [8 x i64], align 8
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6" = alloca [4 x i64], align 8
  %"new::Tuple279" = alloca [1 x i64], align 8
  %"new::Tuple282" = alloca [1 x i64], align 8
  %"new::Tuple284" = alloca [1 x i64], align 8
  store i64 36, ptr %gcframe2, align 8, !tbaa !162
  %task.gcstack = load ptr, ptr %pgcstack, align 8
  %frame.prev = getelementptr inbounds ptr, ptr %gcframe2, i64 1
  store ptr %task.gcstack, ptr %frame.prev, align 8, !tbaa !162
  store ptr %gcframe2, ptr %pgcstack, align 8
  call void @llvm.dbg.declare(metadata ptr %"process::Process", metadata !157, metadata !DIExpression()), !dbg !166
  %3 = getelementptr inbounds i8, ptr %.roots.algo, i64 16
  %4 = load ptr, ptr %3, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  call void @llvm.dbg.declare(metadata ptr %"algo::LoopAlgorithm", metadata !158, metadata !DIExpression()), !dbg !166
  %5 = load ptr, ptr %.roots.context, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %6 = getelementptr inbounds i8, ptr %.roots.context, i64 8
  %7 = load ptr, ptr %6, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %8 = getelementptr inbounds i8, ptr %.roots.context, i64 16
  %9 = load ptr, ptr %8, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %10 = getelementptr inbounds i8, ptr %.roots.context, i64 24
  %11 = load ptr, ptr %10, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %12 = getelementptr inbounds i8, ptr %.roots.context, i64 32
  %13 = load ptr, ptr %12, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %14 = getelementptr inbounds i8, ptr %.roots.context, i64 40
  %15 = load ptr, ptr %14, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %16 = getelementptr inbounds i8, ptr %.roots.context, i64 48
  %17 = load ptr, ptr %16, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %18 = getelementptr inbounds i8, ptr %.roots.context, i64 56
  %19 = load ptr, ptr %18, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %20 = getelementptr inbounds i8, ptr %.roots.context, i64 64
  %21 = load ptr, ptr %20, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %22 = getelementptr inbounds i8, ptr %.roots.context, i64 72
  %23 = load ptr, ptr %22, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %24 = getelementptr inbounds i8, ptr %.roots.context, i64 80
  %25 = load ptr, ptr %24, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %26 = getelementptr inbounds i8, ptr %.roots.context, i64 88
  %27 = load ptr, ptr %26, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %28 = getelementptr inbounds i8, ptr %.roots.context, i64 96
  %29 = load ptr, ptr %28, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %30 = getelementptr inbounds i8, ptr %.roots.context, i64 104
  %31 = load ptr, ptr %30, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %32 = getelementptr inbounds i8, ptr %.roots.context, i64 112
  %33 = load ptr, ptr %32, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %34 = getelementptr inbounds i8, ptr %.roots.context, i64 120
  %35 = load ptr, ptr %34, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %36 = getelementptr inbounds i8, ptr %.roots.context, i64 128
  %37 = load ptr, ptr %36, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %38 = getelementptr inbounds i8, ptr %.roots.context, i64 136
  %39 = load ptr, ptr %38, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %40 = getelementptr inbounds i8, ptr %.roots.context, i64 144
  %41 = load ptr, ptr %40, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %42 = getelementptr inbounds i8, ptr %.roots.context, i64 152
  %43 = load ptr, ptr %42, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %44 = getelementptr inbounds i8, ptr %.roots.context, i64 160
  %45 = load ptr, ptr %44, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %46 = getelementptr inbounds i8, ptr %.roots.context, i64 168
  %47 = load ptr, ptr %46, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %48 = getelementptr inbounds i8, ptr %.roots.context, i64 176
  %49 = load ptr, ptr %48, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %50 = getelementptr inbounds i8, ptr %.roots.context, i64 184
  %51 = load ptr, ptr %50, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %52 = getelementptr inbounds i8, ptr %.roots.context, i64 192
  %53 = load ptr, ptr %52, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %54 = getelementptr inbounds i8, ptr %.roots.context, i64 200
  %55 = load ptr, ptr %54, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %56 = getelementptr inbounds i8, ptr %.roots.context, i64 208
  %57 = load ptr, ptr %56, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %58 = getelementptr inbounds i8, ptr %.roots.context, i64 216
  %59 = load ptr, ptr %58, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %60 = getelementptr inbounds i8, ptr %.roots.context, i64 224
  %61 = load ptr, ptr %60, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %62 = getelementptr inbounds i8, ptr %.roots.context, i64 232
  %63 = load ptr, ptr %62, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  %64 = getelementptr inbounds i8, ptr %.roots.context, i64 240
  %65 = load ptr, ptr %64, align 8, !tbaa !162, !alias.scope !167, !noalias !170
  call void @llvm.dbg.declare(metadata ptr %"context::ProcessContext", metadata !159, metadata !DIExpression()), !dbg !166
  %ptls_field = getelementptr inbounds i8, ptr %pgcstack, i64 16
  %ptls_load = load ptr, ptr %ptls_field, align 8, !tbaa !162
  %66 = getelementptr inbounds i8, ptr %ptls_load, i64 16
  %safepoint = load ptr, ptr %66, align 8, !tbaa !175, !invariant.load !0
  fence syncscope("singlethread") seq_cst
  %67 = load volatile i64, ptr %safepoint, align 8, !dbg !166
  fence syncscope("singlethread") seq_cst
  store i8 1, ptr @"jl_global#9411.jit", align 16, !dbg !177, !tbaa !187, !alias.scope !190, !noalias !191
  %thread_id_ptr = getelementptr inbounds i8, ptr %pgcstack, i64 -8, !dbg !192
  %thread_id = load i16, ptr %thread_id_ptr, align 2, !dbg !192, !tbaa !162, !alias.scope !167, !noalias !170
  %68 = sext i16 %thread_id to i64, !dbg !196
  %69 = add nsw i64 %68, 1, !dbg !201
  %"process::Process.threadid_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 584, !dbg !203
  store i64 %69, ptr %"process::Process.threadid_ptr", align 8, !dbg !203, !tbaa !204, !alias.scope !190, !noalias !191
  %70 = call i64 @jlplt_ijl_hrtime_9413_got.jit(), !dbg !206
  %"process::Process.starttime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 536, !dbg !212
  %"process::Process.starttime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 544, !dbg !212
  store i8 2, ptr %"process::Process.starttime.tindex_ptr", align 1, !dbg !212, !tbaa !204, !alias.scope !190, !noalias !191
  store i64 %70, ptr %"process::Process.starttime_ptr", align 8, !dbg !212, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.loopidx_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 504, !dbg !213
  %"process::Process.loopidx" = load i64, ptr %"process::Process.loopidx_ptr", align 8, !dbg !213, !tbaa !204, !alias.scope !190, !noalias !191
  %71 = icmp ugt i64 %"process::Process.loopidx", 100000, !dbg !219
  %72 = add i64 %"process::Process.loopidx", -1, !dbg !224
  %value_phi = select i1 %71, i64 %72, i64 100000, !dbg !224
  %.not.not = icmp ult i64 %value_phi, %"process::Process.loopidx", !dbg !233
  br i1 %.not.not, label %L32.L666_crit_edge, label %L32.L36_crit_edge, !dbg !232

L32.L666_crit_edge:                               ; preds = %top
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !239
  %".sroa.0.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !239
  %.sroa.0.sroa.8.0.copyload = load i64, ptr %".sroa.0.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.9.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 104, !dbg !239
  %.sroa.0.sroa.9.0.copyload = load i64, ptr %".sroa.0.sroa.9.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !239
  %.sroa.0.sroa.10.0.copyload = load i64, ptr %".sroa.0.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !239
  %".sroa.0.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !239
  %".sroa.0.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !239
  %".sroa.0.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !239
  %.sroa.0.sroa.14.0.copyload = load i64, ptr %".sroa.0.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.15.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 256, !dbg !239
  %.sroa.0.sroa.15.0.copyload = load i64, ptr %".sroa.0.sroa.15.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !239
  %.sroa.0.sroa.16.0.copyload = load i64, ptr %".sroa.0.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.17.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 272, !dbg !239
  %.sroa.0.sroa.17.0.copyload = load i64, ptr %".sroa.0.sroa.17.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !239
  %.sroa.0.sroa.18.sroa.0.0.copyload = load i64, ptr %".sroa.0.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.sroa.8.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 288, !dbg !239
  %.sroa.0.sroa.18.sroa.8.0.copyload = load i64, ptr %".sroa.0.sroa.18.sroa.8.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.sroa.10.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !239
  %.sroa.0.sroa.18.sroa.10.0.copyload = load float, ptr %".sroa.0.sroa.18.sroa.10.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.sroa.12.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 300, !dbg !239
  %.sroa.0.sroa.18.sroa.12.0.copyload = load float, ptr %".sroa.0.sroa.18.sroa.12.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 4, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.sroa.14.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !239
  %.sroa.0.sroa.18.sroa.14.0.copyload = load i64, ptr %".sroa.0.sroa.18.sroa.14.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.sroa.16.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !239
  %.sroa.0.sroa.18.sroa.16.0.copyload = load i8, ptr %".sroa.0.sroa.18.sroa.16.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0.sroa.18.sroa.18.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0.sroa.18.sroa.18.0..sroa.0.sroa.18.0.context::ProcessContext.sroa_idx.sroa_idx", i64 7, i1 false), !dbg !239
  %".sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !239
  %.sroa.8.0.copyload = load float, ptr %".sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !239
  %.sroa.10.0.copyload = load i32, ptr %".sroa.10.0.context::ProcessContext.sroa_idx", align 4, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 328, !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(72) %".sroa.12.0.context::ProcessContext.sroa_idx", i64 72, i1 false), !dbg !239
  br label %L666, !dbg !239

L32.L36_crit_edge:                                ; preds = %top
  %".sroa.0433.sroa.8.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 96, !dbg !239
  %".sroa.0433.sroa.10.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 112, !dbg !239
  %.sroa.0433.sroa.10.0.copyload670 = load i64, ptr %".sroa.0433.sroa.10.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0433.sroa.11.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 120, !dbg !239
  %".sroa.0433.sroa.12.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 152, !dbg !239
  %".sroa.0433.sroa.13.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 216, !dbg !239
  %".sroa.0433.sroa.14.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 248, !dbg !239
  %".sroa.0433.sroa.16.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 264, !dbg !239
  %".sroa.0433.sroa.18.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 280, !dbg !239
  %".sroa.0433.sroa.20.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 296, !dbg !239
  %".sroa.0433.sroa.22.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 304, !dbg !239
  %.sroa.0433.sroa.22.0.copyload700 = load i64, ptr %".sroa.0433.sroa.22.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0433.sroa.23.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 312, !dbg !239
  %.sroa.0433.sroa.23.0.copyload703 = load i8, ptr %".sroa.0433.sroa.23.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.0433.sroa.24.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 313, !dbg !239
  %".sroa.6434.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 320, !dbg !239
  %.sroa.6434.0.copyload435 = load float, ptr %".sroa.6434.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.7436.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 324, !dbg !239
  %.sroa.7436.0.copyload437 = load i32, ptr %".sroa.7436.0.context::ProcessContext.sroa_idx", align 4, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  %".sroa.8438.0.context::ProcessContext.sroa_idx" = getelementptr inbounds i8, ptr %"context::ProcessContext", i64 328, !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"context::ProcessContext", i64 96, i1 false), !dbg !232
  %.sroa.0433.sroa.8.0..sroa_idx665 = getelementptr inbounds i8, ptr %2, i64 96, !dbg !232
  %.sroa.0433.sroa.9.0..sroa_idx668 = getelementptr inbounds i8, ptr %2, i64 104, !dbg !232
  %73 = load <2 x i64>, ptr %".sroa.0433.sroa.8.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  store <2 x i64> %73, ptr %.sroa.0433.sroa.8.0..sroa_idx665, align 8, !dbg !232
  %.sroa.0433.sroa.10.0..sroa_idx671 = getelementptr inbounds i8, ptr %2, i64 112, !dbg !232
  store i64 %.sroa.0433.sroa.10.0.copyload670, ptr %.sroa.0433.sroa.10.0..sroa_idx671, align 8, !dbg !232
  %.sroa.0433.sroa.11.0..sroa_idx673 = getelementptr inbounds i8, ptr %2, i64 120, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.11.0..sroa_idx673, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0433.sroa.11.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !232
  %.sroa.0433.sroa.12.0..sroa_idx674 = getelementptr inbounds i8, ptr %2, i64 152, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0433.sroa.12.0..sroa_idx674, ptr noundef nonnull align 8 dereferenceable(64) %".sroa.0433.sroa.12.0.context::ProcessContext.sroa_idx", i64 64, i1 false), !dbg !232
  %.sroa.0433.sroa.13.0..sroa_idx675 = getelementptr inbounds i8, ptr %2, i64 216, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.13.0..sroa_idx675, ptr noundef nonnull align 8 dereferenceable(32) %".sroa.0433.sroa.13.0.context::ProcessContext.sroa_idx", i64 32, i1 false), !dbg !232
  %.sroa.0433.sroa.14.0..sroa_idx677 = getelementptr inbounds i8, ptr %2, i64 248, !dbg !232
  %.sroa.0433.sroa.15.0..sroa_idx680 = getelementptr inbounds i8, ptr %2, i64 256, !dbg !232
  %74 = load <2 x i64>, ptr %".sroa.0433.sroa.14.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  store <2 x i64> %74, ptr %.sroa.0433.sroa.14.0..sroa_idx677, align 8, !dbg !232
  %.sroa.0433.sroa.16.0..sroa_idx683 = getelementptr inbounds i8, ptr %2, i64 264, !dbg !232
  %.sroa.0433.sroa.17.0..sroa_idx686 = getelementptr inbounds i8, ptr %2, i64 272, !dbg !232
  %75 = load <2 x i64>, ptr %".sroa.0433.sroa.16.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  store <2 x i64> %75, ptr %.sroa.0433.sroa.16.0..sroa_idx683, align 8, !dbg !232
  %.sroa.0433.sroa.18.0..sroa_idx689 = getelementptr inbounds i8, ptr %2, i64 280, !dbg !232
  %.sroa.0433.sroa.19.0..sroa_idx692 = getelementptr inbounds i8, ptr %2, i64 288, !dbg !232
  %76 = load <2 x i64>, ptr %".sroa.0433.sroa.18.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  store <2 x i64> %76, ptr %.sroa.0433.sroa.18.0..sroa_idx689, align 8, !dbg !232
  %.sroa.0433.sroa.20.0..sroa_idx695 = getelementptr inbounds i8, ptr %2, i64 296, !dbg !232
  %.sroa.0433.sroa.21.0..sroa_idx698 = getelementptr inbounds i8, ptr %2, i64 300, !dbg !232
  %77 = load <2 x float>, ptr %".sroa.0433.sroa.20.0.context::ProcessContext.sroa_idx", align 8, !dbg !239, !tbaa !241, !alias.scope !242, !noalias !243
  store <2 x float> %77, ptr %.sroa.0433.sroa.20.0..sroa_idx695, align 8, !dbg !232
  %.sroa.0433.sroa.22.0..sroa_idx701 = getelementptr inbounds i8, ptr %2, i64 304, !dbg !232
  store i64 %.sroa.0433.sroa.22.0.copyload700, ptr %.sroa.0433.sroa.22.0..sroa_idx701, align 8, !dbg !232
  %.sroa.0433.sroa.23.0..sroa_idx704 = getelementptr inbounds i8, ptr %2, i64 312, !dbg !232
  store i8 %.sroa.0433.sroa.23.0.copyload703, ptr %.sroa.0433.sroa.23.0..sroa_idx704, align 8, !dbg !232
  %.sroa.0433.sroa.24.0..sroa_idx706 = getelementptr inbounds i8, ptr %2, i64 313, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0433.sroa.24.0..sroa_idx706, ptr noundef nonnull align 1 dereferenceable(7) %".sroa.0433.sroa.24.0.context::ProcessContext.sroa_idx", i64 7, i1 false), !dbg !232
  %.sroa.6434.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 320, !dbg !232
  store float %.sroa.6434.0.copyload435, ptr %.sroa.6434.0..sroa_idx, align 8, !dbg !232
  %.sroa.7436.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 324, !dbg !232
  store i32 %.sroa.7436.0.copyload437, ptr %.sroa.7436.0..sroa_idx, align 4, !dbg !232
  %.sroa.8438.0..sroa_idx = getelementptr inbounds i8, ptr %2, i64 328, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.8438.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(72) %".sroa.8438.0.context::ProcessContext.sroa_idx", i64 72, i1 false), !dbg !232
  %78 = getelementptr inbounds i8, ptr %2, i64 136, !dbg !244
  %.stop_ptr = getelementptr inbounds i8, ptr %2, i64 144, !dbg !282
  %.stop_ptr.unbox524 = load i64, ptr %.stop_ptr, align 8, !dbg !303, !tbaa !305, !alias.scope !307, !noalias !308
  %.unbox525 = load i64, ptr %78, align 8, !dbg !303, !tbaa !305, !alias.scope !307, !noalias !308
  %.not526 = icmp slt i64 %.stop_ptr.unbox524, %.unbox525, !dbg !303
  %79 = extractelement <2 x i64> %75, i64 1, !dbg !286
  %80 = bitcast i64 %79 to double, !dbg !286
  %81 = bitcast <2 x i64> %73 to i128, !dbg !286
  %82 = trunc i128 %81 to i64, !dbg !286
  %83 = extractelement <2 x i64> %73, i64 1, !dbg !286
  %84 = extractelement <2 x i64> %74, i64 0, !dbg !286
  %85 = extractelement <2 x i64> %74, i64 1, !dbg !286
  %86 = extractelement <2 x i64> %75, i64 0, !dbg !286
  br i1 %.not526, label %L63, label %L66.lr.ph, !dbg !286

L66.lr.ph:                                        ; preds = %L32.L36_crit_edge
  %87 = trunc i128 %81 to i32, !dbg !286
  %88 = getelementptr inbounds i8, ptr %"new::SamplerRangeNDL", i64 8
  %root_phi26.idxF_ptr288 = getelementptr inbounds i8, ptr %47, i64 32
  %root_phi26.vals_ptr290 = getelementptr inbounds i8, ptr %47, i64 16
  %89 = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 8
  %90 = getelementptr inbounds i8, ptr %2, i64 40
  %root_phi7.size_ptr = getelementptr inbounds i8, ptr %9, i64 16
  %91 = getelementptr inbounds ptr, ptr %gcframe2, i64 3
  %92 = getelementptr inbounds ptr, ptr %gcframe2, i64 4
  %93 = getelementptr inbounds ptr, ptr %gcframe2, i64 5
  %94 = getelementptr inbounds ptr, ptr %gcframe2, i64 6
  %95 = getelementptr inbounds i8, ptr %2, i64 16
  %"process::Process.shouldrun_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 528
  %"new::Tuple76.promoted" = load i64, ptr %"new::Tuple76", align 1, !tbaa !305, !alias.scope !307, !noalias !308
  br label %L66, !dbg !286

L63:                                              ; preds = %L665, %L32.L36_crit_edge
  %96 = call swiftcc [1 x ptr] @j_ArgumentError_9414(ptr nonnull swiftself %pgcstack, ptr nonnull @"jl_global#9415.jit"), !dbg !286
  %gc_slot_addr_7 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  %97 = extractvalue [1 x ptr] %96, 0, !dbg !286
  store ptr %97, ptr %gc_slot_addr_7, align 8
  %ptls_load964 = load ptr, ptr %ptls_field, align 8, !dbg !286, !tbaa !162
  %"box::ArgumentError" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load964, i32 424, i32 16, i64 4903880688) #23, !dbg !286
  %"box::ArgumentError.tag_addr" = getelementptr inbounds i64, ptr %"box::ArgumentError", i64 -1, !dbg !286
  store atomic i64 4903880688, ptr %"box::ArgumentError.tag_addr" unordered, align 8, !dbg !286, !tbaa !309
  store ptr %97, ptr %"box::ArgumentError", align 8, !dbg !286, !tbaa !311, !alias.scope !190, !noalias !191
  store ptr null, ptr %gc_slot_addr_7, align 8
  call void @ijl_throw(ptr nonnull %"box::ArgumentError"), !dbg !286
  unreachable, !dbg !286

L66:                                              ; preds = %L665, %L66.lr.ph
  %98 = phi i64 [ %"new::Tuple76.promoted", %L66.lr.ph ], [ %.fr793, %L665 ]
  %.unbox529 = phi i64 [ %.unbox525, %L66.lr.ph ], [ %.unbox, %L665 ]
  %.stop_ptr.unbox528 = phi i64 [ %.stop_ptr.unbox524, %L66.lr.ph ], [ %.stop_ptr.unbox, %L665 ]
  %value_phi5527 = phi i64 [ %"process::Process.loopidx", %L66.lr.ph ], [ %202, %L665 ]
  %.unbox75 = bitcast i32 %87 to float, !dbg !286
  %.unbox268 = bitcast i32 %.sroa.7436.0.copyload437 to float, !dbg !286
  %99 = add i64 %.stop_ptr.unbox528, 1, !dbg !313
  %100 = sub i64 %99, %.unbox529, !dbg !316
  store i64 %.unbox529, ptr %"new::SamplerRangeNDL", align 8, !dbg !317, !tbaa !305, !alias.scope !307, !noalias !308
  store i64 %100, ptr %88, align 8, !dbg !317, !tbaa !305, !alias.scope !307, !noalias !308
  %101 = call swiftcc i64 @j_rand_9417(ptr nonnull swiftself %pgcstack, ptr %47, ptr nocapture nonnull readonly %"new::SamplerRangeNDL"), !dbg !294
  %.fr793 = freeze i64 %101
  %root_phi25.state = load atomic ptr, ptr %45 unordered, align 8, !dbg !319, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !324, !align !325
  %root_phi25.state.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state, i64 16, !dbg !326
  %root_phi25.state.size.0.copyload = load i64, ptr %root_phi25.state.size_ptr, align 8, !dbg !326, !tbaa !241, !alias.scope !332, !noalias !333
  %.not439 = icmp eq i64 %root_phi25.state.size.0.copyload, 100000, !dbg !334
  br i1 %.not439, label %L92, label %L87, !dbg !329

L87:                                              ; preds = %L66
  call swiftcc void @j_throw_dmrsa_9418(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state.size.0.copyload) #9, !dbg !339
  unreachable, !dbg !339

L92:                                              ; preds = %L66
  %102 = load ptr, ptr %root_phi25.state, align 8, !dbg !340, !tbaa !342, !alias.scope !345, !noalias !346
  %memoryref_offset = shl i64 %.fr793, 2, !dbg !347
  %103 = getelementptr i8, ptr %102, i64 %memoryref_offset, !dbg !347
  %memoryref_data44 = getelementptr i8, ptr %103, i64 -4, !dbg !347
  %104 = load float, ptr %memoryref_data44, align 4, !dbg !347, !tbaa !350, !alias.scope !190, !noalias !191
  %105 = icmp slt i64 %.fr793, 100001
  br i1 %105, label %L138, label %L251, !dbg !352

L138:                                             ; preds = %L92
  %106 = call double @llvm.fabs.f64(double %80), !dbg !359
  %107 = fcmp oeq double %80, 0.000000e+00, !dbg !371
  br i1 %107, label %guard_pass356, label %L143, !dbg !373

L143:                                             ; preds = %L138
  %root_phi26.idxF289 = load i64, ptr %root_phi26.idxF_ptr288, align 8, !dbg !374, !tbaa !204, !alias.scope !190, !noalias !191
  %.not444 = icmp eq i64 %root_phi26.idxF289, 1002, !dbg !393
  br i1 %.not444, label %L146, label %L148, !dbg !378

L146:                                             ; preds = %L143
  %108 = call swiftcc i64 @j_gen_rand_9425(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !378
  %root_phi26.idxF293.pre = load i64, ptr %root_phi26.idxF_ptr288, align 8, !dbg !394, !tbaa !204, !alias.scope !190, !noalias !191
  br label %L148, !dbg !378

L148:                                             ; preds = %L146, %L143
  %root_phi26.idxF293 = phi i64 [ %root_phi26.idxF289, %L143 ], [ %root_phi26.idxF293.pre, %L146 ], !dbg !394
  %root_phi26.vals291 = load atomic ptr, ptr %root_phi26.vals_ptr290 unordered, align 8, !dbg !394, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !324, !align !325
  %109 = add i64 %root_phi26.idxF293, 1, !dbg !401
  store i64 %109, ptr %root_phi26.idxF_ptr288, align 8, !dbg !402, !tbaa !204, !alias.scope !190, !noalias !191
  %memoryref_data296 = load ptr, ptr %root_phi26.vals291, align 8, !dbg !403, !tbaa !342, !alias.scope !345, !noalias !346
  %memoryref_byteoffset299 = shl i64 %root_phi26.idxF293, 3, !dbg !403
  %memoryref_data304 = getelementptr inbounds i8, ptr %memoryref_data296, i64 %memoryref_byteoffset299, !dbg !403
  %110 = load i64, ptr %memoryref_data304, align 8, !dbg !403, !tbaa !350, !alias.scope !190, !noalias !191
  %111 = trunc i64 %110 to i32, !dbg !404
  %112 = and i32 %111, 8388607, !dbg !405
  %113 = or disjoint i32 %112, 1065353216, !dbg !407
  %bitcast_coercion306 = bitcast i32 %113 to float, !dbg !409
  %114 = fadd float %bitcast_coercion306, -1.000000e+00, !dbg !411
  %115 = fmul float %114, 2.000000e+00, !dbg !415
  %116 = fadd float %115, -1.000000e+00, !dbg !419
  %117 = fpext float %116 to double, !dbg !420
  %118 = fmul double %106, %117, !dbg !415
  %119 = fpext float %104 to double, !dbg !429
  %120 = fadd double %118, %119, !dbg !435
  %121 = fadd double %120, 1.000000e+00, !dbg !437
  %122 = fsub double %121, %121, !dbg !442
  %123 = fcmp uno double %122, 0.000000e+00, !dbg !451
  %124 = fcmp oeq double %121, 0.000000e+00
  %or.cond = or i1 %123, %124, !dbg !445
  %125 = call double @llvm.fabs.f64(double %121), !dbg !455
  br i1 %or.cond, label %L208, label %L204, !dbg !445

L204:                                             ; preds = %L148
  %126 = call swiftcc double @j_rem_internal_9429(ptr nonnull swiftself %pgcstack, double %125, double 4.000000e+00), !dbg !456
  %127 = call double @llvm.copysign.f64(double %126, double %121), !dbg !457
  br label %L216, !dbg !460

L208:                                             ; preds = %L148
  %128 = bitcast double %125 to i64, !dbg !462
  %.not445 = icmp eq i64 %128, 9218868437227405312, !dbg !462
  br i1 %.not445, label %L223, label %L216, !dbg !464

L216:                                             ; preds = %L208, %L204
  %value_phi307 = phi double [ %127, %L204 ], [ %121, %L208 ]
  %129 = fcmp une double %value_phi307, 0.000000e+00, !dbg !465
  br i1 %129, label %L223, label %L221, !dbg !467

L221:                                             ; preds = %L216
  %130 = call double @llvm.fabs.f64(double %value_phi307), !dbg !468
  br label %guard_pass361, !dbg !460

L223:                                             ; preds = %L216, %L208
  %value_phi307461 = phi double [ %value_phi307, %L216 ], [ 0x7FF8000000000000, %L208 ]
  %131 = fcmp ogt double %value_phi307461, 0.000000e+00, !dbg !470
  %132 = fadd double %value_phi307461, 4.000000e+00
  %spec.select378 = select i1 %131, double %value_phi307461, double %132, !dbg !474
  br label %guard_pass361, !dbg !474

L251:                                             ; preds = %L92
  store i64 %98, ptr %"new::Tuple76", align 1, !dbg !475, !tbaa !305, !alias.scope !307, !noalias !308
  %jl_nothing313 = load ptr, ptr @jl_nothing, align 8, !dbg !490, !tbaa !175, !invariant.load !0, !alias.scope !493, !noalias !494, !nonnull !0
  %box_Float32 = call ptr @ijl_box_float32(float %104), !dbg !490
  %gc_slot_addr_8 = getelementptr inbounds ptr, ptr %gcframe2, i64 10
  store ptr %box_Float32, ptr %gc_slot_addr_8, align 8
  %ptls_load969 = load ptr, ptr %ptls_field, align 8, !dbg !490, !tbaa !162
  %"box::Float64" = call noalias nonnull align 8 dereferenceable(16) ptr @ijl_gc_small_alloc(ptr %ptls_load969, i32 424, i32 16, i64 4904460432) #23, !dbg !490
  %"box::Float64.tag_addr" = getelementptr inbounds i64, ptr %"box::Float64", i64 -1, !dbg !490
  store atomic i64 4904460432, ptr %"box::Float64.tag_addr" unordered, align 8, !dbg !490, !tbaa !309
  store i64 %79, ptr %"box::Float64", align 8, !dbg !490, !tbaa !241, !alias.scope !495, !noalias !496
  %gc_slot_addr_7954 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %"box::Float64", ptr %gc_slot_addr_7954, align 8
  store ptr @"jl_global#9430.jit", ptr %jlcallframe1, align 8, !dbg !490
  %133 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 1, !dbg !490
  store ptr %47, ptr %133, align 8, !dbg !490
  %134 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 2, !dbg !490
  store ptr %jl_nothing313, ptr %134, align 8, !dbg !490
  %135 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 3, !dbg !490
  store ptr %box_Float32, ptr %135, align 8, !dbg !490
  %136 = getelementptr inbounds ptr, ptr %jlcallframe1, i64 4, !dbg !490
  store ptr %"box::Float64", ptr %136, align 8, !dbg !490
  %jl_f_throw_methoderror_ret = call nonnull ptr @jl_f_throw_methoderror(ptr null, ptr nonnull %jlcallframe1, i32 5), !dbg !490
  call void @llvm.trap(), !dbg !490
  unreachable, !dbg !490

L269:                                             ; preds = %guard_pass361, %guard_pass356
  %.sroa.7651.0 = phi float [ %379, %guard_pass356 ], [ %384, %guard_pass361 ], !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10657, i64 7, i1 false), !dbg !497
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10657), !dbg !497
  %"new::Tuple.sroa.0.sroa.6.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 33, !dbg !487
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::Tuple.sroa.0.sroa.6.0..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !497, !tbaa !305, !alias.scope !307, !noalias !308
  store i64 %.fr793, ptr %89, align 8, !dbg !487, !tbaa !305, !alias.scope !307, !noalias !308
  %"new::Tuple.sroa.0.sroa.2.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 16, !dbg !487
  store float %104, ptr %"new::Tuple.sroa.0.sroa.2.0..sroa_idx", align 8, !dbg !487, !tbaa !305, !alias.scope !307, !noalias !308
  %"new::Tuple.sroa.0.sroa.3.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 20, !dbg !487
  store float %.sroa.7651.0, ptr %"new::Tuple.sroa.0.sroa.3.0..sroa_idx", align 4, !dbg !487, !tbaa !305, !alias.scope !307, !noalias !308
  %"new::Tuple.sroa.0.sroa.4.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 24, !dbg !487
  store i64 1, ptr %"new::Tuple.sroa.0.sroa.4.0..sroa_idx", align 8, !dbg !487, !tbaa !305, !alias.scope !307, !noalias !308
  %"new::Tuple.sroa.0.sroa.5.0..sroa_idx" = getelementptr inbounds i8, ptr %"new::#calculate##0#calculate##1", i64 32, !dbg !487
  store i8 0, ptr %"new::Tuple.sroa.0.sroa.5.0..sroa_idx", align 8, !dbg !487, !tbaa !305, !alias.scope !307, !noalias !308
  %137 = add i64 %.fr793, -1, !dbg !498
  %root_phi7.size.0.copyload = load i64, ptr %root_phi7.size_ptr, align 8, !dbg !502, !tbaa !241, !alias.scope !332, !noalias !333
  %.not446 = icmp ult i64 %137, %root_phi7.size.0.copyload, !dbg !498
  br i1 %.not446, label %L327, label %L324, !dbg !498

L324:                                             ; preds = %L269
  store i64 %.fr793, ptr %"new::Tuple284", align 8, !dbg !498, !tbaa !305, !alias.scope !307, !noalias !308
  call swiftcc void @j_throw_boundserror_9427(ptr nonnull swiftself %pgcstack, ptr %9, ptr nocapture nonnull readonly %"new::Tuple284") #9, !dbg !498
  unreachable, !dbg !498

L327:                                             ; preds = %L269
  %root_phi6.state = load atomic ptr, ptr %7 unordered, align 8, !dbg !503, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !324, !align !325
  %memoryref_data55 = load ptr, ptr %9, align 8, !dbg !507, !tbaa !342, !alias.scope !345, !noalias !346
  %138 = getelementptr i8, ptr %memoryref_data55, i64 %memoryref_offset, !dbg !507
  %memoryref_data63 = getelementptr i8, ptr %138, i64 -4, !dbg !507
  %139 = load float, ptr %memoryref_data63, align 4, !dbg !507, !tbaa !350, !alias.scope !190, !noalias !191
  %140 = fpext float %.sroa.7651.0 to double, !dbg !508
  %gc_slot_addr_7955 = getelementptr inbounds ptr, ptr %gcframe2, i64 9
  store ptr %root_phi6.state, ptr %gc_slot_addr_7955, align 8
  %141 = call swiftcc double @"j_#power_by_squaring#401_9421"(ptr nonnull swiftself %pgcstack, double %140, i64 signext 2), !dbg !515
  %root_phi6.state.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state, i64 16, !dbg !502
  %root_phi6.state.size.0.copyload = load i64, ptr %root_phi6.state.size_ptr, align 8, !dbg !502, !tbaa !241, !alias.scope !332, !noalias !333
  %.not447 = icmp ult i64 %137, %root_phi6.state.size.0.copyload, !dbg !498
  br i1 %.not447, label %L352, label %L349, !dbg !498

L349:                                             ; preds = %L327
  store i64 %.fr793, ptr %"new::Tuple282", align 8, !dbg !498, !tbaa !305, !alias.scope !307, !noalias !308
  store ptr %root_phi6.state, ptr %gc_slot_addr_7955, align 8
  call swiftcc void @j_throw_boundserror_9427(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state, ptr nocapture nonnull readonly %"new::Tuple282") #9, !dbg !498
  unreachable, !dbg !498

L352:                                             ; preds = %L327
  %142 = fptrunc double %141 to float, !dbg !518
  %memoryref_data65 = load ptr, ptr %root_phi6.state, align 8, !dbg !507, !tbaa !342, !alias.scope !345, !noalias !346
  %143 = getelementptr i8, ptr %memoryref_data65, i64 %memoryref_offset, !dbg !507
  %memoryref_data73 = getelementptr i8, ptr %143, i64 -4, !dbg !507
  %144 = load float, ptr %memoryref_data73, align 4, !dbg !507, !tbaa !350, !alias.scope !190, !noalias !191
  %145 = fpext float %144 to double, !dbg !508
  store ptr null, ptr %gc_slot_addr_7955, align 8
  %146 = call swiftcc double @"j_#power_by_squaring#401_9421"(ptr nonnull swiftself %pgcstack, double %145, i64 signext 2), !dbg !515
  %147 = fptrunc double %146 to float, !dbg !518
  %148 = fsub float %142, %147, !dbg !523
  %149 = fmul float %139, 0.000000e+00, !dbg !524
  %150 = fmul float %149, %148, !dbg !524
  %151 = fadd float %150, 0.000000e+00, !dbg !527
  store ptr %7, ptr %0, align 8, !dbg !484
  store ptr %15, ptr %1, align 8, !dbg !484
  store ptr %17, ptr %91, align 8, !dbg !484
  store ptr %19, ptr %92, align 8, !dbg !484
  store ptr %21, ptr %93, align 8, !dbg !484
  store ptr %23, ptr %94, align 8, !dbg !484
  %152 = call swiftcc float @"j_#calculate##0_9422"(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %"new::#calculate##0#calculate##1", ptr nocapture nonnull readonly %0, float %151, ptr nocapture nonnull readonly %90, ptr nocapture nonnull readonly %1), !dbg !484
  %153 = fneg float %.unbox75, !dbg !528
  %.not448 = icmp ult i64 %137, %.sroa.0433.sroa.10.0.copyload670, !dbg !529
  br i1 %.not448, label %L410, label %L407, !dbg !535

L407:                                             ; preds = %L352
  %154 = getelementptr inbounds ptr, ptr %gcframe2, i64 8
  store i64 %.fr793, ptr %"new::Tuple76", align 1, !dbg !475, !tbaa !305, !alias.scope !307, !noalias !308
  store ptr %25, ptr %154, align 8, !dbg !535
  call swiftcc void @j_throw_boundserror_9428(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly %.sroa.0433.sroa.9.0..sroa_idx668, ptr nocapture nonnull readonly %154, ptr nocapture nonnull readonly %"new::Tuple76") #9, !dbg !535
  unreachable, !dbg !535

L410:                                             ; preds = %L352
  %root_phi6.state74 = load atomic ptr, ptr %7 unordered, align 8, !dbg !536, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !324, !align !325
  %root_phi6.state74.size_ptr = getelementptr inbounds i8, ptr %root_phi6.state74, i64 16, !dbg !538
  %root_phi6.state74.size.0.copyload = load i64, ptr %root_phi6.state74.size_ptr, align 8, !dbg !538, !tbaa !241, !alias.scope !332, !noalias !333
  %.not449 = icmp ult i64 %137, %root_phi6.state74.size.0.copyload, !dbg !539
  br i1 %.not449, label %L427, label %L424, !dbg !539

L424:                                             ; preds = %L410
  store i64 %.fr793, ptr %"new::Tuple279", align 8, !dbg !539, !tbaa !305, !alias.scope !307, !noalias !308
  store ptr %root_phi6.state74, ptr %gc_slot_addr_7955, align 8
  call swiftcc void @j_throw_boundserror_9427(ptr nonnull swiftself %pgcstack, ptr nonnull %root_phi6.state74, ptr nocapture nonnull readonly %"new::Tuple279") #9, !dbg !539
  unreachable, !dbg !539

L427:                                             ; preds = %L410
  %root_phi15.x = load float, ptr %25, align 4, !dbg !540, !tbaa !204, !alias.scope !190, !noalias !191
  %memoryref_data79 = load ptr, ptr %root_phi6.state74, align 8, !dbg !544, !tbaa !342, !alias.scope !345, !noalias !346
  %155 = getelementptr i8, ptr %memoryref_data79, i64 %memoryref_offset, !dbg !544
  %memoryref_data87 = getelementptr i8, ptr %155, i64 -4, !dbg !544
  %156 = load float, ptr %memoryref_data87, align 4, !dbg !544, !tbaa !350, !alias.scope !190, !noalias !191
  %157 = fsub float %.sroa.7651.0, %156, !dbg !545
  %158 = fmul float %root_phi15.x, %153, !dbg !546
  %159 = fmul float %158, %157, !dbg !546
  %160 = fadd float %152, %159, !dbg !527
  %161 = fcmp ugt float %160, 0.000000e+00, !dbg !548
  br i1 %161, label %L442, label %L559, !dbg !550

L442:                                             ; preds = %L427
  %root_phi26.idxF = load i64, ptr %root_phi26.idxF_ptr288, align 8, !dbg !551, !tbaa !204, !alias.scope !190, !noalias !191
  %.not450 = icmp eq i64 %root_phi26.idxF, 1002, !dbg !564
  br i1 %.not450, label %L445, label %L447, !dbg !553

L445:                                             ; preds = %L442
  %162 = call swiftcc i64 @j_gen_rand_9425(ptr nonnull swiftself %pgcstack, ptr %47), !dbg !553
  %root_phi26.idxF255.pre = load i64, ptr %root_phi26.idxF_ptr288, align 8, !dbg !565, !tbaa !204, !alias.scope !190, !noalias !191
  br label %L447, !dbg !553

L447:                                             ; preds = %L445, %L442
  %root_phi26.idxF255 = phi i64 [ %root_phi26.idxF, %L442 ], [ %root_phi26.idxF255.pre, %L445 ], !dbg !565
  %root_phi26.vals = load atomic ptr, ptr %root_phi26.vals_ptr290 unordered, align 8, !dbg !565, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !324, !align !325
  %163 = add i64 %root_phi26.idxF255, 1, !dbg !570
  store i64 %163, ptr %root_phi26.idxF_ptr288, align 8, !dbg !571, !tbaa !204, !alias.scope !190, !noalias !191
  %memoryref_data258 = load ptr, ptr %root_phi26.vals, align 8, !dbg !572, !tbaa !342, !alias.scope !345, !noalias !346
  %memoryref_byteoffset261 = shl i64 %root_phi26.idxF255, 3, !dbg !572
  %memoryref_data266 = getelementptr inbounds i8, ptr %memoryref_data258, i64 %memoryref_byteoffset261, !dbg !572
  %164 = load i64, ptr %memoryref_data266, align 8, !dbg !572, !tbaa !350, !alias.scope !190, !noalias !191
  %165 = trunc i64 %164 to i32, !dbg !573
  %166 = and i32 %165, 8388607, !dbg !574
  %167 = or disjoint i32 %166, 1065353216, !dbg !575
  %bitcast_coercion267 = bitcast i32 %167 to float, !dbg !576
  %168 = fadd float %bitcast_coercion267, -1.000000e+00, !dbg !577
  %169 = fneg float %160, !dbg !579
  %170 = fdiv float %169, %.unbox268, !dbg !580
  %171 = fmul float %170, 0x3FF7154760000000, !dbg !582
  %172 = call float @llvm.rint.f32(float %171), !dbg !588
  %173 = fptosi float %172 to i32, !dbg !592
  %174 = freeze i32 %173, !dbg !592
  %175 = fmul contract float %172, 0x3FE62E4000000000, !dbg !595
  %176 = fsub contract float %170, %175, !dbg !595
  %177 = fmul contract float %172, 0x3EB7F7D1C0000000, !dbg !598
  %178 = fsub contract float %176, %177, !dbg !598
  %179 = fmul contract float %178, 0x3F2A1D7140000000, !dbg !600
  %180 = fadd contract float %179, 0x3F56DA7560000000, !dbg !600
  %181 = fmul contract float %178, %180, !dbg !600
  %182 = fadd contract float %181, 0x3F811105C0000000, !dbg !600
  %183 = fmul contract float %178, %182, !dbg !600
  %184 = fadd contract float %183, 0x3FA5554640000000, !dbg !600
  %185 = fmul contract float %178, %184, !dbg !600
  %186 = fadd contract float %185, 0x3FC5555560000000, !dbg !600
  %187 = fmul contract float %178, %186, !dbg !600
  %188 = fadd contract float %187, 5.000000e-01, !dbg !600
  %189 = fmul contract float %178, %188, !dbg !600
  %190 = fadd contract float %189, 1.000000e+00, !dbg !600
  %191 = fmul contract float %178, %190, !dbg !600
  %192 = fadd contract float %191, 1.000000e+00, !dbg !600
  %193 = fcmp ule float %170, 0x40562E4300000000, !dbg !608
  br i1 %193, label %L506, label %L557, !dbg !610

L506:                                             ; preds = %L447
  %194 = fcmp uge float %170, 0xC059FE3680000000, !dbg !611
  br i1 %194, label %L550, label %L557, !dbg !612

L550:                                             ; preds = %L506
  %195 = fcmp ugt float %170, 0xC055D58A00000000, !dbg !613
  %196 = fmul float %192, 0x3E70000000000000, !dbg !614
  %value_phi271 = select i1 %195, float %192, float %196, !dbg !614
  %.not451 = icmp eq i32 %174, 128, !dbg !615
  %197 = fmul float %value_phi271, 2.000000e+00, !dbg !617
  %value_phi273 = select i1 %.not451, float %197, float %value_phi271, !dbg !617
  %value_phi270.v = select i1 %195, i32 127, i32 151, !dbg !614
  %value_phi270 = add i32 %174, %value_phi270.v, !dbg !614
  %198 = sext i1 %.not451 to i32, !dbg !617
  %value_phi272 = add i32 %value_phi270, %198, !dbg !617
  %199 = shl i32 %value_phi272, 23, !dbg !618
  %bitcast_coercion276 = bitcast i32 %199 to float, !dbg !624
  %200 = fmul float %value_phi273, %bitcast_coercion276, !dbg !625
  br label %L557, !dbg !460

L557:                                             ; preds = %L550, %L506, %L447
  %value_phi269 = phi float [ %200, %L550 ], [ 0x7FF0000000000000, %L447 ], [ 0.000000e+00, %L506 ]
  %201 = fcmp olt float %168, %value_phi269, !dbg !626
  br i1 %201, label %L559, label %guard_pass371, !dbg !550

L559:                                             ; preds = %L557, %L427
  %root_phi25.state89 = load atomic ptr, ptr %45 unordered, align 8, !dbg !627, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0, !dereferenceable !324, !align !325
  %root_phi25.state89.size_ptr = getelementptr inbounds i8, ptr %root_phi25.state89, i64 16, !dbg !633
  %root_phi25.state89.size.0.copyload = load i64, ptr %root_phi25.state89.size_ptr, align 8, !dbg !633, !tbaa !241, !alias.scope !332, !noalias !333
  %.not452 = icmp eq i64 %root_phi25.state89.size.0.copyload, 100000, !dbg !635
  br i1 %.not452, label %guard_pass366, label %L567, !dbg !634

L567:                                             ; preds = %L559
  call swiftcc void @j_throw_dmrsa_9418(ptr nonnull swiftself %pgcstack, ptr nocapture nonnull readonly @"_j_const#3", i64 signext %root_phi25.state89.size.0.copyload) #9, !dbg !637
  unreachable, !dbg !637

L655:                                             ; preds = %pass110
  store i64 %.fr793, ptr %"new::Tuple76", align 1, !dbg !475, !tbaa !305, !alias.scope !307, !noalias !308
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6604, i64 7, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(72) %"new::ProcessContext.sroa.6", i64 72, i1 false), !dbg !239
  br label %L666, !dbg !239

L656:                                             ; preds = %pass110
  %.not455.not.not = icmp eq i64 %value_phi5527, %value_phi, !dbg !638
  br i1 %.not455.not.not, label %L661.L666_crit_edge, label %L665, !dbg !461

L661.L666_crit_edge:                              ; preds = %L656
  store i64 %.fr793, ptr %"new::Tuple76", align 1, !dbg !475, !tbaa !305, !alias.scope !307, !noalias !308
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6604, i64 7, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.12, ptr noundef nonnull align 8 dereferenceable(72) %"new::ProcessContext.sroa.6", i64 72, i1 false), !dbg !239
  br label %L666, !dbg !239

L665:                                             ; preds = %L656
  %202 = add i64 %value_phi5527, 1, !dbg !460
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %2, ptr noundef nonnull align 8 dereferenceable(96) %"new::SubContext.sroa.0.sroa.0", i64 96, i1 false), !dbg !232
  store i64 %82, ptr %.sroa.0433.sroa.8.0..sroa_idx665, align 8, !dbg !232
  store i64 %83, ptr %.sroa.0433.sroa.9.0..sroa_idx668, align 8, !dbg !232
  store i64 %.sroa.0433.sroa.10.0.copyload670, ptr %.sroa.0433.sroa.10.0..sroa_idx671, align 8, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.11.0..sroa_idx673, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5", i64 32, i1 false), !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0433.sroa.12.0..sroa_idx674, ptr noundef nonnull align 8 dereferenceable(64) %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx", i64 64, i1 false), !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0433.sroa.13.0..sroa_idx675, ptr noundef nonnull align 8 dereferenceable(32) %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx", i64 32, i1 false), !dbg !232
  store i64 %84, ptr %.sroa.0433.sroa.14.0..sroa_idx677, align 8, !dbg !232
  store i64 %85, ptr %.sroa.0433.sroa.15.0..sroa_idx680, align 8, !dbg !232
  store i64 %86, ptr %.sroa.0433.sroa.16.0..sroa_idx683, align 8, !dbg !232
  store i64 %79, ptr %.sroa.0433.sroa.17.0..sroa_idx686, align 8, !dbg !232
  store i64 %.fr793, ptr %.sroa.0433.sroa.19.0..sroa_idx692, align 8, !dbg !232
  store float %104, ptr %.sroa.0433.sroa.20.0..sroa_idx695, align 8, !dbg !232
  store float %.sroa.7651.0, ptr %.sroa.0433.sroa.21.0..sroa_idx698, align 4, !dbg !232
  store i64 1, ptr %.sroa.0433.sroa.22.0..sroa_idx701, align 8, !dbg !232
  store i8 %.sroa.9.0, ptr %.sroa.0433.sroa.23.0..sroa_idx704, align 8, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0433.sroa.24.0..sroa_idx706, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6604, i64 7, i1 false), !dbg !232
  store float %160, ptr %.sroa.6434.0..sroa_idx, align 8, !dbg !232
  store i32 %.sroa.7436.0.copyload437, ptr %.sroa.7436.0..sroa_idx, align 4, !dbg !232
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.8438.0..sroa_idx, ptr noundef nonnull align 8 dereferenceable(72) %"new::ProcessContext.sroa.6", i64 72, i1 false), !dbg !232
  %.stop_ptr.unbox = load i64, ptr %.stop_ptr, align 8, !dbg !303, !tbaa !305, !alias.scope !307, !noalias !308
  %.unbox = load i64, ptr %78, align 8, !dbg !303, !tbaa !305, !alias.scope !307, !noalias !308
  %.not = icmp slt i64 %.stop_ptr.unbox, %.unbox, !dbg !303
  br i1 %.not, label %L63, label %L66, !dbg !286

L666:                                             ; preds = %L661.L666_crit_edge, %L655, %L32.L666_crit_edge
  %.sroa.0.sroa.8.0 = phi i64 [ %.sroa.0.sroa.8.0.copyload, %L32.L666_crit_edge ], [ %82, %L661.L666_crit_edge ], [ %82, %L655 ], !dbg !239
  %.sroa.0.sroa.9.0 = phi i64 [ %.sroa.0.sroa.9.0.copyload, %L32.L666_crit_edge ], [ %83, %L661.L666_crit_edge ], [ %83, %L655 ], !dbg !239
  %.sroa.0.sroa.10.0 = phi i64 [ %.sroa.0.sroa.10.0.copyload, %L32.L666_crit_edge ], [ %.sroa.0433.sroa.10.0.copyload670, %L661.L666_crit_edge ], [ %.sroa.0433.sroa.10.0.copyload670, %L655 ], !dbg !239
  %.sroa.0.sroa.14.0 = phi i64 [ %.sroa.0.sroa.14.0.copyload, %L32.L666_crit_edge ], [ %84, %L661.L666_crit_edge ], [ %84, %L655 ], !dbg !239
  %.sroa.0.sroa.15.0 = phi i64 [ %.sroa.0.sroa.15.0.copyload, %L32.L666_crit_edge ], [ %85, %L661.L666_crit_edge ], [ %85, %L655 ], !dbg !239
  %.sroa.0.sroa.16.0 = phi i64 [ %.sroa.0.sroa.16.0.copyload, %L32.L666_crit_edge ], [ %86, %L661.L666_crit_edge ], [ %86, %L655 ], !dbg !239
  %.sroa.0.sroa.17.0 = phi i64 [ %.sroa.0.sroa.17.0.copyload, %L32.L666_crit_edge ], [ %79, %L661.L666_crit_edge ], [ %79, %L655 ], !dbg !239
  %.sroa.0.sroa.18.sroa.0.0 = phi i64 [ %.sroa.0.sroa.18.sroa.0.0.copyload, %L32.L666_crit_edge ], [ undef, %L661.L666_crit_edge ], [ undef, %L655 ], !dbg !239
  %.sroa.0.sroa.18.sroa.8.0 = phi i64 [ %.sroa.0.sroa.18.sroa.8.0.copyload, %L32.L666_crit_edge ], [ %.fr793, %L661.L666_crit_edge ], [ %.fr793, %L655 ], !dbg !239
  %.sroa.0.sroa.18.sroa.10.0 = phi float [ %.sroa.0.sroa.18.sroa.10.0.copyload, %L32.L666_crit_edge ], [ %104, %L661.L666_crit_edge ], [ %104, %L655 ], !dbg !239
  %.sroa.0.sroa.18.sroa.12.0 = phi float [ %.sroa.0.sroa.18.sroa.12.0.copyload, %L32.L666_crit_edge ], [ %.sroa.7651.0, %L661.L666_crit_edge ], [ %.sroa.7651.0, %L655 ], !dbg !239
  %.sroa.0.sroa.18.sroa.14.0 = phi i64 [ %.sroa.0.sroa.18.sroa.14.0.copyload, %L32.L666_crit_edge ], [ 1, %L661.L666_crit_edge ], [ 1, %L655 ], !dbg !239
  %.sroa.0.sroa.18.sroa.16.0 = phi i8 [ %.sroa.0.sroa.18.sroa.16.0.copyload, %L32.L666_crit_edge ], [ %.sroa.9.0, %L661.L666_crit_edge ], [ %.sroa.9.0, %L655 ], !dbg !239
  %.sroa.8.0 = phi float [ %.sroa.8.0.copyload, %L32.L666_crit_edge ], [ %160, %L661.L666_crit_edge ], [ %160, %L655 ], !dbg !239
  %.sroa.10.0 = phi i32 [ %.sroa.10.0.copyload, %L32.L666_crit_edge ], [ %.sroa.7436.0.copyload437, %L661.L666_crit_edge ], [ %.sroa.7436.0.copyload437, %L655 ], !dbg !239
  %203 = call i64 @jlplt_ijl_hrtime_9413_got.jit(), !dbg !639
  %"process::Process.endtime_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 552, !dbg !645
  %"process::Process.endtime.tindex_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 560, !dbg !645
  store i8 2, ptr %"process::Process.endtime.tindex_ptr", align 1, !dbg !645, !tbaa !204, !alias.scope !190, !noalias !191
  store i64 %203, ptr %"process::Process.endtime_ptr", align 8, !dbg !645, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.task_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 496, !dbg !646
  %"process::Process.task" = load atomic ptr, ptr %"process::Process.task_ptr" unordered, align 8, !dbg !646, !tbaa !204, !alias.scope !190, !noalias !191, !nonnull !0
  %"process::Process.task.tag_addr" = getelementptr inbounds i64, ptr %"process::Process.task", i64 -1, !dbg !647
  %"process::Process.task.tag" = load atomic volatile i64, ptr %"process::Process.task.tag_addr" unordered, align 8, !dbg !647, !tbaa !309, !range !651
  %204 = and i64 %"process::Process.task.tag", -16, !dbg !647
  %205 = inttoptr i64 %204 to ptr, !dbg !647
  %exactly_isa.not.not = icmp eq ptr %205, @"+Core.Nothing#9423.jit", !dbg !647
  %"process::Process.paused_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 529, !dbg !647
  %206 = load atomic i8, ptr %"process::Process.paused_ptr" unordered, align 1, !dbg !647
  %207 = and i8 %206, 1, !dbg !650
  %208 = icmp eq i8 %207, 0, !dbg !650
  %.not459 = select i1 %exactly_isa.not.not, i1 true, i1 %208, !dbg !650
  br i1 %.not459, label %L723, label %L702, !dbg !650

L702:                                             ; preds = %L666
  %"process::Process.runtime_context_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 480, !dbg !652
  %ptls_load977 = load ptr, ptr %ptls_field, align 8, !dbg !652, !tbaa !162
  %"box::ProcessContext" = call noalias nonnull align 8 dereferenceable(448) ptr @ijl_gc_small_alloc(ptr %ptls_load977, i32 1144, i32 448, i64 13731727248) #23, !dbg !652
  %"box::ProcessContext.tag_addr" = getelementptr inbounds i64, ptr %"box::ProcessContext", i64 -1, !dbg !652
  store atomic i64 13731727248, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !652, !tbaa !309
  store atomic ptr %5, ptr %"box::ProcessContext" unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %209 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 8, !dbg !652
  store atomic ptr %7, ptr %209 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %210 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 16, !dbg !652
  store atomic ptr %9, ptr %210 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %211 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 24, !dbg !652
  store atomic ptr %11, ptr %211 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %212 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 32, !dbg !652
  store atomic ptr %13, ptr %212 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %213 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 40, !dbg !652
  %.sroa.0391.sroa.0.40.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.0, i64 40, !dbg !652
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %213, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0391.sroa.0.40.sroa_idx, i64 16, i1 false), !dbg !652
  %214 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 56, !dbg !652
  store atomic ptr %15, ptr %214 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %215 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 64, !dbg !652
  store atomic ptr %17, ptr %215 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %216 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 72, !dbg !652
  store atomic ptr %19, ptr %216 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %217 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 80, !dbg !652
  store atomic ptr %21, ptr %217 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %218 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 88, !dbg !652
  store atomic ptr %23, ptr %218 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %219 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 96, !dbg !652
  store i64 %.sroa.0.sroa.8.0, ptr %219, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %220 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 104, !dbg !652
  store atomic ptr %25, ptr %220 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %221 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 112, !dbg !652
  store i64 %.sroa.0.sroa.10.0, ptr %221, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %222 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 120, !dbg !652
  store atomic ptr %27, ptr %222 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %223 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 128, !dbg !652
  store atomic ptr %29, ptr %223 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %224 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 136, !dbg !652
  %.sroa.0391.sroa.10.136.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.11, i64 16, !dbg !652
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %224, ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0391.sroa.10.136.sroa_idx, i64 16, i1 false), !dbg !652
  %225 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 152, !dbg !652
  store atomic ptr %31, ptr %225 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %226 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 160, !dbg !652
  store atomic ptr %33, ptr %226 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %227 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 168, !dbg !652
  store atomic ptr %35, ptr %227 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %228 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 176, !dbg !652
  store atomic ptr %37, ptr %228 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %229 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 184, !dbg !652
  store atomic ptr %39, ptr %229 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %230 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 192, !dbg !652
  %.sroa.0391.sroa.12.192.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.12, i64 40, !dbg !652
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %230, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0391.sroa.12.192.sroa_idx, i64 24, i1 false), !dbg !652
  %231 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 216, !dbg !652
  store atomic ptr %41, ptr %231 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %232 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 224, !dbg !652
  %.sroa.0391.sroa.14.224.sroa_idx = getelementptr inbounds i8, ptr %.sroa.0.sroa.13, i64 8, !dbg !652
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %232, ptr noundef nonnull align 8 dereferenceable(24) %.sroa.0391.sroa.14.224.sroa_idx, i64 24, i1 false), !dbg !652
  %233 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 248, !dbg !652
  store atomic ptr %43, ptr %233 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %234 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 256, !dbg !652
  store i64 %.sroa.0.sroa.15.0, ptr %234, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %235 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 264, !dbg !652
  store atomic ptr %45, ptr %235 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %236 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 272, !dbg !652
  store i64 %.sroa.0.sroa.17.0, ptr %236, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %237 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 280, !dbg !652
  store atomic ptr %47, ptr %237 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %238 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 288, !dbg !652
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %238, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %.sroa.0391.sroa.22.sroa.6.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 296, !dbg !652
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0391.sroa.22.sroa.6.8..sroa_idx, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %.sroa.0391.sroa.22.sroa.7.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 300, !dbg !652
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0391.sroa.22.sroa.7.8..sroa_idx, align 4, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %.sroa.0391.sroa.22.sroa.8.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 304, !dbg !652
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %.sroa.0391.sroa.22.sroa.8.8..sroa_idx, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %.sroa.0391.sroa.22.sroa.9.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 312, !dbg !652
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0391.sroa.22.sroa.9.8..sroa_idx, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %.sroa.0391.sroa.22.sroa.10.8..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 313, !dbg !652
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0391.sroa.22.sroa.10.8..sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !652
  %.sroa.15.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 320, !dbg !652
  store float %.sroa.8.0, ptr %.sroa.15.288..sroa_idx, align 8, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %.sroa.16.288..sroa_idx = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 324, !dbg !652
  store i32 %.sroa.10.0, ptr %.sroa.16.288..sroa_idx, align 4, !dbg !652, !tbaa !241, !alias.scope !495, !noalias !496
  %239 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 328, !dbg !652
  store atomic ptr %49, ptr %239 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %240 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 336, !dbg !652
  store atomic ptr %51, ptr %240 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %241 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 344, !dbg !652
  store atomic ptr %53, ptr %241 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %242 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 352, !dbg !652
  store atomic ptr %55, ptr %242 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %243 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 360, !dbg !652
  store atomic ptr %57, ptr %243 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %244 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 368, !dbg !652
  store atomic ptr %59, ptr %244 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %245 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 376, !dbg !652
  store atomic ptr %61, ptr %245 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %246 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 384, !dbg !652
  store atomic ptr %63, ptr %246 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  %247 = getelementptr inbounds i8, ptr %"box::ProcessContext", i64 392, !dbg !652
  store atomic ptr %65, ptr %247 unordered, align 8, !dbg !652, !tbaa !311, !alias.scope !190, !noalias !191
  store atomic ptr %"box::ProcessContext", ptr %"process::Process.runtime_context_ptr" release, align 8, !dbg !652, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.tag_addr" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !652
  %"process::Process.tag" = load atomic volatile i64, ptr %"process::Process.tag_addr" unordered, align 8, !dbg !652, !tbaa !309, !range !651
  %parent_bits = and i64 %"process::Process.tag", 3, !dbg !652
  %parent_old_marked = icmp eq i64 %parent_bits, 3, !dbg !652
  br i1 %parent_old_marked, label %may_trigger_wb, label %248, !dbg !652

may_trigger_wb:                                   ; preds = %L702
  %"box::ProcessContext.tag" = load atomic volatile i64, ptr %"box::ProcessContext.tag_addr" unordered, align 8, !dbg !652, !tbaa !309, !range !651
  %child_bit = and i64 %"box::ProcessContext.tag", 1, !dbg !652
  %child_not_marked = icmp eq i64 %child_bit, 0, !dbg !652
  br i1 %child_not_marked, label %trigger_wb, label %248, !dbg !652, !prof !658

trigger_wb:                                       ; preds = %may_trigger_wb
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !652
  br label %248, !dbg !652

248:                                              ; preds = %may_trigger_wb, %trigger_wb, %L702
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0414.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0414.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0414.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0414.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0414.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.8420, ptr noundef nonnull align 8 dereferenceable(72) %.sroa.12, i64 72, i1 false), !dbg !239
  br label %L733, !dbg !239

L723:                                             ; preds = %L666
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !239
  %"process::Process.algo_ptr" = getelementptr inbounds i8, ptr %"process::Process", i64 16, !dbg !659
  %249 = load atomic ptr, ptr %"process::Process.algo_ptr" unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %250 = getelementptr inbounds i8, ptr %"process::Process", i64 24, !dbg !659
  %251 = load atomic ptr, ptr %250 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %252 = getelementptr inbounds i8, ptr %"process::Process", i64 32, !dbg !659
  %253 = load atomic ptr, ptr %252 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %254 = getelementptr inbounds i8, ptr %"process::Process", i64 40, !dbg !659
  %255 = load atomic ptr, ptr %254 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %256 = getelementptr inbounds i8, ptr %"process::Process", i64 48, !dbg !659
  %257 = load atomic ptr, ptr %256 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %258 = getelementptr inbounds i8, ptr %"process::Process", i64 56, !dbg !659
  %259 = load atomic ptr, ptr %258 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %260 = getelementptr inbounds i8, ptr %"process::Process", i64 64, !dbg !659
  %261 = load atomic ptr, ptr %260 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %262 = getelementptr inbounds i8, ptr %"process::Process", i64 472, !dbg !659
  %263 = load atomic ptr, ptr %262 unordered, align 8, !dbg !659, !tbaa !204, !alias.scope !190, !noalias !191
  %264 = getelementptr inbounds i8, ptr %"process::Process", i64 72, !dbg !665
  store atomic ptr %5, ptr %264 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %265 = getelementptr inbounds i8, ptr %"process::Process", i64 80, !dbg !665
  store atomic ptr %7, ptr %265 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %266 = getelementptr inbounds i8, ptr %"process::Process", i64 88, !dbg !665
  store atomic ptr %9, ptr %266 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %267 = getelementptr inbounds i8, ptr %"process::Process", i64 96, !dbg !665
  store atomic ptr %11, ptr %267 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %268 = getelementptr inbounds i8, ptr %"process::Process", i64 104, !dbg !665
  store atomic ptr %13, ptr %268 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %269 = getelementptr inbounds i8, ptr %"process::Process", i64 112, !dbg !665
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0", i64 40, !dbg !665
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %269, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.0.40.sroa_idx", i64 16, i1 false), !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %270 = getelementptr inbounds i8, ptr %"process::Process", i64 128, !dbg !665
  store atomic ptr %15, ptr %270 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %271 = getelementptr inbounds i8, ptr %"process::Process", i64 136, !dbg !665
  store atomic ptr %17, ptr %271 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %272 = getelementptr inbounds i8, ptr %"process::Process", i64 144, !dbg !665
  store atomic ptr %19, ptr %272 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %273 = getelementptr inbounds i8, ptr %"process::Process", i64 152, !dbg !665
  store atomic ptr %21, ptr %273 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %274 = getelementptr inbounds i8, ptr %"process::Process", i64 160, !dbg !665
  store atomic ptr %23, ptr %274 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %275 = getelementptr inbounds i8, ptr %"process::Process", i64 168, !dbg !665
  store i64 %.sroa.0.sroa.8.0, ptr %275, align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %276 = getelementptr inbounds i8, ptr %"process::Process", i64 176, !dbg !665
  store atomic ptr %25, ptr %276 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %277 = getelementptr inbounds i8, ptr %"process::Process", i64 184, !dbg !665
  store i64 %.sroa.0.sroa.10.0, ptr %277, align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %278 = getelementptr inbounds i8, ptr %"process::Process", i64 192, !dbg !665
  store atomic ptr %27, ptr %278 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %279 = getelementptr inbounds i8, ptr %"process::Process", i64 200, !dbg !665
  store atomic ptr %29, ptr %279 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %280 = getelementptr inbounds i8, ptr %"process::Process", i64 208, !dbg !665
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4", i64 16, !dbg !665
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %280, ptr noundef nonnull align 8 dereferenceable(16) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.4.136.sroa_idx", i64 16, i1 false), !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %281 = getelementptr inbounds i8, ptr %"process::Process", i64 224, !dbg !665
  store atomic ptr %31, ptr %281 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %282 = getelementptr inbounds i8, ptr %"process::Process", i64 232, !dbg !665
  store atomic ptr %33, ptr %282 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %283 = getelementptr inbounds i8, ptr %"process::Process", i64 240, !dbg !665
  store atomic ptr %35, ptr %283 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %284 = getelementptr inbounds i8, ptr %"process::Process", i64 248, !dbg !665
  store atomic ptr %37, ptr %284 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %285 = getelementptr inbounds i8, ptr %"process::Process", i64 256, !dbg !665
  store atomic ptr %39, ptr %285 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %286 = getelementptr inbounds i8, ptr %"process::Process", i64 264, !dbg !665
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5", i64 40, !dbg !665
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %286, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.5.192.sroa_idx", i64 24, i1 false), !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %287 = getelementptr inbounds i8, ptr %"process::Process", i64 288, !dbg !665
  store atomic ptr %41, ptr %287 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %288 = getelementptr inbounds i8, ptr %"process::Process", i64 296, !dbg !665
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx" = getelementptr inbounds i8, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6", i64 8, !dbg !665
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %288, ptr noundef nonnull align 8 dereferenceable(24) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.6.224.sroa_idx", i64 24, i1 false), !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %289 = getelementptr inbounds i8, ptr %"process::Process", i64 320, !dbg !665
  store atomic ptr %43, ptr %289 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %290 = getelementptr inbounds i8, ptr %"process::Process", i64 328, !dbg !665
  store i64 %.sroa.0.sroa.15.0, ptr %290, align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %291 = getelementptr inbounds i8, ptr %"process::Process", i64 336, !dbg !665
  store atomic ptr %45, ptr %291 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %292 = getelementptr inbounds i8, ptr %"process::Process", i64 344, !dbg !665
  store i64 %.sroa.0.sroa.17.0, ptr %292, align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %293 = getelementptr inbounds i8, ptr %"process::Process", i64 352, !dbg !665
  store atomic ptr %47, ptr %293 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %294 = getelementptr inbounds i8, ptr %"process::Process", i64 360, !dbg !665
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %294, align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 368, !dbg !665
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.3.8..sroa_idx", align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 372, !dbg !665
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.4.8..sroa_idx", align 4, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 376, !dbg !665
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.5.8..sroa_idx", align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 384, !dbg !665
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.6.8..sroa_idx", align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 385, !dbg !665
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %"new::LoopAlgorithm.sroa.0.sroa.0.sroa.9.sroa.7.8..sroa_idx", ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !665
  %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 392, !dbg !665
  store float %.sroa.8.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.10.288..sroa_idx", align 8, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx" = getelementptr inbounds i8, ptr %"process::Process", i64 396, !dbg !665
  store i32 %.sroa.10.0, ptr %"new::LoopAlgorithm.sroa.0.sroa.11.288..sroa_idx", align 4, !dbg !665, !tbaa !241, !alias.scope !495, !noalias !496
  %295 = getelementptr inbounds i8, ptr %"process::Process", i64 400, !dbg !665
  store atomic ptr %49, ptr %295 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %296 = getelementptr inbounds i8, ptr %"process::Process", i64 408, !dbg !665
  store atomic ptr %51, ptr %296 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %297 = getelementptr inbounds i8, ptr %"process::Process", i64 416, !dbg !665
  store atomic ptr %53, ptr %297 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %298 = getelementptr inbounds i8, ptr %"process::Process", i64 424, !dbg !665
  store atomic ptr %55, ptr %298 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %299 = getelementptr inbounds i8, ptr %"process::Process", i64 432, !dbg !665
  store atomic ptr %57, ptr %299 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %300 = getelementptr inbounds i8, ptr %"process::Process", i64 440, !dbg !665
  store atomic ptr %59, ptr %300 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %301 = getelementptr inbounds i8, ptr %"process::Process", i64 448, !dbg !665
  store atomic ptr %61, ptr %301 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %302 = getelementptr inbounds i8, ptr %"process::Process", i64 456, !dbg !665
  store atomic ptr %63, ptr %302 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %303 = getelementptr inbounds i8, ptr %"process::Process", i64 464, !dbg !665
  store atomic ptr %65, ptr %303 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  store atomic ptr %263, ptr %262 unordered, align 8, !dbg !665, !tbaa !204, !alias.scope !190, !noalias !191
  %"process::Process.tag_addr979" = getelementptr inbounds i64, ptr %"process::Process", i64 -1, !dbg !665
  %"process::Process.tag980" = load atomic volatile i64, ptr %"process::Process.tag_addr979" unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %parent_bits981 = and i64 %"process::Process.tag980", 3, !dbg !665
  %parent_old_marked982 = icmp eq i64 %parent_bits981, 3, !dbg !665
  br i1 %parent_old_marked982, label %may_trigger_wb983, label %343, !dbg !665

may_trigger_wb983:                                ; preds = %L723
  %.tag_addr = getelementptr inbounds i64, ptr %249, i64 -1, !dbg !665
  %.tag = load atomic volatile i64, ptr %.tag_addr unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %.tag_addr986 = getelementptr inbounds i64, ptr %251, i64 -1, !dbg !665
  %.tag987 = load atomic volatile i64, ptr %.tag_addr986 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %304 = and i64 %.tag, %.tag987, !dbg !665
  %.tag_addr990 = getelementptr inbounds i64, ptr %253, i64 -1, !dbg !665
  %.tag991 = load atomic volatile i64, ptr %.tag_addr990 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %305 = and i64 %304, %.tag991, !dbg !665
  %.tag_addr994 = getelementptr inbounds i64, ptr %255, i64 -1, !dbg !665
  %.tag995 = load atomic volatile i64, ptr %.tag_addr994 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %306 = and i64 %305, %.tag995, !dbg !665
  %.tag_addr998 = getelementptr inbounds i64, ptr %257, i64 -1, !dbg !665
  %.tag999 = load atomic volatile i64, ptr %.tag_addr998 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %307 = and i64 %306, %.tag999, !dbg !665
  %.tag_addr1002 = getelementptr inbounds i64, ptr %259, i64 -1, !dbg !665
  %.tag1003 = load atomic volatile i64, ptr %.tag_addr1002 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %308 = and i64 %307, %.tag1003, !dbg !665
  %.tag_addr1006 = getelementptr inbounds i64, ptr %261, i64 -1, !dbg !665
  %.tag1007 = load atomic volatile i64, ptr %.tag_addr1006 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %309 = and i64 %308, %.tag1007, !dbg !665
  %.tag_addr1010 = getelementptr inbounds i64, ptr %5, i64 -1, !dbg !665
  %.tag1011 = load atomic volatile i64, ptr %.tag_addr1010 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %310 = and i64 %309, %.tag1011, !dbg !665
  %.tag_addr1014 = getelementptr inbounds i64, ptr %7, i64 -1, !dbg !665
  %.tag1015 = load atomic volatile i64, ptr %.tag_addr1014 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %311 = and i64 %310, %.tag1015, !dbg !665
  %.tag_addr1018 = getelementptr inbounds i64, ptr %9, i64 -1, !dbg !665
  %.tag1019 = load atomic volatile i64, ptr %.tag_addr1018 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %312 = and i64 %311, %.tag1019, !dbg !665
  %.tag_addr1022 = getelementptr inbounds i64, ptr %11, i64 -1, !dbg !665
  %.tag1023 = load atomic volatile i64, ptr %.tag_addr1022 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %313 = and i64 %312, %.tag1023, !dbg !665
  %.tag_addr1026 = getelementptr inbounds i64, ptr %13, i64 -1, !dbg !665
  %.tag1027 = load atomic volatile i64, ptr %.tag_addr1026 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %314 = and i64 %313, %.tag1027, !dbg !665
  %.tag_addr1030 = getelementptr inbounds i64, ptr %15, i64 -1, !dbg !665
  %.tag1031 = load atomic volatile i64, ptr %.tag_addr1030 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %315 = and i64 %314, %.tag1031, !dbg !665
  %.tag_addr1034 = getelementptr inbounds i64, ptr %17, i64 -1, !dbg !665
  %.tag1035 = load atomic volatile i64, ptr %.tag_addr1034 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %316 = and i64 %315, %.tag1035, !dbg !665
  %.tag_addr1038 = getelementptr inbounds i64, ptr %19, i64 -1, !dbg !665
  %.tag1039 = load atomic volatile i64, ptr %.tag_addr1038 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %317 = and i64 %316, %.tag1039, !dbg !665
  %.tag_addr1042 = getelementptr inbounds i64, ptr %21, i64 -1, !dbg !665
  %.tag1043 = load atomic volatile i64, ptr %.tag_addr1042 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %318 = and i64 %317, %.tag1043, !dbg !665
  %.tag_addr1046 = getelementptr inbounds i64, ptr %23, i64 -1, !dbg !665
  %.tag1047 = load atomic volatile i64, ptr %.tag_addr1046 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %319 = and i64 %318, %.tag1047, !dbg !665
  %.tag_addr1050 = getelementptr inbounds i64, ptr %25, i64 -1, !dbg !665
  %.tag1051 = load atomic volatile i64, ptr %.tag_addr1050 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %320 = and i64 %319, %.tag1051, !dbg !665
  %.tag_addr1054 = getelementptr inbounds i64, ptr %27, i64 -1, !dbg !665
  %.tag1055 = load atomic volatile i64, ptr %.tag_addr1054 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %321 = and i64 %320, %.tag1055, !dbg !665
  %.tag_addr1058 = getelementptr inbounds i64, ptr %29, i64 -1, !dbg !665
  %.tag1059 = load atomic volatile i64, ptr %.tag_addr1058 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %322 = and i64 %321, %.tag1059, !dbg !665
  %.tag_addr1062 = getelementptr inbounds i64, ptr %31, i64 -1, !dbg !665
  %.tag1063 = load atomic volatile i64, ptr %.tag_addr1062 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %323 = and i64 %322, %.tag1063, !dbg !665
  %.tag_addr1066 = getelementptr inbounds i64, ptr %33, i64 -1, !dbg !665
  %.tag1067 = load atomic volatile i64, ptr %.tag_addr1066 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %324 = and i64 %323, %.tag1067, !dbg !665
  %.tag_addr1070 = getelementptr inbounds i64, ptr %35, i64 -1, !dbg !665
  %.tag1071 = load atomic volatile i64, ptr %.tag_addr1070 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %325 = and i64 %324, %.tag1071, !dbg !665
  %.tag_addr1074 = getelementptr inbounds i64, ptr %37, i64 -1, !dbg !665
  %.tag1075 = load atomic volatile i64, ptr %.tag_addr1074 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %326 = and i64 %325, %.tag1075, !dbg !665
  %.tag_addr1078 = getelementptr inbounds i64, ptr %39, i64 -1, !dbg !665
  %.tag1079 = load atomic volatile i64, ptr %.tag_addr1078 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %327 = and i64 %326, %.tag1079, !dbg !665
  %.tag_addr1082 = getelementptr inbounds i64, ptr %41, i64 -1, !dbg !665
  %.tag1083 = load atomic volatile i64, ptr %.tag_addr1082 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %328 = and i64 %327, %.tag1083, !dbg !665
  %.tag_addr1086 = getelementptr inbounds i64, ptr %43, i64 -1, !dbg !665
  %.tag1087 = load atomic volatile i64, ptr %.tag_addr1086 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %329 = and i64 %328, %.tag1087, !dbg !665
  %.tag_addr1090 = getelementptr inbounds i64, ptr %45, i64 -1, !dbg !665
  %.tag1091 = load atomic volatile i64, ptr %.tag_addr1090 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %330 = and i64 %329, %.tag1091, !dbg !665
  %.tag_addr1094 = getelementptr inbounds i64, ptr %47, i64 -1, !dbg !665
  %.tag1095 = load atomic volatile i64, ptr %.tag_addr1094 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %331 = and i64 %330, %.tag1095, !dbg !665
  %.tag_addr1098 = getelementptr inbounds i64, ptr %49, i64 -1, !dbg !665
  %.tag1099 = load atomic volatile i64, ptr %.tag_addr1098 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %332 = and i64 %331, %.tag1099, !dbg !665
  %.tag_addr1102 = getelementptr inbounds i64, ptr %51, i64 -1, !dbg !665
  %.tag1103 = load atomic volatile i64, ptr %.tag_addr1102 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %333 = and i64 %332, %.tag1103, !dbg !665
  %.tag_addr1106 = getelementptr inbounds i64, ptr %53, i64 -1, !dbg !665
  %.tag1107 = load atomic volatile i64, ptr %.tag_addr1106 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %334 = and i64 %333, %.tag1107, !dbg !665
  %.tag_addr1110 = getelementptr inbounds i64, ptr %55, i64 -1, !dbg !665
  %.tag1111 = load atomic volatile i64, ptr %.tag_addr1110 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %335 = and i64 %334, %.tag1111, !dbg !665
  %.tag_addr1114 = getelementptr inbounds i64, ptr %57, i64 -1, !dbg !665
  %.tag1115 = load atomic volatile i64, ptr %.tag_addr1114 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %336 = and i64 %335, %.tag1115, !dbg !665
  %.tag_addr1118 = getelementptr inbounds i64, ptr %59, i64 -1, !dbg !665
  %.tag1119 = load atomic volatile i64, ptr %.tag_addr1118 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %337 = and i64 %336, %.tag1119, !dbg !665
  %.tag_addr1122 = getelementptr inbounds i64, ptr %61, i64 -1, !dbg !665
  %.tag1123 = load atomic volatile i64, ptr %.tag_addr1122 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %338 = and i64 %337, %.tag1123, !dbg !665
  %.tag_addr1126 = getelementptr inbounds i64, ptr %63, i64 -1, !dbg !665
  %.tag1127 = load atomic volatile i64, ptr %.tag_addr1126 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %339 = and i64 %338, %.tag1127, !dbg !665
  %.tag_addr1130 = getelementptr inbounds i64, ptr %65, i64 -1, !dbg !665
  %.tag1131 = load atomic volatile i64, ptr %.tag_addr1130 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %340 = and i64 %339, %.tag1131, !dbg !665
  %.tag_addr1134 = getelementptr inbounds i64, ptr %263, i64 -1, !dbg !665
  %.tag1135 = load atomic volatile i64, ptr %.tag_addr1134 unordered, align 8, !dbg !665, !tbaa !309, !range !651
  %341 = and i64 %340, %.tag1135, !dbg !665
  %342 = and i64 %341, 1, !dbg !665
  %.not3.not = icmp eq i64 %342, 0, !dbg !665
  br i1 %.not3.not, label %trigger_wb1138, label %343, !dbg !665, !prof !658

trigger_wb1138:                                   ; preds = %may_trigger_wb983
  call void @ijl_gc_queue_root(ptr nonnull %"process::Process"), !dbg !665
  br label %343, !dbg !665

343:                                              ; preds = %may_trigger_wb983, %trigger_wb1138, %L723
  %"process::Process.runtime_context_ptr248" = getelementptr inbounds i8, ptr %"process::Process", i64 480, !dbg !667
  %jl_nothing = load ptr, ptr @jl_nothing, align 8, !dbg !667, !tbaa !175, !invariant.load !0, !alias.scope !493, !noalias !494, !nonnull !0
  store atomic ptr %jl_nothing, ptr %"process::Process.runtime_context_ptr248" release, align 8, !dbg !667, !tbaa !204, !alias.scope !190, !noalias !191
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0414.sroa.0, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0.sroa.0, i64 96, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0414.sroa.12, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.11, i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0414.sroa.14, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0.sroa.12, i64 64, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0414.sroa.16, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0.sroa.13, i64 32, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0414.sroa.26.sroa.11, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0.sroa.18.sroa.18, i64 7, i1 false), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.8420, ptr noundef nonnull align 8 dereferenceable(72) %.sroa.12, i64 72, i1 false), !dbg !239
  br label %L733, !dbg !239

L733:                                             ; preds = %343, %248
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %sret_return, ptr noundef nonnull align 8 dereferenceable(96) %.sroa.0414.sroa.0, i64 96, i1 false), !dbg !644
  %.sroa.0426.sroa.2.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 96, !dbg !644
  store i64 %.sroa.0.sroa.8.0, ptr %.sroa.0426.sroa.2.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.3.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 104, !dbg !644
  store i64 %.sroa.0.sroa.9.0, ptr %.sroa.0426.sroa.3.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.4.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 112, !dbg !644
  store i64 %.sroa.0.sroa.10.0, ptr %.sroa.0426.sroa.4.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.5.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 120, !dbg !644
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0426.sroa.5.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0414.sroa.12, i64 32, i1 false), !dbg !644
  %.sroa.0426.sroa.6.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 152, !dbg !644
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0426.sroa.6.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(64) %.sroa.0414.sroa.14, i64 64, i1 false), !dbg !644
  %.sroa.0426.sroa.7.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 216, !dbg !644
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0426.sroa.7.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(32) %.sroa.0414.sroa.16, i64 32, i1 false), !dbg !644
  %.sroa.0426.sroa.8.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 248, !dbg !644
  store i64 %.sroa.0.sroa.14.0, ptr %.sroa.0426.sroa.8.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.9.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 256, !dbg !644
  store i64 %.sroa.0.sroa.15.0, ptr %.sroa.0426.sroa.9.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.10.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 264, !dbg !644
  store i64 %.sroa.0.sroa.16.0, ptr %.sroa.0426.sroa.10.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.11.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 272, !dbg !644
  store i64 %.sroa.0.sroa.17.0, ptr %.sroa.0426.sroa.11.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 280, !dbg !644
  store i64 %.sroa.0.sroa.18.sroa.0.0, ptr %.sroa.0426.sroa.12.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.sroa.2.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 288, !dbg !644
  store i64 %.sroa.0.sroa.18.sroa.8.0, ptr %.sroa.0426.sroa.12.sroa.2.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.sroa.3.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 296, !dbg !644
  store float %.sroa.0.sroa.18.sroa.10.0, ptr %.sroa.0426.sroa.12.sroa.3.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.sroa.4.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 300, !dbg !644
  store float %.sroa.0.sroa.18.sroa.12.0, ptr %.sroa.0426.sroa.12.sroa.4.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 4, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.sroa.5.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 304, !dbg !644
  store i64 %.sroa.0.sroa.18.sroa.14.0, ptr %.sroa.0426.sroa.12.sroa.5.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.sroa.6.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 312, !dbg !644
  store i8 %.sroa.0.sroa.18.sroa.16.0, ptr %.sroa.0426.sroa.12.sroa.6.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.0426.sroa.12.sroa.7.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 313, !dbg !644
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0426.sroa.12.sroa.7.0..sroa.0426.sroa.12.0.sret_return.sroa_idx.sroa_idx, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.0414.sroa.26.sroa.11, i64 7, i1 false), !dbg !644
  %.sroa.2427.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 320, !dbg !644
  store float %.sroa.8.0, ptr %.sroa.2427.0.sret_return.sroa_idx, align 8, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.3428.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 324, !dbg !644
  store i32 %.sroa.10.0, ptr %.sroa.3428.0.sret_return.sroa_idx, align 4, !dbg !644, !tbaa !305, !alias.scope !307, !noalias !308
  %.sroa.4429.0.sret_return.sroa_idx = getelementptr inbounds i8, ptr %sret_return, i64 328, !dbg !644
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(72) %.sroa.4429.0.sret_return.sroa_idx, ptr noundef nonnull align 8 dereferenceable(72) %.sroa.8420, i64 72, i1 false), !dbg !644
  store ptr %5, ptr %return_roots, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %344 = getelementptr inbounds i8, ptr %return_roots, i64 8, !dbg !644
  store ptr %7, ptr %344, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %345 = getelementptr inbounds i8, ptr %return_roots, i64 16, !dbg !644
  store ptr %9, ptr %345, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %346 = getelementptr inbounds i8, ptr %return_roots, i64 24, !dbg !644
  store ptr %11, ptr %346, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %347 = getelementptr inbounds i8, ptr %return_roots, i64 32, !dbg !644
  store ptr %13, ptr %347, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %348 = getelementptr inbounds i8, ptr %return_roots, i64 40, !dbg !644
  store ptr %15, ptr %348, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %349 = getelementptr inbounds i8, ptr %return_roots, i64 48, !dbg !644
  store ptr %17, ptr %349, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %350 = getelementptr inbounds i8, ptr %return_roots, i64 56, !dbg !644
  store ptr %19, ptr %350, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %351 = getelementptr inbounds i8, ptr %return_roots, i64 64, !dbg !644
  store ptr %21, ptr %351, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %352 = getelementptr inbounds i8, ptr %return_roots, i64 72, !dbg !644
  store ptr %23, ptr %352, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %353 = getelementptr inbounds i8, ptr %return_roots, i64 80, !dbg !644
  store ptr %25, ptr %353, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %354 = getelementptr inbounds i8, ptr %return_roots, i64 88, !dbg !644
  store ptr %27, ptr %354, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %355 = getelementptr inbounds i8, ptr %return_roots, i64 96, !dbg !644
  store ptr %29, ptr %355, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %356 = getelementptr inbounds i8, ptr %return_roots, i64 104, !dbg !644
  store ptr %31, ptr %356, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %357 = getelementptr inbounds i8, ptr %return_roots, i64 112, !dbg !644
  store ptr %33, ptr %357, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %358 = getelementptr inbounds i8, ptr %return_roots, i64 120, !dbg !644
  store ptr %35, ptr %358, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %359 = getelementptr inbounds i8, ptr %return_roots, i64 128, !dbg !644
  store ptr %37, ptr %359, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %360 = getelementptr inbounds i8, ptr %return_roots, i64 136, !dbg !644
  store ptr %39, ptr %360, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %361 = getelementptr inbounds i8, ptr %return_roots, i64 144, !dbg !644
  store ptr %41, ptr %361, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %362 = getelementptr inbounds i8, ptr %return_roots, i64 152, !dbg !644
  store ptr %43, ptr %362, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %363 = getelementptr inbounds i8, ptr %return_roots, i64 160, !dbg !644
  store ptr %45, ptr %363, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %364 = getelementptr inbounds i8, ptr %return_roots, i64 168, !dbg !644
  store ptr %47, ptr %364, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %365 = getelementptr inbounds i8, ptr %return_roots, i64 176, !dbg !644
  store ptr %49, ptr %365, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %366 = getelementptr inbounds i8, ptr %return_roots, i64 184, !dbg !644
  store ptr %51, ptr %366, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %367 = getelementptr inbounds i8, ptr %return_roots, i64 192, !dbg !644
  store ptr %53, ptr %367, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %368 = getelementptr inbounds i8, ptr %return_roots, i64 200, !dbg !644
  store ptr %55, ptr %368, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %369 = getelementptr inbounds i8, ptr %return_roots, i64 208, !dbg !644
  store ptr %57, ptr %369, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %370 = getelementptr inbounds i8, ptr %return_roots, i64 216, !dbg !644
  store ptr %59, ptr %370, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %371 = getelementptr inbounds i8, ptr %return_roots, i64 224, !dbg !644
  store ptr %61, ptr %371, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %372 = getelementptr inbounds i8, ptr %return_roots, i64 232, !dbg !644
  store ptr %63, ptr %372, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %373 = getelementptr inbounds i8, ptr %return_roots, i64 240, !dbg !644
  store ptr %65, ptr %373, align 8, !dbg !644, !tbaa !162, !alias.scope !167, !noalias !170
  %frame.prev1139 = load ptr, ptr %frame.prev, align 8, !tbaa !162
  store ptr %frame.prev1139, ptr %pgcstack, align 8, !tbaa !162
  ret void, !dbg !644

pass110:                                          ; preds = %guard_pass371, %guard_pass366
  %.sroa.9.0 = phi i8 [ 1, %guard_pass366 ], [ 0, %guard_pass371 ], !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.6604, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, i64 7, i1 false), !dbg !669
  call void @llvm.lifetime.end.p0(i64 7, ptr nonnull %.sroa.10), !dbg !669
  %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.0", i64 8, !dbg !670
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(80) %"new::NamedTuple.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(80) %95, i64 80, i1 false), !dbg !670, !tbaa !305, !alias.scope !307, !noalias !308
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %"new::NamedTuple.sroa.0.sroa.5", ptr noundef nonnull align 8 dereferenceable(16) %.sroa.0433.sroa.11.0..sroa_idx673, i64 16, i1 false), !dbg !670, !tbaa !305, !alias.scope !307, !noalias !308
  %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 16, !dbg !670
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(112) %"new::NamedTuple.sroa.0.sroa.5.128.sroa_idx", ptr noundef nonnull align 8 dereferenceable(112) %78, i64 112, i1 false), !dbg !670, !tbaa !305, !alias.scope !307, !noalias !308
  %"new::SubContext.sroa.0.sroa.0.8.sroa_idx" = getelementptr inbounds i8, ptr %"new::SubContext.sroa.0.sroa.0", i64 8, !dbg !699
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(88) %"new::SubContext.sroa.0.sroa.0.8.sroa_idx", ptr noundef nonnull align 8 dereferenceable(88) %"new::NamedTuple.sroa.0.sroa.0", i64 88, i1 false), !dbg !699
  %"new::NamedTuple.sroa.0.sroa.5.144.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 32, !dbg !699
  %"new::NamedTuple.sroa.0.sroa.5.208.sroa_idx" = getelementptr inbounds i8, ptr %"new::NamedTuple.sroa.0.sroa.5", i64 96, !dbg !699
  store i64 1, ptr %4, align 8, !dbg !705, !tbaa !204, !alias.scope !190, !noalias !191
  %374 = load <2 x i64>, ptr %"process::Process.loopidx_ptr", align 8, !dbg !714, !tbaa !204, !alias.scope !190, !noalias !191
  %375 = add <2 x i64> %374, <i64 1, i64 1>, !dbg !719
  store <2 x i64> %375, ptr %"process::Process.loopidx_ptr", align 8, !dbg !720, !tbaa !204, !alias.scope !190, !noalias !191
  %376 = load atomic i8, ptr %"process::Process.shouldrun_ptr" unordered, align 16, !dbg !721, !tbaa !204, !alias.scope !190, !noalias !191
  %377 = and i8 %376, 1, !dbg !721
  %"process::Process.shouldrun.not.not.not.not" = icmp eq i8 %377, 0, !dbg !721
  br i1 %"process::Process.shouldrun.not.not.not.not", label %L655, label %L656, !dbg !727

guard_pass356:                                    ; preds = %L138
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !239
  store float %104, ptr %unionalloca.sroa.0, align 8, !dbg !239, !tbaa !305, !alias.scope !307, !noalias !308
  %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload462794 = load i64, ptr %unionalloca.sroa.0, align 8, !dbg !364
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %unionalloca.sroa.0), !dbg !364
  %378 = trunc i64 %unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.unionalloca.sroa.0.0.copyload462794 to i32, !dbg !728
  %379 = bitcast i32 %378 to float, !dbg !728
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10657), !dbg !239
  br label %L269, !dbg !239

guard_pass361:                                    ; preds = %L223, %L221
  %value_phi308 = phi double [ %130, %L221 ], [ %spec.select378, %L223 ]
  %380 = fcmp ugt double %value_phi308, 2.000000e+00, !dbg !730
  %381 = fadd double %value_phi308, -1.000000e+00, !dbg !733
  %382 = fadd double %value_phi308, -2.000000e+00, !dbg !733
  %383 = fsub double 1.000000e+00, %382, !dbg !733
  %value_phi310 = select i1 %380, double %383, double %381, !dbg !733
  %384 = fptrunc double %value_phi310 to float, !dbg !734
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10657), !dbg !239
  br label %L269, !dbg !239

guard_pass366:                                    ; preds = %L559
  %385 = load ptr, ptr %root_phi25.state89, align 8, !dbg !736, !tbaa !342, !alias.scope !345, !noalias !346
  %386 = getelementptr i8, ptr %385, i64 %memoryref_offset, !dbg !738
  %memoryref_data106 = getelementptr i8, ptr %386, i64 -4, !dbg !738
  store float %.sroa.7651.0, ptr %memoryref_data106, align 4, !dbg !738, !tbaa !350, !alias.scope !190, !noalias !191
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !239
  br label %pass110, !dbg !239

guard_pass371:                                    ; preds = %L557
  call void @llvm.lifetime.start.p0(i64 7, ptr nonnull %.sroa.10), !dbg !239
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(7) %.sroa.10, ptr noundef nonnull align 1 dereferenceable(7) %.sroa.11, i64 7, i1 false), !dbg !239, !tbaa !305, !alias.scope !307, !noalias !308
  br label %pass110, !dbg !239
}
