"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C) where {T,Is,C<:AbstractContext}
    this_inc = inc(ca)
    algos = getalgos(ca)::T
    idxs = @inline algonvalumbers(ca)
    algos_and_idxs = @inline zip(algos, idxs)
    return @inline unrollreplace_withcallback(context, context -> begin
            @inline tick!(ca)
            context
        end , algos_and_idxs... ) do context, (func, algoidx)
        if (@inline interval(ca, getvalue(algoidx))) == 1
            context = @inline step!(func, context)
        else
            if this_inc % (@inline interval(ca, getvalue(algoidx))) == 0
                context = @inline step!(func, context)
            end
        end
        return context
    end
end

"""
Routines unroll their subroutines and execute them in order.
"""
Base.@constprop :aggressive @inline function step!(r::Routine, context::C) where {C<:AbstractContext}
    funcs = getalgos(r)
    algo_nums = @inline algonvalumbers(r)
    algos_and_nums = @inline zip(funcs, algo_nums)
    return @inline unrollreplace(context, algos_and_nums...) do context, (func, algo_num_val)
        this_repeat = Processes.repeats(r, algo_num_val)
        start_idx = get_resume_point(r, getvalue(algo_num_val))
        for lidx in start_idx:this_repeat
            if !shouldrun(context.globals.process)
                set_resume_point!(r, getvalue(algo_num_val), lidx)
                return context
            end
            context = @inline step!(func, context)
            # GC.safepoint()
            tick!(context.globals.process)
        end
        return context
    end
end

@inline function resume_step!(a::A, context::C) where {A, C<:AbstractContext}
    @inline step!(a, context)
end

function resume_step!(r::Routine, context::C) where {C<:AbstractContext}
    repeats = Processes.repeats(r)
    
end