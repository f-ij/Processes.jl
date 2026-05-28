@generated function ProcessContext(subcontexts::D, registry::Reg, runtime::R = (;), input::I = (;)) where {D,Reg,R,I}
    # Statically Check if all keys except for global are SubContexts
    sc_names = fieldnames(D)
    bad_names = Symbol[]
    for name in sc_names
        if !(fieldtype(D, name) <: SubContext)
            push!(bad_names, name)
        end
    end
    @assert isempty(bad_names) "All fields in ProcessContext subcontexts must be of type SubContext, but found non-SubContext fields: $bad_names"
    @assert Reg <: AbstractRegistry "Registry type must be a subtype of AbstractRegistry, got: $Reg"
    return :(ProcessContext{D,Reg,R,I}(subcontexts, registry, runtime, input))
end

@inline Base.@constprop :aggressive function Base.getproperty(pc::ProcessContext, name::Symbol)
    if name === :subcontexts || name === :registry || name === :_runtime || name === :_input
        return getfield(pc, name)
    end
    subcontexts = @inline get_subcontexts(pc)
    if haskey(subcontexts, name)
        return @inline getproperty(subcontexts, name)
    end
    input = @inline getruntimeinput(pc)
    if haskey(input, name)
        return @inline getproperty(input, name)
    end
    return @inline getproperty(getfield(pc, :_runtime), name)
end

@inline Base.@constprop :aggressive function Base.getindex(pc::ProcessContext, name::Symbol)
    name === :globals && return getglobals(pc)
    name === :_runtime && return getglobals(pc)
    name === :_input && return getruntimeinput(pc)
    return @inline getproperty(get_subcontexts(pc), name)
end

@inline function Base.getindex(pc::ProcessContext, obj)
    name = getkey(getregistry(pc)[obj])
    return @inline getproperty(get_subcontexts(pc), name)
end

@inline function Base.getindex(pc::ProcessContext, idx::Int)
    get_subcontexts(pc)[idx]
end

@inline get_subcontexts(pc::ProcessContext) = getfield(pc, :subcontexts)
@inline getregistry(pc::ProcessContext) = getfield(pc, :registry)
@inline getruntimeinput(pc::ProcessContext) = getfield(pc, :_input)

