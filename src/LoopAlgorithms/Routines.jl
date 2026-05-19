export Routine, RoutinePlan

"""
Execution plan that repeats child algorithms.

`Routine` is the repeated counterpart to `CompositeAlgorithm`: it keeps child
algorithms, repeat metadata, resume counters, and plan wiring. The runtime
registry, root states, context, inputs, and overrides are carried by the concrete
`LoopAlgorithm` wrapper.
"""
struct Routine{T, Repeats, MV, W, id} <: AbstractLoopAlgorithm
    funcs::T     
    resume_idxs::MV
    wiring::W
end

const RoutinePlan = Routine

function Routine(args...)
    parse_la_input(Routine, args...)
end

"""
Construct a routine execution plan, wrapping it only when root runtime data exists.

`LocalPlanOption` route/share metadata is stored in per-child wiring; plain
route/share wiring is stored on the plan. Root states and other
non-plan options remain on the `LoopAlgorithm` wrapper.
"""
function LoopAlgorithm(::Type{Routine}, funcs::F, states::Tuple, options::Tuple, repeats; id = nothing) where F
    resume_idxs = MVector{length(funcs),Int}(ones(length(funcs)))
    wiring = PlanWiring(_plan_wiring(options), _plan_child_wiring(funcs, options))
    plan = Routine{typeof(funcs), repeats, typeof(resume_idxs), typeof(wiring), id}(funcs, resume_idxs, wiring)
    root_options = _root_loop_options(options)
    return isempty(states) && isempty(root_options) ? plan : LoopAlgorithm(plan; states, options = root_options, id)
end

function newfuncs(r::Routine, funcs)
    setfield(r, :funcs, funcs)
end

function setoptions(r::Routine, options)
    wiring = PlanWiring(_plan_wiring(options), _plan_child_wiring(getalgos(r), options))
    return setfield(r, :wiring, wiring)
end

@inline getalgos(r::Routine) = _raw_plan_funcs(getfield(r, :funcs))
@inline getalgo(r::Routine, idx) = getalgos(r)[idx]
@inline getwiring(r::Routine) = getfield(r, :wiring)
@inline getoptions(r::Routine) = _all_plan_wiring(global_wiring(getwiring(r)), child_wiring(getwiring(r)))
@inline subalgorithms(r::Routine) = getalgos(r)
@inline getstates(r::Routine) = ()



getmultipliers_from_specification_num(::Type{R}, specification_num) where {R<:Routine} = Float64.(specification_num)
get_resume_idxs(r::Routine) = getfield(r, :resume_idxs)
resume_idx(r::Routine, idx) = getfield(r, :resume_idxs)[idx]
resumable(r::Routine) = true

# TODO: This is only used in treesctructure, try to deprecate
subalgotypes(r::Routine{FT}) where FT = _child_tuple_parameters(FT)
subalgotypes(::Type{R}) where {FT, R<:Routine{FT}} = _child_tuple_parameters(FT)
algotypes(r::Union{Routine{FT}, Type{R}}) where {FT, R<:Routine{FT}} = tuple(_child_tuple_parameters(FT)...)
statetypes(r::Union{Routine, Type{<:Routine}}) = ()

# getnames(r::Routine{T, R, NT, N}) where {T, R, NT, N} = N
Base.length(r::Routine) = length(getalgos(r))

function reset!(r::Routine)
    getfield(r, :resume_idxs) .= 1
    reset!.(getalgos(r))
end
#############################################
################ Type Info ###############
#############################################

@inline functypes(r::Union{Routine{T,R}, Type{<:Routine{T,R}}}) where {T,R} = tuple(_child_tuple_parameters(T)...)
@inline getalgotype(::Union{Routine{T,R}, Type{<:Routine{T,R}}}, idx) where {T,R} = _child_tuple_parameters(T)[idx]
@inline numalgos(r::Union{Routine{T,R}, Type{<:Routine{T,R}}}) where {T,R} = length(_child_tuple_parameters(T))

multipliers(r::Routine) = repeats(r)
multipliers(rT::Type{R}) where {R<:Routine} = repeats(rT)
getid(r::Union{Routine{T,R,MV,W,id},Type{<:Routine{T,R,MV,W,id}}}) where {T,R,MV,W,id} = id

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
