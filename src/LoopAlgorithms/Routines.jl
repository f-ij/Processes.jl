export Routine

"""
Struct to create routines
"""
struct Routine{T,Repeats,MV,NSR,O,id} <: LoopAlgorithm
    funcs::T
    resume_idxs::MV
    registry::NSR
    options::O
end

function Routine(funcs::NTuple{N,Any},
    repeats::NTuple{N,Real}=ntuple(x -> 1, length(funcs)),
    shares_and_routes::Union{Share,Route}...) where {N}

    (; functuple, registry, options) = setup(Routine, funcs, repeats, shares_and_routes...)
    sidxs = MVector{length(functuple),Int}(ones(length(functuple)))
    
    if repeats isa Tuple
        repeats = Int.(repeats)
    end
    Routine{typeof(functuple),repeats,typeof(sidxs),typeof(registry),typeof(options),uuid4()}(functuple, sidxs, registry, options)
end

function newfuncs(r::Routine, funcs)
    setfield(r, :funcs, funcs)
end

getalgos(r::Routine) = r.funcs
@inline getalgo(r::Routine, idx) = r.funcs[idx]

function Base.getindex(r::Routine, idx)
   getalgos(r)[idx]
end


getmultipliers_from_specification_num(::Type{<:Routine}, specification_num) = Float64.(specification_num)
get_resume_idxs(r::Routine) = r.resume_idxs
resumable(r::Routine) = true

# subalgorithms(r::Routine) = r.funcs
# TODO: This is only used in treesctructure, try to deprecate
subalgotypes(r::Routine{FT}) where FT = FT.parameters
subalgotypes(rT::Type{<:Routine{FT}}) where FT = FT.parameters

# getnames(r::Routine{T, R, NT, N}) where {T, R, NT, N} = N
Base.length(r::Routine) = length(r.funcs)

function reset!(r::Routine)
    r.resume_idxs .= 1
    reset!.(r.funcs)
end
#############################################
################ Type Info ###############
#############################################

@inline functypes(r::Union{Routine{T,R}, Type{<:Routine{T,R}}}) where {T,R} = tuple(T.parameters...)
@inline getalgotype(::Union{Routine{T,R}, Type{<:Routine{T,R}}}, idx) where {T,R} = T.parameters[idx]
@inline numalgos(r::Union{Routine{T,R}, Type{<:Routine{T,R}}}) where {T,R} = length(T.parameters)

multipliers(r::Routine) = repeats(r)
multipliers(rT::Type{<:Routine}) = repeats(rT)
getid(r::Union{Routine{T,R,MV,NSR,O,id},Type{<:Routine{T,R,MV,NSR,O,id}}}) where {T,R,MV,NSR,O,id} = id

@inline repeats(r::Union{Routine{F,R}, Type{<:Routine{F,R}}}) where {F,R} = R
repeats(r::Union{Routine{F,R}, Type{<:Routine{F,R}}}, idx::Int) where {F,R} = R[idx]
repeats(r::Union{Routine{F,R}, Type{<:Routine{F,R}}}, ::Val{idx}) where {F,R,idx} = R[idx]



function resume_idxs(r::Routine)
    r.resume_idxs
end

function set_resume_point!(r::Routine, idx::Int, loopidx::Int)
    r.resume_idxs[idx] = loopidx
end

@inline function get_resume_point(r::Routine, idx::Int)
    r.resume_idxs[idx]
end