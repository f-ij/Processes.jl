export Routine

"""
Struct to create routines
"""
mutable struct Routine{T, Repeats, NT} <: ProcessLoopAlgorithm
    const funcs::T
    starts::NT
    const flags::Set{Symbol}
end

Base.length(r::Routine) = length(r.funcs)
repeats(::Type{Routine{F,R,NT}}) where {F,R,NT} = R
repeats(r::Routine{F,R}) where {F,R} = R
# repeats(r::Routine{FT, R}) where {FT, R} = tuple_type_property(repeat, FT)

repeats(r::Routine{F,R}, idx) where {F,R} = getindex(repeats(r), idx)
getfuncs(r::Routine) = r.funcs
function save_starts!(r::Routine{T,Repeats}, routineidx, loopidx) where {T, Repeats}
    num = length(Repeats)
    t = tuple(Repeats[1:routineidx-1]..., loopidx, (1 for _ in routineidx+1:num)...)
    r.starts = t
end
get_starts(r::Routine) = r.starts

reset!(a::Any) = nothing
function reset!(r::Routine)
    r.starts = ntuple(x -> 1, length(r.funcs))
    reset!.(r.funcs)
end


function Routine(funcs::NTuple{N, Any}, repeats::NTuple{N, Real} = ntuple(x -> 1, N), flags::Symbol...) where {N}
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    savedfuncs = []
    savedrepeats = []

    for fidx in eachindex(funcs)
        thisfunc = funcs[fidx]
        if thisfunc isa Type
            thisfunc = thisfunc()
        end

        if thisfunc isa CompositeAlgorithm || thisfunc isa Routine # So that they track their own starts/incs
            thisfunc = deepcopy(thisfunc)
        end

        push!(savedfuncs, thisfunc)
        push!(savedrepeats, repeats[fidx])
    end
    savedfuncs = tuple(savedfuncs...)
    savedrepeats = tuple(floor.(Int, savedrepeats)...)
    stype = typeof(savedfuncs)
    sidxs = ntuple(x->1, length(funcs))

    return Routine{stype, savedrepeats, typeof(sidxs)}(savedfuncs, sidxs , set)
end

@inline function (r::Routine{T,R})(args) where {T, R}
    @inline unroll_subroutines(r, r.funcs, get_starts(r), args)
end

function unroll_subroutines(@specialize(r::Routine), @specialize(funcs), start_idxs, args)
    @inline _unroll_subroutines(r, gethead(funcs), gettail(funcs), gethead(repeats(r)), gettail(repeats(r)), gethead(start_idxs), gettail(start_idxs), (;args..., algoidx = 1))
end

function _unroll_subroutines(r::Routine, @specialize(func), tail, this_repeat, repeats, startidx, start_idxs, args) 
    if isnothing(func)
        reset!(r)
        return
    else
        (;proc) = args
        for i in startidx:this_repeat
            if !run(proc)
                save_starts!(r, args.algoidx, i)
                break
            end
            @inline func(args)
            # TODO: Make this a trait? Maybe "countsincrements"
            if !(func isa CompositeAlgorithm || func isa SimpleAlgo || func isa Routine)
                inc!(proc)
            end
            GC.safepoint()
        end
        @inline _unroll_subroutines(r, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats), gethead(start_idxs), gettail(start_idxs), (;args..., algoidx = args.algoidx + 1))
    end
        
end


#SHOWING

function Base.show(io::IO, r::Routine)
    indentio = NextIndentIO(io, VLine(), "Routine")
    rs = repeats(r)
    q_postfixes(indentio, ("\trepeating $rep time(s)" for rep in rs)...)
    for thisfunc in r.funcs
        if thisfunc isa CompositeAlgorithm || thisfunc isa Routine
            invoke(show, Tuple{IO, typeof(thisfunc)}, next(indentio), thisfunc)
        else
            invoke(show, Tuple{IndentIO, Any}, next(indentio), thisfunc)
        end
    end
end

