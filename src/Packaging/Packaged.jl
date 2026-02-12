#=
Mirrors
  struct CompositeAlgorithm{T, Intervals, NSR, O, id, CustomName} <: LoopAlgorithm
    funcs::T
    inc::Base.RefValue{Int} # To track the intervals
    registry::NSR
    options::O
  end

But works like a ProcessAlgorithm, options wont work since SubContext is fully shared
=#

struct PackagedAlgo{T, Intervals, NSR, id, CustomName, ContextKey} <: AbstractIdentifiableAlgo{T, id, VarAliases{NamedTuple(),NamedTuple()}(), CustomName, ContextKey}
    funcs::T
    inc::Base.RefValue{Int} # To track the intervals
    simplereg::NSR
end


package(args...) = PackagedAlgo(args...)

function PackagedAlgo(comp::CompositeAlgorithm, name="")
    algoname(a::Any) = nothing
    flatfuncs, flatintervals = flatten(comp)
    reg = setup_registry(comp)

    # Translate routes to VarAliases
    routes = getoptions(comp, Route)
    id = TreeMatcher()
    # @show routes
    flatfuncs = map(x -> routes_to_varaliases(x, reg, routes...), flatfuncs)
    # @show getvaraliases.(flatfuncs)
    non_keyed_funcs = setcontextkey.(flatfuncs, nothing)
    # @show getvaraliases.(non_keyed_funcs)
    subpackages = map(func -> SubPackage(func, id), non_keyed_funcs)
    # @show getvaraliases.(subpackages)
    ## If shares are used, error and suggest using varaliases
    ## TODO: Support autoalias (e.g. all variables get a postfix)

    customname = name == "" ? isnothing(algoname(comp)) ? Symbol() : algoname(comp) : Symbol(name)

    states = get_states(comp)
    stateintervals = ntuple(i -> 1, length(states))

    subs_and_intervals = zip((states..., subpackages...), (stateintervals..., flatintervals...))
    registry = unrollreplace(SimpleRegistry(), subs_and_intervals...) do reg, sub_interval
        reg, _ = add(reg, first(sub_interval), 1/last(sub_interval))
        return reg
    end
    
    PackagedAlgo{typeof(subpackages), flatintervals, typeof(registry), id, customname, nothing}(subpackages, Ref(1), registry)
    # PackagedAlgo(flatfuncs, flatintervals, customname=name)
end


Base.getindex(ca::PackagedAlgo, i) = getalgos(ca)[i]

function Autokey(pa::PackagedAlgo, i::Int, prefix = Symbol())
    nameof = getname(pa) == Symbol() ? :PackagedAlgo : getname(pa)
    # setparameter(pa, 6, Symbol(prefix, nameof, "_", string(i))) 
    # setcontextkey(pa, Symbol(prefix, nameof, "_", string(i)))
    setcontextkey(pa, static_symbol(Symbol(nameof), :_, i))
end


#################################
####### Properties/Traits #######
#################################

@inline inc(ca::PackagedAlgo) = ca.inc[]
@inline inc!(ca::PackagedAlgo) = (ca.inc[] += 1)
@inline intervals(ca::Union{PackagedAlgo{T,I},Type{<:PackagedAlgo{T,I}}}) where {T,I} = I
@inline interval(ca::Union{PackagedAlgo{T,I},Type{<:PackagedAlgo{T,I}}}, i) where {T,I} = intervals(ca)[i]
@inline getalgotype(::Union{PackagedAlgo{T,I}, Type{<:PackagedAlgo{T,I}}}, idx) where {T,I} = T.parameters[idx]
@inline numalgos(ca::Union{PackagedAlgo{T,I}, Type{<:PackagedAlgo{T,I}}}) where {T,I} = length(T.parameters)
# @inline match_id(::Type{<:PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}) where {T,I,NSR,id,CustomName,ContextKey} = id

@inline getname(::Union{PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}, Type{<:PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}}) where {T,I,NSR,id,CustomName,ContextKey} = CustomName
@inline getmultiplier(ca::PackagedAlgo, subpackage::SubPackage) = static_get_multiplier(getregistry(ca), subpackage)

@inline getregistry(ca::PackagedAlgo) = getfield(ca, :simplereg)
#### FOR REGISTRY ###
@inline match_by(::Union{Type{<:PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}, PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}) where {T,I,NSR,id,CustomName,ContextKey} = id
@inline registry_entrytype(::Type{<:PackagedAlgo}) = PackagedAlgo

reset!(ca::PackagedAlgo) = (ca.inc[] = 1; reset!.(ca.funcs))

get_processentities(ca::PackagedAlgo) = getentries(getregistry(ca))
########################################
####### Identifiable Interface  ########
########################################

@inline getkey(sa::Union{<:PackagedAlgo{T, I, NSR, id, CustomName, ContextKey}, Type{<:PackagedAlgo{T, I, NSR, id, CustomName, ContextKey}}}) where {T,I,NSR,id,CustomName,ContextKey} = ContextKey
@inline setkey(sa::PackagedAlgo, newkey) = setparameter(sa, 6, newkey)
@inline getalgo(sa::PackagedAlgo{F}) where {F} = error("Cannot get singular algo from a PackagedAlgo. Use `getalgos` instead.")
@inline getalgos(ca::PackagedAlgo) = ca.funcs
@inline getalgo(sa::PackagedAlgo{F}, i) where {F} = getalgos(sa)[i]

@inline setid(sa::PackagedAlgo, newid) = setparameter(sa, 4, newid)

function setcontextkey(package::PackagedAlgo, key::Symbol)
    # newfuncs = map(func -> setcontextkey(func, key), package.funcs)
    newfuncs = setcontextkey.(package.funcs, key)
    newreg = replace_all_keys(getregistry(package), key)

    pack = setfield(package, :funcs, newfuncs)
    pack = setfield(pack, :simplereg, newreg)
    setparameter(pack, 6, key)
end

@inline function replacecontextkeys(a::PackagedAlgo, key)
    if contextkey == contextkey(a)
        return setcontextkey(a, key)
    end
    return a
end
@inline setvaraliases(sa::PackagedAlgo, newaliases) = setparameter(sa, 3, newaliases)
