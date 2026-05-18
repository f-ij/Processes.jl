"""Track which output symbols are available to later route expressions in the same DSL block."""
function _dsl_known_outputs!(known_outputs::Set{Symbol}, stmt)
    if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
        _, fields = _dsl_parse_state_statement(stmt)
        union!(known_outputs, getproperty.(fields, :name))
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@input")
        push!(known_outputs, _dsl_parse_input_statement(stmt).name)
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@include_if")
        _, include_body = _dsl_parse_include_if(stmt)
        _dsl_known_outputs_include_body!(known_outputs, include_body)
    elseif stmt isa Expr && stmt.head == :(=)
        outputs = _dsl_try_parse_output_symbols(stmt.args[1])
        isnothing(outputs) || union!(known_outputs, outputs)
    end
    return known_outputs
end

"""Track outputs from an `@include_if` body for later route parsing."""
function _dsl_known_outputs_include_body!(known_outputs::Set{Symbol}, include_body)
    statements = include_body isa Expr && include_body.head == :block ? include_body.args : Any[include_body]
    for stmt in statements
        stmt isa LineNumberNode && continue
        _dsl_known_outputs!(known_outputs, stmt)
    end
    return known_outputs
end

"""Recreate parsed input specs inside the emitted DSL block."""
function _dsl_inputs_expr(input_specs)
    specs = map(input_specs) do spec
        if spec.kind == :simple
            # Keep the emitted structure plain NamedTuples so the builder-side
            # route code stays easy to inspect at runtime.
            :( (; kind = :simple, source = $(QuoteNode(spec.source)), destination = $(QuoteNode(spec.destination)) ) )
        elseif spec.kind == :context_simple
            :( (; kind = :context_simple, owner = $(esc(spec.owner)), source = $(QuoteNode(spec.source)), destination = $(QuoteNode(spec.destination)) ) )
        elseif spec.kind == :simple_transform
            :( (; kind = :simple_transform, source = $(QuoteNode(spec.source)), destination = $(QuoteNode(spec.destination)), transform = $(esc(spec.transform_expr)) ) )
        elseif spec.kind == :context_transform
            :( (; kind = :context_transform, owner = $(esc(spec.owner)), source = $(QuoteNode(spec.source)), destination = $(QuoteNode(spec.destination)), transform = $(esc(spec.transform_expr)) ) )
        else
            error("Unsupported DSL input spec kind `$(spec.kind)`.")
        end
    end
    return Expr(:tuple, specs...)
end

"""Emit keyword values for direct-call DSL syntax."""
_dsl_keyword_value_expr(value) = value isa Symbol ? QuoteNode(value) : esc(value)

"""Store a DSL-emitted plan option at the statement-local owner."""
function _composite_dsl_push_local_option!(options::Vector{Any}, owner, option)
    push!(options, LocalPlanOption(owner, option))
    return options
end

"""Turn parsed DSL input specs into statement-local `Route` options."""
function _composite_dsl_add_routes!(options::Vector{Any}, producers::Dict{Symbol, Any}, external_inputs::Vector{Pair{Symbol, Symbol}}, target, inputs::Tuple)
    for input in inputs
        if input.kind == :simple
            source = input.source
            destination = input.destination
            if haskey(producers, source)
                _composite_dsl_push_local_option!(options, target, Route(producers[source] => target, source => destination))
            else
                ext_mapping = source => source
                ext_mapping in external_inputs || push!(external_inputs, ext_mapping)
            end
        elseif input.kind == :context_simple
            _composite_dsl_push_local_option!(options, target, Route(input.owner => target, input.source => input.destination))
        elseif input.kind == :simple_transform
            source = input.source
            haskey(producers, source) || error("Transform routes currently require a previously produced symbol or an owned field reference. Missing producer for `$source`.")
            _composite_dsl_push_local_option!(options, target, Route(producers[source] => target, source => input.destination; transform = input.transform))
        elseif input.kind == :context_transform
            _composite_dsl_push_local_option!(options, target, Route(input.owner => target, input.source => input.destination; transform = input.transform))
        else
            error("Unsupported DSL input kind `$(input.kind)`.")
        end
    end
    return options
