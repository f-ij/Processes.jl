### FALLBACKS ###
id(obj::Any) = nothing
hasid(::Any) = false
replacecontextkeys(a::Any, name_replacements) = a
setcontextkey(a::Any, newname) = a
algotype(f::Any) = typeof(f)



abstract type AbstractIdentifiableAlgo{F,Id,VarAliases,AlgoName,ContextKey} end
staticmach_by(::Union{<:AbstractIdentifiableAlgo{F,Id},Type{<:AbstractIdentifiableAlgo{F,Id}}}) where {F,Id} = Id

@inline contextkey(sa::Union{AbstractIdentifiableAlgo{F, Id, Aliases, AlgoName, ContextKey}, Type{<:AbstractIdentifiableAlgo{F, Id, Aliases, AlgoName, ContextKey}}}) where {F, Id, Aliases, AlgoName, ContextKey} = ContextKey
@inline id(sa::Union{<:AbstractIdentifiableAlgo{F,Id},Type{<:AbstractIdentifiableAlgo{F,Id}}}) where {F,Id} = Id
@inline hasid(sa::AbstractIdentifiableAlgo) = !isnothing(id(sa))
@inline algotype(::Union{AbstractIdentifiableAlgo{F},Type{<:AbstractIdentifiableAlgo{F}}}) where {F} = F


algoname(sa::AbstractIdentifiableAlgo{F,Id,Aliases,AlgoName}) where {F,Id,Aliases,AlgoName} = AlgoName == Symbol() ? nothing : AlgoName


@inline function getkey(sat::Type{<:AbstractIdentifiableAlgo{F,Id,Aliases,AlgoName,ContextKey}}) where {F,Id,Aliases,AlgoName,ContextKey}
    ContextKey
end

function mergereturn(sa::Union{<:AbstractIdentifiableAlgo{F,Id,Aliases,AlgoName,ContextKey}, Type{<:AbstractIdentifiableAlgo{F,Id,Aliases,AlgoName,ContextKey}}}, 
    args, 
    returnval) where {F,Id,Aliases,AlgoName,ContextKey}
    (; args..., (ContextKey => (; getproperty(returnval, ContextKey)..., returnval...)))
end

@inline varaliases(sa::Union{AbstractIdentifiableAlgo{F,Id,Aliases},Type{<:AbstractIdentifiableAlgo{F,Id,Aliases}}}) where {F,Id,Aliases} = Aliases



########################################
############### Traits #################
########################################

@inline setid(sa::AbstractIdentifiableAlgo, newid) = error("Not implemented for type: $(typeof(sa))")
@inline getalgo(sa::AbstractIdentifiableAlgo{F}) where {F} = error("Not implemented for type: $(typeof(sa))")
@inline getalgos(sa::AbstractIdentifiableAlgo) = error("Not implemented for type: $(typeof(sa))")



################################################
########## SETTING PROPERTIES/TRAITS ###########
################################################

setcontextkey(sa::AbstractIdentifiableAlgo, newname::Symbol) = error("Not implemented for type: $(typeof(sa))")
replacecontextkeys(a::AbstractIdentifiableAlgo, ::Any) = error("Not implemented for type: $(typeof(a))")
setaliases(sa::AbstractIdentifiableAlgo, newaliases) = error("Not implemented for type: $(typeof(sa))")
