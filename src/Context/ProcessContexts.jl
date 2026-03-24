@generated function ProcessContext(subcontexts::D, registry::Reg) where {D,Reg}
    # Statically Check if all keys except for global are SubContexts
    sc_names = fieldnames(D)
    @assert all( n -> fieldtype(D, n) <: SubContext || n == :globals, sc_names) "All fields in ProcessContext subcontexts must be of type SubContext, but found non-SubContext fields: $(filter( n -> !(fieldtype(D, n) <: SubContext) && n != :globals, sc_names))"
    @assert Reg <: AbstractRegistry "Registry type must be a subtype of AbstractRegistry, got: $Reg"
    return :(ProcessContext{D,Reg}(subcontexts, registry))
end

@inline Base.@constprop :aggressive function Base.getproperty(pc::ProcessContext, name::Symbol)
    return @inline getproperty(get_subcontexts(pc), name)
end

@inline Base.@constprop :aggressive function Base.getindex(pc::ProcessContext, name::Symbol)
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

@inline subcontext_names(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldnames(typeof(getproperty(get_subcontexts(pc), name)))
@inline subcontext_type(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldtype(typeof(get_subcontexts(pc)), name)
@inline function subcontext_type(pct::Type{<:ProcessContext{D}}, name::Symbol) where {D}
    fieldtype(D, name)
end

@inline get_subcontexts_fieldnames(pct::Type{<:ProcessContext{D}}) where {D} = fieldnames(D)

@inline getglobals(pc::ProcessContext) = getproperty(get_subcontexts(pc), :globals)
@inline function getglobals(pc::ProcessContext, name::Symbol)
    return getproperty(getproperty(get_subcontexts(pc), :globals), name)
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

struct ContextTypeDiffResult{B,A,Ad,C,R}
    before::B
    after::A
    added::Ad
    changed::C
    removed::R
end

function _ntype_snapshot(nt::Type{<:NamedTuple})
    names = fieldnames(nt)
    return (; (name => fieldtype(nt, name) for name in names)...)
end

function _scope_type_snapshot(scope_type::Type)
    if scope_type <: SubContext
        return _ntype_snapshot(get_datatype(scope_type))
    elseif scope_type <: NamedTuple
        return _ntype_snapshot(scope_type)
    else
        return (; _type = scope_type)
    end
end

function _context_type_snapshot(::Type{<:ProcessContext{D}}) where {D}
    names = fieldnames(D)
    return (; (name => _scope_type_snapshot(fieldtype(D, name)) for name in names)...)
end

_context_type_snapshot(pc::ProcessContext) = _context_type_snapshot(typeof(pc))

function _scope_type_diff(before::NamedTuple, after::NamedTuple)
    added = Pair{Symbol, Any}[]
    changed = Pair{Symbol, Any}[]
    removed = Pair{Symbol, Any}[]

    before_names = propertynames(before)
    after_names = propertynames(after)

    for name in after_names
        if !haskey(before, name)
            push!(added, name => getproperty(after, name))
        elseif getproperty(before, name) != getproperty(after, name)
            push!(changed, name => (; from = getproperty(before, name), to = getproperty(after, name)))
        end
    end

    for name in before_names
        if !haskey(after, name)
            push!(removed, name => getproperty(before, name))
        end
    end

    return (; added = (; added...), changed = (; changed...), removed = (; removed...))
end

function ContextTypeDiff(before::Type{<:ProcessContext}, after::Type{<:ProcessContext})
    before_snapshot = _context_type_snapshot(before)
    after_snapshot = _context_type_snapshot(after)

    added = Pair{Symbol, Any}[]
    changed = Pair{Symbol, Any}[]
    removed = Pair{Symbol, Any}[]

    before_names = propertynames(before_snapshot)
    after_names = propertynames(after_snapshot)

    for scope_name in after_names
        if !haskey(before_snapshot, scope_name)
            push!(added, scope_name => getproperty(after_snapshot, scope_name))
            continue
        end

        scope_diff = _scope_type_diff(getproperty(before_snapshot, scope_name), getproperty(after_snapshot, scope_name))
        if !isempty(scope_diff.added)
            push!(added, scope_name => scope_diff.added)
        end
        if !isempty(scope_diff.changed)
            push!(changed, scope_name => scope_diff.changed)
        end
        if !isempty(scope_diff.removed)
            push!(removed, scope_name => scope_diff.removed)
        end
    end

    for scope_name in before_names
        if !haskey(after_snapshot, scope_name)
            push!(removed, scope_name => getproperty(before_snapshot, scope_name))
        end
    end

    return ContextTypeDiffResult(
        before_snapshot,
        after_snapshot,
        (; added...),
        (; changed...),
        (; removed...),
    )
end

ContextTypeDiff(before::ProcessContext, after::ProcessContext) = ContextTypeDiff(typeof(before), typeof(after))

function _show_context_type_snapshot(io::IO, title::AbstractString, snapshot::NamedTuple)
    println(io, title)
    for scope_name in propertynames(snapshot)
        scope_snapshot = getproperty(snapshot, scope_name)
        if isempty(scope_snapshot)
            println(io, "  ", scope_name, ": <empty>")
            continue
        end
        println(io, "  ", scope_name, ":")
        for var_name in propertynames(scope_snapshot)
            println(io, "    ", var_name, " :: ", getproperty(scope_snapshot, var_name))
        end
    end
end

function _show_context_type_changes(io::IO, title::AbstractString, changes::NamedTuple)
    println(io, title)
    if isempty(changes)
        println(io, "  <none>")
        return nothing
    end

    for scope_name in propertynames(changes)
        scope_changes = getproperty(changes, scope_name)
        println(io, "  ", scope_name, ":")
        for var_name in propertynames(scope_changes)
            val = getproperty(scope_changes, var_name)
            if val isa NamedTuple && haskey(val, :from) && haskey(val, :to)
                println(io, "    ", var_name, " :: ", val.from, " => ", val.to)
            else
                println(io, "    ", var_name, " :: ", val)
            end
        end
    end
    return nothing
end

function Base.show(io::IO, diff::ContextTypeDiffResult)
    println(io, "ContextTypeDiff")
    _show_context_type_snapshot(io, "before:", diff.before)
    _show_context_type_snapshot(io, "after:", diff.after)
    _show_context_type_changes(io, "added:", diff.added)
    _show_context_type_changes(io, "changed:", diff.changed)
    _show_context_type_changes(io, "removed:", diff.removed)
    return nothing
end

###
@inline function merge_into_globals(pc::ProcessContext{D}, args) where {D}
    merged_globals = @inline merge(getfield(get_subcontexts(pc), :globals), args)
    newsubs = (; get_subcontexts(pc)..., globals = merged_globals)
    # return @inline ProcessContext(newsubs, getregistry(pc))
    return setfield(pc, :subcontexts, newsubs)
end

"""
Merge keys into subcontext by args = (;subcontextname1 = (;var1 = val1,...), subcontextname2 = (;...), ...)
    Assumes that the subcontext names exist in the context, otherwise it errors
"""
@inline @generated function merge_into_subcontexts(pc::ProcessContext{D}, args::As) where {D, As}
    sc_names = get_subcontexts_fieldnames(pc)
    mergenames = fieldnames(args)
    getproperty_exprs = Expr[:(getproperty(get_subcontexts(pc), $(QuoteNode(name)))) for name in sc_names]
    for (mergeidx, mergname) in enumerate(mergenames)
        found_idx = findfirst( n -> n == mergname, sc_names)
        if isnothing(found_idx)
            error("Trying to merge into unknown subcontext $(QuoteNode(mergname)) in ProcessContext. Available subcontexts are: $(sc_names) and args has names: $(mergenames)")
        end
        # getproperty_exprs[mergeidx] = :(getproperty(args, $(QuoteNode(mergname))))
        getproperty_exprs[found_idx] = :(merge(getproperty(get_subcontexts(pc), $(QuoteNode(mergname))), getproperty(args, $(QuoteNode(mergname)))))
    end
    ntnames = tuple(sc_names...)
    return quote 
        new_subcontexts = NamedTuple{$ntnames}(tuple($(getproperty_exprs...)))
        @inline setfield(pc, :subcontexts, new_subcontexts)
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
        found_idx = findfirst(n -> n == replacename, sc_names)
        if isnothing(found_idx)
            error("Trying to replace unknown subcontext $(QuoteNode(replacename)) in ProcessContext. Available subcontexts are: $(sc_names) and args has names: $(replacenames)")
        end
        getproperty_exprs[found_idx] = :(replace(getproperty(get_subcontexts(pc), $(QuoteNode(replacename))), getproperty(args, $(QuoteNode(replacename)))))
    end

    ntnames = tuple(sc_names...)
    return quote
        new_subcontexts = NamedTuple{$ntnames}(tuple($(getproperty_exprs...)))
        @inline setfield(pc, :subcontexts, new_subcontexts)
    end
end

@inline Base.replace(pc::ProcessContext{D, Reg}, args::NamedTuple) where {D, Reg} = @inline _replace_subcontexts(pc, args)

### BASE EXTENSIONS


# @inline Base.pairs(pc::ProcessContext) = pairs(pc.subcontexts)
# @inline Base.getproperty(pc::ProcessContext, name::Symbol) = getproperty(pc.subcontexts, name)

