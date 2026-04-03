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
@inline Base.getkey(ps::Union{SubPackage{F, ID, Aliases, ContextKey}, Type{<:SubPackage{F,ID,Aliases,ContextKey}}}) where {F, ID, Aliases, ContextKey} = ContextKey
@inline getalgo(ps::SubPackage{F}) where {F} = ps.func
@inline setcontextkey(ps::SubPackage, key::Symbol) = setparameter(ps, 4, key)
@inline setid(ps::SubPackage, newid) = setparameter(ps, 2, newid isa UUID ? SimpleId(newid) : newid)
@inline getvaraliases(ps::Union{SubPackage{F, ID, Aliases, ContextKey}, Type{<:SubPackage{F,ID,Aliases,ContextKey}}}) where {F, ID, Aliases, ContextKey} = Aliases
@inline setvaraliases(ps::SubPackage, newaliases) = setparameter(ps, 3, newaliases)
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
####### Init-Step-Cleanup #######
####################################

@inline function init(ps::SubPackage, context::C) where C
    viewed = @inline view(context, ps)
    returnvals = @inline init(getalgo(ps), viewed)
    @inline unstablemerge(viewed, returnvals)
end

@inline function step!(ps::SP, context::C, typestable::S = Stable()) where {SP<:SubPackage, C, S}
    viewed = @inline view(context, ps)
    returnvals = @inline step!(getalgo(ps), viewed)
    if typestable isa Stable
        return @inline stablemerge(viewed, returnvals)
    else
        return @inline unstablemerge(viewed, returnvals)
    end
end

@inline function cleanup(ps::SubPackage, context::C) where C
    viewed = @inline view(context, ps)
    returnvals = @inline cleanup(getalgo(ps), viewed)
    @inline merge(viewed, returnvals)
end

@inline function step!_expr(ps::Type{<:SubPackage}, context::Type{C}, funcname::Symbol, stability::Symbol) where {C<:AbstractContext}
    merge_expr = if stability === :stable
        :(context = @inline stablemerge(viewed, returnvals))
    elseif stability === :unstable
        :(context = @inline unstablemerge(viewed, returnvals))
    else
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    end

    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        viewed = @inline view(context, $funcname)
        returnvals = @inline step!(getalgo($funcname), viewed)
        $merge_expr
    end
end
