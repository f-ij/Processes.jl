#AlgoTracker
export inc!, nextalgo!, intervals, interval
export CompositeAlgorithm
struct CompositeAlgorithm{T, Intervals, S , O, R,id} <: LoopAlgorithm
    funcs::T
    states::S
    options::O
    inc::Base.RefValue{Int} # To track the intervals
    reg::R
end

getmultipliers_from_specification_num(::Type{<:CompositeAlgorithm}, specification_num) = 1 ./(Float64.(specification_num))

CompositeAlgorithm(args...) = parse_la_input(CompositeAlgorithm, args...)
function LoopAlgorithm(::Type{CompositeAlgorithm}, funcs::F, states::Tuple, options::Tuple, intervals; id = nothing) where F
    return CompositeAlgorithm{typeof(funcs), intervals, typeof(states), typeof(options), Nothing, id}(funcs, states, options, Ref(1), nothing)
end

function newfuncs(ca::CompositeAlgorithm, funcs)
    # CompositeAlgorithm{typeof(funcs), intervals(ca), typeof(ca.registry), typeof(ca.options)}(funcs, ca.inc, ca.registry , ca.options)
    setfield(ca, :funcs, funcs)
end

function setoptions(ca::CompositeAlgorithm{T, Intervals, S, O, R, id}, options) where {T, Intervals, S, O, R, id}
    CompositeAlgorithm{T, Intervals, S, typeof(options), R, id}(getalgos(ca), getstates(ca), options, getinc(ca), getregistry(ca))
end

@inline getregistry(ca::CompositeAlgorithm) = getfield(ca, :reg)
@inline _attach_registry(ca::CompositeAlgorithm, registry::NameSpaceRegistry) = setfield(ca, :reg, registry)
@inline isresolved(ca::CompositeAlgorithm) = !isnothing(getregistry(ca))

subalgorithms(ca::CompositeAlgorithm) = getfield(ca, :funcs)
algotypes(ca::Union{CompositeAlgorithm{FT}, Type{<:CompositeAlgorithm{FT}}}) where FT = FT.parameters
statetypes(ca::Union{CompositeAlgorithm{FT, I, S}, Type{<:CompositeAlgorithm{FT, I, S}}}) where {FT, I, S} = S.parameters
subalgotypes(ca::CompositeAlgorithm{FT}) where FT = FT.parameters
subalgotypes(caT::Type{<:CompositeAlgorithm{FT}}) where FT = FT.parameters
@inline getstates(ca::CompositeAlgorithm) = getfield(ca, :states)


getinc(ca::CompositeAlgorithm) = getfield(ca, :inc)
getoptions(ca::CompositeAlgorithm) = getfield(ca, :options)

getid(ca::Union{CompositeAlgorithm{T,I,NSR,O,R,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,R,id}}}) where {T,I,NSR,O,R,id} = id
setid(ca::CA, id = uuid4()) where CA = setparameter(ca, 6, id)

# setname(ca::CA, name::Symbol) where CA <: CompositeAlgorithm = setparameter(ca, 6, name)
# getname(ca::Union{CompositeAlgorithm{T,I,NSR,O,R,id,CustomName}, Type{<:CompositeAlgorithm{T,I,NSR,O,R,id,CustomName}}}) where {T,I,NSR,O,R,id,CustomName} = CustomName

interval(ca::Union{CompositeAlgorithm{T,I}, Type{<:CompositeAlgorithm{T,I}}}, idx) where {T,I} = I[idx]


###########################################
################ Type Info ###############
###########################################
@inline functypes(ca::Union{CompositeAlgorithm{T,I}, Type{<:CompositeAlgorithm{T,I}}}) where {T,I} = tuple(T.parameters...)
@inline getalgotype(::Union{CompositeAlgorithm{T,I}, Type{<:CompositeAlgorithm{T,I}}}, idx) where {T,I} = T.parameters[idx]
@inline numalgos(::Union{CompositeAlgorithm{T,I}, Type{<:CompositeAlgorithm{T,I}}}) where {T,I} = length(T.parameters)


