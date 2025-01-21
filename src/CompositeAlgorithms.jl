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
# function next!(ct::CompositeTriggers)
#     ct.lists[ct.listidx] |> next!
#     ct.listidx = mod1(ct.listidx + 1, length(ct.lists))
# end
skiplist!(ct::CompositeTriggers) = ct.listidx = mod1(ct.listidx + 1, length(ct.lists))
thislist(ct::CompositeTriggers) = ct.lists[ct.listidx]
maxtriggers(ct::CompositeTriggers) = length(thislist(ct))
triggeridx(ct::CompositeTriggers) = thislist(ct).idx

# struct CompositeAlgorithm{Functions, Intervals, T} 
    # funcs::T
# end

struct CompositeAlgorithm{FS, Intervals}
    funcs::FS
end

get_funcs(ca::CompositeAlgorithm) = ca.funcs
call_all(tup) = map(f -> f(), tup)

# CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where N = CompositeAlgorithm{Tuple{funcs...}, (intervals), typeof(funcs)}(funcs)
CompositeAlgorithmPA(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where {N} = 
    let funcs = call_all(funcs); CompositeAlgorithm{typeof(funcs), Tuple{intervals...}}(funcs) end


export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 

@inline invokefunc(@specialize(ca::CA), ::Val{idx}, args) where {CA<:CompositeAlgorithm, idx} = ca.funcs[idx](args)
@inline invokeall(@specialize(ca::CA), args) where {CA<:CompositeAlgorithm} = @inline map(f -> (@inline f(args)), ca.funcs)
get_intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]


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

function prepare(c::CompositeAlgorithm, args)
    (;runtime) = args
    functions = get_funcs(c)
    args = (;args...)
    for f in functions
        getargs = prepare(f, args)
        if !isnothing(getargs)
            args = (;args..., getargs...)
        end
    end
    return args
end

function intervalled_step_exp(runtime, ca::Type{<:CompositeAlgorithm})
    q = quote 
        (;proc) = args
        @$
    end

    println(q)
    for (fidx, functype) in enumerate(get_functions(ca))
        f = functype
        interval = get_intervals(ca)
        push!(q.args, generate_intervalled_algo(f, interval[fidx]))
    end
    # push!(q.args, :(inc(proc)))
    return q
end

@inline @generated function intervalled_step(runtime, @specialize(ca::CompositeAlgorithm), @specialize(args))
    return intervalled_step_exp(runtime, ca)
end

function generate_invokes(ca, idx, interval)
    if interval != 1
        return quote
            if loopidx(proc) % $interval == 0
                @inline invokefunc(func, Val($idx), args)
            end
        end
    else
        return quote
            @inline invokefunc(func, Val($idx), args)
        end
    end

end

function generate_intervalled_algo(f, interval)
    if interval != 1
        return quote
            # if @inline shouldtrigger(triggers, loopidx(proc))
            if loopidx(proc) % $interval == 0
                @inline $f(args)
                # inc!(triggers)
            end
            # skiplist!(triggers)
        end
    else
        return quote
            @inline $f(args)
            # skiplist!(triggers)
        end
    end
end

function iserror(func, arg)
    try
        func(arg)
        return false
    catch
        return true
    end
end

cleanup(func::Any, ::Any) = nothing

