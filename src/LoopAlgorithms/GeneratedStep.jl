"""
Generated expression form for a resolved `LoopAlgorithm`.

Generated process loops receive the resolved wrapper at the root. Inline the
stored plan directly so generated code does not call the old no-runtime
`step!` entry point.
"""
function step!_expr(::Type{LA}, context::Type{C}, name::Symbol, stability::Symbol) where {Plan, LA<:LoopAlgorithm{Plan}, C<:AbstractContext}
    plan_name = gensym(:plan)
    return quote
        local $plan_name = @inline getplan($name)
        $(step!_expr(Plan, C, plan_name, stability))
    end
end

"""
Generated expression form for a finalized root loop algorithm.

Finalization affects the result after cleanup, not the loop step itself, so the
generated step expression delegates to the wrapped algorithm.
"""
function step!_expr(::Type{FA}, context::Type{C}, name::Symbol, stability::Symbol) where {LA, FA<:FinalizedAlgorithm{LA}, C<:AbstractContext}
    inner_name = gensym(:inner)
    return quote
        local $inner_name = @inline inneralgorithm($name)
        $(step!_expr(LA, C, inner_name, stability))
    end
end

"""
Generated expression form of the composite step! with a caller-provided name binding.
"""
function step!_expr(ca::Type{CA}, context::Type{C}, name::Symbol, stability::Symbol) where {CA<:CompositeAlgorithm, C<:AbstractContext}
    # This method does not execute the algorithm directly. Instead, it *builds an Expr*
    # representing the body of a `step!` method specialized to:
    # - the CompositeAlgorithm type `ca`
    # - the AbstractContext subtype `C`
    #
    # Each `push!(exprs, ...)` adds (roughly) one "line" to the generated function body.
    # `ca.parameters[1]` is the function-tuple type that stores the child algorithms.
   
    exprs = Any[]
    this_inc = gensym(:this_inc)
    # Generated line: `this_inc = inc(name)` (read the composite's step counter once).
    push!(exprs, :($this_inc = @inline inc($name)))
    for i in 1:numalgos(ca)
        interval = Processes.interval(ca, i)
        local_name = gensym(:algo)
        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        push!(exprs, :(local $local_name = @inline getalgo($name, $i)))
        # fti = ft.parameters[i]
        this_functype = getalgotype(ca, i)
        if interval == 1
            # Generated block: the child algorithm's `step!` body (always executed).
            push!(exprs, step!_expr(this_functype, C, local_name, stability))
        else
            # Generated block:
            #   if this_inc % interval == 0
            #       <child step! body>
            #   end
            push!(exprs, quote
                # Only run this child every `interval` composite steps.
                if $this_inc % $(interval) == 0
                    $(step!_expr(this_functype, C, local_name, stability))
                end
            end)
        end
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
function step!_expr(routine::Type{R}, context::Type{C}, name::Symbol, stability::Symbol) where {R<:Routine, C<:AbstractContext}
    # Builds an Expr representing the body of `step!` for a Routine:
    # each child algorithm runs `reps[i]` times before moving to the next.

    func_lifetimes = lifetimes(routine)
    exprs = Any[]

    for i in 1:numalgos(routine)
        this_lifetime = func_lifetimes[i]
        local_name = gensym(:algo)
        this_functype = getalgotype(routine, i)
        

        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        push!(exprs, :(local $local_name = @inline getalgo($name, $i)))

        if this_lifetime isa Lifetime
            push!(exprs, quote
                local _subroutine_lifetime = lifetimes($name, Val($i))
                local _routine_repeat_count = @inline routine_repeat_count(_subroutine_lifetime)
                if resume_idx($name, $i) <= _routine_repeat_count
                    $(step!_expr(this_functype, C, local_name, :unstable))
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
                        $(step!_expr(this_functype, C, local_name, stability))
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
            if resume_idx($name, $i) <= $this_lifetime
                # One unstable step allowed
                $(step!_expr(this_functype, C, local_name, :unstable))
                
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
                    $(step!_expr(this_functype, C, local_name, stability))
                    
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
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol, ::Symbol) where {T, C<:AbstractContext}
    # Generated single line:
    #   context = step!(funcname, context)
    # This is the non-generated fallback that just dispatches to an existing runtime `step!`.
    return :(context = @inline step!($funcname, context))
end
