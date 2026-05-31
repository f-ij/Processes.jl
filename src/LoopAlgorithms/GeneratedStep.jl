"""
Compile-time state used while expanding a generated loop step expression.

The generated loop keeps every root subcontext as a local variable. Concrete
child steps build an `OnDemandContext` from those variables, while nested plans
reuse the same local variables and only add composite/routine control flow.
"""
struct GeneratedStepState{TopNames, GlobalsSym, InputsSym, ProcessSym, LifetimeSym}
end

GeneratedStepState(
    top_names::TopNames,
    globals_sym::GlobalsSym,
    inputs_sym::InputsSym,
    process_sym::ProcessSym,
    lifetime_sym::LifetimeSym,
) where {TopNames<:Tuple, GlobalsSym<:Symbol, InputsSym<:Symbol, ProcessSym<:Symbol, LifetimeSym<:Symbol} =
    GeneratedStepState{top_names, globals_sym, inputs_sym, process_sym, lifetime_sym}()

"""Return the top-level subcontext names available to generated child blocks."""
_generated_step_top_names(::GeneratedStepState{TopNames}) where {TopNames} = TopNames

"""Return the symbol bound to the current runtime globals in generated code."""
_generated_step_globals_sym(::GeneratedStepState{TopNames, GlobalsSym}) where {TopNames, GlobalsSym} = GlobalsSym

"""Return the symbol bound to the current runtime inputs in generated code."""
_generated_step_inputs_sym(::GeneratedStepState{TopNames, GlobalsSym, InputsSym}) where {TopNames, GlobalsSym, InputsSym} = InputsSym

"""Return the symbol bound to the current process in generated code."""
_generated_step_process_sym(::GeneratedStepState{TopNames, GlobalsSym, InputsSym, ProcessSym}) where {TopNames, GlobalsSym, InputsSym, ProcessSym} = ProcessSym

"""Return the symbol bound to the current process lifetime in generated code."""
_generated_step_lifetime_sym(::GeneratedStepState{TopNames, GlobalsSym, InputsSym, ProcessSym, LifetimeSym}) where {TopNames, GlobalsSym, InputsSym, ProcessSym, LifetimeSym} = LifetimeSym

"""Return a named-tuple expression from live generated subcontext variables."""
function _generated_step_subcontexts_expr(names::Tuple)
    return Expr(:tuple, Expr(:parameters, (Expr(:(=), name, name) for name in names)...))
end

"""Return assignments that refresh only subcontexts present in a child return."""
function _generated_step_return_assignments(names::Tuple, returned_sym)
    return Any[
        quote
            if @inline hasproperty($returned_sym, $(QuoteNode(name)))
                $name = @inline merge($name, getproperty($returned_sym, $(QuoteNode(name))))
            end
        end
        for name in names
    ]
end

"""Return an expression that reconstructs a tuple of resolved route/share values."""
function _generated_step_wiring_tuple_expr(tuple_type::Type{<:Tuple})
    return Expr(:tuple, (:($T()) for T in tuple_type.parameters)...)
end

"""Return an expression that reconstructs a resolved child `Wiring` from type data."""
function _generated_step_wiring_value_expr(wiring_type::Type{<:Wiring})
    routes_type = wiring_type.parameters[1]
    shares_type = wiring_type.parameters[2]
    return :(Wiring($(_generated_step_wiring_tuple_expr(routes_type)), $(_generated_step_wiring_tuple_expr(shares_type))))
end

"""Return the tuple type that carries one plan node's child wirings."""
_generated_step_child_wiring_tuple_type(::Type{<:CompositeAlgorithm{T, Intervals, Namespaces, W}}) where {T, Intervals, Namespaces, W} =
    W.parameters[2]
_generated_step_child_wiring_tuple_type(::Type{<:Routine{T, Repeats, Namespaces, MV, W}}) where {T, Repeats, Namespaces, MV, W} =
    W.parameters[2]

"""Return the concrete child wiring type stored at `idx` for a plan type."""
function _generated_step_child_wiring_type(plan_type::Type, idx::Int)
    return fieldtype(_generated_step_child_wiring_tuple_type(plan_type), idx)
end