function processloop(@specialize(p), @specialize(func::CompositeAlgorithm), @specialize(args), rp::Repeat{repeats}) where repeats
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        # @inline comp_dispatch(func, args)
        # @inline comp_gen(func, args)
        @inline invokeall(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end

@inline @generated function comp_gen(@specialize(func), @specialize(args))
    return comp_gen_exp(func, args)
end

function comp_gen_exp(::Type{CompositeAlgorithm{FS,Is}}, args) where {FS, Is}
    allfuncs = quote 
        (;proc) = args
    end
    intervals = tupletype_to_tuple(Is)
    for fidx in 1:length(intervals)
        # push!(allfuncs.args, generate_intervalled_algo(FS[fidx], intervals[fidx]))
        push!(allfuncs.args, generate_invokes(CompositeAlgorithm{FS,Is}, fidx, intervals[fidx]))
    end
    return allfuncs
end

@inline function comp_dispatch(@specialize(func::CompositeAlgorithm{Fs,I}), args) where {Fs,I}
    @inline _comp_dispatch(gethead(Fs), typeheadval(I), gettail(Fs), typetail(I), args)
end

@inline function _comp_dispatch(@specialize(thisfunc), ::Val{I}, @specialize(funcs), intervals, args) where I
    if I == 1
        @inline thisfunc(args)
    else
        (;proc) = args
        if loopidx(proc) % I == 0
            @inline thisfunc(args)
        end
    end
    @inline _comp_dispatch(gethead(funcs), typehead(intervals), gettail(funcs), typetail(intervals), args)

end

@inline _comp_dispatch(::Nothing, ::Any, ::Any, ::Any, args) = nothing

# function typeloop(@specialize(p), @specialize(func::CompositeAlgorithm), @specialize(args), rp::Repeat{repeats}) where repeats
#     set_starttime!(p)
#     for i in 1:repeats
#         if !run(p)
#             break
#         end
#         @inline typeloop_step(func, args)
#         inc!(p)
#         GC.safepoint()
#     end
#     set_endtime!(p)
#     cleanup(func, args)
# end

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfunc(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]

@inline function typeloop_step(func::CompositeAlgorithm{T,I}, args) where {T,I}
    for idx in 1:numfuncs(func)
        _typeloop_step(getfunc(func,idx), Val(getinterval(func,idx)), args)
    end
end

@inline function _typeloop_step(f, interval::Val{N}, args) where N
    if N == 1
        f(args)
    else
        (;proc) = args
        if loopidx(proc) % N == 0
            f(args)
        end
    end
end

function unrollloop(@specialize(p), @specialize(func::CompositeAlgorithm), @specialize(args), rp::Repeat{repeats}) where repeats
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline unroll_step(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end
export unrollloop

function unroll_step(func::CompositeAlgorithm{T,I}, args) where {T,I}
    _unroll_step(typehead(T), headval(I), typetail(T), gettail(I), args)
end

@inline function _unroll_step(@specialize(funchead), intervalhead::Val{N}, functail, intervaltail, args) where N
    if N == 1
        funchead(args)
    else
        (;proc) = args
        if loopidx(proc) % N == 0
            funchead(args)
        end
    end
    _unroll_step(typehead(functail), headval(intervaltail), typetail(functail), gettail(intervaltail), args)
end

@inline _unroll_step(::Nothing, ::Any, ::Any, ::Any, args) = nothing

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






##### TEST with type

struct CompositeAlgorithmType{FT, Intervals, T} 
    funcs::T
end

# get_funcs(ca::CompositeAlgorithmType{FT}) where FT = FT.parameters
get_func_types(ca::CompositeAlgorithmType{FT}) where FT = FT.parameters
get_funcs(ca::CompositeAlgorithmType) = ca.funcs

@inline function getvals(ca::CompositeAlgorithmType{FT, Interval}) where {FT, Interval <: DataType}
    return (Val.(Interval.parameters)...,)
end

@inline function getvals_tup(ca::CompositeAlgorithmType{FT, Is}) where {FT, Is}
    return Val.(Is)
end


CompositeAlgorithmType(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where N = CompositeAlgorithmType{Tuple{funcs...}, Tuple{intervals...}, typeof(funcs)}(funcs)
CompositeAlgorithmTypeInt(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where N = CompositeAlgorithmType{Tuple{funcs...}, (intervals...,), typeof(funcs)}(funcs)

export CompositeAlgorithmType

function mapunroll(@specialize(func::CompositeAlgorithmType{F,I}), args) where {F,I}
    @inline map((f, interval) -> _mapunroll(f, interval, args), get_funcs(func), getvals(func))
end

function _mapunroll(@specialize(f), interval::Val{N}, args) where N
    if N == 1
        @inline f(args)
    else
        (;proc) = args
        if loopidx(proc) % N == 0
            @inline f(args)
        end
    end
end


function prepare(f::CompositeAlgorithmType, args)
    (;runtime) = args
    functions = get_func_types(f)
    args = (;args...)
    for func in functions
        getargs = prepare(func, args)
        if !isnothing(getargs)
            args = (;args..., getargs...)
        end
    end
    return args
end

function processloop(@specialize(p), @specialize(func::CompositeAlgorithmType), @specialize(args), rp::Repeat{repeats}) where repeats
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline comp_type_dispatch(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end

function maploop(@specialize(p), @specialize(func::CompositeAlgorithmType), @specialize(args), rp::Repeat{repeats}) where repeats
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline mapunroll(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end

@inline function comp_type_dispatch(@specialize(func::CompositeAlgorithmType{Fs,I}), args) where {Fs,I}
    @inline _comp_type_dispatch(typehead(Fs), typeheadval(I), typetail(Fs), typetail(I), args)
end
@inline function _comp_type_dispatch(@specialize(thisfunc), ::Val{I}, @specialize(funcs), intervals, args) where I
    if I == 1
        @inline thisfunc(args)
    else
        (;proc) = args
        if loopidx(proc) % I == 0
            @inline thisfunc(args)
        end
    end
    @inline _comp_type_dispatch(typehead(funcs), typeheadval(intervals), typetail(funcs), typetail(intervals), args)
end

# @inline _comp_type_dispatch(::Nothing, ::Val{I}, ::Any, ::Any, ::Any) where I = nothing
@inline _comp_type_dispatch(::Nothing, ::Any, ::Any, ::Any, ::Any) = nothing

function typeloop(@specialize(p), @specialize(func::CompositeAlgorithmType), @specialize(args), rp::Repeat{repeats}) where repeats
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline typeloop_step(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end
export typeloop

@generated function typeloop_step(func::CompositeAlgorithmType{T,I}, args) where {T,I}
    return typeloop_step_exp(func, args)
end

function typeloop_step_exp(func::Type{CompositeAlgorithmType{T,I,F}}, args) where {T,I,F}
    allfuncs = quote 
        (;proc) = args
    end
    for (fidx,f) in enumerate(T.parameters)
        this_interval = I.parameters[fidx]
        push!(allfuncs.args, algo_with_rem_exp(f, this_interval))
    end
    return allfuncs
end

function algo_with_rem_exp(f, interval)
    if interval != 1
        return quote
            if loopidx(proc) % $interval == 0
                @inline $f(args)
            end
        end
    else
        return quote
            @inline $f(args)
        end
    end
end



### With non Tuple type for intervals

function processloop_int(@specialize(p), @specialize(func::CompositeAlgorithmType{F,I}), @specialize(args), rp::Repeat{repeats}) where {F,I,repeats}
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline comp_type_dispatch_int(func, args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
    cleanup(func, args)
end

function comp_type_dispatch_int(@specialize(func::CompositeAlgorithmType{Fs,I}), args) where {Fs,I}
    @inline _comp_type_dispatch_int(typehead(Fs), headval(I), typetail(Fs), gettail(I), args)
end

function _comp_type_dispatch_int(@specialize(thisfunc), interval::Val{I}, @specialize(funcs), intervals, args) where I
    if I == 1
        @inline thisfunc(args)
    else
        (;proc) = args
        if loopidx(proc) % I == 0
            @inline thisfunc(args)
        end
    end
    @inline _comp_type_dispatch_int(typehead(funcs), headval(intervals), typetail(funcs), gettail(intervals), args)
end

_comp_type_dispatch_int(::Nothing, ::Any, ::Any, ::Any, args) = nothing
# _comp_type_dispatch_int(::Nothing, ::Nothing, ::Any, ::Any, args) = nothing

