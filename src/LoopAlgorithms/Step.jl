"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C) where {T,Is,C<:AbstractContext}
    algoidx = 1
    this_inc = inc(ca)
    return @inline _comp_dispatch(ca, context::C, algoidx, this_inc, gethead(ca.funcs), gettail(ca.funcs))
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
Base.@constprop :aggressive @inline function _comp_dispatch(ca::CompositeAlgorithm{T,Is}, context::C, algoidx::Int, this_inc::Int, thisfunc::TF, funcs) where {T, Is, TF,C<:AbstractContext}
    if isnothing(thisfunc)
        inc!(ca)
        # GC.safepoint()
        return context
    end
    if (@inline interval(ca, algoidx)) == 1
        context = step!(thisfunc, context)
    else
        if this_inc % (@inline interval(ca, algoidx)) == 0
            context = step!(thisfunc, context)
        end
    end
    return @inline _comp_dispatch(ca, context, algoidx + 1, this_inc, gethead(funcs), gettail(funcs))
end




"""
Routines unroll their subroutines and execute them in order.
"""
@inline function step!(r::Routine, context::C) where {C<:AbstractContext}
    @inline unroll_subroutines(r, context, r.funcs)
end

@inline function unroll_subroutines(r::R, context::C, funcs) where {R<:Routine, C<:AbstractContext}
    unroll_idx = 1
    @inline _unroll_subroutines(r, context, unroll_idx, gethead(funcs), gettail(funcs), gethead(repeats(r)), gettail(repeats(r)))
end

@inline function _unroll_subroutines(r::Routine, context::C, unroll_idx, func::F, tail, this_repeat, repeats) where {F, C<:AbstractContext}
    (;process) = getglobals(context)
    if isnothing(func)
        return context
    else
        for i in 1:this_repeat
            if !shouldrun(process)
                set_resume_point!(r, unroll_idx)
                return context
            end
            context = @inline step!(func, context)
            GC.safepoint()
            inc!(context.globals.process)
        end
        @inline _unroll_subroutines(r, context, unroll_idx + 1, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats))
    end
end

function resume_step!(r::Routine, context::C) where {C<:AbstractContext}
    
end