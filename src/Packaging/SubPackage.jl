struct SubPackage{F, ID, Aliases, ContextKey} <: AbstractIdentifiableAlgo{F, ID, Aliases, nothing, ContextKey}
    func::F
end

function SubPackage(algo::IdentifiableAlgo, parentid, aliases = nothing, contextkey = nothing)
    treeid = getchild(parentid, id(algo))
    if isnothing(aliases)
        aliases = getvaraliases(algo)
    end
    algo = getalgo(algo)
    
    SubPackage{typeof(algo), treeid, aliases, contextkey}(algo)
end


##################################
######### Identifiable ##########
##################################


"""
Key of subpackage not set by registry
"""

Autokey(ps::SubPackage{F}, i::Int, prefix = "") where {F} = ps
getkey(ps::Union{SubPackage{F, ID, Aliases, ContextKey}, Type{<:SubPackage{F,ID,Aliases,ContextKey}}}) where {F, ID, Aliases, ContextKey} = ContextKey
getalgo(ps::SubPackage{F}) where {F} = ps.func
setcontextkey(ps::SubPackage, key::Symbol) = setparameter(ps, 4, key)
setid(ps::SubPackage, newid) = setparameter(ps, 2, newid)
getvaraliases(ps::Union{SubPackage{F, ID, Aliases, ContextKey}, Type{<:SubPackage{F,ID,Aliases,ContextKey}}}) where {F, ID, Aliases, ContextKey} = Aliases
setvaraliases(ps::SubPackage, newaliases) = setparameter(ps, 3, newaliases)
"""
SubPackages match with their parent and themselves
    This is to allow for matching with the parent package in a registry
    while still allowing for subpackages to be distinguished from each other if needed.
"""
match_by(ps::Union{SubPackage{T,ID}, Type{<:SubPackage{T,ID}}}) where {T, ID} = ID
registry_entrytype(::Type{<:SubPackage}) = PackagedAlgo

###############################
######### Tools ###############
################################



####################################
####### Prepare-Step-Cleanup #######
####################################

function prepare(ps::SubPackage, context)
    viewed = view(context, ps)
    returnvals = prepare(getalgo(ps), viewed)
    merge(viewed, returnvals)
end

function step!(ps::SubPackage, context)
    viewed = view(context, ps)
    returnvals = step!(getalgo(ps), viewed)
    merge(viewed, returnvals)
end

function cleanup(ps::SubPackage, context)
    viewed = view(context, ps)
    returnvals = cleanup(getalgo(ps), viewed)
    merge(viewed, returnvals)
end