@inline function intervals(ca::Union{CompositeAlgorithm{T,I}, Type{<:CompositeAlgorithm{T,I}}}) where {T,I}
    if I isa Tuple
        return I
    else
        return ntuple(_ -> 1, length(T.parameters))
    end
end
@inline intervals(ca::Union{CompositeAlgorithm, Type{<:CompositeAlgorithm}}, ::Val{Idx}) where Idx = intervals(ca)[Idx]

get_this_interval(args) = interval(getalgo(args.process), algoidx(args))

function setintervals(ca::C, new_intervals) where {C<:CompositeAlgorithm}
    @assert length(new_intervals) == length(getalgos(ca)) "Length of new intervals must match number of functions in the composite algorithm, but got $(length(new_intervals)) intervals for $(length(getalgos(ca))) functions"
    setparameter(ca, 2, new_intervals)
end

function setinterval(ca::C, idx::Int, new_interval) where {C<:CompositeAlgorithm}
    new_intervals = ntuple(i -> i == idx ? new_interval : interval(ca, i), length(getalgos(ca)))
    setparameter(ca, 2, new_intervals)
end


#######################################
############ Properties ################
########################################
# intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]
# intervals(caT::Type{<:CompositeAlgorithm}) = caT.parameters[2]
get_intervals(ca) = intervals(ca)

hasid(ca::Union{CompositeAlgorithm{T,I,NSR,O,R,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,R,id}}}) where {T,I,NSR,O,R,id} = !isnothing(id)
id(ca::Union{CompositeAlgorithm{T,I,NSR,O,R,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,R,id}}}) where {T,I,NSR,O,R,id} = id



# getnames(ca::CompositeAlgorithm{T, I, N}) where {T, I, N} = N
Base.length(ca::CompositeAlgorithm) = length(getfield(ca, :funcs))
Base.eachindex(ca::CompositeAlgorithm) = eachindex(getfield(ca, :funcs))
getalgo(ca::CompositeAlgorithm, idx) = getfield(ca, :funcs)[idx]
getalgos(ca::CompositeAlgorithm) = getfield(ca, :funcs)
hasflag(ca::CompositeAlgorithm, flag) = flag in getfield(ca, :flags)
track_algo(ca::CompositeAlgorithm) = hasflag(ca, :trackalgo)
"""
Increment the stepidx for the composite algorithm
"""
@inline @generated function inc!(ca::CA) where CA <: CompositeAlgorithm
    _lcm = lcm(intervals(ca)...)
    return quote
        cainc = getinc(ca)
        cainc[] = mod1(cainc[] + 1, $_lcm)
    end
end

function reset!(ca::CA) where CA <: CompositeAlgorithm
    getinc(ca)[] = 1
    reset!.(getalgos(ca))
end

num_funcs(ca::CompositeAlgorithm{FA}) where FA = fieldcount(FA)

# TODO: WHAT IS THIS
type_instances(ca::CompositeAlgorithm{FT}) where FT = getfield(ca, :funcs)
get_funcs(ca::CompositeAlgorithm{FT}) where FT = FT.parameters 

# CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 



# repeats(ca::CompositeAlgorithm) = 1 ./ intervals(ca)
# repeats(ca::CompositeAlgorithm, idx) = 1 / interval(ca, idx)
function multipliers(ca::Union{CompositeAlgorithm, Type{<:CompositeAlgorithm}})
    map(x -> 1/getinterval(x), intervals(ca))
end

multiplier(ca::CompositeAlgorithm, idx) = 1 / getinterval(getalgo(ca, idx))

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]

@inline function getvals(ca::CompositeAlgorithm{FT, Is}) where {FT, Is}
    return Val.(Is)
end

@inline inc(ca::CA) where {CA<:CompositeAlgorithm} = getinc(ca)[]


# CompositeAlgorithm(f, interval::Int, flags...) = CompositeAlgorithm((f,), (interval,), flags...)
