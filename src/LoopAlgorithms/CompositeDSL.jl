export @CompositeAlgorithm, @Routine, @state, InlineState

"""
Lightweight inline state used by the DSL.

`@state` declarations inside a DSL block are collected into one `InlineState`.
"""
struct InlineState{Fields, Required, Defaults} <: ProcessState
    defaults::Defaults
end

"""Construct an `InlineState` with compile-time field metadata."""
@inline function _make_inline_state(defaults::Defaults, ::Val{Fields}, ::Val{Required}) where {Defaults, Fields, Required}
    InlineState{Fields, Required, Defaults}(defaults)
end

"""Fetch a required `@state` input or raise a readable error."""
@inline function _inline_state_required(context, name::Symbol)
    haskey(context, name) || error("Missing required @state input `$(name)`.")
    return getproperty(context, name)
end

"""Initialize an `InlineState` from a context or plain named tuple."""
@generated function Processes.init(state::InlineState{Fields, Required, Defaults}, context::C) where {Fields, Required, Defaults, C <: Union{Processes.AbstractContext, NamedTuple}}
    default_names = fieldnames(Defaults)
    values = Expr[]
    for field in Fields
        if field in Required
            push!(values, :(_inline_state_required(context, $(QuoteNode(field)))))
        else
            field in default_names || error("Missing default for optional @state field `$field`.")
            push!(values, :(get(context, $(QuoteNode(field)), getproperty(state.defaults, $(QuoteNode(field))))))
        end
    end

    nt_type = Expr(:curly, :NamedTuple, QuoteNode(Fields))
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        return $nt_type(($(values...),))
    end
end

"""Internal resolved representation used while expanding the DSL."""
struct _CompositeDSLResolved{Kind, Entity, Inputs}
    entity::Entity
    inputs::Inputs
end

@inline _dsl_with_customname(algo, ::Val{Symbol()}) = Unique(algo)
@inline _dsl_with_customname(algo, ::Val{Name}) where {Name} = Unique(algo; customname = Name)

function _resolve_composite_dsl_entity(spec, inputs::Tuple{Vararg{Pair{Symbol, Symbol}}}, output_symbols::Tuple{Vararg{Symbol}}, ::Val{Name}) where {Name}
    if spec isa Union{ProcessState, Type{<:ProcessState}}
        isempty(inputs) || error("ProcessStates in the DSL cannot declare routed inputs.")
        return _CompositeDSLResolved{:state, typeof(spec), typeof(inputs)}(spec, inputs)
    elseif spec isa AbstractIdentifiableAlgo
        return _CompositeDSLResolved{:algo, typeof(spec), typeof(inputs)}(spec, inputs)
    elseif spec isa Union{ProcessAlgorithm, Type{<:ProcessAlgorithm}}
        resolved = _dsl_with_customname(spec, Val(Name))
        return _CompositeDSLResolved{:algo, typeof(resolved), typeof(inputs)}(resolved, inputs)
    elseif spec isa Function
        isempty(inputs) || error("Plain functions should use regular call syntax in the DSL, e.g. `f(x)` or `f(x; scale = 2)`.")
        wrapped = FuncWrapper(spec, (), output_symbols)
        resolved = _dsl_with_customname(wrapped, Val(Name))
        return _CompositeDSLResolved{:algo, typeof(resolved), typeof(inputs)}(resolved, inputs)
    else
        error("Unsupported DSL entry `$spec`. Expected a ProcessAlgorithm, ProcessState, or Function.")
    end
end

function _resolve_composite_dsl_function(
    spec,
    keyword_args::NamedTuple,
    input_symbols::Tuple{Vararg{Symbol}},
    output_symbols::Tuple{Vararg{Symbol}},
    ::Val{Name},
) where {Name}
    spec isa Function || error("Positional/semicolon call syntax in the DSL is reserved for plain functions. For ProcessAlgorithms use `Algo(routes...)` or `Algo(constructor...)(routes...)`.")

    wrapped = FuncWrapper(spec, input_symbols, output_symbols, keyword_args)
    resolved = _dsl_with_customname(wrapped, Val(Name))

    inputs = Pair{Symbol, Symbol}[source => source for source in input_symbols]
    for name in keys(keyword_args)
        source = getproperty(keyword_args, name)
        source isa Symbol || continue
        push!(inputs, source => name)
    end
    routed_inputs = tuple(inputs...)
    return _CompositeDSLResolved{:algo, typeof(resolved), typeof(routed_inputs)}(resolved, routed_inputs)
