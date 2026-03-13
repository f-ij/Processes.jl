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
function Base.replace(pc::ProcessContext{D, Reg}, args::NamedTuple) where {D, Reg}
    names_to_replace = propertynames(args)
    @assert all( n -> hasproperty(get_subcontexts(pc), n), names_to_replace) "Trying to replace unknown subcontext(s) $(setdiff(names_to_replace, propertynames(get_subcontexts(pc)))) in ProcessContext"
    old_subs = get_subcontexts(pc)
    replaced_gen = (name => 
            begin haskey(args, name) ? replace(getproperty(old_subs, name), getproperty(args, name)) : getproperty(old_subs, name) end  for name in propertynames(old_subs))
    newsubs = (;old_subs..., replaced_gen...)
    return setfield(pc, :subcontexts, newsubs)
end

### BASE EXTENSIONS


# @inline Base.pairs(pc::ProcessContext) = pairs(pc.subcontexts)
# @inline Base.getproperty(pc::ProcessContext, name::Symbol) = getproperty(pc.subcontexts, name)



########################
### DISPLAY ###
########################

@inline _is_input_like(x) = x isa NamedInput || x isa NamedOverride

function _format_inputs_tuple(t::Tuple)
    isempty(t) && return "Inputs: ∅"
    items = String[]
    for it in t
        if _is_input_like(it)
            push!(items, string(get_target_name(it), " ", get_vars(it)))
        else
            push!(items, sprint(summary, it))
        end
    end
    return "Inputs: " * join(items, ", ")
end

function _sharedvars_display(sharedvars_types)
    sharedvars_types === Tuple{} && return String[]
    items = String[]
    for sv in sharedvars_types
        from = get_fromname(sv)
        varnames = subvarcontextnames(sv)
        aliases = localnames(sv)
        for (varname, alias) in zip(varnames, aliases)
            push!(items, string(alias, "@", from, ".", varname))
        end
    end
    return items
end

function _subcontext_var_lines(sc::SubContext; io::IO = stdout)
    lines = String[]
    show_ctx = IOContext(io, :limit => get(io, :limit, false), :color => get(io, :color, false))
    shared_types = getsharedcontext_types(typeof(sc))
    shared_names = shared_types === Tuple{} ? Symbol[] : filter(!isnothing, contextname.(shared_types))
    if !isempty(shared_names)
        # Emit styling only when the *caller IO* supports it; otherwise keep plain text.
        if get(io, :color, false)
            buf = IOBuffer()
            # `printstyled` consults `:color` on the IO it is writing to, so wrap the buffer
            # in an IOContext that explicitly enables color/styling.
            cio = IOContext(buf, :color => true)
            printstyled(cio, "shared:"; bold = true)
            print(cio, " ", join(shared_names, ", "))
            push!(lines, String(take!(buf)))
        else
            push!(lines, "shared: " * join(shared_names, ", "))
        end
    end
    data = get_data(sc)
    data_names = propertynames(data)
    if isempty(data_names)
        push!(lines, "vars: ∅")
    else
        for name in data_names
            val = getproperty(data, name)
            if val isa Tuple && all(_is_input_like, val)
                push!(lines, string(name, " = ", _format_inputs_tuple(val)))
            else
                push!(lines, string(name, " = ", sprint(summary, val; context = show_ctx)))
            end
        end
    end
    sharedvars_items = _sharedvars_display(getsharedvars_types(typeof(sc)))
    for item in sharedvars_items
        push!(lines, ":" * item)
    end
    return lines
end

function _subcontext_var_lines(sc::NamedTuple; io::IO = stdout)
    lines = String[]
    show_ctx = IOContext(io, :limit => get(io, :limit, false), :color => get(io, :color, false))
    data_names = propertynames(sc)
    if isempty(data_names)
        push!(lines, "vars: ∅")
    else
        for name in data_names
            val = getproperty(sc, name)
            if val isa Tuple && all(_is_input_like, val)
                push!(lines, string(name, " = ", _format_inputs_tuple(val)))
            else
                push!(lines, string(name, " = ", sprint(summary, val; context = show_ctx)))
            end
        end
    end
    return lines
end

function Base.show(io::IO, sc::SubContext)
    println(io, "SubContext ", getkey(sc))
    for line in _subcontext_var_lines(sc; io)
        println(io, "  ", line)
    end
    return nothing
end

#=
function Base.show(io::IO, pc::ProcessContext)
    println(io, "ProcessContext")
    subs = get_subcontexts(pc)
    names = collect(propertynames(subs))
    last_idx = length(names)
    for (idx, name) in enumerate(names)
        sc = getproperty(subs, name)
        branch = idx == last_idx ? "└── " : "├── "
        stem = idx == last_idx ? "    " : "│   "
        println(io, branch, "[", idx, "]: ", name)

        var_lines = _subcontext_var_lines(sc; io)
        var_last_idx = length(var_lines)
        for (var_idx, line) in enumerate(var_lines)
            var_branch = var_idx == var_last_idx ? " └── " : " ├── "
            var_stem = var_idx == var_last_idx ? "    " : "│   "
            split_lines = split(line, '\n')
            println(io, stem, var_branch, split_lines[1])
            for continuation in Iterators.drop(split_lines, 1)
                println(io, stem, var_stem, lstrip(continuation))
            end
        end
    end
    return nothing
end
=#

function Base.show(io::IO, pc::ProcessContext)
    println(io, "ProcessContext")
    show_ctx = IOContext(io, :limit => get(io, :limit, false), :color => get(io, :color, false))
    subs = get_subcontexts(pc)
    names = collect(propertynames(subs))
    last_idx = length(names)

    for (idx, name) in enumerate(names)
        sc = getproperty(subs, name)
        branch = idx == last_idx ? "└── " : "├── "
        stem = idx == last_idx ? "    " : "│   "
        println(io, branch, "[", idx, "]: ", name)

        var_lines = _subcontext_var_lines(sc; io = show_ctx)
        var_last_idx = length(var_lines)
        for (var_idx, line) in enumerate(var_lines)
            var_branch = var_idx == var_last_idx ? " └── " : " ├── "
            continuation_stem = var_idx == var_last_idx ? "    " : "│   "
            split_lines = split(line, '\n')
            println(io, stem, var_branch, split_lines[1])
            align_prefix = begin
                eqidx = findfirst(" = ", split_lines[1])
                isnothing(eqidx) ? "" : repeat(" ", last(eqidx))
            end
            for continuation in Iterators.drop(split_lines, 1)
                leading_ws = length(continuation) - length(lstrip(continuation))
                pad = isempty(align_prefix) ? 0 : max(length(align_prefix) - leading_ws, 0)
                println(io, stem, continuation_stem, repeat(" ", pad), continuation)
            end
        end
    end
    return nothing
end
