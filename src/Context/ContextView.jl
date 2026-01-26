export viewmerge
#######################
### SUBCONTEXT VIEW ###
#######################

"""
Go from a local variable to the location in the full context
Type can be
    - :local
    - :shared
    - :routed
"""

"""
A location of a variable in subcontext: subcontextname and which has the local name there: originalname
"""
struct VarLocation{Type, subcontextname, originalname} end
VarLocation{Type}(subcontextname::Symbol, originalname::Symbol) where {Type} = VarLocation{Type, subcontextname, originalname}()
VarLocation(type, subcontextname::Symbol, originalname::Symbol) = VarLocation{type, subcontextname, originalname}()

@inline get_subcontextname(vl::Union{VarLocation{T, SCN, ON}, Type{<:VarLocation{T, SCN, ON}}}) where {T, SCN, ON} = SCN
@inline get_originalname(vl::Union{VarLocation{T, SCN, ON}, Type{<:VarLocation{T, SCN, ON}}}) where {T, SCN, ON} = ON


struct SubContextView{CType, SubName, T} <: AbstractContext
    context::CType
    instance::T # instance for which the view is created
end

function Base.show(io::IO, scv::SubContextView{CType, SubName}) where {CType, SubName}
    print(io, "SubContextView(", SubName, ")")
end

"""
Get a subcontext view for a specific subcontext
"""
@inline Base.view(pc::ProcessContext, instance::ScopedAlgorithm) = SubContextView{typeof(pc), getname(instance), typeof(instance)}(pc, instance)

@inline function Base.view(pc::ProcessContext, instance)
    scoped_instance = @inline value(static_get(get_registry(pc), instance))
    return SubContextView{typeof(pc), getname(scoped_instance), typeof(scoped_instance)}(pc, scoped_instance)
end
@inline Base.view(pc::ProcessContext, scv::SubContextView) = @inline view(pc, this_instance(scv))


@inline this_instance(scv::SubContextView) = getfield(scv, :instance)

@inline getglobal(scv::SubContextView, name::Symbol) = getglobal(getcontext(scv), name)
@inline getglobal(scv::SubContextView) = getglobal(getcontext(scv))

@inline getcontext(scv::SubContextView) = @inline getfield(scv, :context)
@inline getsubcontext(scv::SubContextView{CType, SubName}) where {CType, SubName} = @inline getproperty(getcontext(scv), SubName)

"""
Generate a namedtuple of localtuple => VarLocation
"""
@inline @generated function get_varlocations(scv::Union{SubContextView{CType, SubName}, Type{<:SubContextView{CType, SubName}}}) where {CType, SubName}
    # First get the subcontext type
    subcontext_type = Processes.subcontext_type(CType, SubName)

    local_varnames = fieldnames(get_datatype(subcontext_type))

    localst = ntuple(i ->VarLocation{:local}(SubName, local_varnames[i]), length(local_varnames))
    locals = NamedTuple{(local_varnames...,)}(localst)

    ### All shared vars heaped together
    shared_context_names = getsharedcontext_names(subcontext_type)
    sharedcontexts = NamedTuple()
    for name in shared_context_names
        shared_subcontext_type = Processes.subcontext_type(CType, name)
        shared_varnames = fieldnames(shared_subcontext_type)
        sharedt = ntuple(i ->VarLocation{:shared}(name, shared_varnames[i]), length(shared_varnames))
        sharednt = NamedTuple{tuple(shared_varnames...)}(sharedt)
        sharedcontexts = (;sharedcontexts..., sharednt...)
    end

    ### Shared vars resolved separately per subcontext
    sharedvars = getsharedvars_types(subcontext_type)
    sharedvar_locations = tuple()
    sharedvar_names = tuple()
    for sharedvar in sharedvars
        sharedvar_from = get_fromname(sharedvar)
        for var_to_alias in sharedvar
            alias = last(var_to_alias)
            varname = first(var_to_alias)
            sharedvar_locations = (sharedvar_locations..., VarLocation{:routed}(sharedvar_from, varname))
            sharedvar_names = tuple(sharedvar_names..., alias)
        end
    end
    sharedvars = NamedTuple{tuple(sharedvar_names...)}(sharedvar_locations)


    all_vars = (;sharedcontexts = sharedcontexts, sharedvars = sharedvars, locals = locals)
    # all_vars = (;locals..., shared..., routed...)
    return :( $all_vars )
end

@inline @generated function get_all_locations(sctv::Type{SCT}) where {SCT<:SubContextView}
    v_l = get_varlocations(SCT)
    # Locals take precedene over routes which take precedence over shared
    all_locations = (;v_l.sharedcontexts..., v_l.sharedvars..., v_l.locals...)
    return :( $all_locations )
end

@inline get_all_locations(scv::SubContextView) = @inline get_all_locations(typeof(scv))
@inline @generated function Base.getproperty(sct::SubContextView, vl::VarLocation)
    target_subcontext = get_subcontextname(vl)
    target_variable = get_originalname(vl)
    return quote
        context = getcontext(sct)
        subcontext = @inline getproperty(context, $(QuoteNode(target_subcontext)))
        return @inline getproperty(subcontext, $(QuoteNode(target_variable)))
    end
    # subcontext = @inline getproperty(getcontext(sct), get_subcontextname(vl))
    # return @inline getproperty(subcontext, get_originalname(vl))
end

@inline Base.getproperty(sct::SubContextView, v::Symbol) = getproperty(sct, Val(v))
@inline @generated function Base.getproperty(sct::SubContextView{CType, SubName}, v::Val{name}) where {CType, SubName, name}
    locations = get_all_locations(sct)
    target_location = getproperty(locations, name)

    return :( @inline getproperty(sct, $target_location) )
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

"""
Get the type of the original subcontext from the view
"""
@inline subcontext_type(scv::SubContextView{CType, SubName}) where {CType<:ProcessContext, SubName} = subcontext_type(CType, SubName)
@inline subcontext_type(scvt::Type{<:SubContextView{CType, SubName}}) where {CType<:ProcessContext, SubName} = subcontext_type(CType, SubName)

@inline Base.keys(scv::SubContextView) = propertynames(@inline get_all_locations(scv))
@inline Base.propertynames(scv::SubContextView) = propertynames(@inline get_all_locations(scv))

@inline Base.haskey(scv::SubContextView, name::Symbol) = haskey(scv, Val(name))
@inline @generated function Base.haskey(scv::SubContextView, v::Val{name}) where {name}
    locations = @inline get_all_locations(scv)
    has_key = hasproperty(locations, name)
    return :( $has_key )
end

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
        newcontext = @inline merge_into_subcontexts(getcontext(scv), mergetuple)
        return newcontext
    end
end

@inline Base.merge(scv::SubContextView, ::Nothing) = getcontext(scv)

@inline viewmerge(scv::SubContextView, args::NamedTuple) = @inline view(merge(scv, args), this_instance(scv))

"""
Instead of merging, replace the subcontext entirely with the provided args named tuple
Returns new context

This is to be used during the prepare phase, where entire subcontexts are replaced
"""
@inline function Base.replace(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    names = propertynames(args)
    # Error if trying to replace any other subcontext than the one in the view
    if any( n -> n != SubName, names)
        error("Trying to replace subcontext $(n) from SubContextView $(SubName), only $(SubName) can be replaced")
    end
    newsubcontext = @inline newdata(subcontext_type(scv), getproperty(args, SubName))
    old_context = @inline getcontext(scv)
    return replace(old_context, (; SubName => newsubcontext))
end
