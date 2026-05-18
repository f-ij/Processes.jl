"""Create a `GeneralState` value directly."""
macro state(args...)
    fields = _dsl_collect_state_fields(args)
    return _dsl_expand_state_expr(fields)
end

"""Expand a top-level DSL block into either a `CompositeAlgorithm` or a `Routine`."""
function _dsl_expand_loopalgorithm(block, constructor_name::Symbol, expected_schedule::Symbol; print_constructor::Bool = false)
    statements = block isa Expr && block.head == :block ? block.args : Any[block]
    collected = _dsl_collect_block(statements, expected_schedule, constructor_name; allow_final = true)

    state_setup_expr = _dsl_state_setup_expr(collected.state_fields, collected.state_name)
    input_setup_expr = _dsl_runtime_input_setup_expr(collected.input_fields)
    final_expr = collected.final_expr

    expanded = quote
        let
            # Keep the emitted block literal and local so the resulting macro
            # expansion is easy to inspect in lowered code.
            local _dsl_algos = Any[]
            local _dsl_states = Any[]
            local _dsl_options = Any[]
            local _dsl_specification = Int[]
            local _dsl_producers = Dict{Symbol, Any}()
            local _dsl_state_owners = Dict{Symbol, Any}()
            local _dsl_external_inputs = Pair{Symbol, Symbol}[]

            $(isnothing(state_setup_expr) ? nothing : state_setup_expr)
            $(isnothing(input_setup_expr) ? nothing : input_setup_expr)
            $(collected.step_exprs...)

            isempty(_dsl_algos) && error("`@$constructor_name` requires at least one algorithm entry.")
            $(print_constructor ? :(Processes._dsl_print_constructor_call($(QuoteNode(constructor_name)), _dsl_algos, _dsl_specification, _dsl_states, _dsl_options)) : nothing)
            # Build the final `CompositeAlgorithm`/`Routine` using the same
            # constructor surface users would write by hand.
            local _dsl_loopalgorithm = getproperty(Processes, $(QuoteNode(constructor_name)))(_dsl_algos..., Tuple(_dsl_specification), _dsl_states..., _dsl_options...)
            $(isnothing(final_expr) ? :(_dsl_loopalgorithm) : :(Processes.finalstep(_dsl_loopalgorithm, $(esc(final_expr)))))
        end
    end
    return _dsl_strip_generated_linenums!(expanded)
end

"""Print the final loop-algorithm constructor call assembled by the DSL."""
function _dsl_print_constructor_call(constructor_name::Symbol, algos, specification, states, options)
    args = Any[algos..., Tuple(specification), states..., options...]
    println(string(constructor_name, "(", join(repr.(args), ", "), ")"))
    return nothing
end

"""Parse optional macro flags for `@CompositeAlgorithm` and `@Routine`."""
function _dsl_parse_loopalgorithm_macro_args(args, macro_name::Symbol)
    if length(args) == 1
        return (; block = args[1], print_constructor = false)
    elseif length(args) == 2
        flag = args[1]
        is_print = flag == :print || (flag isa QuoteNode && flag.value == :print)
        is_print || error("`@$macro_name` only supports the optional `:print` flag before the block.")
        return (; block = args[2], print_constructor = true)
    end
    error("`@$macro_name` expects either `@$macro_name begin ... end` or `@$macro_name :print begin ... end`.")
end

