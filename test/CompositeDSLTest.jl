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
dsl_final_summary(context) = (; result = context[DSLValueAlgo].result)

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

        @test resolved isa Processes.LoopAlgorithm
        @test Processes.getplan(resolved) isa CompositeAlgorithm
        @test isempty(Processes.getoptions(algo, Processes.Route))
        @test !isempty(Processes.getoptions(Processes.getplan(resolved), Processes.Route))
        @test intervals(resolved) == (
            Processes.Interval(1),
            Processes.Interval(10),
            Processes.Interval(1),
            Processes.Interval(1),
        )
        @test Processes.getkey(Processes.getalgo(resolved, 1)) == :source
        @test length(Processes.getstates(resolved)) == 1
        @test Processes.getkey(first(Processes.getstates(resolved))) == :_state

        sharedcontexts, sharedvars = Processes._resolve_options(resolved)
        @test !isempty(sharedvars)

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
        @test occursin("_composite_dsl_owner", expanded_str)
    end

    @testset "@route statements are top-level plan routes" begin
        @info "Composite DSL: @route statements are top-level plan routes"
        algo = @CompositeAlgorithm begin
            @state seed = 2
            @alias source = DSLSourceAlgo
            @alias sink = DSLSinkAlgo
            produced, passthrough = source(seed = seed)
            sink()
            @route source.produced => sink.value
        end

        @test algo isa Processes.LoopAlgorithm
        plan = Processes.getplan(algo)
        @test length(Processes.getoptions(plan, Processes.Route)) == 2
        @test length(getfield(plan, :plan_wiring)) == 1
        @test length(getfield(plan, :local_wiring)[1]) == 1
        @test isempty(getfield(plan, :local_wiring)[2])

        resolved = resolve(algo)
        @test isempty(Processes.getoptions(resolved, Processes.Route))
        @test length(getfield(Processes.getplan(resolved), :plan_wiring)) == 1
        step_wiring = getfield(Processes.getplan(resolved), :step_wiring)
        sink_routes = @inferred Processes.routing_sharedvars(step_wiring[2])
        @test step_wiring[2] isa Processes.StepRouting
        @test length(sink_routes) == 1
        @test Processes.localnames(only(sink_routes)) == (:value,)

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[:sink].seen == 2
        @test length(typeof(ctx[:sink]).parameters) == 2
    end

    @testset "Local routes occlude top-level @route aliases" begin
        @info "Composite DSL: Local routes occlude top-level @route aliases"
        algo = @CompositeAlgorithm begin
            @state seed = 7
            @alias source = DSLSourceAlgo
            @alias sink = DSLSinkAlgo
            produced, passthrough = source(seed = seed)
            sink(value = passthrough)
            @route source.produced => sink.value
        end

        resolved = resolve(algo)
        step_wiring = getfield(Processes.getplan(resolved), :step_wiring)
        sink_routes = @inferred Processes.routing_sharedvars(step_wiring[2])
        @test length(sink_routes) == 1
        @test Processes.subvarcontextnames(only(sink_routes)) == (:passthrough,)

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[:sink].seen == 7
        @test length(typeof(ctx[:sink]).parameters) == 2
    end

    @testset "Transform routes use explicit @transform syntax" begin
        @info "Composite DSL: Transform routes use explicit @transform syntax"
        one_var_transform = @CompositeAlgorithm begin
            @state seed = 3
            @alias source = DSLSourceAlgo
            produced, passthrough = source(seed = seed)
            DSLSinkAlgo(value = @transform(x -> 3x, produced))
        end

        resolved_one_var = resolve(one_var_transform)
        _, one_var_opts = Processes._resolve_options(resolved_one_var)
        one_var_routes = one_var_opts[:DSLSinkAlgo_1]
        @test length(one_var_routes) == 1
        @test Processes.gettransform(first(one_var_routes)) !== nothing

        p_one_var = Process(resolved_one_var, repeat = 1)
        Processes.run(p_one_var)
        ctx_one_var = fetch(p_one_var)
        @test ctx_one_var[:DSLSinkAlgo_1].seen == 6

        bias = 3
        two_var_transform = @CompositeAlgorithm begin
            @state seed = 3
            @alias source = DSLSourceAlgo
            produced, passthrough = source(seed = seed)
            DSLValueAlgo(value = @transform(x -> x + bias, produced))
        end

        resolved_two_var = resolve(two_var_transform)
        _, two_var_opts = Processes._resolve_options(resolved_two_var)
        two_var_routes = two_var_opts[:DSLValueAlgo_1]
        @test length(two_var_routes) == 1
        @test Processes.gettransform(first(two_var_routes)) !== nothing

        p_two_var = Process(resolved_two_var, repeat = 1)
        Processes.run(p_two_var)
        ctx_two_var = fetch(p_two_var)
        @test ctx_two_var[:DSLValueAlgo_1].result == 5
    end

    @testset "Implicit transform expressions are rejected in route syntax" begin
        @info "Composite DSL: Implicit transform expressions are rejected in route syntax"
        @test_throws ErrorException macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @state seed = 3
                @alias source = DSLSourceAlgo
                produced, passthrough = source(seed = seed)
                DSLSinkAlgo(value = produced * 3)
            end
        end)
    end

    @testset "Scheduled assignment syntax error suggests RHS wrapper" begin
        @info "Composite DSL: Scheduled assignment syntax error suggests RHS wrapper"
        err = try
            macroexpand(@__MODULE__, quote
                @CompositeAlgorithm begin
                    @every 1 produced = DSLSourceAlgo()
                end
            end)
            nothing
        catch caught
            caught
        end

        @test err isa ErrorException
        msg = sprint(showerror, err)
        @test occursin("Invalid scheduled assignment", msg)
        @test occursin("produced = @every 1 DSLSourceAlgo()", msg)
    end

    @testset "Routine repeat form expands correctly" begin
        @info "Composite DSL: Routine repeat form expands correctly"
        routine = @Routine begin
            @state produced = 5
            tripled = @repeat 3 scaled_double_dsl_test(produced; scale = 3)
        end

        resolved_routine = resolve(routine)
        @test resolved_routine isa Processes.LoopAlgorithm
        @test Processes.getplan(resolved_routine) isa Routine
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
        @test resolved_outer isa Processes.LoopAlgorithm
        @test Processes.getplan(resolved_outer) isa CompositeAlgorithm
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
        _, sharedvars = Processes._resolve_options(resolved)
        routes = sharedvars[wrapper_key]
        @test length(routes) == 1
        @test occursin("c1.plus_capture.captured", sprint(show, wrapper))

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[wrapper_key].result == 4
    end

    @testset "FuncWrapper positional args accept explicit @transform routes" begin
        @info "Composite DSL: FuncWrapper positional args accept explicit @transform routes"
        nested_identity(x) = x
        plus = @Routine begin
            @alias plus_capture = DSLNestedSourceAlgo
            plus_capture()
        end

        algo = @CompositeAlgorithm begin
            @context c1 = plus()
            result = nested_identity(@transform(x -> x + 1, c1.plus_capture.captured))
        end

        resolved = resolve(algo)
        wrapper = Processes.getalgo(resolved, 2)
        wrapper_key = Processes.getkey(wrapper)
        @test occursin("@transform", sprint(show, wrapper))
        @test occursin("c1.plus_capture.captured", sprint(show, wrapper))

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[wrapper_key].result == 5
    end

    @testset "FuncWrapper positional @transform routes can source @state fields" begin
        @info "Composite DSL: FuncWrapper positional @transform routes can source @state fields"
        nested_identity(x) = x

        algo = @Routine begin
            @state clamping_beta = 2
            result = nested_identity(@transform(x -> -x, clamping_beta))
        end

        resolved = resolve(algo)
        wrapper = Processes.getalgo(resolved, 1)
        wrapper_key = Processes.getkey(wrapper)
        _, sharedvars = Processes._resolve_options(resolved)
        routes = sharedvars[wrapper_key]
        @test length(routes) == 1
        @test Processes.gettransform(first(routes)) !== nothing
        @test occursin("@transform", sprint(show, wrapper))
        @test occursin("clamping_beta", sprint(show, wrapper))

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[wrapper_key].result == -2
    end

    @testset "State fields can be assigned captured values directly" begin
        @info "Composite DSL: State fields can be assigned captured values directly"
        somevar = 3

        algo = @Routine begin
            @state clamping_beta = 1.0
            clamping_beta = somevar
            result = keyword_value_identity_dsl_test(value = clamping_beta)
        end

        resolved = resolve(algo)
        writer = Processes.getalgo(resolved, 1)
        writer_key = Processes.getkey(writer)
        result_algo = Processes.getalgo(resolved, 2)
        @test Processes.getalgo(writer) isa Processes.ContextWrite

        _, sharedvars = Processes._resolve_options(resolved)
        routes = sharedvars[writer_key]
        @test length(routes) == 1

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[:_state].clamping_beta === 3.0
        @test ctx[Processes.getkey(result_algo)].result === 3.0
    end

    @testset "State buffer indexes can be assigned directly" begin
        @info "Composite DSL: State buffer indexes can be assigned directly"

        algo = @Routine begin
            @state somebuffer = [0, 0, 0]
            somebuffer[1] = 2
            somebuffer[2:3] = [4, 5]
            result = keyword_value_identity_dsl_test(value = somebuffer)
        end

        resolved = resolve(algo)
        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[:_state].somebuffer == [2, 4, 5]
        @test ctx[Processes.getkey(Processes.getalgo(resolved, 3))].result == [2, 4, 5]
    end

    @testset "State buffers support broadcast assignment syntax" begin
        @info "Composite DSL: State buffers support broadcast assignment syntax"
        replacement = [7, 8]

        algo = @Routine begin
            @state somebuffer = [0, 0, 0]
            somebuffer .= 1
            somebuffer[2:3] .= replacement
            result = keyword_value_identity_dsl_test(value = somebuffer)
        end

        resolved = resolve(algo)
        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[:_state].somebuffer == [1, 7, 8]
        @test ctx[Processes.getkey(Processes.getalgo(resolved, 3))].result == [1, 7, 8]
    end

    @testset "Owned state fields can be assigned from ref values" begin
        @info "Composite DSL: Owned state fields can be assigned from ref values"
        nudged = @Routine begin
            @state nudged_beta = 0.0
            result = keyword_value_identity_dsl_test(value = nudged_beta)
        end

        algo = @CompositeAlgorithm begin
            @state clamping_beta = Ref(2.0)
            @alias nudged = nudged

            nudged.nudged_beta = clamping_beta[]
            nudged()
        end

        resolved = resolve(algo)
        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        @test ctx[:_state].nudged_beta === 2.0
        @test ctx[:FuncWrapper_1].result === 2.0
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
        _, sharedvars = Processes._resolve_options(resolved)
        routes = sharedvars[sink_key]
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
        _, sharedvars = Processes._resolve_options(resolved)
        routes = sharedvars[sink_key]
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

    @testset "@include_if filters DSL entries at construction time" begin
        @info "Composite DSL: @include_if filters entries at construction time"
        include_source = false
        skipped = @CompositeAlgorithm begin
            @state seed = 3
            @include_if include_source produced, passthrough = DSLSourceAlgo(seed = seed)
            DSLValueAlgo(value = seed)
        end

        resolved_skipped = resolve(skipped)
        @test length(Processes.getalgos(resolved_skipped)) == 1
        @test Processes.intervals(resolved_skipped) == (Processes.Interval(1),)
        @test isnothing(Processes.findkey(resolved_skipped, :DSLSourceAlgo_1))

        p_skipped = Process(resolved_skipped, repeat = 1)
        Processes.run(p_skipped)
        ctx_skipped = fetch(p_skipped)
        @test ctx_skipped[:DSLValueAlgo_1].result == 3

        include_source = true
        included = @CompositeAlgorithm begin
            @state seed = 3
            @include_if include_source produced, passthrough = DSLSourceAlgo(seed = seed)
            DSLValueAlgo(value = produced)
        end

        resolved_included = resolve(included)
        @test length(Processes.getalgos(resolved_included)) == 2
        @test !isnothing(Processes.findkey(resolved_included, :DSLSourceAlgo_1))

        p_included = Process(resolved_included, repeat = 1)
        Processes.run(p_included)
        ctx_included = fetch(p_included)
        @test ctx_included[:DSLValueAlgo_1].result == 2
    end

    @testset "@include_if supports blocks, schedules, and routines" begin
        @info "Composite DSL: @include_if supports blocks, schedules, and routines"
        include_block = true
        block_algo = @CompositeAlgorithm begin
            @state seed = 3
            @include_if include_block begin
                produced, passthrough = @interval 2 DSLSourceAlgo(seed = seed)
                DSLSinkAlgo(value = produced)
            end
            DSLValueAlgo(value = seed)
        end

        resolved_block = resolve(block_algo)
        @test length(Processes.getalgos(resolved_block)) == 3
        @test Processes.intervals(resolved_block) == (
            Processes.Interval(2),
            Processes.Interval(1),
            Processes.Interval(1),
        )

        include_block = false
        routine = @Routine begin
            @state produced = 5
            @include_if include_block tripled = @repeat 3 scaled_double_dsl_test(produced; scale = 3)
            DSLValueAlgo(value = produced)
        end

        resolved_routine = resolve(routine)
        @test length(Processes.getalgos(resolved_routine)) == 1
        @test repeats(resolved_routine) == (1,)
    end

    @testset "@include_if supports branch-local @context" begin
        @info "Composite DSL: @include_if supports branch-local @context"
        plus = @Routine begin
            @alias plus_capture = DSLNestedSourceAlgo
            plus_capture()
        end

        include_context = true
        algo = @CompositeAlgorithm begin
            @include_if include_context begin
                @context c1 = plus()
                result = keyword_value_identity_dsl_test(value = c1.plus_capture.captured)
            end
        end

        resolved = resolve(algo)
        @test length(Processes.getalgos(resolved)) == 2

        p = Process(resolved, repeat = 1)
        Processes.run(p)
        ctx = fetch(p)
        wrapper = Processes.getalgo(resolved, 2)
        @test ctx[Processes.getkey(wrapper)].result == 4
    end

    @testset "@include_if rejects state and alias declarations" begin
        @info "Composite DSL: @include_if rejects state and alias declarations"
        @test_throws ErrorException macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @include_if true begin
                    @state seed = 3
                    DSLValueAlgo(value = seed)
                end
            end
        end)

        @test_throws ErrorException macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @include_if true begin
                    @alias source = DSLSourceAlgo
                    source()
                end
            end
        end)
    end

    @testset "@finally wraps only the outer DSL algorithm" begin
        @info "Composite DSL: @finally wraps only the outer DSL algorithm"
        algo = @CompositeAlgorithm begin
            @state seed = 8
            DSLValueAlgo(value = seed)
            @finally dsl_final_summary
        end

        @test algo isa Processes.FinalizedAlgorithm
        resolved = resolve(algo)
        p = Process(resolved, repeat = 1)
        run(p)
        @test fetch(p) == (; result = 8)
        @test context(p)[DSLValueAlgo].result == 8

        close(p)
        @test fetch(p) == (; result = 8)

        @test_throws ErrorException macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                DSLValueAlgo(value = 1)
                @finally dsl_final_summary
                @finally dsl_final_summary
            end
        end)

        @test_throws ErrorException macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                @include_if true begin
                    DSLValueAlgo(value = 1)
                    @finally dsl_final_summary
                end
            end
        end)

        @test_throws ErrorException macroexpand(@__MODULE__, quote
            @CompositeAlgorithm begin
                result = @repeat 2 begin
                    DSLValueAlgo(value = 1)
                    @finally dsl_final_summary
                end
            end
        end)
    end
end
