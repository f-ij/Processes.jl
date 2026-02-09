@inline function resume_step!(f::F, context::C) where {F, C<:AbstractContext}
    return step!(f, context)
end

@inline function resume_step!(r::Routine, context::C) where {C<:AbstractContext}
    unroll_idx = 1
    r_idxs = resume_idxs(r)
    @inline _resume_step!(r, context, unroll_idx, gethead(r.funcs), gettail(r.funcs), gethead(repeats(r)), gettail(repeats(r)), gethead(r_idxs), gettail(r_idxs))
end

@inline function _resume_step!(r::Routine, context::C, unroll_idx, func::F, tail, this_repeat, repeats, this_resume_idx, resume_idxs_tail) where {F, C<:AbstractContext}
    (;process) = getglobals(context)
    if isnothing(func)
        reset!(r)
        return context
    else
        for i in this_resume_idx:this_repeat
            if !shouldrun(process)
                set_resume_point!(r, unroll_idx, i)
                return context
            end
            context = @inline step!(func, context)
            GC.safepoint()
        end
        @inline _resume_step!(r, context, unroll_idx + 1, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats), gethead(resume_idxs_tail), gettail(resume_idxs_tail))
    end
end