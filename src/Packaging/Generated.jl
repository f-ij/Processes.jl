function step!_expr(ca::Type{<:PackagedAlgo}, context::Type{C}, name::Symbol) where {C<:AbstractContext}
    # This method does not execute the algorithm directly. Instead, it *builds an Expr*
    # representing the body of a `step!` method specialized to:
    # - the CompositeAlgorithm type `ca`
    # - the AbstractContext subtype `C`
    #
    # Each `push!(exprs, ...)` adds (roughly) one "line" to the generated function body.
    dt = ca
    # `dt.parameters[1]` is the function-tuple type that stores the child algorithms.
    ft = dt.parameters[1]
    # `dt.parameters[2]` is the tuple of per-child execution intervals.
    intervals = dt.parameters[2]
    exprs = Any[]
    # Generated line: `this_inc = inc(name)` (read the composite's step counter once).
    push!(exprs, :(this_inc = inc($name)))
    for i in 1:length(ft.parameters)
        interval = intervals[i]
        local_name = gensym(:algo)
        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        push!(exprs, :(local $local_name = getalgo($name, $i)))
        fti = ft.parameters[i]
        if interval == 1
            # Generated block: the child algorithm's `step!` body (always executed).
            push!(exprs, step!_expr(fti, C, local_name))
        else
            # Generated block:
            #   if this_inc % interval == 0
            #       <child step! body>
            #   end
            push!(exprs, quote
                # Only run this child every `interval` composite steps.
                if this_inc % $(interval) == 0
                    $(step!_expr(fti, C, local_name))
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
