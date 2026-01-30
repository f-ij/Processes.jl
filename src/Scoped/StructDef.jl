######################################
########## Scoped Algorithms #########
######################################
abstract type AbstractScopedAlgorithm end
export ScopedAlgorithm, Unique

"""
Algorithm assigned to a namespace in a context
    Ids can be used te separate two algorithms with the same name and function

    The scopename will be set before when building a LoopAlgorithm, through the a NameSpaceRegistry
        This is done automatically when composing an algorithm and generally will be along the lines of 
        "Type Name of func"_num
    
    The scopename tells the algorithm where to look in the total context

    Id makes two ScopedAlgorithms different even if they have the same name and function
    This can be used to create multiple instances of the same algorithm with each their own state

    VarAliases are bridges from the scope to the runtime (prepare, step!, and cleanup) variables that
        the algorithm can get from a context. An alias definex Varname_in_subcontext => Varname_in_algorithm 

    AlgoName can be used when fusing multiple algorithms to give them custom names

"""
struct ScopedAlgorithm{F, ScopeName, Id, VarAliases, AlgoName} <: AbstractScopedAlgorithm
    func::F
end

"""
Set an explicit name for an algorithm
"""
function ScopedAlgorithm(f, scopename::Symbol = Symbol(), id::Union{Nothing, Symbol, UUID} = nothing; customname = Symbol(), aliases...)
    if f isa ScopedAlgorithm # Don't wrap a ScopedAlgorithm again
        return ScopedAlgorithm(getalgorithm(f), scopename, id(f); aliases...)
    end

    # if hasid(f)
    #     @assert (id(f) == id) || (id = nothing) "Cannot change id of an already identified algorithm"
    #     id = id(f)
    # end

    aliases = VarAliases(;aliases...)
    f = instantiate(f) # Don't wrap a type
    ScopedAlgorithm{typeof(f), scopename, id, aliases, customname}(f)
end
Autoname(f, i::Int, prefix = "", id = nothing; customname = Symbol(), aliases...) = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)),"_",string(i)), id, VarAliases(;aliases...), customname}(f)
Autoname(f::ScopedAlgorithm, i::Int, prefix = ""; customname = Symbol(), aliases...) = ScopedAlgorithm{typeof(f.func), Symbol(prefix, nameof(typeof(f.func)),"_",string(i)), id(f), VarAliases(;aliases...), customname}(f.func)
DefaultScope(f, prefix = ""; customname = Symbol(), aliases...) = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)),"_", 0), :default, VarAliases(;aliases...), customname}(f) 

function Unique(f; customname = Symbol(), aliases...)
    f = instantiate(f)
    ScopedAlgorithm{typeof(f),nothing, uuid4(), VarAliases(;aliases...), customname}(f)
end
