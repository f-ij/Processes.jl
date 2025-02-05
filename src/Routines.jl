export Routine, SubRoutine

struct SubRoutine{F, Lifetime}
    func::F # Func, or composite algorithnm
end

SubRoutine(func, repeats = 1) = SubRoutine{typeof(func), repeats}(func)
SubRoutine(func::Type, repeats = 1) = SubRoutine{func, repeats}(func())

function (sr::SubRoutine{F,L})(args) where {F,L}
    return F(args)
end

function (sr::SubRoutine{<:Function,L})(args) where L
    return sr.func(args)
end

function (sr::SubRoutine{<:CompositeAlgorithm,L})(args) where L
    return sr.func(args)
end

lifetime(sub::SubRoutine{F,L}) where {F,L} = L
lifetime(::Type{SubRoutine{F,L}}) where {F,L} = L

function prepare(sr::SubRoutine{F,L}, args) where {F,L}
    # invoke(prepare, Tuple{F, Any}, sr, args)
    prepare(sr.func, args)
end


"""
Struct to create routines
"""
struct Routine{T, Repeat}
    subrountines::T
end

function Routine(funcs::NTuple{N, Any}, lifetimes::NTuple{N, Int}, repeat = 1) where {N}
    srs = tuple((
        let obj = funcs[i] isa Type ? funcs[i]() : funcs[i]
            SubRoutine{typeof(obj), lifetimes[i]}(obj) end for i in 1:N)...
        )
    return Routine{typeof(srs), repeat}(srs)
end

function Routine(sr::SubRoutine...; repeat = 1)
    return Routine{Tuple{typeof.(sr)...}, repeat}(tuple(sr...))
end

"""
Standard lifetime for a routine is 1
"""
function Process(r::Routine; lifetime = 1, args...)
    invoke(Process, Tuple{Any}, r; lifetime, args...)
end

mutable struct RoutineTracker{R}
    routine::R
    idx::Int
end

RoutineTracker(r::Routine) = RoutineTracker(r, 1)

next!(rt::RoutineTracker) = rt.idx = mod1(rt.idx + 1, length(rt.routine.subrountines))
this_subroutine(rt::RoutineTracker) = rt.routine.subrountines[rt.idx]
this_subroutine(args) = this_subroutine(args.routinetracker)
routinelifetime(rt::RoutineTracker) = lifetime(this_subroutine(rt))
routinelifetime(args) = routinelifetime(args.routinetracker)

function prepare(r::Routine, args = (;))
    args = (;args..., routinetracker = RoutineTracker(r))
    for sr in r.subrountines
        args = (;args..., prepare(sr, args)...)
        next!(args.routinetracker)
    end
    return args
end

processsizehint!(args, r::Routine) = processsizehint!(args, prepare(r))

lifetimes(r::Routine{FT, R}) where {FT, R} = tuple_type_property(lifetime, FT)

function routinestep(p::Process, routine::Routine{F,R}) where {F,R}
    _lifetimes = lifetimes(routine)
    incs_per_step = sum(_lifetimes)
    stepidx = 1 + loopidx(p) ÷ incs_per_step
    return stepidx
end

function construct_routineidx_tuple(i, routine::Routine{F,R}) where {F,R}
    lts = lifetimes(routine)
    headval = gethead(lts)
    if i  > headval
        return _construct_routineidx_tuple(i - headval, (headval+1,), gettail(lifetimes(routine)), Val(false))
    else
        return _construct_routineidx_tuple(i, (i,), gettail(lifetimes(routine)), Val(true))
    end
end

function _construct_routineidx_tuple(i, acc, lifetimes, f::Val{found}) where found
    if found # just return ones, until done
        return _construct_routineidx_tuple(i, (acc..., 1), gettail(lifetimes), Val(true))
    else
        headval = gethead(lifetimes)
        if i > headval
            return _construct_routineidx_tuple(i - headval, (acc..., headval+1), gettail(lifetimes), Val(false))
        else
            return _construct_routineidx_tuple(i, (acc..., i), gettail(lifetimes), Val(true))
        end
    end
end

# If tail is empty, return acc
_construct_routineidx_tuple(i, acc, lifetimes::Tuple{}, v::Val) = acc

"""
For pausing and resuming
"""
function subroutine_idxs(p::Process, routine::Routine{F,R}) where {F,R}
    _lifetimes = lifetimes(routine)
    incs_per_step = sum(_lifetimes)
    idx_in_step = mod1(loopidx(p), incs_per_step)
    return construct_routineidx_tuple(idx_in_step, routine)
end

default_subroutine_idxs(routine::Routine{F,R}) where {F,R} = tuple_type_property(x -> 1, F)


export subroutine_idxs

function processloop(p::Process, @specialize(func::Routine), args, lifetime::Repeat{r}) where r
    @static if DEBUG_MODE
        println("Running processloop for Routines")
    end
    sr_idxs = @inline subroutine_idxs(p, func)
    before_while(p)
    for _ in routinestep(p,func):r
        @inline unroll_subroutines(func, sr_idxs, args)
        sr_idxs = @inline default_subroutine_idxs(func)
    end
    return after_while(p, args)
end

function unroll_subroutines(@specialize(func::Routine{FT, R}), sr_idxs, args) where {FT, R}
    @inline _unroll_subroutines(gethead(func.subrountines), gettail(func.subrountines), lifetimes(func), sr_idxs, args)
end

function _unroll_subroutines(@specialize(subroutine::Union{Nothing,SubRoutine}), tail, lifetimes, sr_idxs, args) 
    if isnothing(subroutine)
        return
    else
        (;proc) = args
        lifetime = gethead(lifetimes)
        startidx = gethead(sr_idxs)
        for i in startidx:lifetime
            if !run(proc)
                break
            end
            @inline subroutine(args)
            inc!(proc)
            GC.safepoint()
        end
        @inline _unroll_subroutines(gethead(tail), gettail(tail), gettail(lifetimes), gettail(sr_idxs), args)
    end
        
end