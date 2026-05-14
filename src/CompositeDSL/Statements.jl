"""Pick the most readable custom name for a DSL statement when no explicit alias is given."""
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

"""Validate schedule usage and turn it into the constructor specification entry."""
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

"""Emit either `algo` or `:alias => algo` for the target constructor call."""
function _dsl_algorithm_entry_expr(alias_name::Symbol)
    return :(Processes._composite_dsl_entry(_dsl_resolved.entity, $(QuoteNode(alias_name))))
end

"""Wrap an algorithm constructor entry in a parser option when conditionally included."""
function _dsl_maybe_conditional_entry_expr(entry_expr, include_condition)
    isnothing(include_condition) && return entry_expr
    return :(Processes.IfWrapped($entry_expr, $include_condition))
end

"""Guard constructor-side metadata for conditionally included entries."""
function _dsl_maybe_guard_metadata_expr(expr, include_condition)
    isnothing(include_condition) && return expr
    return quote
        if $include_condition
            $expr
        end
    end
end

"""
Emit the share/route owner expression matching the eventual constructor entry.

When the DSL already knows a stable alias/key, use that keyed wrapper directly so
later composition/renaming can update the reference without relying on raw-value
matching. Otherwise fall back to the raw entity and let constructor-time naming
resolve it later.
"""
function _dsl_share_endpoint_expr(alias_name::Symbol)
    _dsl_known_owner_expr(:(_dsl_resolved.entity), alias_name)
end

"""Return whether a RHS expression should stay on the normal invocation parser."""
function _dsl_is_invocation_like_rhs(alias_map, known_outputs::Set{Symbol}, rhs)
    rhs isa QuoteNode && return false
    rhs isa Symbol && return haskey(alias_map, rhs) || rhs in known_outputs
    rhs isa Expr || return false
    rhs.head == :call && return true
    rhs.head == :macrocall && return true
    return false
end

"""Parse `state_field = captured_value` into a small `ContextWrite` algorithm."""
function _dsl_parse_context_write_assignment(alias_map, context_map, outputs::Tuple, rhs, known_outputs::Set{Symbol}, state_outputs::Set{Symbol})
    length(outputs) == 1 || return nothing
    output = only(outputs)
    output in state_outputs || return nothing

    schedule_kind, schedule_value, inner = _dsl_parse_schedule(rhs)
    _dsl_is_invocation_like_rhs(alias_map, known_outputs, inner) && return nothing

    value_spec, value_input = _dsl_parse_function_positional_arg(alias_map, context_map, inner, known_outputs, 1)
    inputs = isnothing(value_input) ? () : (_dsl_context_write_value_input(value_input),)
    spec_expr = if isnothing(value_input)
        :(Processes.ContextWrite($(QuoteNode(output)), $(_dsl_context_write_value_expr(value_spec))))
    else
        :(Processes.ContextWrite($(QuoteNode(output))))
    end
    return (
        kind = :entity,
        spec_expr,
        alias_name = Symbol(),
        positional_specs = (),
        routed_positional_inputs = (),
        inputs,
        shares = (),
        keyword_specs = (),
        schedule_kind,
        schedule_value,
    )
end

"""Lower `buffer[idx...] = value` to a normal `setindex!(buffer, value, idx...)` call."""
function _dsl_indexed_assignment_call(lhs, rhs)
    lhs isa Expr && lhs.head == :ref && !isempty(lhs.args) || return nothing
    return Expr(:call, :setindex!, lhs.args[1], rhs, lhs.args[2:end]...)
end

"""Lower `buffer .= value` and `buffer[idx...] .= value` to broadcast mutation calls."""
function _dsl_broadcast_assignment_call(lhs, rhs)
    if lhs isa Expr && lhs.head == :ref && !isempty(lhs.args)
        return Expr(:call, :(Processes.context_broadcast_index!), lhs.args[1], rhs, lhs.args[2:end]...)
    end
    return Expr(:call, :(Processes.context_broadcast!), lhs, rhs)
end

function _dsl_context_write_value_expr(spec)
    if spec.kind == :literal_symbol
        return QuoteNode(spec.value)
    elseif spec.kind == :captured
        return spec.value
    end
    error("ContextWrite captured values only support literal or captured positional specs. Got `$(spec.kind)`.")
end