end

function _composite_dsl_add_routes!(options::Vector{Any}, producers::Dict{Symbol, Any}, external_inputs::Vector{Pair{Symbol, Symbol}}, target, inputs::Tuple)
    for mapping in inputs
        source, destination = mapping
        if haskey(producers, source)
            push!(options, Route(producers[source] => target, source => destination))
        else
            ext_mapping = source => source
            ext_mapping in external_inputs || push!(external_inputs, ext_mapping)
        end
    end
    return options
end

function _composite_dsl_register_outputs!(producers::Dict{Symbol, Any}, owner, outputs::Tuple{Vararg{Symbol}})
    for output in outputs
        producers[output] = owner
    end
    return producers
end

function _composite_dsl_bind_outputs!(options::Vector{Any}, producers::Dict{Symbol, Any}, target, outputs::Tuple{Vararg{Symbol}})
    for output in outputs
        if haskey(producers, output) && producers[output] isa ProcessState
            push!(options, Route(producers[output] => target, output => output))
        else
            producers[output] = target
        end
    end
    return producers
end

"""Build the inline state expression used by both `@state` and the block DSL."""
function _dsl_expand_state_expr(fields)
    field_names = Expr(:tuple, [QuoteNode(field.name) for field in fields]...)
    required_names = Expr(:tuple, [QuoteNode(field.name) for field in fields if field.required]...)
    default_kws = [Expr(:kw, field.name, esc(field.default)) for field in fields if !field.required]
    defaults_expr = Expr(:tuple, Expr(:parameters, default_kws...))

    return quote
        Processes._make_inline_state($defaults_expr, Val{$field_names}(), Val{$required_names}())
    end
end

"""Parse one field entry from a `@state` declaration."""
function _dsl_parse_state_entry(ex)
    if ex isa Symbol
        return (; name = ex, required = true, default = nothing)
    elseif ex isa Expr && ex.head == :(=)
        lhs = ex.args[1]
        lhs isa Symbol || error("@state fields must be plain symbols or `name = default` assignments. Got `$lhs`.")
        return (; name = lhs, required = false, default = ex.args[2])
    end
    error("@state only supports entries like `a` or `a = 1`. Got `$ex`.")
end

"""Collect field entries from a `@state` declaration, ignoring line nodes."""
function _dsl_collect_state_fields(args)
    raw_entries = Any[]
    for arg in args
        if arg isa LineNumberNode
            continue
        elseif arg isa Expr && arg.head == :block
            append!(raw_entries, [item for item in arg.args if !(item isa LineNumberNode)])
        else
            push!(raw_entries, arg)
        end
    end

    isempty(raw_entries) && error("@state requires at least one field.")
    return map(_dsl_parse_state_entry, raw_entries)
end

"""
Parse a `@state` statement inside the DSL block.

Supported forms:
- `@state a = 1`
- `@state begin ... end`
- `@state mystate begin ... end`
"""
function _dsl_parse_state_statement(stmt)
    stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state") || error("Invalid @state statement `$stmt`.")
    args = Any[stmt.args[i] for i in 3:length(stmt.args)]
    isempty(args) && error("@state requires at least one field.")

    if length(args) >= 2 && args[1] isa Symbol
        return args[1], _dsl_collect_state_fields(args[2:end])
    end

    return :_state, _dsl_collect_state_fields(args)
end

"""Accumulate one `@state` statement into the current block-level inline state."""
function _dsl_merge_state_statement!(state_fields::Vector, state_name::Symbol, stmt)
    this_state_name, this_state_fields = _dsl_parse_state_statement(stmt)
    state_name == :_state || this_state_name == :_state || this_state_name == state_name || error("Use a single state name inside one DSL block. Got `$state_name` and `$this_state_name`.")
    append!(state_fields, this_state_fields)
    return this_state_name == :_state ? state_name : this_state_name
end

