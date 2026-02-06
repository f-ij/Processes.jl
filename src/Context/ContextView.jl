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
########## Variable Locations ############
##########################################

# This is the basis for the viewsystem. Variables in and out get mapped to locations in the full context

"""
Get the names for local variables in the subcontext
    Applies aliases if present
"""
function get_local_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubKey}} where {CType, SubKey}
    _subcontext_type = subcontext_type(SCT)
    local_varnames = keys(_subcontext_type)

    localst = ntuple(i ->VarLocation{:local}(SubKey, local_varnames[i]), length(local_varnames))
    return NamedTuple{(local_varnames...,)}(localst)
end

function get_shared_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubKey}} where {CType, SubKey}
    _subcontext_type = subcontext_type(SCT)

    shared_context_names = getsharedcontext_names(_subcontext_type)

    sharedvars = named_flat_collect_broadcast(shared_context_names) do name
        shared_subcontext_type = subcontext_type(CType, name)
        shared_varnames = keys(shared_subcontext_type)
        pairs = (shared_varnames[i] => VarLocation{:subcontext}(name, shared_varnames[i]) for i in 1:length(shared_varnames))
        return NamedTuple(pairs)
    end
    return sharedvars
end

function get_routed_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubKey}} where {CType, SubKey}
    _subcontext_type = subcontext_type(SCT)
    sharedvars = getsharedvars_types(_subcontext_type)

    routedvars = named_flat_collect_broadcast(sharedvars) do sv
        fromname = get_fromname(sv)
        _localnames = localnames(sv)
        _subvarcontextnames = subvarcontextnames(sv)
        pairs = (_localnames[i] => VarLocation{:subcontext}(fromname, _subvarcontextnames[i]) for i in 1:length(_localnames))
        return NamedTuple(pairs)
    end

    return routedvars
end

function get_injected_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubKey}} where {CType, SubKey}
    injected_vars = injectedfieldnames(SCT)
    injst = ntuple(i ->VarLocation{:injected}(SubKey, injected_vars[i]), length(injected_vars))
    return NamedTuple{(injected_vars...,)}(injst)
end


"""
Generate a namedtuple of localtuple => VarLocation
"""
get_varlocations(scv::SubContextView) = @inline get_varlocations(typeof(scv))
@inline @generated function get_varlocations(scv::Type{C}) where {C<:SubContextView{CType, SubKey}} where {CType, SubKey}
    locals = get_local_locations(C)
    sharedvars = get_shared_locations(C)
    routedvars = get_routed_locations(C)
    injectedvars = get_injected_locations(C)
    # Locals take precedene over routes which take precedence over shared if there are name clashes
    # Injected take precedence over all
    all_vars = (;sharedvars..., routedvars..., locals..., injectedvars...)
    return :( $all_vars )
end

@inline get_all_locations(scv::SubContextView) = @inline get_all_locations(typeof(scv))
"""
Get a flat named tuple with (;name_of_runtime_var => VarLocation)
A varlocation is an actual location of the variable in the full context
"""
@inline @generated function get_all_locations(sctv::Type{SCT}) where {SCT<:SubContextView}
    locals = get_local_locations(SCT)
    sharedvars = get_shared_locations(SCT)
    routedvars = get_routed_locations(SCT)
    injectedvars = get_injected_locations(SCT)
    # Locals take precedene over routes which take precedence over shared
    all_locations = (;sharedvars..., routedvars..., locals..., injectedvars...)
    return :( $all_locations )
end

###########################################
########### Getting Properties  ###########
###########################################

@inline Base.keys(scv::SCV) where SCV <: SubContextView = propertynames(@inline get_all_locations(scv))
@inline Base.propertynames(scv::SCV) where SCV <: SubContextView = propertynames(@inline get_all_locations(scv))
@inline Base.haskey(scv::SCV, name::Symbol) where SCV <: SubContextView = haskey(scv, Val(name))
@inline getregistry(scv::SCV) where SCV <: SubContextView = getregistry(getcontext(scv))
@inline getproperty_fromsubcontext(scv::SCV, subcontextname::Symbol, varname::Symbol) where SCV <: SubContextView = @inline getproperty(getproperty(getcontext(scv), subcontextname), varname)
@inline getinjected(scv::SCV, key) where SCV <: SubContextView = getproperty(getinjected(scv), key)

