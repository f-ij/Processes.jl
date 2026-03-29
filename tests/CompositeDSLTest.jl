using Test
using Processes

struct DSLSourceAlgo <: Processes.ProcessAlgorithm end
struct DSLCombineAlgo <: Processes.ProcessAlgorithm end
struct DSLSinkAlgo <: Processes.ProcessAlgorithm end

function Processes.step!(::DSLSourceAlgo, context)
    return (; produced = 2, passthrough = context.seed)
end

function Processes.step!(::DSLCombineAlgo, context)
    return (; combined = context.left + context.right)
end

function Processes.step!(::DSLSinkAlgo, context)
    return (; seen = context.value)
end

scaled_double_dsl_test(x; scale = 1) = scale * (2x)

@testset "Composite DSL" begin
    @testset "FuncWrapper supports init and step" begin
        wrapped = FuncWrapper(x -> 2x, (:x,), (:y,))
        @test Processes.step!(wrapped, (; x = 4)) == (; y = 8)
        @test Processes.init(wrapped, (; x = 4)) == (; y = 8)

        kw_wrapped = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (; scale = 3))
        @test Processes.step!(kw_wrapped, (; external = 4)) == (; y = 12)
        @test Processes.init(kw_wrapped, (; external = 4)) == (; y = 12)

        kw_from_context = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (; scale = :factor))
        @test Processes.step!(kw_from_context, (; external = 4, factor = 5)) == (; y = 20)
        @test Processes.init(kw_from_context, (; external = 4, factor = 5)) == (; y = 20)

        kw_same_name = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (:scale,))
        @test Processes.step!(kw_same_name, (; external = 4, scale = 6)) == (; y = 24)
        @test Processes.init(kw_same_name, (; external = 4, scale = 6)) == (; y = 24)
    end

    @testset "Inline state supports defaults and required inputs" begin
        state = @state begin
            a = 1
            b
        end

        @test Processes.init(state, (; b = 4)) == (; a = 1, b = 4)
        @test Processes.init(state, (; a = 7, b = 4)) == (; a = 7, b = 4)
    end

    @testset "CompositeAlgorithm DSL resolves and runs" begin
        n = 10
        algo = @CompositeAlgorithm begin
            @state seed = 3
            @state doubled = 10
            @alias source = DSLSourceAlgo
            produced, passthrough = source(seed = seed)
            doubled = @interval n scaled_double_dsl_test(produced; scale = 2)
            combined = DSLCombineAlgo(left = passthrough, right = doubled)
            DSLSinkAlgo(value = combined)
        end

        resolved = resolve(algo)

        @test resolved isa CompositeAlgorithm
        @test intervals(resolved) == (1, 10, 1, 1)
        @test Processes.getkey(Processes.getalgo(resolved, 1)) == :source
        @test length(Processes.getstates(resolved)) == 1
        @test Processes.getkey(first(Processes.getstates(resolved))) == :_state

        opts = Processes.getoptions(resolved)
        sharedcontexts, sharedvars = Processes._resolve_options(resolved)
        @test opts == Processes.merge_nested_namedtuples(sharedvars, sharedcontexts)

        init_ctx = Processes.initcontext(resolved; lifetime = Repeat(10))
        @test init_ctx[:_state].seed == 3
        @test init_ctx[:_state].doubled == 10

        process_repeat = Process(resolved, repeat = 10)
        @test repeats(Processes.lifetime(process_repeat)) == 10

        process_indefinite = Process(resolved, repeat = Inf)
        @test Processes.lifetime(process_indefinite) isa Indefinite

        p = Process(resolved, repeat = 10)
        Processes.run(p)
        ctx = fetch(p)

        @test ctx[:_state].seed == 3
        @test ctx[:_state].doubled == 8
        @test ctx[:source].produced == 2
        @test ctx[:source].passthrough == 3
        @test ctx[:DSLCombineAlgo_1].combined == 11
        @test ctx[:DSLSinkAlgo_1].seen == 11
    end

    @testset "Named state uses explicit key" begin
        named_state_algo = @CompositeAlgorithm begin
            @state mystate begin
                a = 1
            end
            DSLSinkAlgo(value = a)
        end

        resolved_named_state = resolve(named_state_algo)
        @test Processes.getkey(first(Processes.getstates(resolved_named_state))) == :mystate

        named_ctx = Processes.initcontext(resolved_named_state)
        @test named_ctx[:mystate].a == 1
    end

    @testset "Repeat forms expand correctly" begin
        repeated = @CompositeAlgorithm begin
            @state produced = 5
            tripled = @repeat 3 begin
                tripled = scaled_double_dsl_test(produced; scale = 3)
            end
        end

        resolved_repeated = resolve(repeated)
        @test resolved_repeated isa CompositeAlgorithm
        @test Processes.getalgo(resolved_repeated, 1) isa Processes.AbstractIdentifiableAlgo
        @test Processes.getalgo(Processes.getalgo(resolved_repeated, 1)) isa Routine
        @test repeats(Processes.getalgo(Processes.getalgo(resolved_repeated, 1))) == (3,)

        routine = @Routine begin
            @state produced = 5
            tripled = @repeat 3 scaled_double_dsl_test(produced; scale = 3)
        end

        resolved_routine = resolve(routine)
        @test resolved_routine isa Routine
        @test repeats(resolved_routine) == (3,)
    end
end