"""Expand the body used inside `@repeat n begin ... end` into a `SimpleAlgo`."""
function _dsl_expand_simplealgorithm_resolved(block)
    statements = block isa Expr && block.head == :block ? block.args : Any[block]
    collected = _dsl_collect_block(statements, :none, :repeat; allow_final = false)

    state_setup_expr = _dsl_state_setup_expr(collected.state_fields, collected.state_name)
    input_setup_expr = _dsl_runtime_input_setup_expr(collected.input_fields)

    expanded = quote
        let
            # The inner repeated block is built exactly once as a plain
            # `SimpleAlgo`, then wrapped by the outer `Routine`.
            local _dsl_algos = Any[]
            local _dsl_states = Any[]
            local _dsl_options = Any[]
            local _dsl_specification = Int[]
            local _dsl_producers = Dict{Symbol, Any}()
            local _dsl_state_owners = Dict{Symbol, Any}()
            local _dsl_external_inputs = Pair{Symbol, Symbol}[]

            $(isnothing(state_setup_expr) ? nothing : state_setup_expr)
            $(isnothing(input_setup_expr) ? nothing : input_setup_expr)
            $(collected.step_exprs...)

            isempty(_dsl_algos) && error("`@repeat n begin ... end` requires at least one algorithm entry.")
            local _dsl_algo = Processes.SimpleAlgo(_dsl_algos..., _dsl_states..., _dsl_options...)
            # Return the same resolved wrapper the outer builder expects from any
            # other DSL statement.
            local _dsl_inputs = Tuple((; kind = :simple, source = input.first, destination = input.second) for input in _dsl_external_inputs)
            Processes._CompositeDSLResolved{:algo, typeof(_dsl_algo), typeof(_dsl_inputs)}(_dsl_algo, _dsl_inputs)
        end
    end
    return _dsl_strip_generated_linenums!(expanded)
end

"""Wrap a repeated DSL block in a `Routine`, then expose it as one routable entity."""
function _dsl_expand_repeated_block(block, repeats_expr)
    inner_expr = _dsl_expand_simplealgorithm_resolved(block)
    expanded = quote
        let
            local _dsl_inner = $inner_expr
            local _dsl_repeats = Int($(esc(repeats_expr)))
            # `Unique` gives the repeated block one stable identity so normal
            # routes and aliases can target it from the outer DSL block.
            local _dsl_algo = Processes.Unique(Processes.Routine(_dsl_inner.entity, (_dsl_repeats,)))
            local _dsl_inputs = _dsl_inner.inputs
            Processes._CompositeDSLResolved{:algo, typeof(_dsl_algo), typeof(_dsl_inputs)}(_dsl_algo, _dsl_inputs)
        end
    end
    return _dsl_strip_generated_linenums!(expanded)
end

