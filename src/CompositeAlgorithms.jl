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

struct CompositeAlgorithm{Functions, Intervals} end

CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where N = CompositeAlgorithm{Tuple{funcs...}, intervals}()

get_functions(ca::C) where {C<:CompositeAlgorithm} = C.parameters[1].parameters
get_intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]

get_functions(ct::Type{<:CompositeAlgorithm}) = ct.parameters[1].parameters
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
    # prepare triggers, or not
    if runtime isa Repeat
        triggers = compute_triggers(c, runtime)
        args = (;args..., triggers)
    end
    functions = get_functions(c)
    for f in functions
        args = (;args..., prepare(f, args)...)
        skiplist!(triggers)
    end
    return args
end

function intervalled_step_exp(runtime, ca::Type{<:CompositeAlgorithm})
    q = quote 
        (;proc, triggers) = args
    end
    for (fidx, functype) in enumerate(get_functions(ca))
        f = functype
        interval = get_intervals(ca)
        push!(q.args, generate_intervalled_algo(f, interval[fidx]))
    end
    # push!(q.args, :(inc(proc)))
    return q
end

@generated function intervalled_step(runtime, @specialize(ca::CompositeAlgorithm), @specialize(args))
    return intervalled_step_exp(runtime, ca)
end


function generate_intervalled_algo(f, interval)
    if interval != 1
        return quote
            if @inline shouldtrigger(triggers, loopidx(proc))
                @inline $f(args)
                inc!(triggers)
            end
            skiplist!(triggers)
        end
    else
        return quote
            @inline $f(args)
            skiplist!(triggers)
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
        @inline intervalled_step(rp, func, args)
        inc!(p)
    end
    set_endtime!(p)
    cleanup(func, args)
end

function unrollloop(@specialize(p), @specialize(func::CompositeAlgorithm), @specialize(args), rp::Repeat{repeats}) where repeats
    set_starttime!(p)
    for i in 1:repeats
        if !run(p)
            break
        end
        @inline unroll_step(func, args)
        inc!(p)
    end
    set_endtime!(p)
    cleanup(func, args)
end
export unrollloop

# function unroll_step(func::CompositeAlgorithm{T,I}, args) where {T,I}
#     _unroll_step(typehead(T), typeheadval(I), typetail(T), typetail(I), args)
# end

# @inline function _unroll_step(@specialize(funchead), intervalhead::Val{N}, functail, intervaltail, args) where N
#     if N == 1
#         funchead(args)
#     else
#         (;proc) = args
#         if loopdidx(proc) % N == 0
#             funchead(args)
#         end
#     end
#     _unroll_step(typehead(functail), typeheadval(intervaltail), typetail(functail), typetail(intervaltail), args)
# end


function unroll_step(func::CompositeAlgorithm{T,I}, args) where {T,I}
    _unroll_step(typehead(T), headval(I), typetail(T), gettail(I), args)
end

@inline function _unroll_step(@specialize(funchead), @specialize(intervalhead::Val{N}), functail, intervaltail, args) where N
    if N == 1
        @inline funchead(args)
    else
        (;proc) = args
        if loopidx(proc) % N == 0
            @inline funchead(args)
        end
    end
    _unroll_step(typehead(functail), headval(intervaltail), typetail(functail), gettail(intervaltail), args)
end

_unroll_step(::Nothing, ::Any, ::Any, ::Any, args) = nothing

@inline function typehead(t::Type{T}) where T<:Tuple
    Base.tuple_type_head(T)
end

@inline typehead(::Type{Tuple{}}) = nothing

@inline function typeheadval(t::Type{T}) where T<:Tuple
    Val(typehead(t))
end

@inline function typetail(t::Type{T}) where T<:Tuple
    Base.tuple_type_tail(T)
end

@inline typetail(t::Type{Tuple{}}) = nothing

@inline function headval(t::Tuple)
    Val(Base.first(t))
end

@inline headval(::Tuple{}) = nothing

@inline gettail(t::Tuple) = Base.tail(t)
@inline gettail(::Tuple{}) = nothing