function _dsl_context_write_value_input(input)
    if input.kind == :simple
        return (; kind = :simple, source = input.source, destination = :value)
    elseif input.kind == :context_simple
        return (; kind = :context_simple, owner = input.owner, source = input.source, destination = :value)
    elseif input.kind == :simple_transform
        return (; kind = :simple_transform, source = input.source, destination = :value, transform_expr = input.transform_expr)
    elseif input.kind == :context_transform
        return (; kind = :context_transform, owner = input.owner, source = input.source, destination = :value, transform_expr = input.transform_expr)
    end
    error("Unsupported ContextWrite value input kind `$(input.kind)`.")
end

function _dsl_parse_owned_write_target(alias_map, context_map, lhs)
    if lhs isa Expr && lhs.head == :. && length(lhs.args) == 2 && lhs.args[2] isa QuoteNode
        source = lhs.args[2].value
        source isa Symbol || return nothing
        base = lhs.args[1]
        if base isa Symbol && haskey(alias_map, base)
            return (; owner = :(Processes._composite_dsl_write_owner($(alias_map[base]), $(QuoteNode(base)))), source)
        end
    end
    return _dsl_parse_owned_route_expr(alias_map, context_map, lhs)
end

"""Build `owner.field = value` as a routed ContextWrite into `owner.field`."""
function _dsl_build_owned_write_statement(lhs, rhs, alias_map, context_map, known_outputs::Set{Symbol}, expected_schedule::Symbol, owner_name::Symbol; include_condition = nothing)
    owned_route = _dsl_parse_owned_write_target(alias_map, context_map, lhs)
    isnothing(owned_route) && return nothing

    schedule_kind, schedule_value, inner = _dsl_parse_schedule(rhs)
    schedule_expr = _dsl_schedule_expr(schedule_kind, schedule_value, expected_schedule, owner_name)

    value_spec, value_input = _dsl_parse_function_positional_arg(alias_map, context_map, inner, known_outputs, 1)
    current_input = (; kind = :context_simple, owner = owned_route.owner, source = owned_route.source, destination = owned_route.source)
    inputs = if isnothing(value_input)
        (current_input,)
    else
        (current_input, _dsl_context_write_value_input(value_input))
    end
    inputs_expr = _dsl_inputs_expr(inputs)
    spec_expr = if isnothing(value_input)
        :(Processes.ContextWrite($(QuoteNode(owned_route.source)), $(_dsl_context_write_value_expr(value_spec))))
    else
        :(Processes.ContextWrite($(QuoteNode(owned_route.source))))
    end

    return quote
        local _dsl_outputs = ()
        local _dsl_resolved = Processes._resolve_composite_dsl_entity($(esc(spec_expr)), $inputs_expr, _dsl_outputs, Val{Symbol()}())
        local _dsl_owner = _dsl_resolved.entity
        push!(_dsl_algos, _dsl_resolved.entity)
        push!(_dsl_specification, Int($schedule_expr))
        $(_dsl_maybe_guard_metadata_expr(quote
            Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_owner, _dsl_resolved.inputs)
        end, include_condition))
    end
end

