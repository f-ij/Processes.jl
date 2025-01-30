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
struct CompositeAlgorithm{FT, Intervals, T} 
    funcs::T
    flags::Set{Symbol}
end

function CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Int} = ntuple(_ -> 1, N), flags::Symbol...) where {N}
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    CompositeAlgorithm{Tuple{funcs...}, (intervals), typeof(funcs)}(funcs, set)
end

hasflag(ca::CompositeAlgorithm, flag) = flag in ca.flags
track_algo(ca::CompositeAlgorithm) = hasflag(ca, :trackalgo)

export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

num_funcs(ca::CompositeAlgorithm{FA}) where FA = fieldcount(FA)

type_instances(::CompositeAlgorithm{FT}) where FT = call_all(FT.parameters)
# type_instances(::CompositeAlgorithm{FT, I, T}) where {FT, I, T} = T
get_funcs(ca::CompositeAlgorithm) = ca.funcs


CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 
get_intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]



@inline function getvals(ca::CompositeAlgorithm{FT, Is}) where {FT, Is}
    return Val.(Is)
end

"""
Get the number of the function currently being prepared
"""
algoidx(args) = algoidx(args.algotracker)

get_this_interval(args) = getinterval(getfunc(args.proc), algoidx(args))

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfunc(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]

algo_loopidx(args) = loopidx(args.proc) ÷ args.interval
export algo_loopidx



function prepare(f::CompositeAlgorithm, args)
    (;lifetime) = args

    _num_funcs = num_funcs(f)

    #Trick to get the number of the function currently being prepared
    args = (;args..., func = f, algotracker = AlgoTracker(_num_funcs))

    # Get the type insances, such that the prepare functions can be defined
    # as prepare(::TypeName, args)
    functions = type_instances(f)

    args = (;args...)
    for func in functions
        getargs = prepare(func, args)
        if !isnothing(getargs)
            args = (;args..., getargs...)
        end

        @inline nextalgo!(args)
    end

    if !hasflag(f, :trackalgo)
        args = deletekeys(args, :algotracker)
    end

    return args
end

function cleanup(f::CompositeAlgorithm, args)
    functions = type_instances(f)
    for func in functions
        args = (;args..., cleanup(func, args)...)
    end
    return args
end


function processloop(@specialize(p), @specialize(func::CompositeAlgorithm{F,I}), @specialize(args), rp::Repeat{repeats}) where {F,I,repeats}
    before_while(p)
    for _ in loopidx(p):repeats
        if !run(p)
            break
        end
        @inline comp_dispatch(func, args)
        @inline inc!(p)
        GC.safepoint()
    end
    after_while(p)
    return cleanup(func, args)
end

function processloop(@specialize(p), @specialize(func::CompositeAlgorithm{F,I}), @specialize(args), ::Indefinite) where {F,I}
    before_while(p)
    while run(p)
        @inline comp_dispatch(func, args)
        inc!(p)
        GC.safepoint()
    end
    after_while(p)
    return cleanup(func, args)
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
@inline function comp_dispatch(@specialize(func::CompositeAlgorithm{Fs,I}), args) where {Fs,I}
    algoidx = 1
    @inline _comp_dispatch(typehead(Fs), headval(I), typetail(Fs), gettail(I), (;args..., algoidx, interval = gethead(I)))
end

function _comp_dispatch(@specialize(thisfunc), interval::Val{I}, @specialize(funcs), intervals, args) where I
    if I == 1
        @inline thisfunc(args)
    else
        (;proc) = args
        if loopidx(proc) % I == 0
            @inline thisfunc(args)
        end
    end
    if haskey(args, :algotracker)
        nextalgo!(args)
    end
    @inline _comp_dispatch(typehead(funcs), headval(intervals), typetail(funcs), gettail(intervals), (;args..., algoidx = args.algoidx + 1, interval = gethead(intervals)))
end

_comp_dispatch(::Nothing, ::Any, ::Any, ::Any, args) = nothing



@inline function typehead(t::Type{T}) where T<:Tuple
    Base.tuple_type_head(T)
end

@inline typehead(::Type{Tuple{}}) = nothing

@inline function typeheadval(t::Type{T}) where T<:Tuple
    Val(typehead(t))
end

@inline typeheadval(::Type{Tuple{}}) = nothing

@inline function typetail(t::Type{T}) where T<:Tuple
    Base.tuple_type_tail(T)
end

@inline typetail(t::Type{Tuple{}}) = nothing

@inline function headval(t::Tuple)
    Val(Base.first(t))
end

@inline headval(::Tuple{}) = nothing

@inline gethead(t::Tuple) = Base.first(t)
@inline gethead(::Tuple{}) = nothing

@inline gettail(t::Tuple) = Base.tail(t)
@inline gettail(::Tuple{}) = nothing


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


