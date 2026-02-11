#AlgoTracker
export inc!, nextalgo!, intervals, interval
export CompositeAlgorithm
struct CompositeAlgorithm{T, Intervals, NSR, O, id, CustomName} <: LoopAlgorithm
    funcs::T
    inc::Base.RefValue{Int} # To track the intervals
    registry::NSR
    options::O
end

getmultipliers_from_specification_num(::Type{<:CompositeAlgorithm}, specification_num) = 1 ./(Float64.(specification_num))


function CompositeAlgorithm(funcs::NTuple{N, Any}, 
                            intervals::NTuple{N, Real} = ntuple(_ -> 1, N), 
                            options::Union{Share, Route, ProcessState, Type{<:ProcessState}}...; id = nothing, customname = Symbol()) where {N}
    (;functuple, registry, options) = setup(CompositeAlgorithm, funcs, intervals, options...)
    if all(x -> x == 1, intervals)
        intervals = RepeatOne() # Set to simpleAlgo
    end
    if any(x -> x isa CompositeAlgorithm, functuple) # Flatten nested composites
        functuple, intervals = flatten_comp_funcs(functuple, intervals)    
    end

    if intervals isa Tuple
        intervals = Int.(intervals)
    end
    CompositeAlgorithm{typeof(functuple), intervals, typeof(registry), typeof(options), nothing, customname}(functuple, Ref(1), registry, options)
end

function newfuncs(ca::CompositeAlgorithm, funcs)
    # CompositeAlgorithm{typeof(funcs), intervals(ca), typeof(ca.registry), typeof(ca.options)}(funcs, ca.inc, ca.registry , ca.options)
    setfield(ca, :funcs, funcs)
end

subalgorithms(ca::CompositeAlgorithm) = ca.funcs
subalgotypes(ca::CompositeAlgorithm{FT}) where FT = FT.parameters
subalgotypes(caT::Type{<:CompositeAlgorithm{FT}}) where FT = FT.parameters

getinc(ca::CompositeAlgorithm) = ca.inc
getoptions(ca::CompositeAlgorithm) = ca.options

getid(ca::Union{CompositeAlgorithm{T,I,NSR,O,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = id
setid(ca::CA, id = uuid4()) where CA = setparameter(ca, 5, id)

setname(ca::CA, name::Symbol) where CA <: CompositeAlgorithm = setparameter(ca, 6, name)
getname(ca::Union{CompositeAlgorithm{T,I,NSR,O,id,CustomName}, Type{<:CompositeAlgorithm{T,I,NSR,O,id,CustomName}}}) where {T,I,NSR,O,id,CustomName} = CustomName

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
    @assert length(new_intervals) == length(ca.funcs)
    setparameter(ca, 2, new_intervals)
end

function setinterval(ca::C, idx::Int, new_interval) where {C<:CompositeAlgorithm}
    new_intervals = ntuple(i -> i == idx ? new_interval : interval(ca, i), length(ca.funcs))
    setparameter(ca, 2, new_intervals)
end


#######################################
############ Properties ################
########################################
# intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]
# intervals(caT::Type{<:CompositeAlgorithm}) = caT.parameters[2]
get_intervals(ca) = intervals(ca)

hasid(ca::Union{CompositeAlgorithm{T,I,NSR,O,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = !isnothing(id)
id(ca::Union{CompositeAlgorithm{T,I,NSR,O,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = id



# getnames(ca::CompositeAlgorithm{T, I, N}) where {T, I, N} = N
Base.length(ca::CompositeAlgorithm) = length(ca.funcs)
Base.eachindex(ca::CompositeAlgorithm) = Base.eachindex(ca.funcs)
getalgo(ca::CompositeAlgorithm, idx) = ca.funcs[idx]
getalgos(ca::CompositeAlgorithm) = ca.funcs
hasflag(ca::CompositeAlgorithm, flag) = flag in ca.flags
track_algo(ca::CompositeAlgorithm) = hasflag(ca, :trackalgo)
"""
Increment the stepidx for the composite algorithm
"""
@generated function inc!(ca::CompositeAlgorithm)
    _max = max(intervals(ca)...)
    return :(ca.inc[] = mod1(ca.inc[] + 1, $_max))
end
function reset!(ca::CompositeAlgorithm)
    ca.inc[] = 1
    reset!.(ca.funcs)
end


# Change the names
setnames(ca::CompositeAlgorithm{T,Int}, names::NTuple{N, Symbol}) where {T,N} = CompositeAlgorithm{T,Int,names}(ca.funcs, ca.inc, ca.flags)


export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

num_funcs(ca::CompositeAlgorithm{FA}) where FA = fieldcount(FA)

type_instances(ca::CompositeAlgorithm{FT}) where FT = ca.funcs
get_funcs(ca::CompositeAlgorithm{FT}) where FT = FT.parameters 

# CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 



# repeats(ca::CompositeAlgorithm) = 1 ./ intervals(ca)
# repeats(ca::CompositeAlgorithm, idx) = 1 / interval(ca, idx)
multipliers(ca::CompositeAlgorithm) = 1 ./ intervals(ca)
multipliers(caT::Type{<:CompositeAlgorithm}) = 1 ./ intervals(caT)
multiplier(ca::CompositeAlgorithm, idx) = 1 / interval(ca, idx)

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]

@inline function getvals(ca::CompositeAlgorithm{FT, Is}) where {FT, Is}
    return Val.(Is)
end

inc(ca::CompositeAlgorithm) = ca.inc[]


# CompositeAlgorithm(f, interval::Int, flags...) = CompositeAlgorithm((f,), (interval,), flags...)
