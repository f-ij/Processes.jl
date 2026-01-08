#TODO: Extend this to wrap multiple functions with a 1:1 interval
mutable struct SimpleAlgo{T, NSR} <: ComplexLoopAlgorithm
    const funcs::T
    inc::Int # To track resuming
    const flags::Set{Symbol}
    const registry::NSR
end

SimpleAlgo(func; flags...) = SimpleAlgo((func,); flags...)
SimpleAlgo(funcs::Vararg{Any}; flags...) = SimpleAlgo(tuple(funcs...); flags...)

function SimpleAlgo(funcs::Tuple; flags...)
    isempty(funcs) && throw(ArgumentError("SimpleAlgo requires at least one function"))
    set = isempty(flags) ? Set{Symbol}() : Set(flags)
    stored_funcs, registry = _build_simplealgo(funcs)
    flags = Set(flags...)
    return SimpleAlgo{typeof(stored_funcs), typeof(registry)}(stored_funcs, 1, flags, registry)
end

function _build_simplealgo(funcs::Tuple)
    num_funcs = length(funcs)
    allfuncs = Vector{Any}(undef, num_funcs)
    registry = NameSpaceRegistry()
    multipliers = fill(1.0, num_funcs)

    for (idx, func) in enumerate(funcs)
        member = _materialize_simple_member(func)
        if needsname(member)
            registry, member = get_named_instance(registry, member, multipliers[idx])
        end
        allfuncs[idx] = member
    end

    registries = getregistry.(allfuncs)
    registries = scale_multipliers.(registries, multipliers)
    func_replacements = Vector{Vector{Pair{Symbol,Symbol}}}(undef, num_funcs)
    for (idx, subregistry) in enumerate(registries)
        registry, repl = merge_registries(registry, subregistry)
        func_replacements[idx] = repl
    end
    allfuncs = update_loopalgorithm_names.(allfuncs, func_replacements)

    stored_funcs = tuple(allfuncs...)
    return stored_funcs, registry
end

function _materialize_simple_member(func)
    if func isa Type
        func = func()
    end
    if func isa CompositeAlgorithm || func isa Routine
        func = deepcopy(func)
    end
    return func
end

function reset!(sa::SimpleAlgo)
    reset!.(getfuncs(sa))
    sa.inc = 1
end

inc!(sa::SimpleAlgo) = sa.inc += 1

"""
Wrapper for functions to ensure proper semantics with the task system
"""
@inline function step!(sf::SimpleAlgo, args)
    a_idx = 1
    args = @inline unroll_funcs(sf, a_idx, sf.funcs, args)
    GC.safepoint()
    return args
end

function unroll_funcs(sf::SimpleAlgo, a_idx, funcs::T, args) where T<:Tuple
    returnval = nothing
    (;proc) = args
    if !run(proc)
        return args
    end
    if a_idx == sf.inc # For pausing/resuming
        returnval = @inline namedstep!(gethead(funcs), args)
        inc!(sf)
    end
    args = mergeargs(args, returnval)
    return @inline unroll_funcs(sf, a_idx+1, gettail(funcs), args)
end

function unroll_funcs(sf::SimpleAlgo, a_idx, ::Tuple{}, args)
    reset!(sf)
    return args
end

getfuncs(sa::SimpleAlgo) = sa.funcs
subalgorithms(sa::SimpleAlgo) = sa.funcs
Base.length(sa::SimpleAlgo) = length(sa.funcs)
Base.eachindex(sa::SimpleAlgo) = Base.eachindex(sa.funcs)
getfunc(sa::SimpleAlgo, idx) = sa.funcs[idx]
subalgotypes(sa::SimpleAlgo{FT}) where FT = FT.parameters
subalgotypes(saT::Type{<:SimpleAlgo{FT}}) where FT = FT.parameters

hasflag(sa::SimpleAlgo, flag) = flag in sa.flags
track_algo(sa::SimpleAlgo) = hasflag(sa, :trackalgo)

function newfuncs(sa::SimpleAlgo, funcs)
    nsr = NameSpaceRegistry(funcs)
    SimpleAlgo{typeof(funcs), typeof(nsr)}(funcs, sa.flags, nsr)
end

multipliers(sa::SimpleAlgo) = ntuple(_ -> 1, length(sa))
multipliers(::Type{<:SimpleAlgo{FT}}) where FT = ntuple(_ -> 1, length(FT.parameters))