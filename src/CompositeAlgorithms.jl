export CompositeAlgorithm, prepare, loopexp, 
    TriggerList, AlwaysTrigger, TriggerList, 
    CompositeTriggers, InitTriggerList, peeknext, next!, skiplist!, thislist, maxtriggers, triggeridx

mutable struct TriggerList{Always}
    const triggers::Vector{Int}
    idx::Int
end

TriggerList() = TriggerList{false}([], 1)

AlwaysTrigger() = TriggerList{true}([], 1)
TriggerList(v::Vector{Int}) = TriggerList{false}(v, 1)


InitTriggerList(interval) = interval == 1 ? AlwaysTrigger() : TriggerList()

Base.length(tl::TriggerList) = length(tl.triggers)
Base.size(tl::TriggerList) = size(tl.triggers)
isfinished(tl::TriggerList) = tl.idx > length(tl.triggers)


peeknext(tl::TriggerList) = tl.triggers[tl.idx]

next!(tl::TriggerList) = tl.idx += 1
next!(tl::TriggerList{true}) = nothing

mutable struct CompositeTriggers{N, TL}
    const lists::TL
    listidx::Int
end

Base.getindex(ct::CompositeTriggers, i) = ct.lists[i]

CompositeTriggers(lists) = CompositeTriggers{length(lists), typeof(lists)}(lists, 1)
inc!(ct::CompositeTriggers) = ct.lists[ct.listidx] |> next!

@inline peeknext(ct::CompositeTriggers) = ct.lists[ct.listidx] |> peeknext
function shouldtrigger(ct::CompositeTriggers, loopidx)
    if thislist(ct) |> isfinished
        return false
    end
    return peeknext(ct) == loopidx
end

skiplist!(ct::CompositeTriggers) = ct.listidx = mod1(ct.listidx + 1, length(ct.lists))
thislist(ct::CompositeTriggers) = ct.lists[ct.listidx]
maxtriggers(ct::CompositeTriggers) = length(thislist(ct))
triggeridx(ct::CompositeTriggers) = thislist(ct).idx
struct CompositeAlgorithm{FT, Intervals, T} 
    funcs::T
end

CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where {N} = CompositeAlgorithm{Tuple{funcs...}, (intervals), typeof(funcs)}(funcs)

export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

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
prepare_number(args) = args.preparing_algo_num[]

get_this_interval(args) = getinterval(getfunc(args.proc), prepare_number(args))


function prepare(f::CompositeAlgorithm, args)
    (;lifetime) = args

    #Trick to get the number of the function currently being prepared
    args = (;args..., preparing_algo_num = Ref(1))

    # Get the type insances, such that the prepare functions can be defined
    # as prepare(::TypeName, args)
    functions = type_instances(f)

    args = (;args...)
    for func in functions
        getargs = prepare(func, args)
        if !isnothing(getargs)
            args = (;args..., getargs...)
        end

        args.preparing_algo_num[] += 1
    end

    # Delete the preparing_algo_num key
    args = deletekeys(args, :preparing_algo_num)

    return args
end


function processloop(@specialize(p), @specialize(func::CompositeAlgorithm{F,I}), @specialize(args), rp::Repeat{repeats}) where {F,I,repeats}
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline comp_dispatch(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end

function comp_dispatch(@specialize(func::CompositeAlgorithm{Fs,I}), args) where {Fs,I}
    @inline _comp_dispatch(typehead(Fs), headval(I), typetail(Fs), gettail(I), args)
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
    @inline _comp_dispatch(typehead(funcs), headval(intervals), typetail(funcs), gettail(intervals), args)
end

_comp_dispatch(::Nothing, ::Any, ::Any, ::Any, args) = nothing

"""
Fallback cleanup
"""
cleanup(func::Any, ::Any) = nothing

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfunc(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]


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
####Triggers
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

# _comp_type_dispatch_int(::Nothing, ::Nothing, ::Any, ::Any, args) = nothing

