export Routine

"""
Struct to create routines
"""
struct Routine{T, Repeats, NT, NSR} <: ComplexLoopAlgorithm
    funcs::T
    incs::MVector # Maybe remove this and make it computed from the process lidx
    flags::Set{Symbol}
    registry::NSR
end

update_instance(ca::Routine{T,R, NT}, ::NameSpaceRegistry) where {T,R, NT} = Routine{T, R, NT, Nothing}(ca.funcs, ca.incs, ca.flags, nothing)


function Routine(funcs...; repeats::NTuple{N, Real} = ntuple(x -> 1, length(funcs)), flags...) where {N}
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    allfuncs = []
    registry = NameSpaceRegistry()
    multipliers = Float64.(repeats)

    for (func_idx, func) in enumerate(funcs)
        if func isa ComplexLoopAlgorithm # Deepcopy to make multiple instances independent
            func = deepcopy(func)
        else
            registry, func = add_instance(registry, func, multipliers[func_idx])
        end
        push!(allfuncs, func)
    end

    registries = getregistry.(allfuncs)
    # return registry, registries[1]
    registry = inherit(registry, registries...; multipliers)
    # return registry
    # Updating names downwards (each branch only needs its own replacements)
    allfuncs = update_loopalgorithm_names.(allfuncs, Ref(registry))
    
    funcstuple = tuple(allfuncs...)
    repeats = tuple(floor.(Int, repeats)...)
    sidxs = MVector{length(funcstuple),Int}(ones(length(funcstuple)))
    return Routine{typeof(funcstuple), repeats, typeof(sidxs), typeof(registry)}(funcstuple, sidxs, set, registry)
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

function unroll_subroutines(r::R, context::C, funcs, start_idxs) where {R<:Routine, C<:AbstractContext}
    a_idx = 1
    @inline _unroll_subroutines(r, context, gethead(funcs), a_idx, gettail(funcs), gethead(repeats(r)), gettail(repeats(r)))
end

@inline function _unroll_subroutines(r::Routine, context::C, a_idx, func::F, tail, this_repeat, repeats) where {F, C<:AbstractContext}
    (;proc) = getglobal(context)
    if isnothing(func)
        reset!(r)
        return context
    else
        a_idx = args.algoidx
        start = r.incs[a_idx]
        for i in start:this_repeat
            if !run(proc)
                return context
            end
            context = @inline step!(func, context)
            # @inline step!(func, args)
            inc!(r, a_idx)
            GC.safepoint()
        end
        @inline _unroll_subroutines(r, context, a_idx + 1, gethead(tail), gettail(tail), gethead(repeats), gettail(repeats))
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