@inline @generated function Base.getproperty(sct::SCV, vl::Union{VarLocation{:subcontext}, VarLocation{:local}}) where SCV <: SubContextView
    target_subcontext = get_subcontextname(vl)
    target_variable = get_originalname(vl)
    fexpr = funcexpr(vl, :var)
    return quote
        # context = getcontext(sct)
        # subcontext = @inline getproperty(context, $(QuoteNode(target_subcontext)))
        # var = @inline getproperty(subcontext, $(QuoteNode(target_variable)))
        var = @inline getproperty_fromsubcontext(sct, $(QuoteNode(target_subcontext)), $(QuoteNode(target_variable)))
        return $(fexpr)
    end
end

@inline @generated function Base.getproperty(sct::SCV, vl::VarLocation{:injected}) where SCV <: SubContextView
    target_variable = get_originalname(vl)
    return quote
        injected = getinjected(sct)
        return @inline getproperty(injected, $(QuoteNode(target_variable)))
    end
end

@inline @generated function Base.haskey(scv::SCV, v::Val{name}) where {name} where SCV <: SubContextView
    locations = @inline get_all_locations(scv)
    has_key = hasproperty(locations, name)
    return :( $has_key )
end

@inline Base.@constprop :aggressive Base.getproperty(sct::SubContextView, v::Symbol) = getproperty(sct, Val(v))
@inline @generated function Base.getproperty(sct::SubContextView{CType, SubKey}, v::Val{key}) where {CType, SubKey, key}    

    locations = get_all_locations(sct)
    #Map the algo name to the subcontext location using aliases
    subcontextname = algo_to_subcontext_names(sct, key)
    if haskey(locations, subcontextname)
        target_location = getproperty(locations, subcontextname)
        return quote 
            $(LineNumberNode(@__LINE__, @__FILE__))
            @inline getproperty(sct, $target_location) 
        end
    else
        available = keys(locations)
        return quote
            if $(QuoteNode(subcontextname)) == $(QuoteNode(key))
                $(LineNumberNode(@__LINE__, @__FILE__))
                a_name = $(QuoteNode(key))
                context = getcontext(sct)
                available_names = $available
                sct_name = $(QuoteNode(subcontextname))
                msg = "Variable $(a_name) requested, but not supplied to context. Available names are: $(available_names) \n Context: $(context)"
            else
                msg = "Variable $(a_name) (mapped to $(sct_name)) requested, but not supplied to context. Available names are: $(available_names) \n Context: $(context)"
            end
            error(msg)
        end
    end
end


@inline @generated function Base.iterate(scv::SCV, state = 1) where SCV <: SubContextView
    locations = get_all_locations(scv)
    _keys = keys(locations)
    return quote 
        if state > length($_keys)
            return nothing
        else
            return (($_keys[state], getproperty(scv, getproperty($locations, $_keys[state]))), state + 1)
        end
    end
end


##########################################
"""
From a pair of a namedtuple intended to merge into context from a view
And all locations in the view
    Create a namedtuple (;target_subcontext => (;var1 = value1, var2 = value2,...),...)
"""
function create_merge_tuples_expr(locations::Locs, args) where Locs
    argsnames_to_merge = fieldnames(args)
    subcontext_merge_parameter_exprs = (;)
    for localname in argsnames_to_merge
        varlocation = getproperty(locations, localname)
        target_subcontext = get_subcontextname(varlocation)
        target_variable = get_originalname(varlocation)

        subcontext_nt_parameters = get(subcontext_merge_parameter_exprs, target_subcontext, Expr(:parameters))
        subcontext_merge_parameter_exprs = (;subcontext_merge_parameter_exprs..., target_subcontext => subcontext_nt_parameters)

        kw_expr = Expr(:kw, target_variable, :(getproperty(args, $(QuoteNode(localname)))))
        push!(subcontext_nt_parameters.args, kw_expr)
    end

    total_nt_expr = Expr(:tuple, Expr(:parameters,
            ((Expr(:kw, subctx, Expr(:tuple,Expr(:parameters, parameter_exprs...))) for (subctx, parameter_exprs) in subcontext_merge_parameter_exprs)...
        )
        )
    )
    return total_nt_expr
end


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