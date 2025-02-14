#AlgoTracker
export AlgoTracker, inc!, algoidx, nextalgo!
export CompositeAlgorithm, prepare, loopexp

mutable struct AlgoTracker{N}
    num::Int
end
AlgoTracker(N) = AlgoTracker{N}(1)

inc!(at::AlgoTracker{N}) where N = at.num = mod1(at.num + 1, N)
algoidx(at::AlgoTracker) = at.num

nextalgo!(args::NamedTuple) = inc!(args.algotracker)
algoidx(args::NamedTuple) = algoidx(args.algotracker)
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

"""
Get the number of the function currently being prepared
"""
algoidx(args) = algoidx(args.algotracker)

get_this_interval(args) = getinterval(getfunc(args.proc), algoidx(args))

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfuncname(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]
iterval(ca::CompositeAlgorithm, idx) = getinterval(ca, idx)

algo_loopidx(args) = loopidx(args.proc) ÷ args.interval
export algo_loopidx

CompositeAlgorithm(f, interval::Int, flags...) = CompositeAlgorithm((f,), (interval,), flags...)

function CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Int} = ntuple(_ -> 1, N), flags::Symbol...) where {N}
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
    allintervals = tuple(Int.(allintervals)...)
    CompositeAlgorithm{typeof(tfuncs), allintervals}(tfuncs, 1, set)
end



# function prepare(f::CompositeAlgorithm, args::NamedTuple)
#     _num_funcs = num_funcs(f)

#     #Trick to get the number of the function currently being prepared
#     args = (;args..., func = f, algotracker = AlgoTracker(_num_funcs))

#     # Get the type insances, such that the prepare functions can be defined
#     # as prepare(::TypeName, args)
#     functions = type_instances(f)

#     args = (;args..., algotracker = AlgoTracker(_num_funcs))
#     for func in functions
#         args = (;args..., prepare(func, args)...)

#         @inline nextalgo!(args)
#     end

#     if !hasflag(f, :trackalgo)
#         args = deletekeys(args, :algotracker)
#     end

#     return args
# end

# function cleanup(f::CompositeAlgorithm, args)
#     functions = type_instances(f)
#     for func in functions
#         args = (;args..., cleanup(func, args)...)
#     end
#     return args
# end

@inline function (ca::CompositeAlgorithm{Fs,I})(@specialize(args)) where {Fs,I}
    algoidx = 1
    @inline _comp_dispatch(ca, gethead(ca.funcs), headval(I), gettail(ca.funcs), gettail(I), (;args..., algoidx, interval = gethead(I)))
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
            @inline thisfunc(args)
        end
    end
    if haskey(args, :algotracker)
        nextalgo!(args)
    end
    @inline _comp_dispatch(ca, gethead(funcs), headval(intervals), gettail(funcs), gettail(intervals), (;args..., algoidx = args.algoidx + 1, interval = gethead(intervals)))
end

function _comp_dispatch(ca::CompositeAlgorithm, ::Nothing, ::Any, ::Any, ::Any, args)
    inc!(ca)
    GC.safepoint()
    return nothing
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