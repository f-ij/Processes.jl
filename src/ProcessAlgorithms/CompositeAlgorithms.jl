#AlgoTracker
export inc!, nextalgo!
export CompositeAlgorithm, prepare, loopexp
mutable struct CompositeAlgorithm{T, Intervals} <: ProcessLoopAlgorithm
    const funcs::T
    inc_tracker::Int
    const flags::Set{Symbol}
end

Base.length(ca::CompositeAlgorithm) = length(ca.funcs)
Base.eachindex(ca::CompositeAlgorithm) = Base.eachindex(ca.funcs)
getfunc(ca::CompositeAlgorithm, idx) = ca.funcs[idx]
getfuncs(ca::CompositeAlgorithm) = ca.funcs
hasflag(ca::CompositeAlgorithm, flag) = flag in ca.flags
track_algo(ca::CompositeAlgorithm) = hasflag(ca, :trackalgo)
"""
Increment the stepidx for the composite algorithm
"""
inc!(ca::CompositeAlgorithm) = ca.inc_tracker += 1
function reset!(ca::CompositeAlgorithm)
    ca.inc_tracker = 1
    reset!.(ca.funcs)
end

export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

num_funcs(ca::CompositeAlgorithm{FA}) where FA = fieldcount(FA)

type_instances(ca::CompositeAlgorithm{FT}) where FT = ca.funcs
get_funcs(ca::CompositeAlgorithm{FT}) where FT = FT.parameters 

CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 
intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]
get_intervals(ca) = intervals(ca)
repeats(ca::CompositeAlgorithm) = 1 ./ intervals(ca)
repeats(ca::CompositeAlgorithm, idx) = 1 / getinterval(ca, idx)

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]

@inline function getvals(ca::CompositeAlgorithm{FT, Is}) where {FT, Is}
    return Val.(Is)
end

inc_tracker(ca::CompositeAlgorithm) = ca.inc_tracker

get_this_interval(args) = getinterval(getfunc(args.proc), algoidx(args))

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfuncname(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]
iterval(ca::CompositeAlgorithm, idx) = getinterval(ca, idx)

algo_loopidx(args) = loopidx(args.proc) ÷ args.interval
export algo_loopidx

CompositeAlgorithm(f, interval::Int, flags...) = CompositeAlgorithm((f,), (interval,), flags...)

function CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Real} = ntuple(_ -> 1, N), flags::Symbol...) where {N}
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    allfuncs = Any[]
    allintervals = Int[]
    for (func_idx, func) in enumerate(funcs)
  
        if func isa Type
            func = func()
        end

        if func isa Routine # To track the starts
            func = deepcopy(func)
        end

        if func isa CompositeAlgorithm # Then splat the functions
            for cfunc_idx in eachindex(func)
                I = intervals[func_idx]
                push!(allfuncs, getfunc(func, cfunc_idx))
                push!(allintervals, getinterval(func, cfunc_idx*intervals[func_idx]))
            end
        else
            I = intervals[func_idx]
            push!(allfuncs, func)
            push!(allintervals, I)
        end
    end
    tfuncs = tuple(allfuncs...)
    allintervals = tuple(floor.(Int, allintervals)...)
    CompositeAlgorithm{typeof(tfuncs), allintervals}(tfuncs, 1, set)
end

@inline function (ca::CompositeAlgorithm{Fs,I})(@specialize(args)) where {Fs,I}
    algoidx = 1
    return @inline _comp_dispatch(ca, gethead(ca.funcs), headval(I), gettail(ca.funcs), gettail(I), (;args..., algoidx, interval = gethead(I)))
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
function _comp_dispatch(ca::CompositeAlgorithm, @specialize(thisfunc), interval::Val{I}, @specialize(funcs), intervals, args) where I
    if I == 1
        @inline thisfunc(args)
    else
        if inc_tracker(ca) % I == 0
            returnval = @inline thisfunc(args)
            if !isnothing(returnval)
                args = (;args..., returnval)
            end
        end
    end
    return @inline _comp_dispatch(ca, gethead(funcs), headval(intervals), gettail(funcs), gettail(intervals), (;args..., algoidx = args.algoidx + 1, interval = gethead(intervals)))
end

function _comp_dispatch(ca::CompositeAlgorithm, ::Nothing, ::Any, ::Any, ::Any, args)
    (;proc) = args
    inc!(ca)
    inc!(proc)
    GC.safepoint()
    return (;)
end

##
function compute_triggers(ca::CompositeAlgorithm{F, Intervals}, ::Repeat{repeats}) where {F, Intervals, repeats}
    triggers = ((InitTriggerList(interval) for interval in Intervals)...,)
    for i in 1:repeats
        for (i_idx, interval) in enumerate(Intervals)
            if i % interval == 0
                push!(triggers[i_idx].triggers, i)
            end
        end
    end
    return CompositeTriggers(triggers)
end




# SHOWING
function Base.show(io::IO, ca::CompositeAlgorithm)
    indentio = NextIndentIO(io, VLine(), "Composite Algorithm")
    _intervals = intervals(ca)
    q_postfixes(indentio, ("\texecuting every $interval time(s)" for interval in _intervals)...)
    for thisfunc in ca.funcs
        if thisfunc isa CompositeAlgorithm || thisfunc isa Routine
            invoke(show, Tuple{IO, typeof(thisfunc)}, next(indentio), thisfunc)
        else
            invoke(show, Tuple{IndentIO, Any}, next(indentio), thisfunc)
        end
    end
end