"""Generate the setup expression for the collected block-level inline state."""
function _dsl_state_setup_expr(state_fields, state_name::Symbol)
    isempty(state_fields) && return nothing

    field_names = getproperty.(state_fields, :name)
    length(unique(field_names)) == length(field_names) || error("Duplicate @state field names are not allowed: $(field_names)")

    state_expr = _dsl_expand_state_expr(state_fields)
    outputs_expr = Expr(:tuple, [QuoteNode(field.name) for field in state_fields]...)
    return quote
        local _dsl_state = $state_expr
        push!(_dsl_states, $(QuoteNode(state_name)) => _dsl_state)
        Processes._composite_dsl_register_outputs!(_dsl_producers, _dsl_state, $outputs_expr)
    end
end

function _dsl_parse_output_symbols(lhs)
    if lhs isa Symbol
        return (lhs,)
    elseif lhs isa Expr && lhs.head == :tuple
        all(x -> x isa Symbol, lhs.args) || error("Multi-output bindings must use plain symbols like `a, b = algo`.")
        return tuple(lhs.args...)
    end
    error("Unsupported left-hand side in the DSL: `$lhs`.")
end

function _dsl_parse_alias(stmt)
    stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias") || error("Invalid alias statement `$stmt`.")
    length(stmt.args) == 3 || error("@alias expects a single assignment like `@alias src = SourceAlgo`.")
    assign = stmt.args[3]
    assign isa Expr && assign.head == :(=) || error("@alias expects a single assignment like `@alias src = SourceAlgo`.")
    lhs = assign.args[1]
    lhs isa Symbol || error("@alias names must be symbols. Got `$lhs`.")
    return lhs => assign.args[2]
end

function _dsl_parse_schedule(ex)
    if ex isa Expr && ex.head == :macrocall && ex.args[1] == Symbol("@interval")
        length(ex.args) == 4 || error("@interval expects `@interval n expr`.")
        return (:every, ex.args[3], ex.args[4])
    elseif ex isa Expr && ex.head == :macrocall && ex.args[1] == Symbol("@every")
        length(ex.args) == 4 || error("@every expects `@every n expr`.")
        return (:every, ex.args[3], ex.args[4])
    elseif ex isa Expr && ex.head == :macrocall && ex.args[1] == Symbol("@repeat")
        length(ex.args) == 4 || error("@repeat expects `@repeat n expr`.")
        return (:repeat, ex.args[3], ex.args[4])
    end
    return (:default, :(1), ex)
end

function _dsl_resolve_alias(alias_map, ex)
    if ex isa Symbol && haskey(alias_map, ex)
        return alias_map[ex], ex
    end
    return ex, Symbol()
end

function _dsl_resolve_constructor_expr(alias_map, ex)
    if ex isa Symbol
        return _dsl_resolve_alias(alias_map, ex)
    elseif ex isa Expr && ex.head == :call && ex.args[1] isa Symbol && haskey(alias_map, ex.args[1])
        isempty(ex.args[2:end]) || error("Aliases can only be called without constructor arguments. Alias the instantiated form instead, e.g. `@alias x = Algo(args...)`.")
        return alias_map[ex.args[1]], ex.args[1]
    end
    return ex, Symbol()
end

function _dsl_parse_function_call(alias_map, ex)
    callee, alias_name = _dsl_resolve_alias(alias_map, ex.args[1])

    input_symbols = Symbol[]
    keyword_pairs = Pair{Symbol, Any}[]

    for arg in ex.args[2:end]
        if arg isa Expr && arg.head == :parameters
            for kw in arg.args
                kw isa Expr && kw.head == :kw || error("Invalid keyword argument `$kw` in DSL function call.")
                name = kw.args[1]
                name isa Symbol || error("Function keyword names must be symbols. Got `$name`.")
                value = kw.args[2]
                push!(keyword_pairs, name => value)
            end
        else
            arg isa Symbol || error("Plain function positional arguments in the DSL must be routed symbols. Got `$arg`.")
            push!(input_symbols, arg)
        end
    end

    return (
        kind = :function_call,
        spec_expr = callee,
        alias_name,
        inputs = (),
        input_symbols = tuple(input_symbols...),
        keyword_pairs = tuple(keyword_pairs...),
    )
end

