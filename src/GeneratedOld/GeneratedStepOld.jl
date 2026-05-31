"""
Old generated expression path for resolved loop algorithms.

This file intentionally keeps the pre-OnDemand generated backend available
under `_old` names. It threads the full `context` through generated `_step!`
calls so `GeneratedOld()` can be benchmarked against the new `Generated()` and
`RuntimeGenerated()` paths without changing their implementations.
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

"""Generated expression form of the old composite step."""
function step!_expr_old(ca::Type{CA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {CA<:CompositeAlgorithm, C<:AbstractContext}
    exprs = Any[]
    algo_count = numalgos(ca)
    interval_type = ca.parameters[2]
    child_namespace_tuple_type = ca.parameters[3]
    child_wiring_type = ca.parameters[4].parameters[2]
    stability_expr = stability === :stable ? :(Stable()) : stability === :unstable ? :(Stable()) :
        error("Unknown step!_expr_old stability $(stability). Expected :stable or :unstable.")
    sizehint!(exprs, algo_count + 4)

    # Read the composite cursor once so every child sees the same interval tick.
    push!(exprs, :(local this_inc = @inline inc($name)))
    for i in 1:algo_count
        interval_value = _generated_old_schedule_value(interval_type, i)
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        local_name = gensym(:algo)
        local_wiring = gensym(:child_step_wiring)
        local_namespace = gensym(:child_namespace)
        push!(exprs, quote
            if @inline divides(this_inc, $interval_value)
                local $local_name = @inline getalgo($name, $i)
                local $local_wiring = $child_step_wiring_type()
                local $local_namespace = $child_namespace_type()
                context = @inline _step!($local_name, context, $local_wiring, $local_namespace, process, lifetime, $stability_expr)
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
    repeat_type = routine.parameters[2]
    child_namespace_tuple_type = routine.parameters[3]
    child_wiring_type = routine.parameters[5].parameters[2]
    stability_expr = stability === :stable ? :(Stable()) : stability === :unstable ? :(Stable()) :
        error("Unknown step!_expr_old stability $(stability). Expected :stable or :unstable.")
    sizehint!(exprs, algo_count + 3)

    for i in 1:algo_count
        child_lifetime = _generated_old_schedule_value(repeat_type, i)
        child_lifetime isa Lifetime || error("Routine schedules must be `Lifetime` values after construction. Got $(typeof(child_lifetime)).")
        child_step_wiring_type = fieldtype(child_wiring_type, i)
        child_namespace_type = fieldtype(child_namespace_tuple_type, i)
        local_name = gensym(:algo)
        local_wiring = gensym(:child_step_wiring)
        local_namespace = gensym(:child_namespace)

        push!(exprs, quote
            local $local_name = @inline getalgo($name, $i)
            local $local_wiring = $child_step_wiring_type()
            local $local_namespace = $child_namespace_type()
            local _subroutine_lifetime = $child_lifetime
            local _routine_repeat_count = @inline routine_repeat_count(_subroutine_lifetime)
            if resume_idx($name, $i) <= _routine_repeat_count
                context = @inline _step!($local_name, context, $local_wiring, $local_namespace, process, lifetime, $stability_expr)
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
                    context = @inline _step!($local_name, context, $local_wiring, $local_namespace, process, lifetime, $stability_expr)
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
    stability_expr = if stability === :stable
        :(Stable())
    elseif stability === :unstable
        :(Stable())
    else
        error("Unknown step!_expr_old stability $(stability). Expected :stable or :unstable.")
    end
    return :(context = @inline _step!($funcname, context, $wiringname, Namespace{nothing}(), process, lifetime, $stability_expr))
end