"""
Build one executable DSL statement inside a composite or routine block.

Accepted top-level statements inside the block:
- `@state ...`
- `@alias ...`
- bare algorithm/state/function entries
- assignments like `x = ...` or `a, b = ...`
- scheduled entries via `@interval`, `@every`, or `@repeat`

`@finally` is root-only and handled by the surrounding block collector.
"""
function _dsl_build_statement(stmt, alias_map, context_map, known_outputs::Set{Symbol}, state_outputs::Set{Symbol}, expected_schedule::Symbol, owner_name::Symbol; include_condition = nothing)
    if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
        return nothing
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias")
        return nothing
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@context")
        return nothing
    elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@finally")
        error("@finally is root-only and must appear as a top-level DSL statement.")
    end

    outputs = ()
    rhs = stmt
    if stmt isa Expr && stmt.head == :(.=)
        rhs = _dsl_broadcast_assignment_call(stmt.args[1], stmt.args[2])
    elseif stmt isa Expr && stmt.head == :(=)
        lhs = stmt.args[1]
        rhs = stmt.args[2]
        indexed_call = _dsl_indexed_assignment_call(lhs, rhs)
        if !isnothing(indexed_call)
            rhs = indexed_call
        else
            owned_write = _dsl_build_owned_write_statement(lhs, rhs, alias_map, context_map, known_outputs, expected_schedule, owner_name; include_condition)
            !isnothing(owned_write) && return owned_write
            outputs = _dsl_parse_output_symbols(lhs)
        end
    end

    owned_route = _dsl_parse_owned_route_expr(alias_map, context_map, rhs)
    if !isnothing(owned_route)
        length(outputs) == 1 || error("Owned field references like `alias.field` can only bind to one output symbol, e.g. `state = dynamics.state`.")
        output = only(outputs)
        output == owned_route.source || error("Owned field aliasing currently requires the output name to match the field name. Use `$(owned_route.source) = ...` for `$(repr(rhs))`.")
        metadata_expr = quote
            local _dsl_output = $(QuoteNode(output))
            local _dsl_owner = $(esc(owned_route.owner))
            if haskey(_dsl_state_owners, _dsl_output)
                push!(_dsl_options, Route(_dsl_owner => _dsl_state_owners[_dsl_output], _dsl_output => _dsl_output))
                _dsl_producers[_dsl_output] = _dsl_state_owners[_dsl_output]
            else
                _dsl_producers[_dsl_output] = _dsl_owner
            end
        end
        return _dsl_maybe_guard_metadata_expr(metadata_expr, include_condition)
    end

    context_write = _dsl_parse_context_write_assignment(alias_map, context_map, outputs, rhs, known_outputs, state_outputs)
    parsed = isnothing(context_write) ? _dsl_parse_invocation(alias_map, context_map, rhs, known_outputs) : context_write
    outputs_expr = Expr(:tuple, [QuoteNode(sym) for sym in outputs]...)
    schedule_expr = _dsl_schedule_expr(parsed.schedule_kind, parsed.schedule_value, expected_schedule, owner_name)

    if parsed.kind == :entity
        customname = _dsl_customname(parsed.spec_expr, parsed.alias_name)
        algo_entry_expr = _dsl_maybe_conditional_entry_expr(_dsl_algorithm_entry_expr(parsed.alias_name), include_condition)
        share_target_expr = _dsl_share_endpoint_expr(parsed.alias_name)
        inputs_expr = _dsl_inputs_expr(parsed.inputs)
        metadata_expr = quote
            $(map(parsed.shares) do share_source
                :(push!(_dsl_options, Processes.Share($(share_source), _dsl_owner)))
            end...)
            Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_owner, _dsl_resolved.inputs)
            Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_state_owners, _dsl_owner, _dsl_outputs)
        end
        return quote
            local _dsl_outputs = $outputs_expr
            # Resolve the user-facing DSL entity into a normal algorithm/state
            # object plus the routed input metadata the builder needs.
            local _dsl_resolved = Processes._resolve_composite_dsl_entity($(esc(parsed.spec_expr)), $inputs_expr, _dsl_outputs, Val{$(QuoteNode(customname))}())
            local _dsl_owner = $share_target_expr
            if _dsl_resolved isa Processes._CompositeDSLResolved{:state}
                # Inline states are stored separately and claim ownership of
                # their outputs immediately.
                $(_dsl_maybe_guard_metadata_expr(quote
                    push!(_dsl_states, _dsl_resolved.entity)
                    Processes._composite_dsl_register_outputs!(_dsl_producers, _dsl_owner, _dsl_outputs)
                end, include_condition))
            else
                # Algorithms are appended to the constructor argument list and
                # then wired into the routing tables.
                push!(_dsl_algos, $algo_entry_expr)
                push!(_dsl_specification, Int($schedule_expr))
                $(_dsl_maybe_guard_metadata_expr(metadata_expr, include_condition))
            end
        end
    end

    if parsed.kind == :resolved_expr
        algo_entry_expr = _dsl_maybe_conditional_entry_expr(_dsl_algorithm_entry_expr(parsed.alias_name), include_condition)
        owner_expr = _dsl_share_endpoint_expr(parsed.alias_name)
        metadata_expr = quote
            Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_owner, _dsl_resolved.inputs)
            Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_state_owners, _dsl_owner, _dsl_outputs)
        end
        return quote
            local _dsl_outputs = $outputs_expr
            # Repeated inner blocks already expand to one resolved entity, so the
            # outer builder only has to wire and register them.
            local _dsl_resolved = $(parsed.resolved_expr)
            local _dsl_owner = $owner_expr
            push!(_dsl_algos, $algo_entry_expr)
            push!(_dsl_specification, Int($schedule_expr))
            $(_dsl_maybe_guard_metadata_expr(metadata_expr, include_condition))
        end
    end

    positional_values_expr = _dsl_function_positional_args_expr(parsed.positional_specs)
    positional_display_expr = _dsl_function_positional_display_expr(parsed.positional_specs)
    routed_positional_inputs_expr = _dsl_inputs_expr(parsed.routed_positional_inputs)
    keyword_args_expr = _dsl_function_keyword_args_expr(parsed.keyword_specs)
    keyword_display_expr = _dsl_function_keyword_display_expr(parsed.keyword_specs)
    inputs_expr = _dsl_inputs_expr(parsed.inputs)
    customname = _dsl_customname(parsed.spec_expr, parsed.alias_name)
    algo_entry_expr = _dsl_maybe_conditional_entry_expr(_dsl_algorithm_entry_expr(parsed.alias_name), include_condition)
    share_target_expr = _dsl_share_endpoint_expr(parsed.alias_name)

    if parsed.kind == :keyword_call
        metadata_expr = quote
            $(map(parsed.shares) do share_source
                :(push!(_dsl_options, Processes.Share($(share_source), _dsl_owner)))
            end...)
            Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_owner, _dsl_resolved.inputs)
            Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_state_owners, _dsl_owner, _dsl_outputs)
        end
        return quote
            local _dsl_outputs = $outputs_expr
            local _dsl_resolved = Processes._resolve_composite_dsl_keyword_call(
                $(esc(parsed.spec_expr)),
                $keyword_args_expr,
                $keyword_display_expr,
                $inputs_expr,
                _dsl_outputs,
                Val{$(QuoteNode(customname))}(),
            )
            local _dsl_owner = $share_target_expr
            push!(_dsl_algos, $algo_entry_expr)
            push!(_dsl_specification, Int($schedule_expr))
            $(_dsl_maybe_guard_metadata_expr(metadata_expr, include_condition))
        end
    end

    metadata_expr = quote
        Processes._composite_dsl_add_routes!(_dsl_options, _dsl_producers, _dsl_external_inputs, _dsl_owner, _dsl_resolved.inputs)
        Processes._composite_dsl_bind_outputs!(_dsl_options, _dsl_producers, _dsl_state_owners, _dsl_owner, _dsl_outputs)
    end
    return quote
        local _dsl_outputs = $outputs_expr
        # Function-call syntax stays on a dedicated path so we can recover
        # positional inputs and keyword captures for `FuncWrapper`.
        local _dsl_resolved = Processes._resolve_composite_dsl_call(
            $(esc(parsed.spec_expr)),
            $keyword_args_expr,
            $positional_values_expr,
            $positional_display_expr,
            $keyword_display_expr,
            _dsl_outputs,
            $routed_positional_inputs_expr,
            $inputs_expr,
            Val{$(QuoteNode(customname))}(),
        )
        local _dsl_owner = $share_target_expr
        push!(_dsl_algos, $algo_entry_expr)
        push!(_dsl_specification, Int($schedule_expr))
        $(_dsl_maybe_guard_metadata_expr(metadata_expr, include_condition))
    end
