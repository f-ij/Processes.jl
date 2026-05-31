@generated function ProcessContext(
    subcontexts::D,
    registry::Reg,
    runtime::R = (;),
    input::I = (;),
    widened::W = (;),
) where {D,Reg,R,I,W}
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
    return :(ProcessContext{D,Reg,R,I,W}(subcontexts, registry, runtime, input, widened))
end

"""
    OnDemandContext(subcontexts, registry, runtime, input, widened)

Construct the lightweight scoped context used only at leaf algorithm step
boundaries.
"""
@generated function OnDemandContext(
    subcontexts::D,
    registry::Reg,
    runtime::R = (;),
    input::I = (;),
    widened::W = (;),
) where {D,Reg,R,I,W}
    sc_names = fieldnames(D)
    bad_names = Symbol[]
    for name in sc_names
        if !(fieldtype(D, name) <: SubContext)
            push!(bad_names, name)
        end
    end
    @assert isempty(bad_names) "All fields in OnDemandContext subcontexts must be of type SubContext, but found non-SubContext fields: $bad_names"
    @assert Reg <: AbstractRegistry "Registry type must be a subtype of AbstractRegistry, got: $Reg"
    return :(OnDemandContext{D,Reg,R,I,W}(subcontexts, registry, runtime, input, widened))
end

"""
    _rebuild_scoped_context(pc, subcontexts, registry, runtime, input, widened)

Rebuild a scoped context while preserving whether the caller is a full
`ProcessContext` or a leaf-only `OnDemandContext`.
"""
@inline function _rebuild_scoped_context(
    ::Type{C},
    subcontexts::D,
    registry::Reg,
    runtime::R,
    input::I,
    widened::W,
) where {C<:AbstractScopedContext, D, Reg, R, I, W}
    return C(subcontexts, registry, runtime, input, widened)
end

@inline function _rebuild_scoped_context(
    pc::C,
    subcontexts::D,
    registry::Reg,
    runtime::R,
    input::I,
    widened::W,
) where {C<:AbstractScopedContext, D, Reg, R, I, W}
    return _rebuild_scoped_context(C, subcontexts, registry, runtime, input, widened)
end

@inline Base.@constprop :aggressive function Base.getproperty(pc::AbstractScopedContext, name::Symbol)
    if name === :subcontexts || name === :registry || name === :_runtime || name === :_input || name === :_widened
        return getfield(pc, name)
    end
    subcontexts = @inline get_subcontexts(pc)
    if haskey(subcontexts, name)
        subcontext = @inline getproperty(subcontexts, name)
        widened = @inline get_widened_subcontext(pc, Val(name))
        return isempty(widened) ? subcontext : @inline merge(subcontext, widened)
    end
    input = @inline getruntimeinput(pc)
    if haskey(input, name)
        return @inline getproperty(input, name)
    end
    return @inline getproperty(getfield(pc, :_runtime), name)
end

@inline Base.@constprop :aggressive function Base.getindex(pc::AbstractScopedContext, name::Symbol)
    name === :globals && return getglobals(pc)
    name === :_runtime && return getglobals(pc)
    name === :_input && return getruntimeinput(pc)
    return @inline getproperty(pc, name)
end

@inline function Base.getindex(pc::AbstractScopedContext, obj)
    name = getkey(getregistry(pc)[obj])
    return @inline getproperty(pc, name)
end

@inline function Base.getindex(pc::AbstractScopedContext, idx::Int)
    get_subcontexts(pc)[idx]
end

@inline get_subcontexts(pc::AbstractScopedContext) = getfield(pc, :subcontexts)
@inline getregistry(pc::AbstractScopedContext) = getfield(pc, :registry)
@inline getruntimeinput(pc::AbstractScopedContext) = getfield(pc, :_input)
@inline getwidened(pc::AbstractScopedContext) = getfield(pc, :_widened)

"""
    withruntime(pc, runtime)

Return an immutable `ProcessContext` rebuild with updated runtime globals.
This is the package-local replacement for `@set pc._runtime = runtime`.
"""
@inline function withruntime(pc::PC, runtime::R) where {PC<:AbstractScopedContext, R<:NamedTuple}
    return _rebuild_scoped_context(pc, get_subcontexts(pc), getregistry(pc), runtime, getruntimeinput(pc), getwidened(pc))
end

"""
    withsubcontexts(pc, subcontexts)

Return an immutable `ProcessContext` rebuild with updated subcontexts. This is
the package-local replacement for `@set pc.subcontexts = subcontexts`.
"""
@inline function withsubcontexts(pc::PC, subcontexts::D) where {PC<:AbstractScopedContext, D<:NamedTuple}
    return _rebuild_scoped_context(pc, subcontexts, getregistry(pc), getglobals(pc), getruntimeinput(pc), getwidened(pc))
end

