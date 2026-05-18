"""
Package-local executable child for `NewPackage`.

`NewSubPackage` is identifiable, but it is not meant to become a root registry
entry. Its `registry_entrytype` points at `NewPackage`, and its tree matcher is
a child of the containing package matcher. A lookup for a new subpackage
therefore resolves to the registered package entry, which is exactly the scope
that owns the child data.
"""
struct NewSubPackage{F, ID, Aliases, ContextKey} <: AbstractIdentifiableAlgo{F, ID, Aliases, nothing, ContextKey}
    func::F
end

@inline _newsubpackage_child_id(algo::AbstractIdentifiableAlgo) = id(algo)
@inline _newsubpackage_child_id(algo) = match_by(algo)

"""
Wrap `algo` as a child of a `NewPackage`.

Aliases are stored on the child wrapper, mirroring `IdentifiableAlgo` alias
semantics. The wrapped algorithm itself is kept alias-free so package-local
wiring does not leak into standalone use of the algorithm value.
"""
function NewSubPackage(algo, parentid, aliases = VarAliases(), contextkey = nothing)
    algo = instantiate(algo)
    child_id = getchild(parentid, _newsubpackage_child_id(algo))
    return NewSubPackage{typeof(algo), child_id, aliases, contextkey}(algo)
end

function NewSubPackage(algo::AbstractIdentifiableAlgo, parentid, aliases = getvaraliases(algo), contextkey = nothing)
    child = getalgo(algo)
    child_id = getchild(parentid, id(algo))
    return NewSubPackage{typeof(child), child_id, aliases, contextkey}(child)
end

@inline Base.getkey(::Union{NewSubPackage{F, ID, Aliases, ContextKey}, Type{<:NewSubPackage{F, ID, Aliases, ContextKey}}}) where {F, ID, Aliases, ContextKey} = ContextKey
@inline getalgo(child::NewSubPackage) = getfield(child, :func)
@inline getalgos(child::NewSubPackage) = (getalgo(child),)
@inline getvaraliases(::Union{NewSubPackage{F, ID, Aliases, ContextKey}, Type{<:NewSubPackage{F, ID, Aliases, ContextKey}}}) where {F, ID, Aliases, ContextKey} = Aliases
@inline setvaraliases(child::NewSubPackage, aliases) = setparameter(child, 3, aliases)
@inline setcontextkey(child::NewSubPackage, key::Symbol) = setparameter(child, 4, key)
@inline Autokey(child::NewSubPackage, i::Int, prefix = Symbol()) = child

@inline match_by(::Union{NewSubPackage{F, ID}, Type{<:NewSubPackage{F, ID}}}) where {F, ID} = ID
@inline registry_entrytype(::Type{<:NewSubPackage}) = NewPackage