@inline subcontext_names(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldnames(typeof(getproperty(get_subcontexts(pc), name)))
@inline subcontext_type(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldtype(typeof(get_subcontexts(pc)), name)
@inline function subcontext_type(pct::Type{<:ProcessContext{D}}, name::Symbol) where {D}
    fieldtype(D, name)
end

@inline get_subcontexts_fieldnames(pct::Type{<:ProcessContext{D}}) where {D} = fieldnames(D)

@inline getglobals(pc::ProcessContext) = getfield(pc, :_runtime)
@inline function getglobals(pc::ProcessContext, name::Symbol)
    return getproperty(getglobals(pc), name)
end

subcontexts(pc::ProcessContext) = get_subcontexts(pc)

@inline function isasubcontext(pc::Type{<:ProcessContext}, v::Val{s}) where {s<:Symbol}
    subcontext_types = pc.parameters[1]
    return fieldtype(subcontext_types, s) <: SubContext
end
@inline isasubcontext(pc::ProcessContext, s::Symbol) = isasubcontext(typeof(pc), Val(s))
@inline isasubcontext(pc::Type{<:ProcessContext}, s::Symbol) = isasubcontext(pc, Val(s))

function get_subcontext_type(pc::Type{<:ProcessContext}, s)
    return fieldtype(pc.parameters[1], s)
end

###
@inline function _merge_into_globals(pc::ProcessContext{D}, args) where {D}
    merged_runtime = @inline merge(getglobals(pc), args)
    return @inline ProcessContext(get_subcontexts(pc), getregistry(pc), merged_runtime, getruntimeinput(pc))
end

"""
Merge a runtime-owned step return into `ProcessContext._runtime`.
"""
@inline merge_runtime_return(context::C, ::Nothing) where {C<:ProcessContext} = context

@inline function merge_runtime_return(context::C, retval::R) where {C<:ProcessContext, R<:NamedTuple}
    return @inline _merge_into_globals(context, retval)
end

function merge_runtime_return(context::C, retval::R) where {C<:ProcessContext, R}
    error("Runtime-owned step returns must be named tuples or `nothing`, got $(typeof(retval)).")
end

"""
Merge keys into subcontext by args = (;subcontextname1 = (;var1 = val1,...), subcontextname2 = (;...), ...)
    Assumes that the subcontext names exist in the context, otherwise it errors
"""
@inline @generated function merge_into_subcontexts(pc::ProcessContext{D}, args::As) where {D, As}
    sc_names = get_subcontexts_fieldnames(pc)
    mergenames = fieldnames(args)
    if length(mergenames) == 1
        mergename = first(mergenames)
        return :(@inline merge_into_subcontext(pc, Val($(QuoteNode(mergename))), getproperty(args, $(QuoteNode(mergename)))))
    end

    merge_exprs = Any[:(merged_context = pc)]
    for mergename in mergenames
        mergename in sc_names || error("Trying to merge into unknown subcontext $(QuoteNode(mergename)) in ProcessContext. Available subcontexts are: $(sc_names) and args has names: $(mergenames)")
        push!(
            merge_exprs,
            :(merged_context = @inline merge_into_subcontext(
                merged_context,
                Val($(QuoteNode(mergename))),
                getproperty(args, $(QuoteNode(mergename))),
            )),
        )
    end
    push!(merge_exprs, :(return merged_context))

    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        $(merge_exprs...)
    end
end

Base.@constprop :aggressive merge_into_subcontext(pc::ProcessContext{D}, name::Symbol, args) where {D} = @inline merge_into_subcontext(pc, Val(name), args)

function _namedtuple_merge_preserves_type(old_type::Type{<:NamedTuple}, new_type::Type)
    new_type <: NamedTuple || return false

    old_names = fieldnames(old_type)
    new_names = fieldnames(new_type)
    for name in new_names
        name in old_names || return false
        fieldtype(old_type, name) === fieldtype(new_type, name) || return false
    end
    return true
end

@inline @generated function merge_into_subcontext(pc::ProcessContext{D}, ::Val{name}, args::A) where {D, name, A}
    sc_names = get_subcontexts_fieldnames(pc)
    found_idx = _static_tuple_index(sc_names, name)
    if isnothing(found_idx)
        error("Trying to merge into unknown subcontext $(QuoteNode(name)) in ProcessContext. Available subcontexts are: $(sc_names)")
    end
    old_sc_type = fieldtype(D, name)

    if _namedtuple_merge_preserves_type(getdatatype(old_sc_type), A)
        return quote
            LineNumberNode(@__LINE__, @__FILE__)
            @inline merge_into_subcontext_mutate(pc, Val($(QuoteNode(name))), args)
        end
    end
    return quote 
        LineNumberNode(@__LINE__, @__FILE__)
        @inline merge_into_subcontext_rebuild(pc, Val($(QuoteNode(name))), args)
    end
end

@inline @generated function merge_into_subcontext_rebuild(pc::ProcessContext{D}, ::Val{name}, args) where {D, name}
    sc_names = get_subcontexts_fieldnames(pc)
    found_idx = _static_tuple_index(sc_names, name)
    if isnothing(found_idx)
        error("Trying to merge into unknown subcontext $(QuoteNode(name)) in ProcessContext. Available subcontexts are: $(sc_names)")
    end

    getproperty_exprs = Expr[:(getproperty(get_subcontexts(pc), $(QuoteNode(sc_name)))) for sc_name in sc_names]
    getproperty_exprs[found_idx] = :(@inline merge(getproperty(get_subcontexts(pc), $(QuoteNode(name))), args))
    ntnames = tuple(sc_names...)

    return quote
        LineNumberNode(@__LINE__, @__FILE__)
        new_subcontexts = @inline NamedTuple{$ntnames}(tuple($(getproperty_exprs...)))
        return @inline ProcessContext(new_subcontexts, getregistry(pc), getglobals(pc), getruntimeinput(pc))
    end
end

@inline @generated function merge_into_subcontext_mutate(pc::ProcessContext{D}, ::Val{name}, args) where {D, name}
    sc_names = get_subcontexts_fieldnames(pc)
    found_idx = _static_tuple_index(sc_names, name)
    if isnothing(found_idx)
        error("Trying to merge into unknown subcontext $(QuoteNode(name)) in ProcessContext. Available subcontexts are: $(sc_names)")
    end

    getproperty_exprs = Expr[:(getproperty(get_subcontexts(pc), $(QuoteNode(sc_name)))) for sc_name in sc_names]
    getproperty_exprs[found_idx] = :(@inline merge(getproperty(get_subcontexts(pc), $(QuoteNode(name))), args))
    ntnames = tuple(sc_names...)

    return quote
        LineNumberNode(@__LINE__, @__FILE__)
        new_subcontexts = @inline NamedTuple{$ntnames}(tuple($(getproperty_exprs...)))
        @inline setfield!(pc, :subcontexts, new_subcontexts)
        return pc
    end
end


"""
Args should name subcontext they want to replace, check if all names are in the original context
    since we can only replace existing subcontexts
"""
@inline @generated function _replace_subcontexts(pc::ProcessContext{D, Reg}, args::As) where {D, Reg, As<:NamedTuple}
    sc_names = get_subcontexts_fieldnames(pc)
    replacenames = fieldnames(args)
    getproperty_exprs = Expr[:(getproperty(get_subcontexts(pc), $(QuoteNode(name)))) for name in sc_names]

    for replacename in replacenames
        found_idx = _static_tuple_index(sc_names, replacename)
        if isnothing(found_idx)
            error("Trying to replace unknown subcontext $(QuoteNode(replacename)) in ProcessContext. Available subcontexts are: $(sc_names) and args has names: $(replacenames)")
        end
        getproperty_exprs[found_idx] = :(replace(getproperty(get_subcontexts(pc), $(QuoteNode(replacename))), getproperty(args, $(QuoteNode(replacename)))))
    end

    ntnames = tuple(sc_names...)
    return quote
        new_subcontexts = NamedTuple{$ntnames}(tuple($(getproperty_exprs...)))
        # @inline setfield(pc, :subcontexts, new_subcontexts)
        return @inline ProcessContext(new_subcontexts, getregistry(pc), getglobals(pc), getruntimeinput(pc))
    end
end

@inline Base.replace(pc::ProcessContext{D, Reg}, args::NamedTuple) where {D, Reg} = @inline _replace_subcontexts(pc, args)
