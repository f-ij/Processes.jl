"""
Generated expression form for a resolved `LoopAlgorithm`.

Generated process loops receive the resolved wrapper at the root. Inline the
stored plan directly so generated code does not call the old no-runtime
`step!` entry point.
"""
function step!_expr(::Type{LA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {Plan, LA<:LoopAlgorithm{Plan}, C<:AbstractContext}
    plan_name = gensym(:plan)
    return quote
        local $plan_name = @inline getplan($name)
        $(step!_expr(Plan, C, plan_name, wiringname, stability))
    end
end

"""
Generated expression form for a finalized root loop algorithm.

Finalization affects the result after cleanup, not the loop step itself, so the
generated step expression delegates to the wrapped algorithm.
"""
function step!_expr(::Type{FA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {LA, FA<:FinalizedAlgorithm{LA}, C<:AbstractContext}
    inner_name = gensym(:inner)
    return quote
        local $inner_name = @inline inneralgorithm($name)
        $(step!_expr(LA, C, inner_name, wiringname, stability))
    end
end

"""Generated child expression for nested loop plans; parent namespaces are ignored."""
function step!_expr(::Type{LA}, context::Type{C}, name::Symbol, wiringname::Symbol, ::Symbol, stability::Symbol) where {LA<:AbstractLoopAlgorithm, C<:AbstractContext}
    return step!_expr(LA, context, name, wiringname, stability)
end

"""Generated child expression for unresolved identifiable wrappers."""
function step!_expr(::Type{IA}, context::Type{C}, name::Symbol, wiringname::Symbol, ::Symbol, stability::Symbol) where {IA<:IdentifiableAlgo, C<:AbstractContext}
    return step!_expr(IA, context, name, wiringname, stability)
end

"""
Generated expression form of the composite step! with a caller-provided name binding.
"""
function step!_expr(ca::Type{CA}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {CA<:CompositeAlgorithm, C<:AbstractContext}
    # This method does not execute the algorithm directly. Instead, it *builds an Expr*
    # representing the body of a `step!` method specialized to:
    # - the CompositeAlgorithm type `ca`
    # - the AbstractContext subtype `C`
    #
    # Each `push!(exprs, ...)` adds (roughly) one "line" to the generated function body.
    # `ca.parameters[1]` is the function-tuple type that stores the child algorithms.
   
    exprs = Any[]
    algo_count = numalgos(ca)
    child_wiring_type = ca.parameters[3].parameters[2]
    stability_expr = stability === :stable ? :(Stable()) : stability === :unstable ? :(Unstable()) :
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    stability_type = stability === :stable ? Stable : Unstable
    sizehint!(exprs, algo_count + 4)
    # Generated line: `this_inc = inc(name)` (read the composite's step counter once).
    push!(exprs, :(local this_inc = @inline inc($name)))
    for i in 1:algo_count
        interval = Processes.interval(ca, i)
        interval_type = typeof(interval)
        child_step_wiring_value = fieldtype(child_wiring_type, i)()
        local_name = gensym(:algo)
        local_wiring = gensym(:child_step_wiring)
        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        # fti = ft.parameters[i]
        this_functype = getalgotype(ca, i)
        namespace = _generated_child_namespace(ca, i)
        child_step_expr = _generated_child_step_expr(this_functype, :context, local_name, local_wiring, namespace, stability_expr, stability_type, child_step_wiring_value)
        push!(exprs, quote
            # Only run this child every `interval` composite steps.
            if @inline divides(this_inc, $interval_type())
                local $local_name = @inline getalgo($name, $i)
                local $local_wiring = $(QuoteNode(child_step_wiring_value))
                $child_step_expr
            end
        end)
    end
    # Generated line: `inc!(name)` (advance composite counter after running children).
    push!(exprs, :(@inline inc!($name)))
    # push!(exprs, :(GC.safepoint()))
    # Generated line: `context` (ensure the generated function returns the runtime context).
    push!(exprs, :(context))
    return Expr(:block, exprs...)
end

"""
Generated expression form of the routine step! with a caller-provided name binding.
"""
function step!_expr(routine::Type{R}, context::Type{C}, name::Symbol, wiringname::Symbol, stability::Symbol) where {R<:Routine, C<:AbstractContext}
    # Builds an Expr representing the body of `step!` for a Routine:
    # each child algorithm runs `reps[i]` times before moving to the next.

    func_lifetimes = lifetimes(routine)
    exprs = Any[]
    algo_count = numalgos(routine)
    child_wiring_type = routine.parameters[4].parameters[2]
    stable_expr = :(Stable())
    unstable_expr = :(Unstable())
    stability_expr = stability === :stable ? stable_expr : stability === :unstable ? unstable_expr :
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    stability_type = stability === :stable ? Stable : Unstable
    sizehint!(exprs, algo_count + 3)

    for i in 1:algo_count
        this_lifetime = func_lifetimes[i]
        child_step_wiring_value = fieldtype(child_wiring_type, i)()
        local_name = gensym(:algo)
        local_wiring = gensym(:child_step_wiring)
        this_functype = getalgotype(routine, i)
        namespace = _generated_child_namespace(routine, i)
        unstable_child_step_expr = _generated_child_step_expr(this_functype, :context, local_name, local_wiring, namespace, unstable_expr, Unstable, child_step_wiring_value)
        stable_child_step_expr = _generated_child_step_expr(this_functype, :context, local_name, local_wiring, namespace, stability_expr, stability_type, child_step_wiring_value)
        

        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        if this_lifetime isa Lifetime
            push!(exprs, quote
                local $local_name = @inline getalgo($name, $i)
                local $local_wiring = $(QuoteNode(child_step_wiring_value))
                local _subroutine_lifetime = lifetimes($name, Val($i))
                local _routine_repeat_count = @inline routine_repeat_count(_subroutine_lifetime)
                if resume_idx($name, $i) <= _routine_repeat_count
                    $unstable_child_step_expr
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
                        $stable_child_step_expr
                        @inline tick!(process)
                    end
                end
            end)
            continue
        end

        # Generated block: a repeat-loop for this child algorithm.
        # - If `shouldrun(process)` is false, record the resume point (child index i) and return early.
        # - Otherwise execute the child's generated `step!` body.
        push!(exprs, quote
            local $local_name = @inline getalgo($name, $i)
            local $local_wiring = $(QuoteNode(child_step_wiring_value))
            if resume_idx($name, $i) <= $this_lifetime
                # One unstable step allowed
                $unstable_child_step_expr
                
                # Assumes process is defined in the top level
                @inline tick!(process) # Tick counter
                if @inline breakcondition(lifetime, process, context)
                    set_resume_point!($name, $i, 2)
                    return context
                end

                start_idx = @inline resume_idx($name, $i) + UInt(1)
                for lidx in start_idx:$(this_lifetime)
                    # Pause/stop check: if the process is not running, record which child we were on.

                    # Inline the child's `step!` body, specialized to the child's algorithm type and the context type.
                    $stable_child_step_expr
                    
                    # Assumes process is defined in the top level
                    @inline tick!(process) # Tick counter
                    if @inline breakcondition(lifetime, process, context)
                        set_resume_point!($name, $i, lidx+UInt(1))
                        return context
                    end
                    # GC.safepoint()
                end
            else
            end
        end)
    end
    # Generated line: `context` (ensure the generated function returns the runtime context).
    push!(exprs, :(context))
    return Expr(:block, exprs...)
end


"""
Fallback expression form for non-CLA algorithms.
"""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiringname::Symbol, stability::Symbol) where {T, C<:AbstractContext}
    # Generated single line:
    #   context = _step!(funcname, context, wiring, process, lifetime, stability)
    # This keeps generated loops aligned with the normal runtime route/share
    # semantics for algorithms that do not provide a custom expression form.
    stability_expr = if stability === :stable
        :(Stable())
    elseif stability === :unstable
        :(Unstable())
    else
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    end
    return :(context = @inline _step!($funcname, context, $wiringname, process, lifetime, $stability_expr))
end

"""
Generated expression form for raw resolved plan children.
"""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, wiringname::Symbol, namespace::Symbol, stability::Symbol) where {T<:ProcessAlgorithm, C<:AbstractContext}
    namespace_expr = :(Namespace{$(QuoteNode(namespace))}())
    stability_expr = if stability === :stable
        :(Stable())
    elseif stability === :unstable
        :(Unstable())
    else
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    end
    return :(context = @inline _step!($funcname, context, $wiringname, $namespace_expr, process, lifetime, $stability_expr))
end