"""Return the concrete child namespace type stored at `idx` for a plan type."""
function _generated_step_child_namespace_type(plan_type::Type, idx::Int)
    namespace_tuple_type = plan_type.parameters[3]
    return fieldtype(namespace_tuple_type, idx)
end

"""Build one generated child expression using the child-specific wiring when needed."""
function _generated_step_child_expr(child_type::Type, context::Type{C}, child_name::Symbol, child_wiring_type::Type, child_namespace_type::Type, state::GeneratedStepState) where {C<:AbstractContext}
    if child_type <: AbstractLoopAlgorithm
        return step!_expr(child_type, C, child_name, nothing, nothing, state)
    end
    child_wiring_expr = _generated_step_wiring_value_expr(child_wiring_type)
    child_namespace_expr = :($child_namespace_type())
    child_available_names = get_available_subcontext_names(child_wiring_type(), child_namespace_type())
    if child_type <: Union{FuncWrapper, ProcessAlgorithm}
        return _generated_process_algorithm_step_expr(child_type, C, child_name, child_wiring_expr, child_namespace_expr, state, child_available_names)
    end
    return step!_expr(child_type, C, child_name, child_wiring_expr, child_namespace_expr, state)
end

"""
Generated expression form for a resolved `LoopAlgorithm`.

The root wrapper owns process-level state, but child execution should step the
resolved plan itself. This keeps the owned root step out of nested boundaries.
"""
function step!_expr(::Type{LA}, context::Type{C}, name::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {Plan, LA<:LoopAlgorithm{Plan}, C<:AbstractContext}
    plan_name = gensym(:plan)
    return quote
        local $plan_name = @inline getplan($name)
        $(step!_expr(Plan, C, plan_name, wiring_expr, namespace_expr, state))
    end
end

"""
Generated expression form for a finalized root loop algorithm.

Finalization is only a result projection after cleanup, so stepping delegates to
the wrapped loop algorithm.
"""
function step!_expr(::Type{FA}, context::Type{C}, name::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {LA, FA<:FinalizedAlgorithm{LA}, C<:AbstractContext}
    inner_name = gensym(:inner)
    return quote
        local $inner_name = @inline inneralgorithm($name)
        $(step!_expr(LA, C, inner_name, wiring_expr, namespace_expr, state))
    end
end

"""Generated expression form of a composite plan step."""
function step!_expr(ca::Type{CA}, context::Type{C}, name::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {CA<:CompositeAlgorithm, C<:AbstractContext}
    exprs = Any[]
    algo_count = numalgos(ca)
    funcs = tuple(algotypes(ca)...)
    inc_sym = gensym(:this_inc)
    sizehint!(exprs, algo_count + 2)

    # Read the composite cursor once so every child in this generated block
    # makes its interval decision from the same parent step.
    push!(exprs, :(local $inc_sym = @inline inc($name)))
    for i in 1:algo_count
        child_type = funcs[i]
        child_wiring_type = _generated_step_child_wiring_type(ca, i)
        child_namespace_type = _generated_step_child_namespace_type(ca, i)
        child_name = gensym(:algo)
        interval_sym = gensym(:interval)
        child_expr = _generated_step_child_expr(child_type, C, child_name, child_wiring_type, child_namespace_type, state)
        push!(exprs, quote
            local $interval_sym = @inline interval($name, $i)
            if @inline divides($inc_sym, $interval_sym)
                local $child_name = @inline getalgo($name, $i)
                $child_expr
            end
        end)
    end
    push!(exprs, :(@inline inc!($name)))
    return Expr(:block, exprs...)
end

"""Generated expression form of a routine plan step."""
function step!_expr(routine::Type{R}, context::Type{C}, name::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {R<:Routine, C<:AbstractContext}
    exprs = Any[]
    algo_count = numalgos(routine)
    funcs = tuple(algotypes(routine)...)
    lifetime_values = lifetimes(routine)
    process_sym = _generated_step_process_sym(state)
    lifetime_sym = _generated_step_lifetime_sym(state)
    sizehint!(exprs, algo_count)

    for i in 1:algo_count
        child_type = funcs[i]
        child_wiring_type = _generated_step_child_wiring_type(routine, i)
        child_namespace_type = _generated_step_child_namespace_type(routine, i)
        lifetime_value = lifetime_values[i]
        child_name = gensym(:algo)
        child_idx = gensym(:child_idx)
        child_lifetime = gensym(:child_lifetime)
        repeat_count = gensym(:repeat_count)
        resume_point = gensym(:resume_point)
        lidx = gensym(:lidx)
        child_expr = _generated_step_child_expr(child_type, C, child_name, child_wiring_type, child_namespace_type, state)
        push!(exprs, quote
            local $child_idx = $i
            local $child_name = @inline getalgo($name, $child_idx)
            local $child_lifetime = $lifetime_value
            local $repeat_count = @inline routine_repeat_count($child_lifetime)
            local $resume_point = @inline get_resume_point($name, $child_idx)
            if $resume_point <= $repeat_count
                for $lidx in $resume_point:$repeat_count
                    if @inline routine_breakcondition($child_lifetime, $lifetime_sym, $process_sym, nothing, $lidx)
                        if !(@inline _routine_local_breakcondition($child_lifetime, $process_sym, nothing, $lidx))
                            @inline set_resume_point!($name, $child_idx, $lidx)
                        end
                        break
                    end
                    $child_expr
                    @inline tick!($process_sym)
                end
            end
            @inline set_resume_point!($name, $child_idx, 1)
        end)
    end
    return Expr(:block, exprs...)
end

"""Build the generated leaf body shared by process-algorithm expression methods."""
function _generated_process_algorithm_step_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState, available_names::Tuple = _generated_step_top_names(state)) where {T, C<:AbstractContext}
    globals_sym = _generated_step_globals_sym(state)
    inputs_sym = _generated_step_inputs_sym(state)
    available_subcontexts = gensym(:available_subcontexts)
    available_variables = gensym(:available_variables)
    available_locations = gensym(:available_locations)
    on_demand_context = gensym(:on_demand_context)
    retval = gensym(:retval)
    returned = gensym(:returned)
    subcontexts_expr = _generated_step_subcontexts_expr(available_names)
    assignments = _generated_step_return_assignments(available_names, returned)

    isnothing(wiring_expr) && error("Concrete generated child step requires resolved child wiring.")
    isnothing(namespace_expr) && error("Concrete generated child step requires a resolved child namespace.")

    return quote
        local $available_subcontexts = $subcontexts_expr
        local $available_locations = @inline on_demand_locations($available_subcontexts, $wiring_expr, $funcname, $namespace_expr)
        local $available_variables = @inline on_demand_variables($available_subcontexts, $available_locations, $inputs_sym, $globals_sym)
        local $on_demand_context = @inline OnDemandContext($available_variables, $available_locations, $wiring_expr, $inputs_sym, $globals_sym, $funcname, $namespace_expr)
        local $retval = @inline step!($funcname, $on_demand_context)
        local $returned = @inline merge_by_wiring($on_demand_context, $retval)
        $globals_sym = @inline getproperty($returned, :globals)
        $(assignments...)
    end
end

"""
Generated expression form for raw `FuncWrapper` children.

Function-call DSL statements remain executable children, but identifiable
wrappers should have been stripped from resolved execution plans before this
point.
"""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {T<:FuncWrapper, C<:AbstractContext}
    return _generated_process_algorithm_step_expr(T, C, funcname, wiring_expr, namespace_expr, state)
end

"""Reject identifiable wrappers that leaked into a generated execution plan."""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {T<:AbstractIdentifiableAlgo, C<:AbstractContext}
    error("Resolved generated execution plans should contain raw algorithms, not identifiable wrappers. Got $(T).")
end

"""
Generated expression form for concrete `ProcessAlgorithm` children.

The child sees the public `step!(algo, context)` extension point. The context is
an `OnDemandContext` over the root subcontext variables currently live in the
generated loop; the resolved wiring decides which fields are actually exposed
and where returned fields are merged.
"""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {T<:ProcessAlgorithm, C<:AbstractContext}
    return _generated_process_algorithm_step_expr(T, C, funcname, wiring_expr, namespace_expr, state)
end

"""Reject generated leaf expansion for child types outside the process API."""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiring_expr, namespace_expr, state::GeneratedStepState) where {T, C<:AbstractContext}
    error("Generated step expression for concrete children requires a ProcessAlgorithm. Got $(T).")
end
