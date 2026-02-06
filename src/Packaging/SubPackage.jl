struct SubPackage{F, ID, Aliases, ContextKey} <: AbstractIdentifiableAlgo{F, ID, Aliases, nothing, ContextKey}
    func::F
end

function SubPackage(func::IdentifiableAlgo, parentid, aliases = nothing, contextkey = nothing)
    treeid = getchild(parentid, id(func))
    func = getalgo(func)
    SubPackage{typeof(func), treeid, aliases, contextkey}(func)
end

"""
Key of subpackage not set by registry
"""
Autokey(ps::SubPackage{F}, i::Int, prefix = "") where {F} = ps

getalgo(ps::SubPackage{F}) where {F} = ps.func
setcontextkey(ps::SubPackage, key::Symbol) = setparameter(ps, 4, key)
setid(ps::SubPackage, newid) = setparameter(ps, 2, newid)

"""
SubPackages match with their parent and themselves
    This is to allow for matching with the parent package in a registry
    while still allowing for subpackages to be distinguished from each other if needed.
"""
match_by(ps::Union{SubPackage{T,ID}, Type{<:SubPackage{T,ID}}}) where {T, ID} = ID

registry_entrytype(::Type{<:SubPackage}) = PackagedAlgo


####################################
####### Prepare-Step-Cleanup #######
####################################

function prepare(ps::SubPackage, context)
    viewed = view(context, ps)
    returnvals = prepare(getalgo(ps), viewed)
    merge(viewed, returnvals)
end



