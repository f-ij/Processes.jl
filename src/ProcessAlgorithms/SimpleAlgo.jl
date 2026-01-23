#TODO: Extend this to wrap multiple functions with a 1:1 interval
struct SimpleAlgo{T, NSR, S, R} <: ComplexLoopAlgorithm
    funcs::T
    inc::Base.RefValue # To track resuming
    flags::Set{Symbol}
    registry::NSR
    shared_contexts::S
    shared_vars::R
end

getmultipliers_from_specification_num(::Type{<:SimpleAlgo}, specification_num) = ntuple(_ -> 1, length(specification_num))

function SimpleAlgo(funcs::NTuple{N, Any}, 
                    shares_and_routes::Union{Share, Route}...; flags...) where {N}
    (;functuple, flags, registry, shared_contexts, shared_vars) = setup(SimpleAlgo, funcs, ntuple(_ -> 1, N), shares_and_routes...; flags...)
    flags = Set(flags...)
    return SimpleAlgo{typeof(functuple), typeof(registry), typeof(shared_contexts), typeof(shared_vars)}(functuple, Ref(1), flags, registry, shared_contexts, shared_vars)
end

@inline function reset!(sa::SimpleAlgo)
    @inline reset!.(getfuncs(sa))
    sa.inc[] = 1
end

@inline inc!(sa::SimpleAlgo) = sa.inc[] += 1
@inline inc(sa::SimpleAlgo) = sa.inc[]

"""
Wrapper for functions to ensure proper semantics with the task system
"""
@inline function step!(sf::SimpleAlgo, context::C) where C
    a_idx = 1
    # r_idx = @inline inc(sf)
    r_idx = 1
    return @inline unroll_funcs(sf, a_idx, r_idx, gethead(sf.funcs), gettail(sf.funcs), context)
end

function unroll_funcs(sf::SimpleAlgo, a_idx, r_idx, headf::F, tailf::T, context::C) where {F, T, C}
    (;process) = @inline getglobal(context)
    if !run(process)
        return context
    end
    # if a_idx == r_idx # For pausing/resuming
        context = @inline step!(headf, context)
        # r_idx += 1
    # end
    return @inline unroll_funcs(sf, a_idx+1, r_idx, gethead(tailf), gettail(tailf), context)
end

@inline function unroll_funcs(sf::SimpleAlgo, ::Any, ::Any, ::Nothing, ::Any, context::C) where C
    @inline reset!(sf)
    GC.safepoint()
    return context
end

@inline getfuncs(sa::SimpleAlgo) = sa.funcs
@inline subalgorithms(sa::SimpleAlgo) = sa.funcs
@inline Base.length(sa::SimpleAlgo) = length(sa.funcs)
@inline Base.eachindex(sa::SimpleAlgo) = Base.eachindex(sa.funcs)
@inline getfunc(sa::SimpleAlgo, idx) = sa.funcs[idx]
@inline subalgotypes(sa::SimpleAlgo{FT}) where FT = FT.parameters
@inline subalgotypes(saT::Type{<:SimpleAlgo{FT}}) where FT = FT.parameters

@inline hasflag(sa::SimpleAlgo, flag) = flag in sa.flags
@inline track_algo(sa::SimpleAlgo) = hasflag(sa, :trackalgo)

function newfuncs(sa::SimpleAlgo, funcs)
    nsr = NameSpaceRegistry(funcs)
    SimpleAlgo{typeof(funcs), typeof(nsr)}(funcs, sa.flags, nsr)
end 

multipliers(sa::SimpleAlgo) = ntuple(_ -> 1, length(sa))
multipliers(::Type{<:SimpleAlgo{FT}}) where FT = ntuple(_ -> 1, length(FT.parameters))

function Base.show(io::IO, sa::SimpleAlgo)
    println(io, "SimpleAlgo")
    funcs = sa.funcs
    if isempty(funcs)
        print(io, "  (empty)")
        return
    end
    limit = get(io, :limit, false)
    for (idx, thisfunc) in enumerate(funcs)
        func_str = repr(thisfunc; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        print(io, "  | ", lines[1])
        for line in Iterators.drop(lines, 1)
            print(io, "\n  | ", line)
        end
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end
