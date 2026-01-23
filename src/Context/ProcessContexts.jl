

"""
For every type register possible names and last updated name
"""
struct UpdateRegistry{Types, T}
    entries::T
end



#######################################
############# CONTEXT #################
#######################################
"""
Previously args system
This stores the context of a process
"""
struct ProcessContext{D,Reg} <: AbstractContext
    subcontexts::D
    registry::Reg
end

@inline Base.@constprop :aggressive function Base.getproperty(pc::ProcessContext, name::Symbol)
    return getproperty(get_subcontexts(pc), name)
end

@inline Base.@constprop :aggressive function Base.getindex(pc::ProcessContext, name::Symbol)
    return getproperty(get_subcontexts(pc), name)
end

"""
Args should name subcontext they want to replace, check if all names are in the original context
    since we can only replace existing subcontexts
"""
function Base.replace(pc::ProcessContext{D, Reg}, args::NamedTuple) where {D, Reg}
    names_to_replace = propertynames(args)
    @assert all( n -> hasproperty(get_subcontexts(pc), n), names_to_replace) "Trying to replace unknown subcontext(s) $(setdiff(names_to_replace, propertynames(get_subcontexts(pc)))) in ProcessContext"
    newcontext = merge_into_subcontexts(pc, args)
    return newcontext
end

@inline get_subcontexts(pc::ProcessContext) = getfield(pc, :subcontexts)
@inline get_registry(pc::ProcessContext) = getfield(pc, :registry)
@inline subcontext_names(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldnames(typeof(getproperty(get_subcontexts(pc), name)))
@inline subcontext_type(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldtype(typeof(get_subcontexts(pc)), name)
@inline function subcontext_type(pct::Type{<:ProcessContext{D}}, name::Symbol) where {D}
    fieldtype(D, name)
end

@inline getglobal(pc::ProcessContext) = getproperty(get_subcontexts(pc), :globals)
@inline function getglobal(pc::ProcessContext, name::Symbol)
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
    return @inline ProcessContext(newsubs, get_registry(pc))
end

### BASE EXTENSIONS
"""
Merge keys into subcontext by args = (;subcontextname1 = (;var1 = val1,...), subcontextname2 = (;...), ...)
    Assumes that the subcontext names exist in the context, otherwise it errors
"""
@inline function merge_into_subcontexts(pc::ProcessContext{D}, args::As) where {D, As}
    subs = subcontexts(pc)
    subnames = propertynames(subs)
    merged_subvalues = @inline ntuple(length(subnames)) do i
        if hasproperty(args, subnames[i])
            return merge(getproperty(subs, subnames[i]), getproperty(args, subnames[i]) )
        else
            return getproperty(subs, subnames[i])
        end
    end
    # for name in propertynames(args)
    #     if !(name in subnames)
    #         error("Trying to merge into unknown subcontext $(name) in ProcessContext")
    #     end
    # end
    newsubs = NamedTuple{subnames}(merged_subvalues)
    return ProcessContext{typeof(newsubs), typeof(get_registry(pc))}(newsubs, get_registry(pc))
end

# @inline Base.pairs(pc::ProcessContext) = pairs(pc.subcontexts)
# @inline Base.getproperty(pc::ProcessContext, name::Symbol) = getproperty(pc.subcontexts, name)



########################
### DISPLAY ###
########################

function _sharedvars_display(sharedvars_types)
    sharedvars_types === Tuple{} && return String[]
    items = String[]
    for sv in sharedvars_types
        from = get_fromname(sv)
        for (varname, alias) in sv
            push!(items, string(alias, "@", from, ".", varname))
        end
    end
    return items
end

function _subcontext_var_lines(sc::SubContext)
    lines = String[]
    shared_types = getsharedcontext_types(typeof(sc))
    shared_names = shared_types === Tuple{} ? Symbol[] : filter(!isnothing, contextname.(shared_types))
    if !isempty(shared_names)
        push!(lines, "shared: " * join(shared_names, ", "))
    end
    data = getdata(sc)
    data_names = propertynames(data)
    if isempty(data_names)
        push!(lines, "vars: ∅")
    else
        for name in data_names
            val = getproperty(data, name)
            push!(lines, string(name, " = ", summary(val)))
        end
    end
    sharedvars_items = _sharedvars_display(getsharedvars_types(typeof(sc)))
    for item in sharedvars_items
        push!(lines, ":" * item)
    end
    return lines
end

function _subcontext_var_lines(sc::NamedTuple)
    lines = String[]
    data_names = propertynames(sc)
    if isempty(data_names)
        push!(lines, "vars: ∅")
    else
        for name in data_names
            val = getproperty(sc, name)
            push!(lines, string(name, " = ", summary(val)))
        end
    end
    return lines
end

function Base.show(io::IO, sc::SubContext)
    println(io, "SubContext ", getname(sc))
    for line in _subcontext_var_lines(sc)
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
        for line in _subcontext_var_lines(sc)
            println(io, stem, "| ", line)
        end
    end
    return nothing
end
