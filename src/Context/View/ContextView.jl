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

#################################
####### CREATING VIEWS ##########
#################################

"""
Get a subcontext view for a specific subcontext
"""
@inline Base.view(pc::ProcessContext, instance::SA; inject = (;)) where SA <: AbstractIdentifiableAlgo = SubContextView{typeof(pc), getkey(instance), typeof(instance), typeof(inject)}(pc, instance; inject)
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
@inline Base.view(pc::PC, scv::CV; inject = (;)) where {PC <: ProcessContext, CV <: SubContextView} = @inline view(pc, this_instance(scv), inject(scv))

"""
View a view
"""
@inline function Base.view(scv::SubContextView{C,SubKey}, instance::SA) where {C, SubKey, SA <: AbstractIdentifiableAlgo}
    scopename = getkey(instance)
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
@inline Base.merge(scv::SubContextView, args) = error("Step, prepare and cleanup must return namedtuple, trying to merge $(args) into context from SubContextView $(scv)")
"""
Returns a merged context by merging the provided named tuple into the appropriate subcontexts
"""
@inline @generated function Base.merge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    algo_varnames = fieldnames(args)

    # These are the names in the subcontext after applying aliases
    subcontext_varnames = algo_to_subcontext_names.(Ref(scv), algo_varnames)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    
    for (var_idx, subcontext_varname) in enumerate(subcontext_varnames)

        if hasproperty(locations, subcontext_varname) # If the local variable exists

            target_location = getproperty(locations, subcontext_varname)

            target_subcontext = get_subcontextname(target_location)
            targetname = get_originalname(target_location)

            exprs = get!(merge_expressions_by_subcontext, target_subcontext, Expr[])
               
            # Expression for targetname = getproperty(args, algo_varnames[var_idx])
            # Which will be used to construct subcontext = (; targetname = getproperty(args, this_algo_varname), ...)
            push!(exprs, 
                  Expr(:(=), targetname, :(getproperty(args, $(QuoteNode(algo_varnames[var_idx]))))))

        else # New variable so add it to this subcontext
            exprs = get!(merge_expressions_by_subcontext, SubKey, Expr[])
            push!(exprs, 
                  Expr(:(=), subcontext_varname, :(getproperty(args, $(QuoteNode(algo_varnames[var_idx]))))))
        end
    end
    
    # Build the NamedTuple expression for mergetuple
    # There lines creates (;subcontext1 = (; varname1 = getproperty(args, :algoname_1), ...), subcontext2 = (...), ...)

    subcontext_exprs = [Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...))) 
                        for (subctx, field_exprs) in merge_expressions_by_subcontext]
    mergetuple_expr = Expr(:tuple, Expr(:parameters, subcontext_exprs...))
    
    # Return the expression that does the merge
    return quote
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        return newcontext
    end
end

"""
Merge but error if a var would be overwritten and only allow local merging
"""
@inline @generated function safemerge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    algo_varnames = fieldnames(args)

    # These are the names in the subcontext after applying aliases
    subcontext_varnames = algo_to_subcontext_names.(Ref(scv), algo_varnames)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    
    for (var_idx, subcontext_varname) in enumerate(subcontext_varnames)

        if hasproperty(locations, subcontext_varname) # If the local variable exists

            target_location = getproperty(locations, subcontext_varname)

            target_subcontext = get_subcontextname(target_location)

            if target_subcontext != SubKey
                return quote
                    algo_varnames = $(algo_varnames)
                    var_idx = $(var_idx)
                    target_subcontext = $(target_subcontext)
                    SubKey = $(SubKey)
                    error("Safe merge error: Trying to merge variable $(QuoteNode(algo_varnames[$var_idx])) into remote subcontext $(target_subcontext) from SubContextView $(SubKey). Only local variables can be merged using safemerge.")
                end
            else
                return quote
                    error("Safe merge error: Trying to overwrite variable $(QuoteNode(algo_varnames[$var_idx])) in SubContextView $(SubKey). Overwriting variables is not allowed in safemerge.")
                end
            end

        else # New variable so add it to this subcontext
            exprs = get!(merge_expressions_by_subcontext, SubKey, Expr[])
            push!(exprs, 
                  Expr(:(=), subcontext_varname, :(getproperty(args, $(QuoteNode(algo_varnames[var_idx]))))))
        end
    end
    
    # Build the NamedTuple expression for mergetuple
    # There lines creates (;subcontext1 = (; varname1 = getproperty(args, :algoname_1), ...), subcontext2 = (...), ...)

    subcontext_exprs = [Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...))) 
                        for (subctx, field_exprs) in merge_expressions_by_subcontext]
    mergetuple_expr = Expr(:tuple, Expr(:parameters, subcontext_exprs...))
    
    # Return the expression that does the merge
    return quote
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        return newcontext
    end
end

"""
Merge, but return view, useful for injecting variables that are not meant to be in the full context
"""
@inline inject(scv::SubContextView, args::NamedTuple) = @inline setfield(scv, :injected, merge(getinjected(scv), args))

"""
Instead of merging, replace the subcontext entirely with the provided args named tuple
Returns new context

This is to be used during the prepare phase, where entire subcontexts are replaced
"""
@inline @generated function Base.replace(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    names = fieldnames(args)
    if any( n -> n != SubKey, names) # Static check that only the correct subcontext is being replaced
        error("Trying to replace subcontext $(n) from SubContextView $(SubKey), only $(SubKey) can be replaced")
    end

    return quote
        newsubcontext = @inline newdata(subcontext_type(scv), getproperty(args, SubKey))
        old_context = @inline getcontext(scv)
        return replace(old_context, (; SubKey => newsubcontext))
    end
end

####################################
############## SHOW ################
####################################

function Base.show(io::IO, scv::SubContextView{CType, SubKey}) where {CType, SubKey}
    print(io, "SubContextView(", SubKey, ")")
end