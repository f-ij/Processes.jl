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


# @inline function merge_into_subcontexts(pc::ProcessContext{D}, args::As) where {D, As}
#     subs = subcontexts(pc)
#     subnames = propertynames(subs)
#     merged_subvalues = @inline ntuple(length(subnames)) do i
#         if hasproperty(args, subnames[i])
#             return merge(getproperty(subs, subnames[i]), getproperty(args, subnames[i]) )
#         else
#             return getproperty(subs, subnames[i])
#         end
#     end
#     newsubs = NamedTuple{subnames}(merged_subvalues)
#     setfield(pc, :subcontexts, newsubs)
#     # return ProcessContext{typeof(newsubs), typeof(getregistry(pc))}(newsubs, getregistry(pc))
# end

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
        # `SharedVars` is usually carried around as a *type* (DataType) whose 2nd type-parameter
        # encodes the varname=>alias mapping (typically as a NamedTuple value).
        # Iterating the type itself isn't defined, so iterate the stored mapping instead.
        svu = Base.unwrap_unionall(sv)
        nt = svu.parameters[2]
        itr = nt isa NamedTuple ? pairs(nt) : nt
        for (varname, alias) in itr
            push!(items, string(alias, "@", from, ".", varname))
        end
    end
    return items
end

function _subcontext_var_lines(sc::SubContext; io::IO = stdout)
    lines = String[]
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
                push!(lines, string(name, " = ", summary(val)))
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
    data_names = propertynames(sc)
    if isempty(data_names)
        push!(lines, "vars: ∅")
    else
        for name in data_names
            val = getproperty(sc, name)
            if val isa Tuple && all(_is_input_like, val)
                push!(lines, string(name, " = ", _format_inputs_tuple(val)))
            else
                push!(lines, string(name, " = ", summary(val)))
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

function Base.show(io::IO, pc::ProcessContext)
    println(io, "ProcessContext")
    subs = get_subcontexts(pc)
    names = collect(propertynames(subs))
    last_idx = length(names)
    for (idx, name) in enumerate(names)
        sc = getproperty(subs, name)
        branch = idx == last_idx ? "`-- " : "|-- "
        stem = idx == last_idx ? "    " : "|   "
        println(io, branch, name)
        for line in _subcontext_var_lines(sc; io)
            println(io, stem, "| ", line)
        end
    end
    return nothing
end