end

"""Build a constructor-time conditional include block."""
function _dsl_build_include_if_statement(stmt, alias_map, context_map, known_outputs::Set{Symbol}, state_outputs::Set{Symbol}, expected_schedule::Symbol, owner_name::Symbol)
    condition_expr, include_body = _dsl_parse_include_if(stmt)
    statements = include_body isa Expr && include_body.head == :block ? include_body.args : Any[include_body]

    branch_alias_map = copy(alias_map)
    branch_context_map = copy(context_map)
    branch_known_outputs = copy(known_outputs)
    branch_state_outputs = copy(state_outputs)
    branch_exprs = Any[]
    current_line = nothing
    condition_sym = gensym(:include_if)

    for branch_stmt in statements
        if branch_stmt isa LineNumberNode
            current_line = branch_stmt
            continue
        end

        _dsl_reject_include_if_declarations(branch_stmt)

        if branch_stmt isa Expr && branch_stmt.head == :macrocall && branch_stmt.args[1] == Symbol("@context")
            context = _dsl_parse_context(branch_stmt)
            branch_alias_map[context.first] = context.second
            branch_context_map[context.first] = context.second
            step_expr = _dsl_build_statement(
                branch_stmt.args[3].args[2],
                branch_alias_map,
                branch_context_map,
                branch_known_outputs,
                branch_state_outputs,
                expected_schedule,
                owner_name;
                include_condition = condition_sym,
            )
            if !isnothing(step_expr)
                step_expr = Base.remove_linenums!(step_expr)
                isnothing(current_line) || push!(branch_exprs, current_line)
                push!(branch_exprs, step_expr)
            end
            continue
        elseif branch_stmt isa Expr && branch_stmt.head == :macrocall && branch_stmt.args[1] == Symbol("@include_if")
            error("Nested `@include_if` blocks are not supported.")
        else
            step_expr = _dsl_build_statement(
                branch_stmt,
                branch_alias_map,
                branch_context_map,
                branch_known_outputs,
                branch_state_outputs,
                expected_schedule,
                owner_name;
                include_condition = condition_sym,
            )
        end

        if !isnothing(step_expr)
            step_expr = Base.remove_linenums!(step_expr)
            isnothing(current_line) || push!(branch_exprs, current_line)
            push!(branch_exprs, step_expr)
        end
        _dsl_known_outputs!(branch_known_outputs, branch_stmt)
    end

    return quote
        local $condition_sym = Bool($(esc(condition_expr)))
        $(branch_exprs...)
    end
