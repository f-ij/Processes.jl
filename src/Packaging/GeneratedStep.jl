"""
Generated expression form of the composite step! with a caller-provided name binding.
"""
function step!_expr(pa::Type{<:PackagedAlgo}, context::Type{C}, name::Symbol) where {C<:AbstractContext}
    # This method does not execute the algorithm directly. Instead, it *builds an Expr*
    # representing the body of a `step!` method specialized to:
    # - the CompositeAlgorithm type `pa`
    # - the AbstractContext subtype `C`
    #
    # Each `push!(exprs, ...)` adds (roughly) one "line" to the generated function body.
    # `pa.parameters[1]` is the function-tuple type that stores the child algorithms.
   
    exprs = Any[]
    # Generated line: `this_inc = inc(name)` (read the composite's step counter once).
    push!(exprs, :(this_inc = inc($name)))
    for i in 1:numalgos(pa)
        interval = Processes.interval(pa, i)
        local_name = gensym(:algo)
        # Generated line: `local algoᵢ = getalgo(name, i)` (bind child algorithm instance).
        push!(exprs, :(local $local_name = getalgo($name, $i)))
        # fti = ft.parameters[i]
        this_functype = getalgotype(pa, i)
        push!(exprs, quote
            # Only run this child every `interval` composite steps.
            if this_inc % $(interval) == 0 # If interval == 1 this will be compiled away and optimized out, so no need for a separate branch
                $(step!_expr(this_functype, C, local_name))
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