"""
    withwidened(pc, widened)

Return an immutable `ProcessContext` rebuild with updated shape-widening data.

The widened bucket is part of the `ProcessContext` type so rare shape-changing
returns still rebuild a concrete context. The field is stripped after loop
completion, which keeps persistent context shape separate from widening.
"""
@inline function withwidened(pc::PC, widened) where {PC<:AbstractScopedContext}
    return _rebuild_scoped_context(pc, get_subcontexts(pc), getregistry(pc), getglobals(pc), getruntimeinput(pc), widened)
end

"""
    get_widened_subcontext(pc, Val(name))

Return the widened field patch for one subcontext, or an empty `NamedTuple`.
"""
@inline function get_widened_subcontext(pc::PC, ::Val{name}) where {PC<:AbstractScopedContext, name}
    widened = getwidened(pc)
    return haskey(widened, name) ? getproperty(widened, name) : (;)
end

"""
    has_widened_var(pc, Val(subcontext), Val(name))

Return whether a shape-widening patch contains `name` for `subcontext`.
"""
@inline function has_widened_var(pc::PC, ::Val{subcontext}, ::Val{name}) where {PC<:AbstractScopedContext, subcontext, name}
    patch = @inline get_widened_subcontext(pc, Val(subcontext))
    return haskey(patch, name)
end

"""
    get_widened_var(pc, Val(subcontext), Val(name))

Read a variable stored in the widened bucket for a subcontext.
"""
@inline function get_widened_var(pc::PC, ::Val{subcontext}, ::Val{name}) where {PC<:AbstractScopedContext, subcontext, name}
    patch = @inline get_widened_subcontext(pc, Val(subcontext))
    return getproperty(patch, name)
end

"""
    merge_into_widened(pc, args)

Merge nested subcontext patches into `ProcessContext._widened`.

This rebuilds a concretely typed `ProcessContext` with a new widened field type,
but does not change the main subcontext layout.
"""
@inline @generated function merge_into_widened(pc::PC, args::As) where {PC<:AbstractScopedContext, As<:NamedTuple}
    patch_names = fieldnames(As)
    isempty(patch_names) && return :(pc)

    widened_type = PC.parameters[5]
    widened_names = fieldnames(widened_type)
    exprs = Any[:(widened = @inline getwidened(pc))]
    for name in patch_names
        old_patch_expr = name in widened_names ? :(getproperty(widened, $(QuoteNode(name)))) : :((;))
        new_patch = gensym(:new_patch)
        push!(exprs, :($new_patch = @inline merge($old_patch_expr, getproperty(args, $(QuoteNode(name))))))
        if name in widened_names
            push!(exprs, :(widened = @inline replace_namedtuple_field(widened, Val($(QuoteNode(name))), $new_patch)))
        else
            push!(exprs, :(widened = @inline merge(widened, NamedTuple{$((name,))}(($new_patch,)))))
        end
    end
    push!(exprs, :(return @inline withwidened(pc, widened)))
    return Expr(:block, exprs...)
end

"""
    materialize_widened_context(pc)

Merge widened patches into their target subcontexts. This is used after a loop
has finished so external callers can inspect shape-changing results without the
hot `_step!` path changing context type.
"""
function materialize_widened_context(pc::PC) where {PC<:ProcessContext}
    widened = getwidened(pc)
    widened isa NamedTuple || return pc
    isempty(widened) && return pc
    context = pc
    for name in fieldnames(typeof(widened))
        context = @inline merge_into_subcontext_rebuild(context, Val(name), getproperty(widened, name))
    end
    return @inline withwidened(context, (;))
end

@inline subcontext_names(pc::AbstractScopedContext{D}, name::Symbol) where {D} = @inline fieldnames(typeof(getproperty(get_subcontexts(pc), name)))
@inline subcontext_type(pc::AbstractScopedContext{D}, name::Symbol) where {D} = @inline fieldtype(typeof(get_subcontexts(pc)), name)
@inline function subcontext_type(pct::Type{<:AbstractScopedContext{D}}, name::Symbol) where {D}
    fieldtype(D, name)
end

@inline get_subcontexts_fieldnames(pct::Type{<:AbstractScopedContext{D}}) where {D} = fieldnames(D)

@inline getglobals(pc::AbstractScopedContext) = getfield(pc, :_runtime)
@inline function getglobals(pc::AbstractScopedContext, name::Symbol)
    return getproperty(getglobals(pc), name)
end

subcontexts(pc::AbstractScopedContext) = get_subcontexts(pc)

@inline function isasubcontext(pc::Type{<:AbstractScopedContext}, v::Val{s}) where {s<:Symbol}
    subcontext_types = pc.parameters[1]
    return fieldtype(subcontext_types, s) <: SubContext
end
@inline isasubcontext(pc::AbstractScopedContext, s::Symbol) = isasubcontext(typeof(pc), Val(s))
@inline isasubcontext(pc::Type{<:AbstractScopedContext}, s::Symbol) = isasubcontext(pc, Val(s))

function get_subcontext_type(pc::Type{<:AbstractScopedContext}, s)
    return fieldtype(pc.parameters[1], s)
end

###
@inline function _merge_into_globals(pc::AbstractScopedContext{D}, args) where {D}
    merged_runtime = @inline merge(getglobals(pc), args)
    return @inline withruntime(pc, merged_runtime)
    # Accessors path kept for comparison:
    # return @inline @set pc._runtime = merged_runtime