end

"""Register outputs as the current producer for later routed lookups."""
function _composite_dsl_register_outputs!(producers::Dict{Symbol, Any}, owner, outputs::Tuple{Vararg{Symbol}})
    for output in outputs
        # Later statements resolve symbols by asking this table who currently
        # owns a given output name.
        producers[output] = owner
    end
    return producers
end

"""Remember which symbols belong to an inline state for later writeback routing."""
function _composite_dsl_register_state_outputs!(state_owners::Dict{Symbol, Any}, owner, outputs::Tuple{Vararg{Symbol}})
    for output in outputs
        state_owners[output] = owner
    end
    return state_owners
end

"""
Bind the outputs produced by one DSL statement.

If the output already belongs to an inline `@state`, keep that state as the
owner and add a writeback route instead of rebinding the symbol.
"""
function _composite_dsl_bind_outputs!(options::Vector{Any}, producers::Dict{Symbol, Any}, state_owners::Dict{Symbol, Any}, target, outputs::Tuple{Vararg{Symbol}})
    for output in outputs
        if haskey(state_owners, output)
            _composite_dsl_push_local_option!(options, target, Route(state_owners[output] => target, output => output))
            producers[output] = state_owners[output]
        else
            producers[output] = target
        end
    end
    return producers
end

"""
Wrap an entity in a keyed owner when the DSL already knows its final name.

Internal rule: known alias/state keys should be preferred over raw values in
emitted route/share ownership metadata, because those keyed endpoints can later
be renamed during composition.
"""
function _composite_dsl_owner(entity, name::Symbol)
    if entity isa AbstractLoopAlgorithm
        return entity
    end
    return IdentifiableAlgo(entity, name)
end

function _composite_dsl_entry(entity, name::Symbol)
    if name == Symbol() || entity isa AbstractLoopAlgorithm
        return entity
    end
    return name => entity
end

function _dsl_known_owner_expr(entity_expr, name::Symbol)
    name == Symbol() && return entity_expr
    return :(Processes._composite_dsl_owner($entity_expr, $(QuoteNode(name))))
end

function _composite_dsl_write_owner(entity, name::Symbol)
    if entity isa AbstractLoopAlgorithm
        return getproperty(entity, :_state)
    end
    return IdentifiableAlgo(entity, name)
end

"""Build the general state expression used by both `@state` and the block DSL."""
function _dsl_expand_state_expr(fields)
    field_names = Expr(:tuple, [QuoteNode(field.name) for field in fields]...)
    required_names = Expr(:tuple, [QuoteNode(field.name) for field in fields if field.required]...)
    default_kws = [Expr(:kw, field.name, esc(field.default)) for field in fields if !field.required]
    defaults_expr = Expr(:tuple, Expr(:parameters, default_kws...))

    return quote
        # The field metadata is kept in the type, while defaults are rebuilt on
        # each init call through the stored scheme closure.
        Processes.GeneralState(() -> $defaults_expr, Val{$field_names}(), Val{$required_names}())
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

function _dsl_parse_input_entry(ex)
    default = nothing
    required = true
    lhs = ex
    if ex isa Expr && ex.head == :(=)
        lhs = ex.args[1]
        default = ex.args[2]
        required = false
    end
    name, typeexpr = if lhs isa Expr && lhs.head == :(::)
        lhs.args[1], lhs.args[2]
    else
        lhs, :Any
    end
    name isa Symbol || error("@input fields must be plain symbols or typed symbols. Got `$lhs`.")
    return (; name, typeexpr, required, default)
end

function _dsl_parse_input_statement(stmt)
    stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@input") || error("Invalid @input statement `$stmt`.")
    args = [stmt.args[i] for i in 3:length(stmt.args) if !(stmt.args[i] isa LineNumberNode)]
    length(args) == 1 || error("@input expects one declaration, got `$args`.")
    return _dsl_parse_input_entry(only(args))
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
    state_owner_expr = _dsl_known_owner_expr(:(_dsl_state), state_name)
    return quote
        local _dsl_state = $state_expr
        push!(_dsl_states, $(QuoteNode(state_name)) => _dsl_state)
        local _dsl_state_owner = $state_owner_expr
        Processes._composite_dsl_register_outputs!(_dsl_producers, _dsl_state_owner, $outputs_expr)
        Processes._composite_dsl_register_state_outputs!(_dsl_state_owners, _dsl_state_owner, $outputs_expr)
    end
