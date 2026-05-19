export Routine, RoutinePlan

"""
Execution plan that repeats child algorithms.

`Routine` is the repeated counterpart to `CompositeAlgorithm`: it keeps child
algorithms, repeat metadata, resume counters, raw local route/share wiring,
plan-wide raw route/share wiring, and resolved per-child `step_wiring`. The
runtime registry, root states, context, inputs, and overrides are carried by the
concrete `LoopAlgorithm` wrapper.
"""
struct Routine{T, Repeats, MV, LW, PW, SW, id} <: AbstractLoopAlgorithm
    funcs::T     
    resume_idxs::MV
    local_wiring::LW
    plan_wiring::PW
    step_wiring::SW
end

const RoutinePlan = Routine

function Routine(args...)
    parse_la_input(Routine, args...)
end

"""
Construct a routine execution plan, wrapping it only when root runtime data exists.

`LocalPlanOption` route/share metadata is stored in per-child plan wiring; plain
route/share wiring is stored on the plan. Root states and other
non-plan options remain on the `LoopAlgorithm` wrapper.
"""
function LoopAlgorithm(::Type{Routine}, funcs::F, states::Tuple, options::Tuple, repeats; id = nothing) where F
    resume_idxs = MVector{length(funcs),Int}(ones(length(funcs)))
    local_wiring = _local_plan_wiring(funcs, options)
    plan_wiring = _plan_wiring(options)
    step_wiring = ntuple(_ -> StepRouting(), length(funcs))
    plan = Routine{typeof(funcs), repeats, typeof(resume_idxs), typeof(local_wiring), typeof(plan_wiring), typeof(step_wiring), id}(funcs, resume_idxs, local_wiring, plan_wiring, step_wiring)
    root_options = _root_loop_options(options)
    return isempty(states) && isempty(root_options) ? plan : LoopAlgorithm(plan; states, options = root_options, id)
end

function newfuncs(r::Routine, funcs)
    setfield(r, :funcs, funcs)
end

function setoptions(r::Routine, options)
    r = setfield(r, :local_wiring, _local_plan_wiring(getalgos(r), options))
    r = setfield(r, :plan_wiring, _plan_wiring(options))
    return setfield(r, :step_wiring, ntuple(_ -> StepRouting(), length(getalgos(r))))
end

@inline getalgos(r::Routine) = getfield(r, :funcs)
@inline getalgo(r::Routine, idx) = getfield(r, :funcs)[idx]
@inline getoptions(r::Routine) = _all_plan_wiring(getfield(r, :plan_wiring), getfield(r, :local_wiring))
@inline subalgorithms(r::Routine) = getfield(r, :funcs)
@inline getstates(r::Routine) = ()



getmultipliers_from_specification_num(::Type{R}, specification_num) where {R<:Routine} = Float64.(specification_num)
get_resume_idxs(r::Routine) = getfield(r, :resume_idxs)
resume_idx(r::Routine, idx) = getfield(r, :resume_idxs)[idx]
resumable(r::Routine) = true

# TODO: This is only used in treesctructure, try to deprecate
subalgotypes(r::Routine{FT}) where FT = FT.parameters
subalgotypes(::Type{R}) where {FT, R<:Routine{FT}} = FT.parameters
algotypes(r::Union{Routine{FT}, Type{R}}) where {FT, R<:Routine{FT}} = tuple(FT.parameters...)
statetypes(r::Union{Routine, Type{<:Routine}}) = ()

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
multipliers(rT::Type{R}) where {R<:Routine} = repeats(rT)
getid(r::Union{Routine{T,R,MV,LW,PW,SW,id},Type{<:Routine{T,R,MV,LW,PW,SW,id}}}) where {T,R,MV,LW,PW,SW,id} = id

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
