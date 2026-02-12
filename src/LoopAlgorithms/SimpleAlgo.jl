struct RepeatOne{N} <: AbstractArray{Int,1} end
RepeatOne(n::Integer) = RepeatOne{n}()
Base.getindex(::Union{RepeatOne{N}, Type{RepeatOne{N}}}, idx = nothing) where N = 1
Base.length(::Union{RepeatOne{N}, Type{RepeatOne{N}}}) where {N} = N
Base.iterate(ro::Union{RepeatOne{N}, Type{RepeatOne{N}}}, state = 1) where {N} = state > N ? nothing : (1, state + 1)


"""
Simple algo is base case for composite algorithms with all intervals set to 1
"""
const SimpleAlgo{T, S, O, id} = CompositeAlgorithm{T, <:RepeatOne, S, O, id}
SimpleAlgo(args...) = CompositeAlgorithm(args...)
# function SimpleAlgo(funcs::NTuple{N, Any}, 
#                     options::Union{Share, Route, ProcessState}...; id = nothing, customname = Symbol()) where {N}
#     (;functuple, registry, options) = setup(SimpleAlgo, funcs, ntuple(_ -> 1, N), options...)
#     CompositeAlgorithm{typeof(functuple), RepeatOne(), typeof(registry), typeof(options), id, customname}(functuple, Ref(1), registry, options)
# end
@inline intervals(sa::SA) where SA <: SimpleAlgo = ntuple(_ -> 1, length(sa))

# #TODO: Extend this to wrap multiple functions with a 1:1 interval
# """
# Has id for matching
# """
# struct SimpleAlgo{T, I, NSR, O, id} <: LoopAlgorithm
#     funcs::T
#     resume_idx::I
#     registry::NSR
#     options::O
# end

# getmultipliers_from_specification_num(::Type{<:SimpleAlgo}, specification_num) = ntuple(_ -> 1, length(specification_num))
# # function update_scope(ca::SimpleAlgo{T,I}, newreg::NameSpaceRegistry) where {T,I}
# #     updated_reg, _ = updatenames(ca.registry, newreg)
# #     # SimpleAlgo{T, I, typeof(updated_reg), Nothing}(ca.funcs, ca.resume_idx, updated_reg, nothing)
# #     return setfield(ca, :registry, updated_reg)
# # end

# function SimpleAlgo(funcs::NTuple{N, Any}, 
#                     options::AbstractOption...;
#                     resumable = false) where {N}
#     (;functuple, registry, options) = setup(SimpleAlgo, funcs, ntuple(_ -> 1, N), options...)
#     resume_idx = resumable ? Ref(1) : nothing
#     return SimpleAlgo{typeof(functuple),  typeof(resume_idx), typeof(registry), typeof(options), uuid4()}(functuple, resume_idx, registry, options)
# end

# function newfuncs(sa::SimpleAlgo, funcs)
#     setfield(sa, :funcs, funcs)
# end 

# @inline resumable(sa::SimpleAlgo{T,I}) where {T,I} = I != Nothing

# @inline function reset!(sa::SimpleAlgo)
#     @inline reset!.(getalgos(sa))
#     sa.resume_idx[] = 1
# end

# @inline resume_idx!(sa::SimpleAlgo) = sa.resume_idx[] += 1
# @inline resume_idx(sa::SimpleAlgo) = sa.resume_idx[]

# """
# Wrapper for functions to ensure proper semantics with the task system
# """
# @inline Base.@constprop :aggressive function step!(sf::SimpleAlgo, context::C) where C
#     # a_idx = 1
#     return @inline unroll_funcs(sf, (@inline gethead(sf.funcs)), (@inline gettail(sf.funcs)), context)
# end

# @inline Base.@constprop :aggressive function unroll_funcs(sf::SimpleAlgo, headf::F, tailf::T, context::C) where {F, T, C}
#     (;process) = @inline getglobal(context)
#     if @inline isnothing(headf)
#         return context
#     end

#     if !run(process)
#         if @inline resumable(sf)
#             @inline resume_idx!(sf)
#         end
#         return context
#     end
#     context = @inline step!(headf, context)
#     return @inline unroll_funcs(sf, (@inline gethead(tailf)), (@inline gettail(tailf)), context)
# end

# @inline getid(sa::Union{SimpleAlgo{T,I,NSR,O,id}, Type{<:SimpleAlgo{T,I,NSR,O,id}}}) where {T,I,NSR,O,id} = id
# @inline getalgos(sa::SimpleAlgo) = sa.funcs
# @inline subalgorithms(sa::SimpleAlgo) = sa.funcs
# @inline Base.length(sa::SimpleAlgo) = length(sa.funcs)
# @inline Base.eachindex(sa::SimpleAlgo) = eachindex(sa.funcs)
# @inline getalgo(sa::SimpleAlgo, idx) = sa.funcs[idx]
# @inline subalgotypes(sa::SimpleAlgo{FT}) where FT = FT.parameters
# @inline subalgotypes(saT::Type{<:SimpleAlgo{FT}}) where FT = FT.parameters

# @inline hasflag(sa::SimpleAlgo, flag) = flag in sa.flags
# @inline track_algo(sa::SimpleAlgo) = hasflag(sa, :trackalgo)


# multipliers(sa::SimpleAlgo) = ntuple(_ -> 1, length(sa))
# multipliers(::Type{<:SimpleAlgo{FT}}) where FT = ntuple(_ -> 1, length(FT.parameters))



# ##################
# ##### SHOWING #####
# ##################
# function Base.show(io::IO, sa::SimpleAlgo)
#     println(io, "SimpleAlgo")
#     funcs = sa.funcs
#     if isempty(funcs)
#         print(io, "  (empty)")
#         return
#     end
#     limit = get(io, :limit, false)
#     for (idx, thisfunc) in enumerate(funcs)
#         func_str = repr(thisfunc; context = IOContext(io, :limit => limit))
#         lines = split(func_str, '\n')
#         print(io, "  | ", lines[1])
#         for line in Iterators.drop(lines, 1)
#             print(io, "\n  | ", line)
#         end
#         if idx < length(funcs)
#             print(io, "\n")
#         end
#     end
# end
