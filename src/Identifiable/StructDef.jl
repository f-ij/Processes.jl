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

    VarAliases are bridges from the scope to the runtime (init, step!, and cleanup) variables that
        the algorithm can get from a context. An alias definex Varname_in_subcontext => Varname_in_algorithm 

    AlgoName can be used when fusing multiple algorithms to give them custom names

"""
struct IdentifiableAlgo{F, Id, VarAliases, AlgoName, Key} <: AbstractIdentifiableAlgo{F, Id, VarAliases, AlgoName, Key}
    func::F
end

"""
Set an explicit name for an algorithm
"""
@inline function IdentifiableAlgo(f::F, contextkey::Symbol, id::Union{Nothing, Symbol, UUID} = nothing; customname = Symbol(), aliases...) where F
    if f isa AbstractIdentifiableAlgo # Don't wrap a IdentifiableAlgo again, just setid
        # return IdentifiableAlgo(getalgo(f), contextkey, id(f); aliases...)
        if !isnothing(id) && !isnothing(getid(f))
            error("Trying to wrap an IdentifiableAlgo with a new id")
        end
        return setcontextkey(f, contextkey)
    end

    if isnothing(id) # Not unique so auto matching
        id = match_by(f) # Either match by f, or get the matching behavior of f if set
        # if 
    end
    f = instantiate(f) # Don't wrap a type
    aliases = VarAliases(;aliases...)

    IdentifiableAlgo{typeof(f), id, aliases, customname, contextkey}(f)::IdentifiableAlgo{typeof(f), id, aliases, customname, contextkey}
end

IdentifiableAlgo(f::F; key = Symbol(), id = nothing, customname = Symbol(), aliases...) where F = @inline IdentifiableAlgo(f, key, id; customname, aliases...)

"""
Scoped Algorithms don't wrap other IdentifiableAlgos
    We just change the name of the algorithm
"""
IdentifiableAlgo(na::IdentifiableAlgo, name::Symbol) = setcontextkey(na, name)

function Autokey(f::F, i::Int, id = nothing; customname = Symbol(), aliases...) where F
    f = instantiate(f)
    TName = nameof(typeof(f))
    key = @inline static_symbol(TName,(:_), i)
    @inline IdentifiableAlgo(f, key, id; customname, aliases...)
end

function Autokey(f::IA, i::Int; customname = Symbol(), aliases...) where IA <: IdentifiableAlgo
    TName = nameoftype(getalgo(f))
    key = @inline static_symbol(TName,(:_), i)
    setcontextkey(f, key)
end


function Unique(f; customname = Symbol(), aliases...)
    f = instantiate(f)
    IdentifiableAlgo{typeof(f), uuid4(), VarAliases(;aliases...), customname, Symbol()}(f)
end
