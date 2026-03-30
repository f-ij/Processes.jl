"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C, typestable::S = Stable()) where {T,Is,C<:AbstractContext, S}
    this_inc = inc(ca)
    algos_and_intervals = @inline algo_and_interval_iterator(ca)
    
    context = @inline unrollreplace_withargs(context, algos_and_intervals..., args = (this_inc,)) do context, _inc, (func, interval)
        if @inline divides(_inc, interval)
            context = @inline step!(func, context, typestable)
        end
        return context
    end
    @inline inc!(ca)
    return context
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

    return @inline unrollreplace_withargs(context, algos_and_nums..., args = (lifetime, process)) do context, lifetime, process, (func, algo_num_val) 
        algo_idx = getvalue(algo_num_val)
        this_repeat = Processes.repeats(r, algo_num_val)
        start_idx = get_resume_point(r, algo_idx)

        if start_idx <= this_repeat
            if @inline breakcondition(lifetime, process, context)
                set_resume_point!(r, algo_idx, start_idx)
                return context
            end

            context = @inline step!(func, context, Unstable())
            tick!(process)
            

            for lidx in (start_idx + 1):this_repeat
                if @inline breakcondition(lifetime, process, context)
                    set_resume_point!(r, algo_idx, lidx)
                    return context
                end
                context = @inline step!(func, context, typestable)
                tick!(process)
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
