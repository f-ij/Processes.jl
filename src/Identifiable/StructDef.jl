######################################
########## Scoped Algorithms #########
######################################
export IdentifiableAlgo, Unique

"""
Algorithm assigned to a namespace in a context
    Ids can be used te separate two algorithms with the same name and function

    The scopename will be set before when building a LoopAlgorithm, through the a NameSpaceRegistry
        This is done automatically when composing an algorithm and generally will be along the lines of 
        "Type Name of func"_num
    
    The scopename tells the algorithm where to look in the total context

    Id makes two IdentifiableAlgos different even if they have the same name and function
    This can be used to create multiple instances of the same algorithm with each their own state

    VarAliases are bridges from the scope to the runtime (prepare, step!, and cleanup) variables that
        the algorithm can get from a context. An alias definex Varname_in_subcontext => Varname_in_algorithm 

    AlgoName can be used when fusing multiple algorithms to give them custom names

"""
struct IdentifiableAlgo{F, Id, VarAliases, AlgoName, ScopeName} <: AbstractIdentifiableAlgo{F, Id, VarAliases, AlgoName, ScopeName}
    func::F
end

"""
Set an explicit name for an algorithm
"""
function IdentifiableAlgo(f, scopename::Symbol = Symbol(), id::Union{Nothing, Symbol, UUID} = nothing; customname = Symbol(), aliases...)
    if f isa AbstractIdentifiableAlgo # Don't wrap a IdentifiableAlgo again, just setid
        # return IdentifiableAlgo(getalgo(f), scopename, id(f); aliases...)
        return setid(f, id)
    end

    if isnothing(id) # Not unique so auto matching
        id = staticmatch_by(f) # Either match by f, or get the matching behavior of f if set
    end
    f = instantiate(f) # Don't wrap a type

    aliases = VarAliases(;aliases...)
    IdentifiableAlgo{typeof(f), id, aliases, customname, scopename}(f)
end

"""
Scoped Algorithms don't wrap other IdentifiableAlgos
    We just change the name of the algorithm
"""
IdentifiableAlgo(na::IdentifiableAlgo, name::Symbol) = setcontextkey(na, name)


Autoname(f, i::Int, prefix = "", id = nothing; customname = Symbol(), aliases...) = IdentifiableAlgo(f, Symbol(prefix, nameoftype(f),"_",string(i)), id; customname=customname, aliases...)
Autoname(f::IdentifiableAlgo, i::Int, prefix = ""; customname = Symbol(), aliases...) = setcontextkey(f, Symbol(prefix, nameoftype(getalgo(f)),"_",string(i)))


function Unique(f; customname = Symbol(), aliases...)
    f = instantiate(f)
    IdentifiableAlgo{typeof(f), uuid4(), VarAliases(;aliases...), customname, Symbol()}(f)
end
