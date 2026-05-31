
@inline function Base.merge(scv::SubContextView{CType, SubKey}, ::Nothing) where {CType<:AbstractScopedContext, SubKey}
    return @inline getcontext(scv)
end
@inline function Base.merge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:AbstractScopedContext, SubKey}
    return @inline stablemerge(scv, args)
end

@inline function stablemerge(scv::SubContextView{CType, SubKey}, ::Nothing) where {CType<:AbstractScopedContext, SubKey}
    return @inline getcontext(scv)
end

function _subcontext_view_mergetuple_expr(SCV::Type, Args::Type)
    @nospecialize SCV Args
    merge_expr, widened_expr = _subcontext_view_merge_exprs(SCV, Args)
    return merge_expr
end

function _subcontext_view_merge_exprs(SCV::Type, Args::Type)
    @nospecialize SCV Args
    SubKey = SCV.parameters[2]
    algo_varnames = fieldnames(Args)

    merge_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()
    widened_expressions_by_subcontext = Dict{Symbol, Vector{Expr}}()

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

        else # New variable so add it to this subcontext
            exprs = get!(widened_expressions_by_subcontext, SubKey, Expr[])
            push!(
                exprs,
                Expr(:(=), subcontext_varname, :(getproperty(args, $(QuoteNode(algo_varname))))),
            )
        end
    end

    # Build the NamedTuple expressions for real subcontext writes and widened
    # field patches. These create:
    #   (; subcontext1 = (; var1 = ...), ...)

    merge_subcontext_exprs = [
        Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...)))
        for (subctx, field_exprs) in merge_expressions_by_subcontext
    ]
    widened_subcontext_exprs = [
        Expr(:(=), subctx, Expr(:tuple, Expr(:parameters, field_exprs...)))
        for (subctx, field_exprs) in widened_expressions_by_subcontext
    ]
    return (
        Expr(:tuple, Expr(:parameters, merge_subcontext_exprs...)),
        Expr(:tuple, Expr(:parameters, widened_subcontext_exprs...)),
    )
end

"""
Merge but error if a var would be overwritten and only allow local merging
"""
@inline @generated function stablemerge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:AbstractScopedContext, SubKey}
    mergetuple_expr, widenedtuple_expr = _subcontext_view_merge_exprs(scv, args)

    # Return the expression that does the merge
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        @assert typeof(newcontext) == typeof(getcontext(scv)) "A variable type in a subcontext was changed. This is prohibited for performance reasons.\nIf type mutation is needed, set the variable up as a Ref\n$(sprint(show, ContextTypeDiff(getcontext(scv), newcontext)))"
        widenedtuple = $widenedtuple_expr
        return @inline merge_into_widened(newcontext, widenedtuple)
    end
end

"""
Returns a merged context by merging the provided named tuple into the appropriate subcontexts

This doesn't check for type stability, and allows overwriting existing variables. 

"""
@inline @generated function unstablemerge(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:AbstractScopedContext, SubKey}
    mergetuple_expr, widenedtuple_expr = _subcontext_view_merge_exprs(scv, args)

    # Return the expression that does the merge
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        mergetuple = $mergetuple_expr
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        @assert typeof(newcontext) == typeof(getcontext(scv)) "A variable type in a subcontext was changed. This is prohibited for performance reasons.\nIf type mutation is needed, set the variable up as a Ref\n$(sprint(show, ContextTypeDiff(getcontext(scv), newcontext)))"
        widenedtuple = $widenedtuple_expr
        return @inline merge_into_widened(newcontext, widenedtuple)
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
@inline @generated function Base.replace(scv::SubContextView{CType, SubKey}, args::NamedTuple) where {CType<:AbstractScopedContext, SubKey}
    names = fieldnames(args)
    if any( n -> n != SubKey, names) # Static check that only the correct subcontext is being replaced
        error("Trying to replace subcontext $(n) from SubContextView $(SubKey), only $(SubKey) can be replaced")
    end

    return quote
        old_context = @inline getcontext(scv)
        return replace(old_context, (; SubKey => getproperty(args, SubKey)))
    end
end
