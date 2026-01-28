export Routine

"""
Struct to create routines
"""
struct Routine{T, Repeats, MV, NSR, O, id} <: ComplexLoopAlgorithm
    funcs::T
    resume_idxs::MV
    registry::NSR
    options::O
end

# function update_scope(ca::Routine{T,R, MV}, newreg::NameSpaceRegistry) where {T,R, MV}
#     updated_reg, _ = updatenames(ca.registry, newreg)
#     # Routine{T, R, MV, typeof(updated_reg), Nothing}(ca.funcs, ca.resume_idxs, updated_reg, nothing)
#     return setfield(ca, :registry, updated_reg)
# end
getmultipliers_from_specification_num(::Type{<:Routine}, specification_num) = Float64.(specification_num)
get_resume_idxs(r::Routine) = r.resume_idxs
resumable(r::Routine) = true

function Routine(funcs::NTuple{N, Any}, 
                            repeats::NTuple{N, Real} = ntuple(x -> 1, length(funcs)), 
                            shares_and_routes::Union{Share, Route}...) where {N}

    (;functuple, registry, options) = setup(Routine, funcs, repeats, shares_and_routes...)
    sidxs = MVector{length(functuple),Int}(ones(length(functuple)))
    Routine{typeof(functuple), repeats, typeof(sidxs), typeof(registry), typeof(options), uuid4()}(functuple, sidxs, registry, options)
end

function newfuncs(r::Routine, funcs)
    setfield(r, :funcs, funcs)
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
getid(r::Union{Routine{T,R,MV,NSR,O,id}, Type{<:Routine{T,R,MV,NSR,O,id}}}) where {T,R,MV,NSR,O,id} = id

repeats(r::Routine{F,R}, idx) where {F,R} = getindex(repeats(r), idx)
getfuncs(r::Routine) = r.funcs
@inline getfunc(r::Routine, idx) = r.funcs[idx]

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
