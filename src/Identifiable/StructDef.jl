######################################
########## Scoped Algorithms #########
######################################
abstract type AbstractIdentifiableAlgo end
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
struct IdentifiableAlgo{F, Id, VarAliases, AlgoName, ScopeName} <: AbstractIdentifiableAlgo
    func::F
end

"""
Set an explicit name for an algorithm
"""
function IdentifiableAlgo(f, scopename::Symbol = Symbol(), id::Union{Nothing, Symbol, UUID} = nothing; customname = Symbol(), aliases...)
    if f isa IdentifiableAlgo # Don't wrap a IdentifiableAlgo again
        return IdentifiableAlgo(getalgorithm(f), scopename, id(f); aliases...)
    end

    if isnothing(id) # Not unique so auto matching
        if f isa Type  
            id = f # If no id is given, match by type
        else
            id = f # Otherwise match by value
        end
    end
    f = instantiate(f) # Don't wrap a type

    aliases = VarAliases(;aliases...)
    IdentifiableAlgo{typeof(f), id, aliases, customname, scopename}(f)
end

"""
Scoped Algorithms don't wrap other IdentifiableAlgos
    We just change the name of the algorithm
"""
IdentifiableAlgo(na::IdentifiableAlgo, name::Symbol) = changecontextname(na, name)



Autoname(f, i::Int, prefix = "", id = nothing; customname = Symbol(), aliases...) = IdentifiableAlgo(f, Symbol(prefix, nameoftype(f),"_",string(i)), id; customname=customname, aliases...)
Autoname(f::IdentifiableAlgo, i::Int, prefix = ""; customname = Symbol(), aliases...) = changecontextname(f, Symbol(prefix, nameoftype(getalgorithm(f)),"_",string(i)))


function Unique(f; customname = Symbol(), aliases...)
    f = instantiate(f)
    IdentifiableAlgo{typeof(f), uuid4(), VarAliases(;aliases...), customname, Symbol()}(f)
end
