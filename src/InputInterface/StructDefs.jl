export Init, Input, Override

abstract type InputInterface end

target_type(ii::InputInterface) = typeof(ii.target_algo)
change_target(ii::InputInterface, newtarget) = setfield(ii, :target_algo, newtarget)

########################################
########### User Interface #############
########################################

struct Init{T,NT<:NamedTuple} <: InputInterface
    target_algo::T
    vars::NT
end

"""
    Init(target, :name => value, ...; kwargs...)

Initialization-time values for one process algorithm or state. These values are
merged before `init` runs and are replayed by `init(la)` when stored on an
initialized loop algorithm.
"""
function Init(target_algo::T, pairs::Pair{Symbol,<:Any}...; kwargs...) where {T}
    nt = (;pairs..., kwargs...)
    Init{T, typeof(nt)}(target_algo, nt)
end

const Input = Init


"""
Override an internal prepared arg in the context of a target algorithm
"""
struct Override{T,NT<:NamedTuple} <: InputInterface
    target_algo::T
    vars::NT
end

function Override(target_algo::T, pairs::Pair{Symbol,<:Any}...; kwargs...) where {T}
    nt = (;pairs..., kwargs...)
    Override{T, typeof(nt)}(target_algo, nt)
end


########################################
############## Backend #################
########################################

"""
Backend input system, translated from user input through registry
"""
struct NamedInput{Name, NT}
    vars::NT
end

function NamedInput{Name}(vars::NT) where {Name, NT}
    NamedInput{Name, NT}(vars)
end


struct NamedOverride{Name, NT}
    vars::NT
end

function NamedOverride{Name}(vars::NT) where {Name, NT}
    NamedOverride{Name, NT}(vars)
end
