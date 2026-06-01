"""
Old generated expression path for resolved loop algorithms.

This file intentionally keeps the pre-OnDemand generated backend available
under `_old` names. It expands child step blocks in the top-level generated
loop while keeping one loop-level `context` aggregate as the merge target.
"""

"""Return the singleton value represented by a schedule field type."""
function _generated_old_schedule_value(::Type{T}) where {T}
    return Base.issingletontype(T) ? T.instance : T
end

"""Return the child schedule value stored at `idx` in a schedule tuple type."""
function _generated_old_schedule_value(::Type{T}, idx::Int) where {T<:Tuple}
    return _generated_old_schedule_value(fieldtype(T, idx))
end

"""Generated expression form for a resolved `LoopAlgorithm`."""
function step!_expr_old(::Type{LA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {Plan, LA<:LoopAlgorithm{Plan}, C<:AbstractContext}
    plan_name = gensym(:plan)
    return quote
        local $plan_name = @inline getplan($name)
        $(step!_expr_old(Plan, C, plan_name, wiringname, stability))
    end
end

"""Generated expression form for a finalized root loop algorithm."""
function step!_expr_old(::Type{FA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {LA, FA<:FinalizedAlgorithm{LA}, C<:AbstractContext}
    inner_name = gensym(:inner)
    return quote
        local $inner_name = @inline inneralgorithm($name)
        $(step!_expr_old(LA, C, inner_name, wiringname, stability))
    end
end

"""Return the view-merge stability marker used by the old generated leaf path."""
function _generated_old_stability_expr(stability::Symbol)
    return stability === :unstable ? :(Unstable()) : :(Stable())
end

"""Build one old generated child block through the legacy `_step!` view path."""
function _generated_old_context_child_expr(child_type::Type, context::Type{C}, child_name::Symbol, child_wiring_type::Type, child_namespace_type::Type, stability::Symbol) where {C<:AbstractContext}
    if child_type <: AbstractLoopAlgorithm
        return step!_expr_old(child_type, C, child_name, nothing, stability)
    end
    if child_type <: Union{FuncWrapper, ProcessAlgorithm}
        child_wiring_expr = _generated_step_wiring_value_expr(child_wiring_type)
        child_namespace_expr = :($child_namespace_type())
        return _generated_old_process_algorithm_step_expr(child_type, C, child_name, child_wiring_expr, child_namespace_expr, stability)
    end
    return step!_expr_old(child_type, C, child_name, nothing, stability)
end

"""Build the old generated leaf body through the legacy `view`/`merge` step path."""
function _generated_old_process_algorithm_step_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiring_expr, namespace_expr, stability::Symbol) where {T, C<:AbstractContext}
    stability_expr = _generated_old_stability_expr(stability)
    return quote
        context = @inline _step!($funcname, context, $wiring_expr, $namespace_expr, process, lifetime, $stability_expr)
    end
end

"""Generated expression form of the old composite step."""
function step!_expr_old(ca::Type{CA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {CA<:CompositeAlgorithm, C<:AbstractContext}
    exprs = Any[]
    algo_count = numalgos(ca)
    funcs = tuple(algotypes(ca)...)
    child_namespace_tuple_type = ca.parameters[3]
    child_wiring_type = ca.parameters[4].parameters[2]
    sizehint!(exprs, algo_count + 4)

    # Read the composite cursor once so every child sees the same interval tick.
    push!(exprs, :(local algos = @inline getalgos($name)))
    push!(exprs, :(local this_inc = @inline inc($name)))
    for i in 1:algo_count
        child_type = funcs[i]
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        local_name = gensym(:algo)
        child_expr = _generated_old_context_child_expr(child_type, C, local_name, child_step_wiring_type, child_namespace_type, stability)
        push!(exprs, quote
            local this_interval = @inline interval($name, $i)
            if @inline divides(this_inc, this_interval)
                local $local_name = @inline getfield(algos, $i)
                $child_expr
            end
        end)
    end
    push!(exprs, :(@inline inc!($name)))
    push!(exprs, :(context))
    return Expr(:block, exprs...)
end

"""Generated expression form of the old routine step."""
function step!_expr_old(routine::Type{R}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {R<:Routine, C<:AbstractContext}
    exprs = Any[]
    algo_count = numalgos(routine)
    funcs = tuple(algotypes(routine)...)
    repeat_type = routine.parameters[2]
    child_namespace_tuple_type = routine.parameters[3]
    child_wiring_type = routine.parameters[5].parameters[2]
    sizehint!(exprs, algo_count + 3)

    for i in 1:algo_count
        child_type = funcs[i]
        child_lifetime = _generated_old_schedule_value(repeat_type, i)
        child_lifetime isa Lifetime || error("Routine schedules must be `Lifetime` values after construction. Got $(typeof(child_lifetime)).")
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        local_name = gensym(:algo)
        child_expr = _generated_old_context_child_expr(child_type, C, local_name, child_step_wiring_type, child_namespace_type, stability)

        push!(exprs, quote
            local $local_name = @inline getalgo($name, $i)
            local _subroutine_lifetime = $child_lifetime
            local _routine_repeat_count = @inline routine_repeat_count(_subroutine_lifetime)
            if resume_idx($name, $i) <= _routine_repeat_count
                $child_expr
                @inline tick!(process)

                local _routine_next_idx = resume_idx($name, $i) + 1
                local _routine_resume_point = resume_idx($name, $i)
                if @inline routine_breakcondition(_subroutine_lifetime, lifetime, process, context, _routine_resume_point)
                    if !(@inline _routine_local_breakcondition(_subroutine_lifetime, process, context, _routine_resume_point))
                        set_resume_point!($name, $i, _routine_next_idx)
                    end
                    return context
                end

                for lidx in _routine_next_idx:_routine_repeat_count
                    if @inline routine_breakcondition(_subroutine_lifetime, lifetime, process, context, lidx)
                        if !(@inline _routine_local_breakcondition(_subroutine_lifetime, process, context, lidx))
                            set_resume_point!($name, $i, lidx)
                        end
                        return context
                    end
                    $child_expr
                    @inline tick!(process)
                end
            end
        end)
    end
    push!(exprs, :(context))
    return Expr(:block, exprs...)
end

"""Fallback old expression form for concrete non-plan algorithms."""
function step!_expr_old(::Type{T}, ::Type{C}, funcname::Symbol, wiringname::Symbol, stability::Symbol) where {T, C<:AbstractContext}
    error("GeneratedOld block expansion requires concrete child wiring and namespace types. Got child type $(T).")
end
