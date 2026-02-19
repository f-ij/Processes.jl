##########################################
########## Variable Locations ############
##########################################

# This is the basis for the viewsystem. Variables in and out get mapped to locations in the full context

"""
 Local variables => VarLocations
"""

function get_local_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubKey}} where {CType, SubKey}
    _subcontext_type = subcontext_type(SCT)
    local_varnames = keys(_subcontext_type)

    localst = ntuple(i ->VarLocation{:local}(SubKey, local_varnames[i]), length(local_varnames))
    return NamedTuple{(local_varnames...,)}(localst)
end

"""
Shared subcontexts => VarLocations
"""
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

"""
Routes stored in the subcontext => VarLocations
"""
function get_routed_locations(sct::Type{SCT}) where {SCT<:SubContextView{CType, SubKey}} where {CType, SubKey}
    _subcontext_type = subcontext_type(SCT)
    sharedvars = getsharedvars_types(_subcontext_type)

    routedvars = named_flat_collect_broadcast(sharedvars) do sv
        fromname = get_fromname(sv)
        _localnames = localnames(sv)
        _subvarcontextnames = subvarcontextnames(sv)
        _transform = gettransform(sv)
        pairs = (_localnames[i] => VarLocation{:subcontext}(fromname, _subvarcontextnames[i], _transform) for i in 1:length(_localnames))
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

const getprop_expr = Ref(Expr(:block))
@inline @generated function Base.getproperty(sct::SCV, vl::Union{VarLocation{:subcontext}, VarLocation{:local}}) where SCV <: SubContextView
    # target_subcontext = get_subcontextname(vl)
    # target_variable = get_originalname(vl)
    # numvars = length(target_variable)
    # varsymbols = ntuple(i -> Symbol("var", i), numvars)
    # fexpr = funcexpr(vl, varsymbols...)

    assign_exprs, varsymbols = getvar_expressions_and_varnames(vl)
    fexpr = funcexpr(vl, varsymbols...)

    global getprop_expr[] = quote
        # var = @inline getproperty_fromsubcontext(sct, $(QuoteNode(target_subcontext)), $(QuoteNode(target_variable)))
        $(assign_exprs...)
        return $(fexpr)
    end
    
    return  quote
        # var = @inline getproperty_fromsubcontext(sct, $(QuoteNode(target_subcontext)), $(QuoteNode(target_variable)))
        $(assign_exprs...)
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
                msg = "Variable $(a_name) requested from $(sct) in View: $(SubKey), but not supplied to context. Available names are: $(available_names) \n Context: $(context)"
            else
                msg = "Variable $(a_name) (mapped to $(sct_name)) requested from $(sct) in View: $(SubKey), but not supplied to context. Available names are: $(available_names) \n Context: $(context)"
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
