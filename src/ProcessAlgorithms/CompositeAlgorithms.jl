#AlgoTracker
export inc!, nextalgo!
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
                            options::Union{Share, Route, ProcessState}...; id = nothing, customname = Symbol()) where {N}
    (;functuple, registry, options) = setup(CompositeAlgorithm, funcs, intervals, options...)
    if all(x -> x == 1, intervals)
        intervals = RepeatOne() # Set to simpleAlgo
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

function intervals(ca::Union{CompositeAlgorithm{T,I}, Type{<:CompositeAlgorithm{T,I}}}) where {T,I}
    if I isa Tuple
        return I
    else
        return ntuple(_ -> 1, length(T.parameters))
    end
end
get_this_interval(args) = interval(getfunc(args.process), algoidx(args))

function setintervals(ca::C, new_intervals) where {C<:CompositeAlgorithm}
    @assert length(new_intervals) == length(ca.funcs)
    setparameter(ca, 2, new_intervals)
end

function setinterval(ca::C, idx::Int, new_interval) where {C<:CompositeAlgorithm}
    new_intervals = ntuple(i -> i == idx ? new_interval : interval(ca, i), length(ca.funcs))
    setparameter(ca, 2, new_intervals)
end

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfuncname(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]



#######################################
############ Properties ################
########################################
intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]
intervals(caT::Type{<:CompositeAlgorithm}) = caT.parameters[2]
get_intervals(ca) = intervals(ca)

hasid(ca::Union{CompositeAlgorithm{T,I,NSR,O,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = !isnothing(id)
id(ca::Union{CompositeAlgorithm{T,I,NSR,O,id}, Type{<:CompositeAlgorithm{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = id



# getnames(ca::CompositeAlgorithm{T, I, N}) where {T, I, N} = N
Base.length(ca::CompositeAlgorithm) = length(ca.funcs)
Base.eachindex(ca::CompositeAlgorithm) = Base.eachindex(ca.funcs)
getfunc(ca::CompositeAlgorithm, idx) = ca.funcs[idx]
getfuncs(ca::CompositeAlgorithm) = ca.funcs
hasflag(ca::CompositeAlgorithm, flag) = flag in ca.flags
track_algo(ca::CompositeAlgorithm) = hasflag(ca, :trackalgo)
"""
Increment the stepidx for the composite algorithm
"""
@generated function inc!(ca::CompositeAlgorithm)
    _max = max(ca.parameters[2]...)
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



### STEP
"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C) where {T,Is,C<:AbstractContext}
    algoidx = 1
    this_inc = inc(ca)
    return @inline _comp_dispatch(ca, context::C, algoidx, this_inc, gethead(ca.funcs), gettail(ca.funcs))
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
Base.@constprop :aggressive @inline function _comp_dispatch(ca::CompositeAlgorithm{T,Is}, context::C, algoidx::Int, this_inc::Int, thisfunc::TF, funcs) where {T, Is, TF,C<:AbstractContext}
    if isnothing(thisfunc)
        inc!(ca)
        GC.safepoint()
        return context
    end
    if interval(ca, algoidx) == 1
        context = step!(thisfunc, context)
    else
        if this_inc % interval(ca, algoidx) == 0
            context = step!(thisfunc, context)
        end
    end
    return @inline _comp_dispatch(ca, context, algoidx + 1, this_inc, gethead(funcs), gettail(funcs))
end

