#################################
########## Properties ###########
#################################
varaliases(scv::Union{SubContextView{CType, SubName, T, NT, Aliases}, Type{<:SubContextView{CType, SubName, T, NT, Aliases}}}) where {CType, SubName, T, NT, Aliases} = Aliases

@inline this_instance(scv::SubContextView) = getfield(scv, :instance)

@inline getglobal(scv::SubContextView, name::Symbol) = getglobal(getcontext(scv), name)
@inline getglobal(scv::SubContextView) = getglobal(getcontext(scv))

@inline getcontext(scv::SubContextView) = @inline getfield(scv, :context)
@inline getsubcontext(scv::SubContextView{CType, SubName}) where {CType, SubName} = @inline getproperty(getcontext(scv), SubName)

#################################
####### CREATING VIEWS ##########
#################################

"""
Get a subcontext view for a specific subcontext
"""
@inline Base.view(pc::ProcessContext, instance::SA; inject = (;)) where SA <: ScopedAlgorithm = SubContextView{typeof(pc), getname(instance), typeof(instance), typeof(inject)}(pc, instance; inject)
@inline function Base.view(pc::ProcessContext{D}, instance::ScopedAlgorithm{T, nothing}, inject = (;)) where {D, T}
    named_instance = get_registry(pc)[instance]
    return view(pc, named_instance; inject)
end

"""
Create a view from a non-scoped instance by looking it up in the registry
"""
@inline function Base.view(pc::ProcessContext, instance::I, inject = (;)) where I
    scoped_instance = @inline value(static_get(get_registry(pc), instance))
    return SubContextView{typeof(pc), getname(scoped_instance), typeof(scoped_instance), typeof(inject)}(pc, scoped_instance; inject=inject)
end

"""
Regenerate a SubContextView from its type
"""
@inline Base.view(pc::PC, scv::CV; inject = (;)) where {PC <: ProcessContext, CV <: SubContextView} = @inline view(pc, this_instance(scv), inject(scv))

"""
View a view
"""
@inline function Base.view(scv::SubContextView{C,SubName}, instance::SA) where {C, SubName, SA <: ScopedAlgorithm}
    scopename = getname(instance)
    @assert scopename == SubName "Trying to view SubContextView of subcontext $(SubName) with instance of subcontext $(scopename)"
    context = getcontext(scv)
    return view(context, instance)
end


##########################################
################# TYPES ##################
##########################################

"""
Get the type of the original subcontext from the view
"""
@inline subcontext_type(scv::Union{SubContextView{CType, SubName}, Type{<:SubContextView{CType, SubName}}}) where {CType<:ProcessContext, SubName} = subcontext_type(CType, SubName)


##########################################
########## Variable Locations ############
##########################################

# This is the basis for the viewsystem. Variables in and out get mapped to locations in the full context

"""
Get the names for local variables in the subcontext
    Applies aliases if present
"""
function get_local_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubName}} where {CType, SubName}
    _subcontext_type = subcontext_type(SCT)
    local_varnames = keys(_subcontext_type)

    localst = ntuple(i ->VarLocation{:local}(SubName, local_varnames[i]), length(local_varnames))

    _aliases = varaliases(SCT)

    # try
        aliassed_local_varnames = @inline apply_aliases(_aliases, local_varnames)
    # catch e
    #     error("Error applying aliases $(_aliases) to local variable names $(local_varnames) in SubContextView $(SCT): \n $(e)")
    # end

    return NamedTuple{(aliassed_local_varnames...,)}(localst)
end

function get_shared_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubName}} where {CType, SubName}
    _subcontext_type = subcontext_type(SCT)
    _aliases = varaliases(SCT)

    shared_context_names = getsharedcontext_names(_subcontext_type)

    sharedvars = named_flat_collect_broadcast(shared_context_names) do name
        shared_subcontext_type = subcontext_type(CType, name)
        shared_varnames = keys(shared_subcontext_type)
        aliased_varnames = @inline apply_aliases(_aliases, shared_varnames)
        pairs = (aliased_varnames[i] => VarLocation{:subcontext}(name, shared_varnames[i]) for i in 1:length(shared_varnames))
        return NamedTuple(pairs)
    end
    return sharedvars
end

function get_routed_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubName}} where {CType, SubName}
    _subcontext_type = subcontext_type(SCT)
    sharedvars = getsharedvars_types(_subcontext_type)
    _aliases = varaliases(SCT)

    routedvars = named_flat_collect_broadcast(sharedvars) do sv
        fromname = get_fromname(sv)
        varnames = keys(sv)
        aliased_varnames = @inline apply_aliases(_aliases, varnames)
        pairs = (aliased_varnames[i] => VarLocation{:subcontext}(fromname, varnames[i]) for i in 1:length(varnames))
        return NamedTuple(pairs)
    end

    return routedvars
end

function get_injected_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubName}} where {CType, SubName}
    injected_vars = injectedfieldnames(SCT)
    injst = ntuple(i ->VarLocation{:injected}(SubName, injected_vars[i]), length(injected_vars))
    return NamedTuple{(injected_vars...,)}(injst)
end


"""
Generate a namedtuple of localtuple => VarLocation
"""
get_varlocations(scv::SubContextView) = @inline get_varlocations(typeof(scv))
@inline @generated function get_varlocations(scv::Type{C}) where {C<:SubContextView{CType, SubName}} where {CType, SubName}
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

getinjected(scv::SubContextView) = getfield(scv, :injected)
injectedfieldnames(scvt::Union{SubContextView{CType, SubName, T, NT}, Type{<:SubContextView{CType, SubName, T, NT}}}) where {CType, SubName, T, NT} = fieldnames(NT)

