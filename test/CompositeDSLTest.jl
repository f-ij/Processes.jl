using Test
using Processes

struct DSLSourceAlgo <: Processes.ProcessAlgorithm end
struct DSLCombineAlgo <: Processes.ProcessAlgorithm end
struct DSLSinkAlgo <: Processes.ProcessAlgorithm end
struct DSLValueAlgo <: Processes.ProcessAlgorithm end
struct DSLNestedSourceAlgo <: Processes.ProcessAlgorithm end
struct DSLHeldStateAlgo <: Processes.ProcessAlgorithm end

function Processes.step!(::DSLSourceAlgo, context)
    return (; produced = 2, passthrough = context.seed)
end

function Processes.step!(::DSLCombineAlgo, context)
    return (; combined = context.left + context.right)
end

function Processes.step!(::DSLSinkAlgo, context)
    return (; seen = context.value)
end

function Processes.step!(::DSLValueAlgo, context)
    return (; result = context.value)
end

function Processes.step!(::DSLNestedSourceAlgo, context)
    return (; captured = 4)
end

function Processes.init(::DSLHeldStateAlgo, context)
    return (; state = 11)
end

function Processes.step!(::DSLHeldStateAlgo, context)
    return (; state = context.state)
end

scaled_double_dsl_test(x; scale = 1) = scale * (2x)
zero_input_dsl_test() = 7
keyword_only_capture_dsl_test(; plus_capture, minus_capture, β, buffers) = plus_capture + minus_capture + β + buffers
literal_join_dsl_test(prefix, value, marker) = string(prefix, value, marker)
constant_value_dsl_test() = 0.25
square_dsl_test(x) = x^2
keyword_value_identity_dsl_test(; value) = value

@ProcessAlgorithm function DSLPositionalCallAlgo(value)
    return (; seen = value)
end

@ProcessAlgorithm function DSLKeywordCallAlgo(value; scale = 1)
    return (; seen = value * scale)
end

