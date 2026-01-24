#AlgoTracker
export inc!, nextalgo!
export CompositeAlgorithm
struct CompositeAlgorithm{T, Intervals, NSR, S, R} <: ComplexLoopAlgorithm
    funcs::T
    inc::Base.RefValue{Int} # To track the intervals
    registry::NSR
    shared_contexts::S
    shared_vars::R
end

"""
Update auto generated names means registry has been overruled, thus we set this to nothing
"""
update_instance(ca::CompositeAlgorithm{T,I}, ::NameSpaceRegistry) where {T,I} = CompositeAlgorithm{T, I, Nothing, Nothing, Nothing}(ca.funcs, ca.inc, nothing, nothing, nothing)
getmultipliers_from_specification_num(::Type{<:CompositeAlgorithm}, specification_num) = 1 ./(Float64.(specification_num))


function CompositeAlgorithm(funcs::NTuple{N, Any}, 
                            intervals::NTuple{N, Real} = ntuple(_ -> 1, N), 
                            options::Union{Share, Route, ProcessState}...) where {N}
    (;functuple, registry, shared_contexts, shared_vars) = setup(CompositeAlgorithm, funcs, intervals, options...)
    CompositeAlgorithm{typeof(functuple), intervals, typeof(registry), typeof(shared_contexts), typeof(shared_vars)}(functuple, Ref(1), registry, shared_contexts, shared_vars)
end


# function CompositeAlgorithm(funcs::NTuple{N, Any}, 
#                             intervals::NTuple{N, Real} = ntuple(_ -> 1, N), 
#                             shares_and_routes::Union{Share, Route}...; 
#                             flags...) where {N}

#     set = isempty(flags) ? Set{Symbol}() : Set(flags)
#     allfuncs = Any[]
#     allintervals = Int[]
#     registry = NameSpaceRegistry()
#     multipliers = 1. ./(Float64.(intervals))

#     for (func_idx, func) in enumerate(funcs)
#         if func isa ComplexLoopAlgorithm # Deepcopy to make multiple instances independent
#             func = deepcopy(func)
#         else
#             registry, namedfunc = add_instance(registry, func, multipliers[func_idx])
#         end
#         I = intervals[func_idx]
#         push!(allfuncs, namedfunc)
#         push!(allintervals, I)
#     end

#     registry = inherit(registry, get_registry.(allfuncs)...; multipliers)
#     # Updating names downwards (each branch only needs its own replacements)
#     allfuncs = update_loopalgorithm_names.(allfuncs, Ref(registry))

#     tfuncs = tuple(allfuncs...)
#     allintervals = tuple(floor.(Int, allintervals)...)

#     flags = Set(flags...)
#     CompositeAlgorithm{typeof(tfuncs), allintervals, typeof(registry), typeof(shares_and_routes)}(tfuncs, Ref(1), flags, registry, shares_and_routes)
# end

# CompositeAlgorithm(ca::CompositeAlgorithm, funcs = ca.funcs) = CompositeAlgorithm(funcs, ca.inc, flags = ca.flags)
function newfuncs(ca::CompositeAlgorithm, funcs)
    nsr = NameSpaceRegistry(funcs)
    CompositeAlgorithm{typeof(funcs), intervals(ca), typeof(nsr), typeof(ca.shared_specs)}(funcs, ca.inc, ca.flags, nsr, ca.shared_specs)
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
    return :(ca.inc[] = mod1(ca.inc[] + 1, $_max))
end
function reset!(ca::CompositeAlgorithm)
    ca.inc[] = 1
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

inc(ca::CompositeAlgorithm) = ca.inc[]

get_this_interval(args) = getinterval(getfunc(args.process), algoidx(args))

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfuncname(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]
iterval(ca::CompositeAlgorithm, idx) = getinterval(ca, idx)



# CompositeAlgorithm(f, interval::Int, flags...) = CompositeAlgorithm((f,), (interval,), flags...)



### STEP
"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
@inline function step!(ca::CompositeAlgorithm{T, Is}, context::C) where {T,Is,C<:AbstractContext}
    algoidx = 1
    this_inc = inc(ca)
    return @inline _comp_dispatch(ca, context::C, algoidx, this_inc, gethead(ca.funcs), headval(Is), gettail(ca.funcs), gettail(Is))
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
@inline function _comp_dispatch(ca::CompositeAlgorithm, context::C, algoidx::Int, this_inc::Int, thisfunc::TF, interval, funcs, intervals) where {I,TF,C<:AbstractContext}
    if isnothing(thisfunc)
        inc!(ca)
        GC.safepoint()
        return context
    end
    if interval == 1
        context = step!(thisfunc, context)
    else
        if this_inc % interval == 0
            context = step!(thisfunc, context)
        end
    end
    return @inline _comp_dispatch(ca, context, algoidx + 1, this_inc, gethead(funcs), gethead(intervals), gettail(funcs), gettail(intervals))
end