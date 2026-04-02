export Routine

"""
Struct to create routines
"""
struct Routine{T, Repeats, S, MV, O, R, id} <: LoopAlgorithm
    funcs::T     
    states::S
    options::O
    resume_idxs::MV
    reg::R
end

function Routine(args...)
    parse_la_input(Routine, args...)
end

function LoopAlgorithm(::Type{Routine}, funcs::F, states::Tuple, options::Tuple, repeats; id = nothing) where F
    resume_idxs = MVector{length(funcs),Int}(ones(length(funcs)))
    return Routine{typeof(funcs), repeats, typeof(states), typeof(resume_idxs), typeof(options), Nothing, id}(funcs, states, options, resume_idxs, nothing)
end

function newfuncs(r::Routine, funcs)
    setfield(r, :funcs, funcs)
end

function setoptions(r::Routine{T, Repeats, S, MV, O, R, id}, options) where {T, Repeats, S, MV, O, R, id}
    Routine{T, Repeats, S, MV, typeof(options), R, id}(getalgos(r), get_states(r), options, get_resume_idxs(r), getregistry(r))
end

@inline getregistry(r::Routine) = getfield(r, :reg)
@inline _attach_registry(r::Routine, registry::NameSpaceRegistry) = setfield(r, :reg, registry)
@inline isresolved(r::Routine) = !isnothing(getregistry(r))

@inline getalgos(r::Routine) = getfield(r, :funcs)
@inline getalgo(r::Routine, idx) = getfield(r, :funcs)[idx]
@inline getoptions(r::Routine) = getfield(r, :options)
@inline subalgorithms(r::Routine) = getfield(r, :funcs)

function Base.getindex(r::Routine, idx)
   getalgos(r)[idx]
end


getmultipliers_from_specification_num(::Type{<:Routine}, specification_num) = Float64.(specification_num)
get_resume_idxs(r::Routine) = getfield(r, :resume_idxs)
resume_idx(r::Routine, idx) = getfield(r, :resume_idxs)[idx]
resumable(r::Routine) = true

# TODO: This is only used in treesctructure, try to deprecate
subalgotypes(r::Routine{FT}) where FT = FT.parameters
subalgotypes(rT::Type{<:Routine{FT}}) where FT = FT.parameters
algotypes(r::Union{Routine{FT}, Type{<:Routine{<:FT}}}) where FT = tuple(FT.parameters...)
statetypes(r::Union{Routine{FT, R, S}, Type{<:Routine{FT, R, S}}}) where {FT, R, S} = S.parameters

# getnames(r::Routine{T, R, NT, N}) where {T, R, NT, N} = N
Base.length(r::Routine) = length(getfield(r, :funcs))

function reset!(r::Routine)
    getfield(r, :resume_idxs) .= 1
    reset!.(getalgos(r))
end
#############################################
################ Type Info ###############
#############################################

@inline functypes(r::Union{Routine{T,R}, Type{<:Routine{T,R}}}) where {T,R} = tuple(T.parameters...)
@inline getalgotype(::Union{Routine{T,R}, Type{<:Routine{T,R}}}, idx) where {T,R} = T.parameters[idx]
@inline numalgos(r::Union{Routine{T,R}, Type{<:Routine{T,R}}}) where {T,R} = length(T.parameters)

multipliers(r::Routine) = repeats(r)
multipliers(rT::Type{<:Routine}) = repeats(rT)
getid(r::Union{Routine{T,R,S,MV,O,Reg,id},Type{<:Routine{T,R,S,MV,O,Reg,id}}}) where {T,R,S,MV,O,Reg,id} = id

@inline repeats(r::Union{Routine{F,R}, Type{<:Routine{F,R}}}) where {F,R} = R
repeats(r::Union{Routine{F,R}, Type{<:Routine{F,R}}}, idx::Int) where {F,R} = R[idx]
repeats(r::Union{Routine{F,R}, Type{<:Routine{F,R}}}, ::Val{idx}) where {F,R,idx} = R[idx]



function resume_idxs(r::Routine)
    getfield(r, :resume_idxs)
end

function set_resume_point!(r::Routine, idx::Int, loopidx::Int)
    getfield(r, :resume_idxs)[idx] = loopidx
end

@inline function get_resume_point(r::Routine, idx::Int)
    getfield(r, :resume_idxs)[idx]
end
