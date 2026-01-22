export Routine

"""
Struct to create routines
"""
struct Routine{T, Repeats, MV, NSR, S, SV} <: ComplexLoopAlgorithm
    funcs::T
    incs::MV
    flags::Set{Symbol}
    registry::NSR
    shared_contexts::S
    shared_vars::SV
end

update_instance(ca::Routine{T,R, MV}, ::NameSpaceRegistry) where {T,R, MV} = Routine{T, R, MV, Nothing, Nothing, Nothing}(ca.funcs, ca.incs, ca.flags, nothing, nothing, nothing)
getmultipliers_from_specification_num(::Type{<:Routine}, specification_num) = Float64.(specification_num)
get_incs(r::Routine) = r.incs


function Routine(funcs::NTuple{N, Any}, 
                            repeats::NTuple{N, Real} = ntuple(x -> 1, length(funcs)), 
                            shares_and_routes::Union{Share, Route}...; 
                            flags...) where {N}

    (;functuple, flags, registry, shared_contexts, shared_vars) = setup(Routine, funcs, repeats, shares_and_routes...; flags...)
    sidxs = MVector{length(functuple),Int}(ones(length(functuple)))
    Routine{typeof(functuple), typeof(repeats), typeof(sidxs), typeof(registry), typeof(shared_contexts), typeof(shared_vars)}(functuple, sidxs, flags, registry, shared_contexts, shared_vars)
end

                    

# function Routine(funcs::NTuple{N, Any}, repeats::NTuple{N, Real} = ntuple(x -> 1, length(funcs)), shares_and_routes::Union{Share, Route}...; flags...) where {N}
#     set = isempty(flags) ? Set{Symbol}() : Set(flags)
#     allfuncs = []
#     registry = NameSpaceRegistry()
#     multipliers = Float64.(repeats)

#     for (func_idx, func) in enumerate(funcs)
#         if func isa ComplexLoopAlgorithm # Deepcopy to make multiple instances independent
#             func = deepcopy(func)
#         else
#             registry, func = add_instance(registry, func, multipliers[func_idx])
#         end
#         push!(allfuncs, func)
#     end

#     registries = getregistry.(allfuncs)
#     # return registry, registries[1]
#     registry = inherit(registry, registries...; multipliers)
#     # return registry
#     # Updating names downwards (each branch only needs its own replacements)
#     allfuncs = update_loopalgorithm_names.(allfuncs, Ref(registry))
    
#     funcstuple = tuple(allfuncs...)
#     repeats = tuple(floor.(Int, repeats)...)
#     sidxs = MVector{length(funcstuple),Int}(ones(length(funcstuple)))
#     return Routine{typeof(funcstuple), repeats, typeof(sidxs), typeof(registry), typeof(shares_and_routes)}(funcstuple, sidxs, set, registry, shares_and_routes)
# end

# Routine(r::Routine, funcs = r.funcs) = Routine(funcs, r.incs, flags = r.flags)
# newfuncs(r::Routine, funcs) = Routine(funcs, r.incs, flags = r.flags)
function newfuncs(r::Routine, funcs)
    nsr = NameSpaceRegistry(funcs)
    Routine{typeof(funcs), repeats(r), typeof(r.incs), typeof(nsr), typeof(r.shared_contexts), typeof(r.shared_vars)}(funcs, r.incs, r.flags, nsr, r.shared_contexts, r.shared_vars)
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
    r.incs .= 1 
    reset!.(r.funcs)
end

### STEP
"""
Routines unroll their subroutines and execute them in order.
"""
@inline function step!(r::Routine, context::C) where {C<:AbstractContext}
    @inline unroll_subroutines(r, context, r.funcs)
end

function unroll_subroutines(r::R, context::C, funcs) where {R<:Routine, C<:AbstractContext}
    unroll_idx = 1
    @inline _unroll_subroutines(r, context, unroll_idx, gethead(funcs), gettail(funcs), gethead(repeats(r)), gettail(repeats(r)))
end

@inline function _unroll_subroutines(r::Routine, context::C, unroll_idx, func::F, tail, this_repeat, repeats) where {F, C<:AbstractContext}
    (;process) = getglobal(context)
    if isnothing(func)
        reset!(r)
        return context
    else
        start = r.incs[unroll_idx]
        for i in start:this_repeat
            if !run(process)
                return context
            end
            context = @inline step!(func, context)
            # @inline step!(func, args)
            inc!(r, unroll_idx)
            GC.safepoint()
        end
        @inline _unroll_subroutines(r, context, unroll_idx + 1, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats))
    end
end


#SHOWING

# function Base.show(io::IO, r::Routine)
#     indentio = NextIndentIO(io, VLine(), "Routine")
#     rs = repeats(r)
#     q_postfixes(indentio, ("\trepeating $rep time(s)" for rep in rs)...)
#     for thisfunc in r.funcs
#         if thisfunc isa CompositeAlgorithm || thisfunc isa Routine
#             invoke(show, Tuple{IO, typeof(thisfunc)}, next(indentio), thisfunc)
#         else
#             invoke(show, Tuple{IndentIO, Any}, next(indentio), thisfunc)
#             # show(next(indentio), thisfunc)
#         end
#     end
# end

function Base.show(io::IO, r::Routine)
    println(io, "Routine")
    funcs = r.funcs
    if isempty(funcs)
        print(io, "  (empty)")
        return
    end
    reps = repeats(r)
    limit = get(io, :limit, false)
    for (idx, thisfunc) in enumerate(funcs)
        rep = reps[idx]
        func_str = repr(thisfunc; context = IOContext(io, :limit => limit))
        lines = split(func_str, '\n')
        suffix = " (repeats " * string(rep) * " time(s))"
        print(io, "  [", idx, "] ", lines[1], suffix)
        for line in Iterators.drop(lines, 1)
            print(io, "\n  ", line)
        end
        if idx < length(funcs)
            print(io, "\n")
        end
    end
end