@testset "Composite DSL" begin
    @info "Composite DSL"
    @testset "FuncWrapper steps directly and does not eagerly init" begin
        @info "Composite DSL: FuncWrapper steps directly and does not eagerly init"
        wrapped = FuncWrapper(x -> 2x, (:x,), (:y,))
        @test Processes.step!(wrapped, (; x = 4)) == (; y = 8)
        @test Processes.init(wrapped, (; x = 4)) == (;)
        @test occursin("(x) -> (; y)", sprint(summary, wrapped))

        kw_wrapped = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (; scale = 3))
        @test Processes.step!(kw_wrapped, (; external = 4)) == (; y = 12)
        @test Processes.init(kw_wrapped, (; external = 4)) == (;)
        @test occursin("(external; scale = 3) -> (; y)", sprint(summary, kw_wrapped))

        kw_from_context = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (; scale = :factor))
        @test Processes.step!(kw_from_context, (; external = 4, factor = 5)) == (; y = 20)
        @test Processes.init(kw_from_context, (; external = 4, factor = 5)) == (;)

        kw_same_name = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (:scale,))
        @test Processes.step!(kw_same_name, (; external = 4, scale = 6)) == (; y = 24)
        @test Processes.init(kw_same_name, (; external = 4, scale = 6)) == (;)

        literal_wrapped = FuncWrapper(println, ("Num: ", :value), ())
        literal_show = sprint(show, literal_wrapped)
        literal_plain = sprint(io -> show(io, MIME("text/plain"), literal_wrapped))
        @test occursin("(\"Num: \", value) -> nothing", literal_show)
        @test occursin("function = println", literal_plain)
    end

    @testset "Inline state supports defaults and required inputs" begin
        @info "Composite DSL: Inline state supports defaults and required inputs"
        state = @state begin
            a = 1
            b
        end

        @test Processes.init(state, (; b = 4)) == (; a = 1, b = 4)
        @test Processes.init(state, (; a = 7, b = 4)) == (; a = 7, b = 4)
    end

    @testset "Mutable @state defaults are rebuilt per init" begin
        @info "Composite DSL: Mutable @state defaults are rebuilt per init"
        state = @state begin
            nums = Float64[]
        end

        first_init = Processes.init(state, (;))
        push!(first_init.nums, 1.0)
        second_init = Processes.init(state, (;))

        @test length(first_init.nums) == 1
        @test isempty(second_init.nums)
        @test first_init.nums !== second_init.nums
    end

    @testset "GeneralState merge combines disjoint state schemes" begin
        @info "Composite DSL: GeneralState merge combines disjoint state schemes"
        left = @state begin
            seed = 4
            scale
        end
        right = @state begin
            buffer = Float64[]
            offset = 2
        end

        merged = merge(left, right)
        init = Processes.init(merged, (; scale = 3.0))

        @test init == (; seed = 4, scale = 3.0, buffer = Float64[], offset = 2)
        overlap_merged = @test_logs (:warn, r"Overlapping GeneralState field names") merge(left, @state begin
            seed = 7
        end)
        @test Processes.init(overlap_merged, (; scale = 3.0)) == (; seed = 7, scale = 3.0)
    end

    @testset "CompositeAlgorithm DSL resolves and runs" begin
        @info "Composite DSL: CompositeAlgorithm DSL resolves and runs"
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
        @test intervals(resolved) == (
            Processes.Interval(1),
            Processes.Interval(10),
            Processes.Interval(1),
            Processes.Interval(1),
        )
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
        @info "Composite DSL: Named state uses explicit key"
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

    @testset "@all uses known alias keys in share endpoints" begin
        @info "Composite DSL: @all uses known alias keys in share endpoints"
        @ProcessAlgorithm function DSLShareSource(@managed(x = 1))
            return (; x)
        end

        @ProcessAlgorithm function DSLShareTarget(x)
            return nothing
        end

        expanded = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @alias osc = DSLShareSource
                osc()
                DSLShareTarget(@all(osc...))
            end
        end)
        expanded_str = sprint(show, Base.remove_linenums!(expanded))
        @test occursin("Share(", expanded_str)
        @test occursin("IdentifiableAlgo", expanded_str)
    end

    @testset "Transform routes resolve from expressions" begin
        @info "Composite DSL: Transform routes resolve from expressions"
        one_var_transform = @CompositeAlgorithm begin
            @state seed = 3
            @alias source = DSLSourceAlgo
            produced, passthrough = source(seed = seed)
            DSLSinkAlgo(value = produced * 3)
        end

        resolved_one_var = resolve(one_var_transform)
        one_var_opts = Processes.getoptions(resolved_one_var)
        one_var_routes = one_var_opts[:DSLSinkAlgo_1]
        @test length(one_var_routes) == 1
        @test Processes.gettransform(first(one_var_routes)) !== nothing

        p_one_var = Process(resolved_one_var, repeat = 1)
        Processes.run(p_one_var)
        ctx_one_var = fetch(p_one_var)
        @test ctx_one_var[:DSLSinkAlgo_1].seen == 6

        two_var_transform = @CompositeAlgorithm begin
            @state seed = 3
            @alias source = DSLSourceAlgo
            produced, passthrough = source(seed = seed)
            DSLValueAlgo(value = produced + passthrough)
        end

        resolved_two_var = resolve(two_var_transform)
        two_var_opts = Processes.getoptions(resolved_two_var)
        two_var_routes = two_var_opts[:DSLValueAlgo_1]
        @test length(two_var_routes) == 1
        @test Processes.gettransform(first(two_var_routes)) !== nothing

        p_two_var = Process(resolved_two_var, repeat = 1)
        Processes.run(p_two_var)
        ctx_two_var = fetch(p_two_var)
        @test ctx_two_var[:DSLValueAlgo_1].result == 5
    end

    @testset "Routine repeat form expands correctly" begin
        @info "Composite DSL: Routine repeat form expands correctly"
        routine = @Routine begin
            @state produced = 5
            tripled = @repeat 3 scaled_double_dsl_test(produced; scale = 3)
        end

        resolved_routine = resolve(routine)
        @test resolved_routine isa Routine
        @test repeats(resolved_routine) == (3,)
    end

    @testset "Nested DSL state writeback resolves through keyed _state" begin
        @info "Composite DSL: Nested DSL state writeback resolves through keyed _state"
        inner = @Routine begin
            @state stored = 0
            stored = zero_input_dsl_test()
        end

        outer = @CompositeAlgorithm begin
            @state outer_flag = 1
            inner
        end

        resolved_outer = resolve(outer)
        @test resolved_outer isa CompositeAlgorithm
    end

    @testset "FuncWrapper positional args accept @context property routes" begin
        @info "Composite DSL: FuncWrapper positional args accept @context property routes"
        nested_identity(x) = x
        plus = @Routine begin
            @alias plus_capture = DSLNestedSourceAlgo
            plus_capture()
        end

        algo = @CompositeAlgorithm begin
            @context c1 = plus()
            result = nested_identity(c1.plus_capture.captured)
        end

        resolved = resolve(algo)
        wrapper = Processes.getalgo(resolved, 2)
        wrapper_key = Processes.getkey(wrapper)
        routes = Processes.getoptions(resolved)[wrapper_key]
        @test length(routes) == 1
        @test occursin("c1.plus_capture.captured", sprint(show, wrapper))

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[wrapper_key].result == 4
    end

    @testset "FuncWrapper keyword args preserve routed display expressions" begin
        @info "Composite DSL: FuncWrapper keyword args preserve routed display expressions"
        plus = @Routine begin
            @alias plus_capture = DSLNestedSourceAlgo
            plus_capture()
        end

        algo = @CompositeAlgorithm begin
            @context c1 = plus()
            result = keyword_value_identity_dsl_test(value = c1.plus_capture.captured)
        end

        resolved = resolve(algo)
        wrapper = Processes.getalgo(resolved, 2)
        @test occursin("value = c1.plus_capture.captured", sprint(show, wrapper))

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[Processes.getkey(wrapper)].result == 4
    end

    @testset "Alias field routes work before later output bindings" begin
        @info "Composite DSL: Alias field routes work before later output bindings"
        algo = @Routine begin
            @alias dynamics = DSLHeldStateAlgo()
            seen = DSLValueAlgo(value = dynamics.state)
            state = dynamics()
        end

        resolved = resolve(algo)
        sink = Processes.getalgo(resolved, 1)
        sink_key = Processes.getkey(sink)
        routes = Processes.getoptions(resolved)[sink_key]
        @test length(routes) == 1

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[sink_key].result == 11
        @test ctx[:dynamics].state == 11
    end

    @testset "ProcessAlgorithm direct-call positional args accept alias field routes" begin
        @info "Composite DSL: ProcessAlgorithm direct-call positional args accept alias field routes"
        algo = @Routine begin
            @alias dynamics = DSLHeldStateAlgo()
            DSLPositionalCallAlgo(dynamics.state)
            state = dynamics()
        end

        resolved = resolve(algo)
        sink = Processes.getalgo(resolved, 1)
        sink_key = Processes.getkey(sink)
        routes = Processes.getoptions(resolved)[sink_key]
        @test length(routes) == 1

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[sink_key].seen == 11
        @test ctx[:dynamics].state == 11
    end

    @testset "state = dynamics.state aliases a known owned field" begin
        @info "Composite DSL: state = dynamics.state aliases a known owned field"
        algo = @Routine begin
            @alias dynamics = DSLHeldStateAlgo()
            state = dynamics.state
            seen = DSLValueAlgo(value = state)
            state = dynamics()
        end

        resolved = resolve(algo)
        sink = Processes.getalgo(resolved, 1)
        sink_key = Processes.getkey(sink)

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[sink_key].result == 11
    end
end
