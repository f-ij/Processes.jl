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