"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C, typestable::S = Stable()) where {T,Is,C<:AbstractContext, S}
    this_inc = inc(ca)
    algos = getalgos(ca)::T
    idxs = @inline algonvalumbers(ca)
    algos_and_idxs = @inline zip(algos, idxs)
    
    return @inline unrollreplace_withcallback(context, context -> begin
            @inline tick!(getglobals(context).process)
            context
        end , algos_and_idxs... ) do context, (func, algoidx)
        if (@inline interval(ca, getvalue(algoidx))) == 1
            context = @inline step!(func, context, typestable)
        else
            if this_inc % (@inline interval(ca, getvalue(algoidx))) == 0
                context = @inline step!(func, context, typestable)
            end
        end
        return context
    end
end

"""
Routines unroll their subroutines and execute them in order.
"""
Base.@constprop :aggressive @inline function step!(r::Routine, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    funcs = getalgos(r)
    algo_nums = @inline algonvalumbers(r)
    algos_and_nums = @inline zip(funcs, algo_nums)
    globals = @inline getglobals(context)
    process = globals.process
    lifetime = globals.lifetime

    return @inline unrollreplace(context, algos_and_nums...) do context, (func, algo_num_val)
        algo_idx = getvalue(algo_num_val)
        this_repeat = Processes.repeats(r, algo_num_val)
        start_idx = get_resume_point(r, algo_idx)

        if start_idx <= this_repeat
            context = @inline step!(func, context, Unstable())
            tick!(process)
            if @inline breakcondition(lifetime, process, context)
                set_resume_point!(r, algo_idx, start_idx + 1)
                return context
            end

            for lidx in (start_idx + 1):this_repeat
                context = @inline step!(func, context, typestable)
                tick!(process)
                if @inline breakcondition(lifetime, process, context)
                    set_resume_point!(r, algo_idx, lidx + 1)
                    return context
                end
            end
        end
        return context
    end
end

@inline function resume_step!(a::A, context::C, typestable::S = Stable()) where {A, C<:AbstractContext, S}
    @inline step!(a, context, typestable)
end

@inline function resume_step!(r::Routine, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    @inline step!(r, context, typestable)
end
