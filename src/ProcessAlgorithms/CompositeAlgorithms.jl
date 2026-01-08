#AlgoTracker
export inc!, nextalgo!
export CompositeAlgorithm, prepare, loopexp
mutable struct CompositeAlgorithm{T, Intervals, NSR} <: ComplexLoopAlgorithm
    const funcs::T
    inc::Int # To track the intervals
    const flags::Set{Symbol}
    const registry::NSR
end

function CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Real} = ntuple(_ -> 1, N); names = tuple(), flags...) where {N}
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    allfuncs = Any[]
    allintervals = Int[]
    registry = NameSpaceRegistry()
    multipliers = 1. ./(Float64.(intervals))

    for (func_idx, func) in enumerate(funcs)
  
        if func isa Type
            func = func()
        end

        if func isa CompositeAlgorithm || func isa Routine # So that they track their own starts/incs
            func = deepcopy(func)
        end

        name = getname(func)
        if !isnothing(name) && !(func isa NamedAlgorithm)
            func = NamedAlgorithm(func, name)
        end

        if !needsname(func)
            registry, func = add_named_instance(registry, func, multipliers[func_idx])
        elseif needsname(func)
            registry, func = get_named_instance(registry, func, multipliers[func_idx])
        end


        I = intervals[func_idx]
        push!(allfuncs, func)
        push!(allintervals, I)
    end

    registries = getregistry.(allfuncs)
    registries = scale_multipliers.(registries, multipliers)
    func_replacements = Vector{Vector{Pair{Symbol,Symbol}}}(undef, length(allfuncs))
    # Merging registries pairwise so replacement direction is explicit
    for (idx, subregistry) in enumerate(registries)
        registry, repl = merge_registries(registry, subregistry)
        func_replacements[idx] = repl
    end
    # Updating names downwards (each branch only needs its own replacements)
    allfuncs = update_loopalgorithm_names.(allfuncs, func_replacements)

    tfuncs = tuple(allfuncs...)
    allintervals = tuple(floor.(Int, allintervals)...)
    _instances = unique_instances(tfuncs)

    flags = Set(flags...)
    CompositeAlgorithm{typeof(tfuncs), allintervals, typeof(registry)}(tfuncs, 1, flags, registry)
end

# CompositeAlgorithm(ca::CompositeAlgorithm, funcs = ca.funcs) = CompositeAlgorithm(funcs, ca.inc, flags = ca.flags)
function newfuncs(ca::CompositeAlgorithm, funcs)
    nsr = NameSpaceRegistry(funcs)
    CompositeAlgorithm{typeof(funcs), intervals(ca), typeof(nsr)}(funcs, ca.inc, ca.flags, nsr)
end

subalgorithms(ca::CompositeAlgorithm) = ca.funcs
subalgotypes(ca::CompositeAlgorithm{FT}) where FT = FT.parameters
subalgotypes(caT::Type{<:CompositeAlgorithm{FT}}) where FT = FT.parameters

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
    return :(ca.inc = mod1(ca.inc + 1, $_max))
end
function reset!(ca::CompositeAlgorithm)
    ca.inc = 1
    reset!.(ca.funcs)
end

# Change the names
setnames(ca::CompositeAlgorithm{T,Int}, names::NTuple{N, Symbol}) where {T,N} = CompositeAlgorithm{T,Int,names}(ca.funcs, ca.inc, ca.flags)


export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

num_funcs(ca::CompositeAlgorithm{FA}) where FA = fieldcount(FA)

type_instances(ca::CompositeAlgorithm{FT}) where FT = ca.funcs
get_funcs(ca::CompositeAlgorithm{FT}) where FT = FT.parameters 

CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 
intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]
intervals(caT::Type{<:CompositeAlgorithm}) = caT.parameters[2]
get_intervals(ca) = intervals(ca)


# repeats(ca::CompositeAlgorithm) = 1 ./ intervals(ca)
# repeats(ca::CompositeAlgorithm, idx) = 1 / getinterval(ca, idx)
multipliers(ca::CompositeAlgorithm) = 1 ./ intervals(ca)
multipliers(caT::Type{<:CompositeAlgorithm}) = 1 ./ intervals(caT)
multiplier(ca::CompositeAlgorithm, idx) = 1 / getinterval(ca, idx)

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]

@inline function getvals(ca::CompositeAlgorithm{FT, Is}) where {FT, Is}
    return Val.(Is)
end

inc(ca::CompositeAlgorithm) = ca.inc

get_this_interval(args) = getinterval(getfunc(args.proc), algoidx(args))

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfuncname(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]
iterval(ca::CompositeAlgorithm, idx) = getinterval(ca, idx)

algo_loopidx(args) = loopidx(args.proc) ÷ args.interval
export algo_loopidx

# CompositeAlgorithm(f, interval::Int, flags...) = CompositeAlgorithm((f,), (interval,), flags...)



### STEP
"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
@inline function step!(ca::CompositeAlgorithm{T, Is}, args::As) where {T,Is,As<:NamedTuple}
    algoidx = 1
    return @inline _comp_dispatch(ca, gethead(ca.funcs), headval(Is), gettail(ca.funcs), gettail(Is), (;args..., algoidx, interval = gethead(Is)))
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
@inline function _comp_dispatch(ca::CompositeAlgorithm, thisfunc::TF, interval::Val{I}, funcs, intervals, args) where {I,TF}
    returnval = nothing
    (;proc) = args
    if I == 1
        returnval = step!(thisfunc, args)

    else
        if inc(ca) % I == 0
            returnval = step!(thisfunc, args)
        end
    end
    args = mergeargs(args, returnval)
    return @inline _comp_dispatch(ca, gethead(funcs), headval(intervals), gettail(funcs), gettail(intervals), (;args..., algoidx = args.algoidx + 1, interval = gethead(intervals)))
end

"""
Last dispatch function when all functions have been called
"""
@inline function _comp_dispatch(ca::CompositeAlgorithm, ::Nothing, ::Any, ::Any, ::Any, args)
    inc!(ca)
    GC.safepoint()
    # return args
    return
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
            # show(next(indentio), thisfunc)
        end
    end
end
