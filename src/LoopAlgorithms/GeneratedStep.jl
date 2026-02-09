"""
Generated expression form of the composite step! with a caller-provided name binding.
"""
function step!_expr(ca::Type{<:CompositeAlgorithm}, context::Type{C}, name::Symbol) where {C<:AbstractContext}
    # This method does not execute the algorithm directly. Instead, it *builds an Expr*
    # representing the body of a `step!` method specialized to:
    # - the CompositeAlgorithm type `ca`
    # - the AbstractContext subtype `C`
    #
    # Each `push!(exprs, ...)` adds (roughly) one "line" to the generated function body.
    # `ca.parameters[1]` is the function-tuple type that stores the child algorithms.
   
    exprs = Any[]
    # Generated line: `this_inc = inc(name)` (read the composite's step counter once).
    push!(exprs, :(this_inc = inc($name)))
    for i in 1:numfuncs(ca)
        interval = Processes.interval(ca, i)
        local_name = gensym(:algo)
        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        push!(exprs, :(local $local_name = getalgo($name, $i)))
        # fti = ft.parameters[i]
        this_functype = getalgotype(ca, i)
        if interval == 1
            # Generated block: the child algorithm's `step!` body (always executed).
            push!(exprs, step!_expr(this_functype, C, local_name))
        else
            # Generated block:
            #   if this_inc % interval == 0
            #       <child step! body>
            #   end
            push!(exprs, quote
                # Only run this child every `interval` composite steps.
                if this_inc % $(interval) == 0
                    $(step!_expr(this_functype, C, local_name))
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
function step!_expr(routine::Type{<:Routine}, context::Type{C}, name::Symbol) where {C<:AbstractContext}
    # Builds an Expr representing the body of `step!` for a Routine:
    # each child algorithm runs `reps[i]` times before moving to the next.

    func_repeats = repeats(routine)
    exprs = Any[]

    for i in 1:numfuncs(routine)
        this_repeat = func_repeats[i]
        local_name = gensym(:algo)
        this_functype = getalgotype(routine, i)
        

        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        push!(exprs, :(local $local_name = getalgo($name, $i)))

        # Generated block: a repeat-loop for this child algorithm.
        # - If `shouldrun(process)` is false, record the resume point (child index i) and return early.
        # - Otherwise execute the child's generated `step!` body.
        push!(exprs, quote

            for _ in 1:$(this_repeat)
                # Pause/stop check: if the process is not running, record which child we were on.
                if !shouldrun(process)
                    set_resume_point!($name, $i)
                    return context
                end
                # Inline the child's `step!` body, specialized to the child's algorithm type and the context type.
                $(step!_expr(this_functype, C, local_name))
                
                # Assumes process is defined in the top level
                inc!(process)
                # GC.safepoint()
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
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol) where {T, C<:AbstractContext}
    # Generated single line:
    #   context = step!(funcname, context)
    # This is the non-generated fallback that just dispatches to an existing runtime `step!`.
    return :(context = @inline step!($funcname, context))
end
