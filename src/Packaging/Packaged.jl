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
end

function PackagedAlgo(comp::CompositeAlgorithm, name="")
    flatfuncs, flatintervals = flatten(comp)
    reg = getregistry(comp)

    # Translate routes to VarAliases
    routes = getoptions(comp, Route)

    flatfuncs = map(x -> set_aliases_from_routes(x, reg, routes...), flatfuncs)
    non_keyed_funcs = setcontextkey.(flatfuncs, nothing)

    ## If shares are used, error and suggest using varaliases
    ## TODO: Support autoalias (e.g. all variables get a postfix)

    customname = name == "" ? algoname(comp) === nothing ? Symbol() : algoname(comp) : Symbol(name)
    PackagedAlgo{typeof(non_keyed_funcs), typeof(flatintervals), typeof(reg), id(comp), customname, nothing}(non_keyed_funcs, Ref(1))
    # PackagedAlgo(flatfuncs, flatintervals, customname=name)
end



#################################
####### Properties/Traits #######
#################################

inc(ca::PackagedAlgo) = ca.inc[]
intervals(ca::Union{PackagedAlgo{T,I},Type{<:PackagedAlgo{T,I}}}) where {T,I} = I
interval(ca::PackagedAlgo, i) = intervals(ca)[i]

########################################
####### Identifiable Interface  ########
########################################
@inline getkey(sa::Union{<:PackagedAlgo{T, I, NSR, id, CustomName, ContextKey}, Type{<:PackagedAlgo{T, I, NSR, id, CustomName, ContextKey}}}) where {T,I,NSR,id,CustomName,ContextKey} = CustomName
@inline getalgo(sa::PackagedAlgo{F}) where {F} = error("Cannot get singular algo from a PackagedAlgo. Use `getalgos` instead.")
@inline getalgos(ca::PackagedAlgo) = ca.funcs
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
@inline setaliases(sa::PackagedAlgo, newaliases) = setparameter(sa, 3, newaliases)
