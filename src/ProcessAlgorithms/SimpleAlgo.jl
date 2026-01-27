#TODO: Extend this to wrap multiple functions with a 1:1 interval
"""
Has id for matching
"""
struct SimpleAlgo{T, I, NSR, O, id} <: ComplexLoopAlgorithm
    funcs::T
    resume_idx::I
    registry::NSR
    options::O
end

getmultipliers_from_specification_num(::Type{<:SimpleAlgo}, specification_num) = ntuple(_ -> 1, length(specification_num))
# function update_scope(ca::SimpleAlgo{T,I}, newreg::NameSpaceRegistry) where {T,I}
#     updated_reg, _ = updatenames(ca.registry, newreg)
#     # SimpleAlgo{T, I, typeof(updated_reg), Nothing}(ca.funcs, ca.resume_idx, updated_reg, nothing)
#     return setfield(ca, :registry, updated_reg)
# end

function SimpleAlgo(funcs::NTuple{N, Any}, 
                    options::AbstractOption...;
                    resumable = false) where {N}
    (;functuple, registry, options) = setup(SimpleAlgo, funcs, ntuple(_ -> 1, N), options...)
    resume_idx = resumable ? Ref(1) : nothing
    return SimpleAlgo{typeof(functuple),  typeof(resume_idx), typeof(registry), typeof(options), uuid4()}(functuple, resume_idx, registry, options)
end

function newfuncs(sa::SimpleAlgo, funcs)
    setfield(sa, :funcs, funcs)
end 

@inline resumable(sa::SimpleAlgo{T,I}) where {T,I} = I != Nothing

@inline function reset!(sa::SimpleAlgo)
    @inline reset!.(getfuncs(sa))
    sa.resume_idx[] = 1
end

@inline resume_idx!(sa::SimpleAlgo) = sa.resume_idx[] += 1
@inline resume_idx(sa::SimpleAlgo) = sa.resume_idx[]

"""
Wrapper for functions to ensure proper semantics with the task system
"""
@inline function step!(sf::SimpleAlgo, context::C) where C
    a_idx = 1
    return @inline unroll_funcs(sf, a_idx, gethead(sf.funcs), gettail(sf.funcs), context)
end

function unroll_funcs(sf::SimpleAlgo, a_idx, headf::F, tailf::T, context::C) where {F, T, C}
    (;process) = @inline getglobal(context)
    if isnothing(headf)
        return context
    end

    if !run(process)
        if resumable(sf)
            resume_idx!(sf)
        end
        return context
    end
    context = @inline step!(headf, context)
    return @inline unroll_funcs(sf, a_idx+1, gethead(tailf), gettail(tailf), context)
end

@inline getid(sa::Union{SimpleAlgo{T,I,NSR,O,id}, Type{<:SimpleAlgo{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = id
@inline getfuncs(sa::SimpleAlgo) = sa.funcs
@inline subalgorithms(sa::SimpleAlgo) = sa.funcs
@inline Base.length(sa::SimpleAlgo) = length(sa.funcs)
@inline Base.eachindex(sa::SimpleAlgo) = eachindex(sa.funcs)
@inline getfunc(sa::SimpleAlgo, idx) = sa.funcs[idx]
@inline subalgotypes(sa::SimpleAlgo{FT}) where FT = FT.parameters
@inline subalgotypes(saT::Type{<:SimpleAlgo{FT}}) where FT = FT.parameters

@inline hasflag(sa::SimpleAlgo, flag) = flag in sa.flags
@inline track_algo(sa::SimpleAlgo) = hasflag(sa, :trackalgo)


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
