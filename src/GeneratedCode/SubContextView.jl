
@inline function Base.merge(scv::SubContextView{CType, SubKey}, ::Nothing) where {CType<:ProcessContext, SubKey}
    return (@inline getcontext(scv)), (@inline getruntimecontext(scv))
end

function _subcontext_view_mergetuple_expr(SCV::Type, Args::Type)
    @nospecialize SCV Args
    merge_expr, runtime_expr = _subcontext_view_merge_exprs(SCV, Args)
    return merge_expr
end

function _subcontext_view_merge_exprs(SCV::Type, Args::Type, demanded_runtime_names = fieldnames(Args))
    @nospecialize SCV Args
    SubKey = SCV.parameters[2]
    algo_varnames = fieldnames(Args)

    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    runtime_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()

    for (var_idx, algo_varname) in enumerate(algo_varnames)
        target_location, subcontext_varname = _compute_location(SCV, algo_varname)
        # First look if varname is in locations
        if !isnothing(target_location) # If the local variable exists
            target_subcontext = get_subcontextname(target_location)
            targetname = get_originalname(target_location)
            if targetname isa Tuple
                error("Algorithm returned a variable: $(algo_varname) which it tries to merge into $(targetname) in subcontext $(target_subcontext) \n Merging into multiple variables is not supported at this moment, but might be supported in the future through inverse transforms.")
            end

            exprs = get!(merge_expressions_by_subcontext, target_subcontext, Expr[])

            # Expression for targetname = getproperty(args, algo_varnames[var_idx])
            # Which will be used to construct subcontext = (; targetname = getproperty(args, this_algo_varname), ...)
            push!(
                exprs,
                Expr(:(=), targetname, :(getproperty(args, $(QuoteNode(algo_varname))))),
            )

        elseif algo_varname in demanded_runtime_names # New demanded variable so add it to this subcontext's runtime bucket.
            exprs = get!(runtime_expressions_by_subcontext, SubKey, Expr[])
            push!(
                exprs,
                Expr(:(=), subcontext_varname, :(getproperty(args, $(QuoteNode(algo_varname))))),
            )
        end
    end

    # Build the NamedTuple expressions for real subcontext writes and runtime
    # field patches. These create:
    #   (; subcontext1 = (; var1 = ...), ...)

    merge_subcontext_exprs = [
        Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...)))
        for (subctx, field_exprs) in merge_expressions_by_subcontext
    ]
    runtime_subcontext_exprs = [
        Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...)))
        for (subctx, field_exprs) in runtime_expressions_by_subcontext
    ]
    return (
        Expr(:tuple, Expr(:parameters, merge_subcontext_exprs...)),
        Expr(:tuple, Expr(:parameters, runtime_subcontext_exprs...)),
    )
end

"""Merge with every non-state return field demanded."""
@inline function Base.merge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:ProcessContext, SubKey}
    return @inline merge(scv, args, ReturnDemand{fieldnames(typeof(args))}())
end

"""
Merge a step/init/cleanup return into persistent state and loop-local runtime state.
"""
@inline @generated function Base.merge(scv::SubContextView{CType, SubKey}, args::NamedTuple, demand::ReturnDemand{Names}) where {CType<:ProcessContext, SubKey, Names}
    mergetuple_expr, runtimetuple_expr = _subcontext_view_merge_exprs(scv, args, Names)

    # Return the expression that does the merge
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        @assert typeof(newcontext) == typeof(getcontext(scv)) "A variable type in a subcontext was changed. This is prohibited for performance reasons.\nIf type mutation is needed, set the variable up as a Ref\n$(sprint(show, ContextTypeDiff(getcontext(scv), newcontext)))"
        runtimetuple = $runtimetuple_expr
        newruntimecontext = @inline merge_runtime_subcontexts(getruntimecontext(scv), runtimetuple)
        return newcontext, newruntimecontext
    end
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
