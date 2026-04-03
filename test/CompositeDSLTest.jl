using Test
using Processes

struct DSLSourceAlgo <: Processes.ProcessAlgorithm end
struct DSLCombineAlgo <: Processes.ProcessAlgorithm end
struct DSLSinkAlgo <: Processes.ProcessAlgorithm end
struct DSLValueAlgo <: Processes.ProcessAlgorithm end

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

scaled_double_dsl_test(x; scale = 1) = scale * (2x)
zero_input_dsl_test() = 7
keyword_only_capture_dsl_test(; plus_capture, minus_capture, β, buffers) = plus_capture + minus_capture + β + buffers
literal_join_dsl_test(prefix, value, marker) = string(prefix, value, marker)
constant_value_dsl_test() = 0.25
square_dsl_test(x) = x^2

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
        @test_throws ErrorException merge(left, @state begin
            seed = 7
        end)
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

    @testset "@all uses raw share endpoints" begin
        @info "Composite DSL: @all uses raw share endpoints"
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
        @test !occursin("Processes.IdentifiableAlgo", expanded_str)
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

    @testset "Zero-input plain functions are routable" begin
        @info "Composite DSL: Zero-input plain functions are routable"
        generated = @CompositeAlgorithm begin
            result = zero_input_dsl_test()
        end

        p_generated = Process(resolve(generated), repeat = 1)
        Processes.run(p_generated)
        ctx_generated = fetch(p_generated)
        @test ctx_generated[:FuncWrapper_1].result == 7
    end

    @testset "Assignments write back into inline state" begin
        @info "Composite DSL: Assignments write back into inline state"
        mockcomp = @CompositeAlgorithm begin
            @state num = 0.0
            num = rand()
            num = sqrt(num)
        end

        comp_process = InlineProcess(mockcomp, repeats = 1)
        comp_ctx = run(comp_process)

        @test 0.0 < comp_ctx[:_state].num <= 1.0
    end

    @testset "Repeated assignments write back into inline state" begin
        @info "Composite DSL: Repeated assignments write back into inline state"
        mockroutine = @Routine begin
            @state num = 16.0
            num = @repeat 2 sqrt(num)
        end

        routine_process = InlineProcess(mockroutine, repeats = 1)
        routine_ctx = run(routine_process)

        @test routine_ctx[:_state].num == 2.0
    end

    @testset "FuncWrapper positional literals survive DSL lowering" begin
        @info "Composite DSL: FuncWrapper positional literals survive DSL lowering"
        literal_algo = @CompositeAlgorithm begin
            @state num = 4
            joined = literal_join_dsl_test("Num: ", num, :done)
        end

        literal_process = InlineProcess(literal_algo, repeats = 1)
        literal_ctx = run(literal_process)

        @test literal_ctx[:_state].num == 4
        @test literal_ctx[:FuncWrapper_1].joined == "Num: 4done"
    end

    @testset "Interval and repeat DSL shapes from manual test work" begin
        @info "Composite DSL: Interval and repeat DSL shapes from manual test work"
        mockcomp = @CompositeAlgorithm begin
            @state num = 0.0
            num = constant_value_dsl_test()
            num = sqrt(num)
            println(num)
        end

        comp_process = InlineProcess(mockcomp, repeats = 1)
        comp_ctx = run(comp_process)
        @test comp_ctx[:_state].num == 0.5

        mockroutine = @Routine begin
            @state num = 0.0
            num = constant_value_dsl_test()
            num = @repeat 2 square_dsl_test(num)
            println("Num: ", num)
            num = constant_value_dsl_test()
        end

        resolved_routine = resolve(mockroutine)
        @test resolved_routine isa Routine
        @test repeats(resolved_routine) == (1, 2, 1, 1)

        routine_process = InlineProcess(mockroutine, repeats = 2)
        routine_ctx = run(routine_process)
        @test routine_ctx[:_state].num == 0.25
        @test occursin("globals", sprint(show, routine_ctx))

        inline_process_show = sprint(io -> show(io, MIME("text/plain"), routine_process))
        @test !occursin("globals", inline_process_show)
        @test occursin("FuncWrapper_3: println :: (\"Num: \", num) -> nothing", inline_process_show)
    end

    @testset "Constructor expression left of final route call is preserved" begin
        @info "Composite DSL: Constructor expression left of final route call is preserved"
        expanded_ctor = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                state = DSLSourceAlgo()
            end
        end)
        expanded_ctor_str = sprint(show, Base.remove_linenums!(expanded_ctor))
        @test occursin("_resolve_composite_dsl_keyword_call(DSLSourceAlgo,", expanded_ctor_str)

        expanded_nested = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                DSLCombineAlgo(1)(left = produced)
            end
        end)
        expanded_nested_str = sprint(show, Base.remove_linenums!(expanded_nested))
        @test occursin("_resolve_composite_dsl_entity(DSLCombineAlgo(1)", expanded_nested_str)

        expanded_double = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                state = DSLSourceAlgo()()
            end
        end)
        expanded_double_str = sprint(show, Base.remove_linenums!(expanded_double))
        @test occursin("_resolve_composite_dsl_entity(DSLSourceAlgo()", expanded_double_str)
    end

    @testset "Aliases rewrite call roots directly" begin
        @info "Composite DSL: Aliases rewrite call roots directly"
        expanded = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @alias source = DSLSourceAlgo
                produced = source(seed = seed)
            end
        end)
        expanded_str = sprint(show, Base.remove_linenums!(expanded))
        @test occursin("_resolve_composite_dsl_keyword_call", expanded_str)
        @test occursin("DSLSourceAlgo", expanded_str)
    end

    @testset "@context lowers to plain route owner expressions" begin
        @info "Composite DSL: @context lowers to plain route owner expressions"
        expanded_property = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @alias plus = DSLSourceAlgo
                @context c1 = plus()
                DSLSinkAlgo(value = c1.plus_capture.buffer)
            end
        end)
        expanded_property_str = sprint(show, Base.remove_linenums!(expanded_property))
        @test occursin("owner = plus.plus_capture", expanded_property_str)
        @test occursin("source = :buffer", expanded_property_str)

        expanded_index = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @alias plus = DSLSourceAlgo
                @context c1 = plus()
                DSLSinkAlgo(value = c1[plus_capture].buffer)
            end
        end)
        expanded_index_str = sprint(show, Base.remove_linenums!(expanded_index))
        @test occursin("owner = plus[plus_capture]", expanded_index_str)
        @test occursin("source = :buffer", expanded_index_str)
    end

    @testset "@context direct field lowers to nested state owner" begin
        @info "Composite DSL: @context direct field lowers to nested state owner"
        expanded = macroexpand(@__MODULE__, quote
            @Routine begin
                @alias inner = DSLSourceAlgo
                @context c = inner()
                DSLSinkAlgo(value = c.seed)
            end
        end)
        expanded_str = sprint(show, Base.remove_linenums!(expanded))
        @test occursin("owner = inner._state", expanded_str)
        @test occursin("source = :seed", expanded_str)
    end

    @testset "@context strips scheduling wrappers" begin
        @info "Composite DSL: @context strips scheduling wrappers"
        expanded = macroexpand(@__MODULE__, quote
            @Routine begin
                @alias plus = DSLSourceAlgo
                @context c1 = @repeat 2 plus()
                DSLSinkAlgo(value = c1.plus_capture.buffer)
            end
        end)
        expanded_str = sprint(show, Base.remove_linenums!(expanded))
        @test occursin("owner = plus.plus_capture", expanded_str)
        @test !occursin("@repeat", expanded_str)
    end

    @testset "Keyword-only plain functions can mix @context routes and lexical captures" begin
        @info "Composite DSL: Keyword-only plain functions can mix @context routes and lexical captures"
        expanded = macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @state buffers
                @alias plus = DSLSourceAlgo
                @alias minus = DSLSourceAlgo
                @context c1 = plus()
                @context c2 = minus()
                keyword_only_capture_dsl_test(plus_capture = c1.plus_capture.buffer, minus_capture = c2[minus_capture].buffer, β = beta, buffers = buffers)
            end
        end)
        expanded_str = sprint(show, Base.remove_linenums!(expanded))
        @test occursin("owner = plus.plus_capture", expanded_str)
        @test occursin("owner = minus[minus_capture]", expanded_str)
        @test occursin("plus_capture = :plus_capture", expanded_str)
        @test occursin("minus_capture = :minus_capture", expanded_str)
        @test occursin("β = beta", expanded_str)
        @test occursin("buffers = :buffers", expanded_str)
    end

    @testset "Identity aliases stay plain aliases in nested DSL blocks" begin
        @info "Composite DSL: Identity aliases stay plain aliases in nested DSL blocks"
        expanded = macroexpand(@__MODULE__, quote
            function nudged_process_dsl_regression(beta, fullsweeps, plus_capture, minus_capture, plus, minus)
                @CompositeAlgorithm begin
                    @state buffers
                    @alias plus = plus
                    @alias minus = minus
                    @context c1 = plus()
                    @context c2 = minus()
                    keyword_only_capture_dsl_test(
                        plus_capture = c1.plus_capture.buffer,
                        minus_capture = c2.minus_capture.buffer,
                        β = beta,
                        buffers = buffers,
                    )
                end
            end
        end)
        expanded_str = sprint(show, Base.remove_linenums!(expanded))
        @test occursin("owner = plus.plus_capture", expanded_str)
        @test occursin("owner = minus.minus_capture", expanded_str)
        @test !occursin("Transform route for `plus_capture`", expanded_str)
    end

    @testset "Routine DSL accepts direct ProcessAlgorithm call syntax" begin
        @info "Composite DSL: Routine DSL accepts direct ProcessAlgorithm call syntax"
        positional_routine = @Routine begin
            @state input = 5
            seen = @repeat 2 DSLPositionalCallAlgo(input)
        end

        resolved_positional = resolve(positional_routine)
        p_positional = Process(resolved_positional, repeat = 1)
        Processes.run(p_positional)
        ctx_positional = fetch(p_positional)
        @test ctx_positional[:DSLPositionalCallAlgo_1].seen == 5

        keyword_routine = @Routine begin
            @state begin
                input = 5
                factor = 3
            end
            seen = @repeat 2 DSLKeywordCallAlgo(input; scale = factor)
        end

        resolved_keyword = resolve(keyword_routine)
        p_keyword = Process(resolved_keyword, repeat = 1)
        Processes.run(p_keyword)
        ctx_keyword = fetch(p_keyword)
        @test ctx_keyword[:DSLKeywordCallAlgo_1].seen == 15
    end

end
