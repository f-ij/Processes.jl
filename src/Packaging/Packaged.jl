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

function PackagedAlgo(comp::CompositeAlgorithm, name="")
    flatfuncs, flatintervals = flatten(comp)
    reg = getregistry(comp)

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

    customname = name == "" ? algoname(comp) === nothing ? Symbol() : algoname(comp) : Symbol(name)

    subs_and_intervals = zip(subpackages, flatintervals)
    registry = unrollreplace(SimpleRegistry(), subs_and_intervals...) do reg, sub_interval
        reg, _ = add(reg, first(sub_interval), 1/last(sub_interval))
        return reg
    end
    
    PackagedAlgo{typeof(subpackages), flatintervals, typeof(registry), id, customname, nothing}(subpackages, Ref(1), registry)
    # PackagedAlgo(flatfuncs, flatintervals, customname=name)
end


Base.getindex(ca::PackagedAlgo, i) = getalgos(ca)[i]

function Autokey(pa::PackagedAlgo, i::Int, prefix = "")
    nameof = !isnothing(getname(pa)) ? getname(pa) : :PackagedAlgo
    # setparameter(pa, 6, Symbol(prefix, nameof, "_", string(i))) 
    setcontextkey(pa, Symbol(prefix, nameof, "_", string(i)))
end

#################################
####### Properties/Traits #######
#################################

@inline inc(ca::PackagedAlgo) = ca.inc[]
@inline inc!(ca::PackagedAlgo) = (ca.inc[] += 1)
@inline intervals(ca::Union{PackagedAlgo{T,I},Type{<:PackagedAlgo{T,I}}}) where {T,I} = I
@inline interval(ca::Union{PackagedAlgo{T,I},Type{<:PackagedAlgo{T,I}}}, i) where {T,I} = intervals(ca)[i]
@inline getalgotype(::Union{PackagedAlgo{T,I}, Type{<:PackagedAlgo{T,I}}}, idx) where {T,I} = T.parameters[idx]
@inline numfuncs(ca::Union{PackagedAlgo{T,I}, Type{<:PackagedAlgo{T,I}}}) where {T,I} = length(T.parameters)
# @inline match_id(::Type{<:PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}) where {T,I,NSR,id,CustomName,ContextKey} = id

@inline getname(::Union{PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}, Type{<:PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}}) where {T,I,NSR,id,CustomName,ContextKey} = CustomName
@inline getmultiplier(ca::PackagedAlgo, subpackage::SubPackage) = static_get_multiplier(getregistry(ca), subpackage)

@inline getregistry(ca::PackagedAlgo) = getfield(ca, :simplereg)
#### FOR REGISTRY ###
@inline match_by(::Type{<:PackagedAlgo{T,I,NSR,id,CustomName,ContextKey}}) where {T,I,NSR,id,CustomName,ContextKey} = id
@inline registry_entrytype(::Type{<:PackagedAlgo}) = PackagedAlgo

########################################
####### Identifiable Interface  ########
########################################

@inline getkey(sa::Union{<:PackagedAlgo{T, I, NSR, id, CustomName, ContextKey}, Type{<:PackagedAlgo{T, I, NSR, id, CustomName, ContextKey}}}) where {T,I,NSR,id,CustomName,ContextKey} = ContextKey
@inline getalgo(sa::PackagedAlgo{F}) where {F} = error("Cannot get singular algo from a PackagedAlgo. Use `getalgos` instead.")
@inline getalgos(ca::PackagedAlgo) = ca.funcs
@inline getalgo(sa::PackagedAlgo{F}, i) where {F} = getalgos(sa)[i]

@inline setid(sa::PackagedAlgo, newid) = setparameter(sa, 4, newid)
function setcontextkey(package::PackagedAlgo, key::Symbol)
    newfuncs = map(func -> setcontextkey(func, key), package.funcs)
    pack = setfield(package, :funcs, newfuncs)
    setparameter(pack, 6, key)
end
@inline function replacecontextkeys(a::PackagedAlgo, key)
    if contextkey == contextkey(a)
        return setcontextkey(a, key)
    end
    return a
end
@inline setvaraliases(sa::PackagedAlgo, newaliases) = setparameter(sa, 3, newaliases)