end

"""
Merge a runtime-owned step return into `ProcessContext._runtime`.
"""
@inline merge_runtime_return(context::C, ::Nothing) where {C<:AbstractScopedContext} = context

@inline function merge_runtime_return(context::C, retval::R) where {C<:AbstractScopedContext, R<:NamedTuple}
    return @inline _merge_into_globals(context, retval)
end

function merge_runtime_return(context::C, retval::R) where {C<:AbstractScopedContext, R}
    error("Runtime-owned step returns must be named tuples or `nothing`, got $(typeof(retval)).")
end

"""
Merge keys into subcontext by args = (;subcontextname1 = (;var1 = val1,...), subcontextname2 = (;...), ...)
    Assumes that the subcontext names exist in the context, otherwise it errors
"""
@inline @generated function merge_into_subcontexts(pc::PC, args::As) where {PC<:AbstractScopedContext{D}, D, As}
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

Base.@constprop :aggressive merge_into_subcontext(pc::PC, name::Symbol, args) where {PC<:AbstractScopedContext{D}, D} = @inline merge_into_subcontext(pc, Val(name), args)

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

@inline @generated function merge_into_subcontext(pc::PC, ::Val{name}, args::A) where {PC<:AbstractScopedContext{D}, D, name, A}
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

@inline @generated function merge_into_subcontext_rebuild(pc::PC, ::Val{name}, args) where {PC<:AbstractScopedContext{D}, D, name}
    sc_names = get_subcontexts_fieldnames(pc)
    found_idx = _static_tuple_index(sc_names, name)
    if isnothing(found_idx)
        error("Trying to merge into unknown subcontext $(QuoteNode(name)) in ProcessContext. Available subcontexts are: $(sc_names)")
    end

    return quote
        LineNumberNode(@__LINE__, @__FILE__)
        old_subcontexts = @inline get_subcontexts(pc)
        old_subcontext = @inline getproperty(old_subcontexts, $(QuoteNode(name)))
        new_subcontext = @inline merge(old_subcontext, args)
        new_subcontexts = @inline replace_namedtuple_field(old_subcontexts, Val($(QuoteNode(name))), new_subcontext)
        return @inline withsubcontexts(pc, new_subcontexts)
    end
end

@inline @generated function merge_into_subcontext_mutate(pc::PC, ::Val{name}, args) where {PC<:AbstractScopedContext{D}, D, name}
    sc_names = get_subcontexts_fieldnames(pc)
    found_idx = _static_tuple_index(sc_names, name)
    if isnothing(found_idx)
        error("Trying to merge into unknown subcontext $(QuoteNode(name)) in ProcessContext. Available subcontexts are: $(sc_names)")
    end

    return quote
        LineNumberNode(@__LINE__, @__FILE__)
        old_subcontexts = @inline get_subcontexts(pc)
        subcontext = @inline getproperty(old_subcontexts, $(QuoteNode(name)))
        new_data = @inline merge(getdata(subcontext), args)
        new_subcontext = @inline withdata(subcontext, new_data)
        new_subcontexts = @inline replace_namedtuple_field(old_subcontexts, Val($(QuoteNode(name))), new_subcontext)
        return @inline withsubcontexts(pc, new_subcontexts)
        # Mutable SubContext path kept for comparison:
        # @inline setfield!(subcontext, :data, new_data)
        # return pc
    end
end


"""
Args should name subcontext they want to replace, check if all names are in the original context
    since we can only replace existing subcontexts
"""
@inline @generated function _replace_subcontexts(pc::PC, args::As) where {PC<:AbstractScopedContext{D, Reg}, D, Reg, As<:NamedTuple}
    sc_names = get_subcontexts_fieldnames(pc)
    replacenames = fieldnames(args)
    replace_exprs = Expr[]

    for replacename in replacenames
        found_idx = _static_tuple_index(sc_names, replacename)
        if isnothing(found_idx)
            error("Trying to replace unknown subcontext $(QuoteNode(replacename)) in ProcessContext. Available subcontexts are: $(sc_names) and args has names: $(replacenames)")
        end
        push!(
            replace_exprs,
            quote
                old_subcontext = @inline getproperty(new_subcontexts, $(QuoteNode(replacename)))
                new_subcontext = @inline replace(old_subcontext, getproperty(args, $(QuoteNode(replacename))))
                new_subcontexts = @inline replace_namedtuple_field(new_subcontexts, Val($(QuoteNode(replacename))), new_subcontext)
            end,
        )
    end

    return quote
        new_subcontexts = @inline get_subcontexts(pc)
        $(replace_exprs...)
        return @inline withsubcontexts(pc, new_subcontexts)
        # Accessors path kept for comparison:
        # return @inline @set pc.subcontexts = new_subcontexts
    end
end

@inline Base.replace(pc::PC, args::NamedTuple) where {PC<:AbstractScopedContext} = @inline _replace_subcontexts(pc, args)