end

"""
Walk a DSL block once and collect the state declarations plus executable statements.

This is shared by the top-level `@CompositeAlgorithm`/`@Routine` expansion and the
inner `@repeat n begin ... end` block expansion so they stay in sync.
"""
function _dsl_collect_block(statements, expected_schedule::Symbol, owner_name::Symbol; allow_final::Bool = false)
    alias_map = Dict{Symbol, Any}()
    context_map = Dict{Symbol, Any}()
    known_outputs = Set{Symbol}()
    step_exprs = Any[]
    state_fields = Any[]
    state_outputs = Set{Symbol}()
    state_name = :_state
    final_expr = nothing
    current_line = nothing

    for stmt in statements
        if stmt isa LineNumberNode
            current_line = stmt
            continue
        end

        if stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@state")
            # States are collected first and emitted once for the whole block.
            state_name = _dsl_merge_state_statement!(state_fields, state_name, stmt)
            _, fields = _dsl_parse_state_statement(stmt)
            union!(state_outputs, getproperty.(fields, :name))
            _dsl_known_outputs!(known_outputs, stmt)
            continue
        elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@alias")
            # Aliases only affect later statements, so store them and keep moving.
            alias = _dsl_parse_alias(stmt)
            alias_map[alias.first] = alias.second
            continue
        elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@finally")
            allow_final || error("@finally is only supported at the outer @CompositeAlgorithm or @Routine level.")
            isnothing(final_expr) || error("Only one @finally statement is supported per DSL block.")
            final_expr = _dsl_parse_finally(stmt)
            continue
        elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@context")
            context = _dsl_parse_context(stmt)
            alias_map[context.first] = context.second
            context_map[context.first] = context.second
            step_expr = _dsl_build_statement(stmt.args[3].args[2], alias_map, context_map, known_outputs, state_outputs, expected_schedule, owner_name)
            if !isnothing(step_expr)
                step_expr = Base.remove_linenums!(step_expr)
                isnothing(current_line) || push!(step_exprs, current_line)
                push!(step_exprs, step_expr)
            end
            continue
        elseif stmt isa Expr && stmt.head == :macrocall && stmt.args[1] == Symbol("@include_if")
            step_expr = _dsl_build_include_if_statement(stmt, alias_map, context_map, known_outputs, state_outputs, expected_schedule, owner_name)
            if !isnothing(step_expr)
                step_expr = Base.remove_linenums!(step_expr)
                isnothing(current_line) || push!(step_exprs, current_line)
                push!(step_exprs, step_expr)
            end
            _dsl_known_outputs!(known_outputs, stmt)
            continue
        end

        step_expr = _dsl_build_statement(stmt, alias_map, context_map, known_outputs, state_outputs, expected_schedule, owner_name)
        if !isnothing(step_expr)
            step_expr = Base.remove_linenums!(step_expr)
            isnothing(current_line) || push!(step_exprs, current_line)
            push!(step_exprs, step_expr)
        end
        # Outputs become available to the statements that follow them.
        _dsl_known_outputs!(known_outputs, stmt)
    end

    return (; step_exprs, state_fields, state_name, final_expr)
end