function _dsl_split_route_kwargs(kwargs)
    inputs = Pair{Symbol, Symbol}[]
    for kw in kwargs
        kw isa Expr && kw.head == :kw || error("Only keyword-based routes are supported for ProcessAlgorithms in the DSL.")
        destination = kw.args[1]
        source = kw.args[2]
        destination isa Symbol || error("Route targets must be symbols. Got `$destination`.")
        source isa Symbol || error("Route sources must reference previously named outputs, got `$source`.")
        push!(inputs, source => destination)
    end
    return tuple(inputs...)
end

function _dsl_parse_invocation(alias_map, ex)
    if ex isa Expr && ex.head == :macrocall && ex.args[1] == Symbol("@repeat") && length(ex.args) == 4
        repeats_expr = ex.args[3]
        block = ex.args[4]
        if block isa Expr && block.head == :block
            return (
                kind = :resolved_expr,
                resolved_expr = _dsl_expand_repeated_block(block, repeats_expr),
                alias_name = Symbol(),
                inputs = (),
                input_symbols = (),
                keyword_pairs = (),
                schedule_kind = :default,
                schedule_value = :(1),
            )
        end
    end

    schedule_kind, schedule_value, inner = _dsl_parse_schedule(ex)

    parsed = if inner isa Symbol
        spec_expr, alias_name = _dsl_resolve_constructor_expr(alias_map, inner)
        (
            kind = :entity,
            spec_expr,
            alias_name,
            inputs = (),
            input_symbols = (),
            keyword_pairs = (),
        )
    elseif inner isa Expr && inner.head == :call
        callee = inner.args[1]
        args = inner.args[2:end]

        if callee isa Expr && callee.head == :call
            spec_expr, alias_name = _dsl_resolve_constructor_expr(alias_map, callee)
            inputs = _dsl_split_route_kwargs(args)
            (
                kind = :entity,
                spec_expr,
                alias_name,
                inputs,
                input_symbols = (),
                keyword_pairs = (),
            )
        elseif isempty(args)
            spec_expr, alias_name = _dsl_resolve_constructor_expr(alias_map, inner)
            (
                kind = :entity,
                spec_expr,
                alias_name,
                inputs = (),
                input_symbols = (),
                keyword_pairs = (),
            )
        else
            has_parameters = any(arg -> arg isa Expr && arg.head == :parameters, args)
            has_positional = any(arg -> !(arg isa Expr && arg.head == :kw), args)
            if has_parameters || has_positional
                _dsl_parse_function_call(alias_map, inner)
            else
                spec_expr, alias_name = _dsl_resolve_alias(alias_map, callee)
                inputs = _dsl_split_route_kwargs(args)
                (
                    kind = :entity,
                    spec_expr,
                    alias_name,
                    inputs,
                    input_symbols = (),
                    keyword_pairs = (),
                )
            end
        end
    else
        spec_expr, alias_name = _dsl_resolve_constructor_expr(alias_map, inner)
        (
            kind = :entity,
            spec_expr,
            alias_name,
            inputs = (),
            input_symbols = (),
            keyword_pairs = (),
        )
    end

    return (; parsed..., schedule_kind, schedule_value)
end

function _dsl_customname(ex, alias_name::Symbol)
    alias_name != Symbol() && return alias_name
    if ex isa Symbol
        return ex
    elseif ex isa Expr && ex.head == :call
        return _dsl_customname(ex.args[1], Symbol())
    elseif ex isa Expr && ex.head == :. && ex.args[end] isa QuoteNode
        return ex.args[end].value
    end
    return Symbol()
end

function _dsl_schedule_expr(schedule_kind::Symbol, schedule_value, expected_schedule::Symbol, owner_name::Symbol)
    if schedule_kind == :default
        return :(1)
    elseif expected_schedule == :none
        got = schedule_kind == :every ? "@interval" : "@repeat"
        error("Use plain entries inside `@$(owner_name) ... begin ... end`, not `$got`.")
    elseif schedule_kind == expected_schedule
        return esc(schedule_value)
    else
        expected = expected_schedule == :every ? "@interval" : "@repeat"
        got = schedule_kind == :every ? "@interval" : "@repeat"
        error("Use `$expected` inside `@$owner_name`, not `$got`.")
    end
end

