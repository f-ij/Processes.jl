
@inline function Base.merge(scv::SubContextView{CType, SubKey}, ::Nothing) where {CType<:ProcessContext, SubKey}
    return @inline getcontext(scv)
end
@inline function Base.merge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    return @inline stablemerge(scv, args)
end

@inline function stablemerge(scv::SubContextView{CType, SubKey}, ::Nothing) where {CType<:ProcessContext, SubKey}
    return @inline getcontext(scv)
end
"""
Merge but error if a var would be overwritten and only allow local merging
"""
@inline @generated function stablemerge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    algo_varnames = fieldnames(args)

    # These are the names in the subcontext after applying aliases
    subcontext_varnames = algo_to_subcontext_names.(Ref(scv), algo_varnames)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    
    for (var_idx, subcontext_varname) in enumerate(subcontext_varnames)
        # First look if varname is in locations
        if hasproperty(locations, subcontext_varname) # If the local variable exists

            target_location = getproperty(locations, subcontext_varname)

            target_subcontext = get_subcontextname(target_location)
            targetname = get_originalname(target_location)
            if targetname isa Tuple
                error("Algorithm returned a variable: $(algo_varnames[var_idx]) which it tries to merge into $(targetname) in subcontext $(target_subcontext) \n Merging into multiple variables is not supported at this moment, but might be supported in the future through inverse transforms.")
            end

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
        $(LineNumberNode(@__LINE__, @__FILE__))
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        @assert typeof(newcontext) == typeof(getcontext(scv)) "A variable type in a subcontext was changed. This is prohibited for performance reasons.\nIf type mutation is needed, set the variable up as a Ref\n$(sprint(show, ContextTypeDiff(getcontext(scv), newcontext)))"
        return newcontext
    end
end

"""
Returns a merged context by merging the provided named tuple into the appropriate subcontexts

This doesn't check for type stability, and allows overwriting existing variables. 

"""
@inline @generated function unstablemerge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    algo_varnames = fieldnames(args)

    # These are the names in the subcontext after applying aliases
    subcontext_varnames = algo_to_subcontext_names.(Ref(scv), algo_varnames)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    
    for (var_idx, subcontext_varname) in enumerate(subcontext_varnames)
        # First look if varname is in locations
        if hasproperty(locations, subcontext_varname) # If the local variable exists

            target_location = getproperty(locations, subcontext_varname)

            target_subcontext = get_subcontextname(target_location)
            targetname = get_originalname(target_location)
            if targetname isa Tuple
                error("Algorithm returned a variable: $(algo_varnames[var_idx]) which it tries to merge into $(targetname) in subcontext $(target_subcontext) \n Merging into multiple variables is not supported at this moment, but might be supported in the future through inverse transforms.")
            end

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
        $(LineNumberNode(@__LINE__, @__FILE__))
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        return newcontext
    end
end

@inline function unstablemerge(scg::SCV, ::Nothing) where {SCV<:SubContextView}
    return @inline getcontext(scg)
end

"""
Instead of merging, replace the subcontext entirely with the provided args named tuple
Returns new context

This is to be used during the init phase, where entire subcontexts are replaced
"""
@inline @generated function Base.replace(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    names = fieldnames(args)
    if any( n -> n != SubKey, names) # Static check that only the correct subcontext is being replaced
        error("Trying to replace subcontext $(n) from SubContextView $(SubKey), only $(SubKey) can be replaced")
    end

    return quote
        old_context = @inline getcontext(scv)
        return replace(old_context, (; SubKey => getproperty(args, SubKey)))
    end
end
