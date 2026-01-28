
"""
Give the expression form of the step! function form the types
"""
function step!_expr(sa::Type{SA}, context::Type{C}, name::Symbol) where {SA<:SimpleAlgo, C<:AbstractContext}
    dt = SA
    ft = dt.parameters[1]

    exprs = Any[]
    push!(exprs, :((;process) = @inline getglobal(context)))

    for i in 1:length(ft.parameters)
        push!(exprs, quote
            if !run(process)
                if resumable($name)
                    resume_idx!($name)
                end
                return context
            end
        end)
        fti = ft.parameters[i]
        local_name = gensym(:algo)
        push!(exprs, :(local $local_name = getfunc($name, $i)))
        push!(exprs, step!_expr(fti, C, local_name))
    end

    push!(exprs, :(context))
    return Expr(:block, exprs...)
end

"""
Generated expression form of the composite step! with a caller-provided name binding.
"""
function step!_expr(ca::Type{<:CompositeAlgorithm}, context::Type{C}, name::Symbol) where {C<:AbstractContext}
    dt = ca
    ft = dt.parameters[1]
    intervals = dt.parameters[2]
    exprs = Any[]
    push!(exprs, :(this_inc = inc($name)))
    for i in 1:length(ft.parameters)
        interval = intervals[i]
        local_name = gensym(:algo)
        push!(exprs, :(local $local_name = getfunc($name, $i)))
        fti = ft.parameters[i]
        if interval == 1
            push!(exprs, step!_expr(fti, C, local_name))
        else
            push!(exprs, quote
                if this_inc % $(interval) == 0
                    $(step!_expr(fti, C, local_name))
                end
            end)
        end
    end
    push!(exprs, :(@inline inc!($name)))
    # push!(exprs, :(GC.safepoint()))
    push!(exprs, :(context))
    return Expr(:block, exprs...)
end

"""
Generated expression form of the routine step! with a caller-provided name binding.
"""
function step!_expr(r::Type{<:Routine}, context::Type{C}, name::Symbol) where {C<:AbstractContext}
    dt = r
    ft = dt.parameters[1]
    reps = dt.parameters[2]
    exprs = Any[]
    push!(exprs, :((;process) = @inline getglobal(context)))
    for i in 1:length(ft.parameters)
        this_repeat = reps[i]
        local_name = gensym(:algo)
        fti = ft.parameters[i]
        push!(exprs, :(local $local_name = getfunc($name, $i)))
        push!(exprs, quote
            for _ in 1:$(this_repeat)
                if !run(process)
                    set_resume_point!($name, $i)
                    return context
                end
                $(step!_expr(fti, C, local_name))
                # GC.safepoint()
            end
        end)
    end
    push!(exprs, :(context))
    return Expr(:block, exprs...)
end


"""
Fallback expression form for non-CLA algorithms.
"""
function step!_expr(::Type{T}, ::Type{C}, funcname::Symbol) where {T, C<:AbstractContext}
    return :(context = @inline step!($funcname, context))
end