function _dsl_algorithm_entry_expr(alias_name::Symbol)
    alias_name == Symbol() ? :(_dsl_resolved.entity) : :($(QuoteNode(alias_name)) => _dsl_resolved.entity)
end

"""Build one executable DSL statement inside a composite or routine block."""
function _dsl_build_statement(stmt, alias_map, expected_schedule::Symbol, owner_name::Symbol)
    if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
        return nothing
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias")
        return nothing
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@finally")
        error("@finally is not implemented yet.")
    end

    outputs = ()
    rhs = stmt
    if stmt isa Expr && stmt.head == :(=)
        outputs = _dsl_parse_output_symbols(stmt.args[1])
        rhs = stmt.args[2]
    end

    parsed = _dsl_parse_invocation(alias_map, rhs)
    outputs_expr = Expr(:tuple, [QuoteNode(sym) for sym in outputs]...)
    schedule_expr = _dsl_schedule_expr(parsed.schedule_kind, parsed.schedule_value, expected_schedule, owner_name)

    if parsed.kind == :entity
        customname = _dsl_customname(parsed.spec_expr, parsed.alias_name)
        algo_entry_expr = _dsl_algorithm_entry_expr(parsed.alias_name)
        inputs_expr = Expr(:tuple, [:( $(QuoteNode(src)) => $(QuoteNode(dst)) ) for (src, dst) in parsed.inputs]...)
        return quote
            local _dsl_outputs = $outputs_expr
            local _dsl_resolved = Processes._resolve_composite_dsl_entity($(esc(parsed.spec_expr)), $inputs_expr, _dsl_outputs, Val{$(QuoteNode(customname))}())
            if _dsl_resolved isa Processes._CompositeDSLResolved{:state}
                push!(_dsl_states, _dsl_resolved.entity)
                Processes._composite_dsl_register_outputs!(_dsl_producers, _dsl_resolved.entity, _dsl_outputs)
            else
                push!(_dsl_algos, $algo_entry_expr)
                push!(_dsl_specification, Int($schedule_expr))
                Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_resolved.entity, _dsl_resolved.inputs)
                Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_resolved.entity, _dsl_outputs)
            end
        end
    end

    if parsed.kind == :resolved_expr
        algo_entry_expr = _dsl_algorithm_entry_expr(parsed.alias_name)
        return quote
            local _dsl_outputs = $outputs_expr
            local _dsl_resolved = $(parsed.resolved_expr)
            push!(_dsl_algos, $algo_entry_expr)
            push!(_dsl_specification, Int($schedule_expr))
            Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_resolved.entity, _dsl_resolved.inputs)
            Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_resolved.entity, _dsl_outputs)
        end
    end

    input_symbols_expr = Expr(:tuple, [QuoteNode(sym) for sym in parsed.input_symbols]...)
    keyword_args_expr = Expr(:tuple, Expr(:parameters, [
        Expr(:kw, name, esc(value)) for (name, value) in parsed.keyword_pairs
    ]...))
    customname = _dsl_customname(parsed.spec_expr, parsed.alias_name)
    algo_entry_expr = _dsl_algorithm_entry_expr(parsed.alias_name)

    return quote
        local _dsl_outputs = $outputs_expr
        local _dsl_resolved = Processes._resolve_composite_dsl_function(
            $(esc(parsed.spec_expr)),
            $keyword_args_expr,
            $input_symbols_expr,
            _dsl_outputs,
            Val{$(QuoteNode(customname))}(),
        )
        push!(_dsl_algos, $algo_entry_expr)
        push!(_dsl_specification, Int($schedule_expr))
        Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_resolved.entity, _dsl_resolved.inputs)
        Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_resolved.entity, _dsl_outputs)
    end
end

"""Create an `InlineState` value directly."""
macro state(args...)
    fields = _dsl_collect_state_fields(args)
    return _dsl_expand_state_expr(fields)
end

