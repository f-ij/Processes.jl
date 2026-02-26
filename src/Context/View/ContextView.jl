export getglobals
#################################
########## Properties ###########
#################################
varaliases(scv::Union{SubContextView{CType, SubKey, T, NT, Aliases}, Type{<:SubContextView{CType, SubKey, T, NT, Aliases}}}) where {CType, SubKey, T, NT, Aliases} = Aliases

@inline this_instance(scv::SubContextView) = getfield(scv, :instance)


@inline getglobals(scv::SubContextView) = getglobals(getcontext(scv))
@inline getglobal(scv::SubContextView, name::Symbol) = getglobals(getcontext(scv), name)

@inline getcontext(scv::SubContextView) = @inline getfield(scv, :context)
@inline getsubcontext(scv::SubContextView{CType, SubKey}) where {CType, SubKey} = @inline getproperty(getcontext(scv), SubKey)


getinjected(scv::SubContextView) = getfield(scv, :injected)
injectedfieldnames(scvt::Union{SubContextView{CType, SubKey, T, NT}, Type{<:SubContextView{CType, SubKey, T, NT}}}) where {CType, SubKey, T, NT} = fieldnames(NT)


"""
Helper to merge into a subcontext target in a namedtuple
    Merge nt's are (;targetsubcontext => (;targetname1 = value1, targetname2 = value2,...),...)

This merges a set of named tuples into the appropriate subcontexts in the provided context
"""
function algo_to_subcontext_names(scv::Union{SubContextView{CType, SubKey, T, NT, Aliases}, Type{<:SubContextView{CType, SubKey, T, NT, Aliases}}}, name::Symbol) where {CType, SubKey, T, NT, Aliases}
    _aliases = varaliases(scv)
    return @inline algo_to_subcontext_names(_aliases, name)
end

@inline function Base.keys(scv::SCV) where SCV <: SubContextView
    locations = @inline get_all_locations(scv)
    return keys(locations)
end

@inline function Base.haskey(scv::SCV, key) where SCV <: SubContextView
    locations = @inline get_all_locations(scv)
    return haskey(locations, key)
end

#################################
####### CREATING VIEWS ##########
#################################

"""
Get a subcontext view for a specific subcontext
"""
@inline function Base.view(pc::ProcessContext, instance::SA; inject = (;)) where SA <: AbstractIdentifiableAlgo
    key = getkey(instance)
    # TODO: no key should always be nothing
    if key == Symbol() || isnothing(key)
        key = getkey(getregistry(pc)[instance])
    end
    SubContextView{typeof(pc), key, typeof(instance), typeof(inject)}(pc, instance; inject)
end

@inline function Base.view(pc::ProcessContext{D}, instance::AbstractIdentifiableAlgo{T, nothing}, inject = (;)) where {D, T}
    named_instance = getregistry(pc)[instance]
    return view(pc, named_instance; inject)
end

"""
Create a view from a non-scoped instance by looking it up in the registry
"""
@inline function Base.view(pc::ProcessContext, instance::I, inject = (;)) where I
    scoped_instance = @inline static_get(getregistry(pc), instance)
    return SubContextView{typeof(pc), getkey(scoped_instance), typeof(scoped_instance), typeof(inject)}(pc, scoped_instance; inject=inject)
end

"""
Regenerate a SubContextView from its type
"""
@inline function Base.view(pc::PC, scv::CV; inject = (;)) where {PC <: ProcessContext, CV <: SubContextView}
    @inline view(pc, this_instance(scv), inject(scv))
end

"""
View a view
"""
@inline function Base.view(scv::SubContextView{C,SubKey}, instance::SA) where {C, SubKey, SA <: AbstractIdentifiableAlgo}
    scoped_instance = @inline static_get(getregistry(scv), instance)
    scopename = getkey(scoped_instance)
    @assert scopename == SubKey "Trying to view SubContextView of subcontext $(SubKey) with instance of subcontext $(scopename)"
    context = getcontext(scv)
    return view(context, instance)
end


##########################################
################# TYPES ##################
##########################################

"""
Get the type of the original subcontext from the view
"""
@inline subcontext_type(scv::Union{SubContextView{CType, SubKey}, Type{<:SubContextView{CType, SubKey}}}) where {CType<:ProcessContext, SubKey} = subcontext_type(CType, SubKey)



##########################################
############### MERGING ##################
##########################################

"""
Fallback merge if nothing is merged that just returns the original context
"""
@inline Base.merge(scv::SubContextView, ::Nothing) = getcontext(scv)
@inline Base.merge(scv::SubContextView, args) = error("Step, init and cleanup must return namedtuple, trying to merge $(args) into context from SubContextView $(scv)")


####################################
############## SHOW ################
####################################

function Base.show(io::IO, scv::SubContextView{CType, SubKey}) where {CType, SubKey}
    print(io, "SubContextView(", SubKey, ")")
end