@inline Base.keys(scv::SubContextView) = propertynames(@inline get_all_locations(scv))
@inline Base.propertynames(scv::SubContextView) = propertynames(@inline get_all_locations(scv))

@inline Base.haskey(scv::SubContextView, name::Symbol) = haskey(scv, Val(name))

"""
From a pair of a namedtuple intended to merge into context from a view
And all locations in the view
    Create a namedtuple (;target_subcontext => (;var1 = value1, var2 = value2,...),...)
"""
function create_merge_tuples(locations, args)
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


@inline @generated function Base.getproperty(sct::SubContextView, vl::Union{VarLocation{:subcontext}, VarLocation{:local}})
    target_subcontext = get_subcontextname(vl)
    target_variable = get_originalname(vl)
    return quote
        context = getcontext(sct)
        subcontext = @inline getproperty(context, $(QuoteNode(target_subcontext)))
        return @inline getproperty(subcontext, $(QuoteNode(target_variable)))
    end
end

@inline @generated function Base.getproperty(sct::SubContextView, vl::VarLocation{:injected})
    target_variable = get_originalname(vl)
    return quote
        injected = getinjected(sct)
        return @inline getproperty(injected, $(QuoteNode(target_variable)))
    end
end

@inline @generated function Base.haskey(scv::SubContextView, v::Val{name}) where {name}
    locations = @inline get_all_locations(scv)
    has_key = hasproperty(locations, name)
    return :( $has_key )
end

@inline Base.@constprop :aggressive Base.getproperty(sct::SubContextView, v::Symbol) = getproperty(sct, Val(v))
@inline @generated function Base.getproperty(sct::SubContextView{CType, SubName}, v::Val{name}) where {CType, SubName, name}
    locations = get_all_locations(sct)
    if haskey(locations, name)
        target_location = getproperty(locations, name)
        return :( @inline getproperty(sct, $target_location) )
    else
        available = keys(locations)
        error("Variable $(QuoteNode(name)) requested, but not supplied to context. Available names are: $(available)")
    end
end

@inline @generated function Base.iterate(scv::SubContextView, state = 1)
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
############### MERGING ##################
##########################################

"""
Fallback merge if nothing is merged that just returns the original context
"""
@inline Base.merge(scv::SubContextView, ::Nothing) = getcontext(scv)

"""
Returns a merged context by merging the provided named tuple into the appropriate subcontexts
"""
@inline @generated function Base.merge(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    # this_subcontext = subcontext_type(scv)
    keys_to_merge = fieldnames(args)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    
    for localname in keys_to_merge
        if hasproperty(locations, localname) # If the local variable exists
            target_subcontext = get_subcontextname(getproperty(locations, localname))
            targetname = get_originalname(getproperty(locations, localname))
            
            if !haskey(merge_expressions_by_subcontext, target_subcontext)
                merge_expressions_by_subcontext[target_subcontext] = Expr[]
            end
            
            push!(merge_expressions_by_subcontext[target_subcontext], 
                  Expr(:(=), targetname, :(getproperty(args, $(QuoteNode(localname))))))
        else # Just add the variable to the viewing subcontext TODO: CHECK THIS
            if !haskey(merge_expressions_by_subcontext, SubName)
                merge_expressions_by_subcontext[SubName] = Expr[]
            end
            push!(merge_expressions_by_subcontext[SubName], 
                  Expr(:(=), localname, :(getproperty(args, $(QuoteNode(localname))))))
        end
    end
    
    # Build the NamedTuple expression for mergetuple
    subcontext_exprs = [Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...))) 
                        for (subctx, field_exprs) in merge_expressions_by_subcontext]
    
    mergetuple_expr = Expr(:tuple, Expr(:parameters, subcontext_exprs...))
    
    return quote
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        return newcontext
    end
end

"""
Merge but error in variable are overwritten
"""
@inline @generated function safemerge(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    # this_subcontext = subcontext_type(scv)
    keys_to_merge = fieldnames(args)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    
    for localname in keys_to_merge
        if hasproperty(locations, localname) # If the local variable exists
            target_subcontext = get_subcontextname(getproperty(locations, localname))
            targetname = get_originalname(getproperty(locations, localname))
            
            if !haskey(merge_expressions_by_subcontext, target_subcontext)
                merge_expressions_by_subcontext[target_subcontext] = Expr[]
            end
            
            push!(merge_expressions_by_subcontext[target_subcontext], 
                  Expr(:(=), targetname, :(getproperty(args, $(QuoteNode(localname))))))
        else # Just add the variable to the viewing subcontext TODO: CHECK THIS
            if !haskey(merge_expressions_by_subcontext, SubName)
                merge_expressions_by_subcontext[SubName] = Expr[]
            end
            push!(merge_expressions_by_subcontext[SubName], 
                  Expr(:(=), localname, :(getproperty(args, $(QuoteNode(localname))))))
        end
    end
    
    # Build the NamedTuple expression for mergetuple
    subcontext_exprs = [Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...))) 
                        for (subctx, field_exprs) in merge_expressions_by_subcontext]
    
    mergetuple_expr = Expr(:tuple, Expr(:parameters, subcontext_exprs...))
    
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
@inline @generated function Base.replace(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    names = fieldnames(args)
    if any( n -> n != SubName, names) # Static check that only the correct subcontext is being replaced
        error("Trying to replace subcontext $(n) from SubContextView $(SubName), only $(SubName) can be replaced")
    end

    return quote
        newsubcontext = @inline newdata(subcontext_type(scv), getproperty(args, SubName))
        old_context = @inline getcontext(scv)
        return replace(old_context, (; SubName => newsubcontext))
    end
end

####################################
############## SHOW ################
####################################

function Base.show(io::IO, scv::SubContextView{CType, SubName}) where {CType, SubName}
    print(io, "SubContextView(", SubName, ")")
end
