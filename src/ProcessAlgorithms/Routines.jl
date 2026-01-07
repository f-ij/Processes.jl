export Routine

"""
Struct to create routines
"""
mutable struct Routine{T, Repeats, NT, NSR} <: ComplexLoopAlgorithm
    const funcs::T
    incs::MVector # Maybe remove this and make it computed from the process lidx
    const flags::Set{Symbol}
    const registry::NSR
end

function Routine(funcs...; repeats::NTuple{N, Real} = ntuple(x -> 1, N), flags...) where {N}
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    allfuncs = []
    savedrepeats = []
    registry = NameSpaceRegistry()


    for (fidx, func) in enumerate(funcs)

        if func isa Type
            func = func()
        end

        if func isa CompositeAlgorithm || func isa Routine # So that they track their own incs/incs
            func = deepcopy(func)
        end


        multiplier = Float64(repeats[fidx])
        if needsname(func) 
            registry, func = get_named_instance(registry, func, multiplier)
        end

        push!(allfuncs, func)
        push!(savedrepeats, repeats[fidx])
    end

    registries = getregistry.(allfuncs)
    registries = scale_multipliers.(registries, repeats)

    func_replacements = Vector{Vector{Pair{Symbol,Symbol}}}(undef, length(allfuncs))
    # Merging registries pairwise so replacements propagate down the right branch
    for (idx, subregistry) in enumerate(registries)
        registry, repl = merge_registries(registry, subregistry)
        func_replacements[idx] = repl
    end
    # Updating names downwards
    allfuncs = update_loopalgorithm_names.(allfuncs, func_replacements)
    
    funcstuple = tuple(allfuncs...)
    savedrepeats = tuple(floor.(Int, savedrepeats)...)
    sidxs = MVector{length(funcstuple),Int}(ones(length(funcstuple)))
    return Routine{typeof(funcstuple), savedrepeats, typeof(sidxs), typeof(registry)}(funcstuple, sidxs, set, registry)
end

# Routine(r::Routine, funcs = r.funcs) = Routine(funcs, r.incs, flags = r.flags)
# newfuncs(r::Routine, funcs) = Routine(funcs, r.incs, flags = r.flags)
function newfuncs(r::Routine, funcs)
    nsr = NameSpaceRegistry(funcs)
    Routine{typeof(funcs), repeats(r), typeof(r.incs), typeof(nsr)}(funcs, r.incs, r.flags, nsr)
end

subalgorithms(r::Routine) = r.funcs
subalgotypes(r::Routine{FT}) where FT = FT.parameters
subalgotypes(rT::Type{<:Routine{FT}}) where FT = FT.parameters

# getnames(r::Routine{T, R, NT, N}) where {T, R, NT, N} = N
Base.length(r::Routine) = length(r.funcs)
repeats(::Type{<:Routine{F,R}}) where {F,R} = R
repeats(r::Routine{F,R}) where {F,R} = R
multipliers(r::Routine) = repeats(r)
multipliers(rT::Type{<:Routine}) = repeats(rT)

repeats(r::Routine{F,R}, idx) where {F,R} = getindex(repeats(r), idx)
getfuncs(r::Routine) = r.funcs

inc!(r::Routine, idx) = r.incs[idx] += 1

function reset!(r::Routine)
    r.incs = MVector{length(r.funcs),Int}(ones(length(r.funcs)))
    reset!.(r.funcs)
end

### STEP
"""
Routines unroll their subroutines and execute them in order.
"""
@inline function step!(r::Routine, args::As) where {As<:NamedTuple}
    @inline unroll_subroutines(r, r.funcs, get_incs(r), args)
end

function unroll_subroutines(@specialize(r::Routine), @specialize(funcs), start_idxs, args)
    a_idx = 1
    @inline _unroll_subroutines(r, gethead(funcs), a_idx, gettail(funcs), gethead(repeats(r)), gettail(repeats(r)), args,)
end

@inline function _unroll_subroutines(r::Routine, a_idx, func::F, tail, this_repeat, repeats, args) where F
    (;proc) = args
    if isnothing(func)
        reset!(r)
        return args
    else
        a_idx = args.algoidx
        start = r.incs[a_idx]
        for i in start:this_repeat
            if !run(proc)
                return args
            end
            # returnval = @inline step!(func, args)
            # args = mergeargs(args, returnval)
            @inline step!(func, args)
            inc!(r, a_idx)
            GC.safepoint()
        end
        @inline _unroll_subroutines(r, a_idx + 1, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats), args)
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
            # show(next(indentio), thisfunc)
        end
    end
end