end

function _dsl_runtime_input_setup_expr(input_fields)
    isempty(input_fields) && return nothing
    specs = map(input_fields) do field
        :(Processes.RuntimeInput($(QuoteNode(field.name)), $(esc(field.typeexpr)); required = $(field.required), default = $(field.required ? nothing : esc(field.default))))
    end
    outputs_expr = Expr(:tuple, [QuoteNode(field.name) for field in input_fields]...)
    return quote
        local _dsl_runtime_input_specs = ($(specs...),)
        local _dsl_input_state = Processes.RuntimeInputState(_dsl_runtime_input_specs)
        push!(_dsl_states, :_input => _dsl_input_state)
        push!(_dsl_options, Processes.RuntimeInputs(_dsl_runtime_input_specs))
        local _dsl_input_owner = Processes._composite_dsl_owner(_dsl_input_state, :_input)
        Processes._composite_dsl_register_outputs!(_dsl_producers, _dsl_input_owner, $outputs_expr)
    end
end

"""
Parse the left-hand side of a DSL assignment.

Supported output bindings:
- `x = ...`
- `a, b = ...`

Tuple bindings must contain only plain symbols.
"""
function _dsl_parse_output_symbols(lhs)
    parsed = _dsl_try_parse_output_symbols(lhs)
    !isnothing(parsed) && return parsed
    error("Unsupported left-hand side in the DSL: `$lhs`.")
end

function _dsl_try_parse_output_symbols(lhs)
    if lhs isa Symbol
        return (lhs,)
    elseif lhs isa Expr && lhs.head == :tuple
        all(x -> x isa Symbol, lhs.args) || error("Multi-output bindings must use plain symbols like `a, b = algo`.")
        return tuple(lhs.args...)
    end
    return nothing
end

"""
Parse an alias declaration.

Supported form:
- `@alias name = SomeAlgo`
- `@alias name = SomeAlgo(args...)`

The alias name must be a plain symbol. Alias resolution is plain root
substitution inside the DSL: later `name` refers to the aliased expression, and
`name(args...)` rewrites to the aliased expression called with those arguments.
Only later uses of the alias name are rewritten. Writing the raw aliased
expression directly does not preserve the alias key.
"""
function _dsl_parse_alias(stmt)
    stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias") || error("Invalid alias statement `$stmt`.")
    length(stmt.args) == 3 || error("@alias expects a single assignment like `@alias src = SourceAlgo`.")
    assign = stmt.args[3]
    assign isa Expr && assign.head == :(=) || error("@alias expects a single assignment like `@alias src = SourceAlgo`.")
    lhs = assign.args[1]
    lhs isa Symbol || error("@alias names must be symbols. Got `$lhs`.")
    return lhs => assign.args[2]
end

"""Parse a constructor-time conditional include statement."""
function _dsl_parse_include_if(stmt)
    stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@include_if") || error("Invalid @include_if statement `$stmt`.")
    length(stmt.args) == 4 || error("@include_if expects `@include_if condition entry` or `@include_if condition begin ... end`.")
    return stmt.args[3], stmt.args[4]
end

"""Parse a root-level final post-processing statement."""
function _dsl_parse_finally(stmt)
    stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@finally") || error("Invalid @finally statement `$stmt`.")
    length(stmt.args) == 3 || error("@finally expects exactly one callable, e.g. `@finally summarize`.")
    return stmt.args[3]
end

"""Reject declarations whose scope would be ambiguous inside conditional blocks."""
function _dsl_reject_include_if_declarations(stmt)
    if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
        error("@state is not supported inside `@include_if`; declare state at the surrounding DSL block level.")
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias")
        error("@alias is not supported inside `@include_if`; declare aliases before the conditional block.")
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@finally")
        error("@finally is root-only and is not supported inside `@include_if`.")
    end
    return nothing
end