"""Expand a top-level DSL block into either a `CompositeAlgorithm` or a `Routine`."""
function _dsl_expand_loopalgorithm(block, constructor_name::Symbol, expected_schedule::Symbol)
    statements = block isa Expr && block.head == :block ? [stmt for stmt in block.args if !(stmt isa LineNumberNode)] : [block]
    alias_map = Dict{Symbol, Any}()
    step_exprs = Expr[]
    state_fields = Any[]
    state_name = :_state

    for stmt in statements
        if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
            state_name = _dsl_merge_state_statement!(state_fields, state_name, stmt)
            continue
        elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias")
            alias = _dsl_parse_alias(stmt)
            alias_map[alias.first] = alias.second
            continue
        end

        step_expr = _dsl_build_statement(stmt, alias_map, expected_schedule, constructor_name)
        isnothing(step_expr) || push!(step_exprs, step_expr)
    end

    state_setup_expr = _dsl_state_setup_expr(state_fields, state_name)

    return quote
        let
            local _dsl_algos = Any[]
            local _dsl_states = Any[]
            local _dsl_options = Any[]
            local _dsl_specification = Int[]
            local _dsl_producers = Dict{Symbol, Any}()
            local _dsl_external_inputs = Pair{Symbol, Symbol}[]

            $(isnothing(state_setup_expr) ? nothing : state_setup_expr)
            $(step_exprs...)

            isempty(_dsl_algos) && error("`@$constructor_name` requires at least one algorithm entry.")
            getproperty(Processes, $(QuoteNode(constructor_name)))(_dsl_algos..., Tuple(_dsl_specification), _dsl_states..., _dsl_options...)
        end
    end
end

"""Expand the body used inside `@repeat n begin ... end` into a `SimpleAlgo`."""
function _dsl_expand_simplealgorithm_resolved(block)
    statements = block isa Expr && block.head == :block ? [stmt for stmt in block.args if !(stmt isa LineNumberNode)] : [block]
    alias_map = Dict{Symbol, Any}()
    step_exprs = Expr[]
    state_fields = Any[]
    state_name = :_state

    for stmt in statements
        if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
            state_name = _dsl_merge_state_statement!(state_fields, state_name, stmt)
            continue
        elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias")
            alias = _dsl_parse_alias(stmt)
            alias_map[alias.first] = alias.second
            continue
        end

        step_expr = _dsl_build_statement(stmt, alias_map, :none, :repeat)
        isnothing(step_expr) || push!(step_exprs, step_expr)
    end

    state_setup_expr = _dsl_state_setup_expr(state_fields, state_name)

    return quote
        let
            local _dsl_algos = Any[]
            local _dsl_states = Any[]
            local _dsl_options = Any[]
            local _dsl_specification = Int[]
            local _dsl_producers = Dict{Symbol, Any}()
            local _dsl_external_inputs = Pair{Symbol, Symbol}[]

            $(isnothing(state_setup_expr) ? nothing : state_setup_expr)
            $(step_exprs...)

            isempty(_dsl_algos) && error("`@repeat n begin ... end` requires at least one algorithm entry.")
            local _dsl_algo = Processes.SimpleAlgo(_dsl_algos..., _dsl_states..., _dsl_options...)
            local _dsl_inputs = Tuple(_dsl_external_inputs)
            Processes._CompositeDSLResolved{:algo, typeof(_dsl_algo), typeof(_dsl_inputs)}(_dsl_algo, _dsl_inputs)
        end
    end
end

"""Wrap a repeated DSL block in a `Routine`, then expose it as one routable entity."""
function _dsl_expand_repeated_block(block, repeats_expr)
    inner_expr = _dsl_expand_simplealgorithm_resolved(block)
    return quote
        let
            local _dsl_inner = $inner_expr
            local _dsl_repeats = Int($(esc(repeats_expr)))
            local _dsl_algo = Processes.Unique(Processes.Routine(_dsl_inner.entity, (_dsl_repeats,)))
            local _dsl_inputs = _dsl_inner.inputs
            Processes._CompositeDSLResolved{:algo, typeof(_dsl_algo), typeof(_dsl_inputs)}(_dsl_algo, _dsl_inputs)
        end
    end
end

"""Build a `CompositeAlgorithm` from a declarative DSL block."""
macro CompositeAlgorithm(block)
    _dsl_expand_loopalgorithm(block, :CompositeAlgorithm, :every)
end

"""Build a `Routine` from a declarative DSL block."""
macro Routine(block)
    _dsl_expand_loopalgorithm(block, :Routine, :repeat)
end