"""
Build a `CompositeAlgorithm` from a declarative DSL block.

Supported block contents
========================

State declarations:
- `@state x`
- `@state x = 1`
- `@state begin ... end`
- `@state mystate begin ... end`

Alias declarations:
- `@alias source = SomeAlgo`
- `@alias source = SomeAlgo(args...)`

Aliases only affect later uses of the alias name itself. For example,
`@alias dynamics = Metropolis()` only contributes the key `:dynamics` when a
later statement actually uses `dynamics(...)`; writing `Metropolis(...)`
directly emits an unaliased `Metropolis` entry.

Plain entries:
- `Algo`
- `Algo()`
- `alias`
- `alias()`
- `alias(args...)`

Assignments:
- `x = Algo`
- `x = Algo()`
- `x = alias`
- `x = alias()`
- `x = alias(args...)`
- `a, b = Algo(...)`
- `state_field = captured_value`

ProcessAlgorithm routes:
- `x = Algo(input = produced)`
- `x = Algo(left = a, right = b)`
- `x = Algo(value = @transform(x -> x * 2, produced))`
- `x = Algo(value = @transform(x -> x + bias, produced))`
- `x = SomeAlgo(args...)(input = produced)`
- `x = alias(input = produced)`
- `x = alias(args...)(input = produced)`

Plain-function entries:
- `x = f(produced)`
- `x = f(produced, other)`
- `x = f(produced; scale = 2)`
- `x = f(produced; scale = factor)`

Context aliases:
- `@context c = algo()`
- `@context c = @repeat n algo()`
- `@context c = Algo(args...)`
- `x = f(value = c.seed)`
- `x = f(value = c.subalgo.buffer)`
- `x = f(value = c[subalgo].buffer)`
- `consumer(input = dynamics.state)`
- `value = f(dynamics.state)`
- `consumer(input = c1.plus_capture.captured)`
- `state = dynamics.state`

`@context` is only a macro-time alias for later references. The executable DSL
statement is still built from the original right-hand side expression, so
`@context c = @repeat 2 capture_noise()` runs `capture_noise()` on that schedule
but does not assign the nested algorithm the key `:c`.

Direct `c.field` access is interpreted as a reference to the nested inline
state owned by that algorithm, so `n.changeable_seed` lowers like routing from
`capture_noise._state` with source `:changeable_seed`.

Direct owned-field access like `dynamics.state` is also accepted in route
positions. It routes directly from the known `:dynamics` owner with source
`:state`, even if no earlier statement bound `state = dynamics()`. The special
binding form `state = dynamics.state` exposes that same owned field under the
plain DSL output name `state` for later statements.

Full-context shares:
- `Algo(@all(source))`
- `Algo(@all(alias...))`

`@all(...)` lowers to a statement-local `Share(raw_source, raw_target)` option.
The DSL does not manufacture unnecessary `IdentifiableAlgo` wrappers for the
source endpoint; keyed matching is left to normal runtime registration logic.

Top-level plan routes can be written as route statements:
- `@route source.produced => sink.value`

Known `@alias` names and `@context` references are accepted in those endpoint
positions. Normal call inputs still create statement-local wiring.

Scheduling:
- `x = @interval n Algo(...)`
- `x = @every n Algo(...)`
- `x = @interval n f(produced)`
- `x = @repeat n begin ... end`

Constructor-time conditional inclusion:
- `@include_if condition Algo(...)`
- `@include_if condition begin ... end`

The condition is evaluated when constructing the loop algorithm. Skipped entries
are not registered and do not contribute routes, shares, or schedules.

Current transform-route rules
=============================

Transformed routes must be written explicitly with `@transform(f, source)`. For
example:

`consumer(value = @transform(x -> x^2, a))`

The `source` part is resolved exactly like a normal route source, so it can be a
previous DSL output symbol such as `a` or an owned-field reference such as
`dynamics.state` or `c1.plus_capture.captured`.

State rebinding
===============

If an output name already belongs to the inline DSL state, assigning to that name
does not replace the state owner. Instead, the produced value is routed back into
that state slot.

Plain captured state writes
===========================

Assignments like `state_field = captured_value` lower to `ContextWrite`, which
captures the right-hand-side Julia value and writes it back through the existing
state writeback route. Use function or algorithm call syntax when the right-hand
side should be routed or stepped instead of captured.

Debug output
============

- `@CompositeAlgorithm :print begin ... end`

prints the final `CompositeAlgorithm(...)` constructor call assembled by the DSL
before it is executed.
"""
macro CompositeAlgorithm(args...)
    parsed = _dsl_parse_loopalgorithm_macro_args(args, :CompositeAlgorithm)
    _dsl_expand_loopalgorithm(parsed.block, :CompositeAlgorithm, :every; print_constructor = parsed.print_constructor)
end

"""
Build a `Routine` from a declarative DSL block.

The supported statement syntax is the same as `@CompositeAlgorithm`, except that
the scheduling wrapper expected inside the block is `@repeat n expr` instead of
`@interval n expr`.

Examples:
- `x = Algo(input = value)`
- `x = @repeat 10 Algo(input = value)`
- `y = @repeat 5 begin ... end`
- `@include_if enabled x = Algo(input = value)`
- `z = f(value; scale = 2)`
- `@context c = @repeat 2 algo()`
- `Damper(@all(osc...))`
- `PickRandomSeed(targetseed = n.changeable_seed)`
- `@Routine :print begin ... end`
"""
macro Routine(args...)
    parsed = _dsl_parse_loopalgorithm_macro_args(args, :Routine)
    _dsl_expand_loopalgorithm(parsed.block, :Routine, :repeat; print_constructor = parsed.print_constructor)
end
