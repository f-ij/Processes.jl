export Routine

"""
Struct to create routines
"""
struct Routine{T, Repeats, MV, NSR, S, SV} <: ComplexLoopAlgorithm
    funcs::T
    resume_idxs::MV
    registry::NSR
    shared_contexts::S
    shared_vars::SV
end

update_instance(ca::Routine{T,R, MV}, ::NameSpaceRegistry) where {T,R, MV} = Routine{T, R, MV, Nothing, Nothing, Nothing}(ca.funcs, ca.resume_idxs, nothing, nothing, nothing)
getmultipliers_from_specification_num(::Type{<:Routine}, specification_num) = Float64.(specification_num)
get_resume_idxs(r::Routine) = r.resume_idxs
resumable(r::Routine) = true

function Routine(funcs::NTuple{N, Any}, 
                            repeats::NTuple{N, Real} = ntuple(x -> 1, length(funcs)), 
                            shares_and_routes::Union{Share, Route}...) where {N}

    (;functuple, registry, shared_contexts, shared_vars) = setup(Routine, funcs, repeats, shares_and_routes...)
    sidxs = MVector{length(functuple),Int}(ones(length(functuple)))
    Routine{typeof(functuple), typeof(repeats), typeof(sidxs), typeof(registry), typeof(shared_contexts), typeof(shared_vars)}(functuple, sidxs, registry, shared_contexts, shared_vars)
end

function newfuncs(r::Routine, funcs)
    nsr = NameSpaceRegistry(funcs)
    Routine{typeof(funcs), repeats(r), typeof(r.resume_idxs), typeof(nsr), typeof(r.shared_contexts), typeof(r.shared_vars)}(funcs, r.resume_idxs, nsr, r.shared_contexts, r.shared_vars)
end

subalgorithms(r::Routine) = r.funcs
subalgotypes(r::Routine{FT}) where FT = FT.parameters
subalgotypes(rT::Type{<:Routine{FT}}) where FT = FT.parameters

# getnames(r::Routine{T, R, NT, N}) where {T, R, NT, N} = N
Base.length(r::Routine) = length(r.funcs)
repeats(::Type{<:Routine{F,R}}) where {F,R} = R
repeats(r::Routine{F,R}) where {F,R} = R
multipliers(r::Routine) = repeats(r)
multipliers(rT::Type{<:Routine}) = repeats(rT)

repeats(r::Routine{F,R}, idx) where {F,R} = getindex(repeats(r), idx)
getfuncs(r::Routine) = r.funcs

function reset!(r::Routine)
    r.resume_idxs .= 1 
    reset!.(r.funcs)
end

function resume_idxs(r::Routine)
    r.resume_idxs
end

function set_resume_point!(r::Routine, idx::Int)
    r.resume_idxs[1:idx-1] = repeats(r)[1:idx-1]
    r.resume_idxs[idx] = r.resume_idxs[idx]
end

### STEP
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
    (;process) = getglobal(context)
    if isnothing(func)
        return context
    else
        for i in 1:this_repeat
            if !run(process)
                set_resume_point!(r, unroll_idx)
                return context
            end
            context = @inline step!(func, context)
            GC.safepoint()
        end
        @inline _unroll_subroutines(r, context, unroll_idx + 1, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats))
    end
end

