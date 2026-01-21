

"""
For every type register possible names and last updated name
"""
struct UpdateRegistry{Types, T}
    entries::T
end


"""
Whole name space from A1 to A2, optionally directional
"""
struct Share{A1,A2}
    algo1::A1
    algo2::A2
    directional::Bool
end

function Share(algo1::Symbol, algo2::Symbol; directional::Bool=false)
    Share{typeof(algo1), typeof(algo2)}(algo1, algo2, directional)
end

function get_sharedcontexts(reg::NameSpaceRegistry, s::Share)
    names = (static_find_name(reg, s.algo1), static_find_name(reg, s.algo2))
    if any(isnothing, names)
        error("No registered name found for share endpoints $(s.algo1), $(s.algo2)")
    end
    nt = (; names[1] => SharedContext{ names[2] }())
    if !s.directional
        nt = (; nt..., names[2] => SharedContext{ names[1] }())
    end
    return nt
end

"""
User-facing route from one subcontext to another
"""
struct Route{F,T,N}
    from::F # From algo
    to::T   # To algo
    varnames::NTuple{N, Symbol}
    aliases::NTuple{N, Symbol}
end

function Route(from::Symbol, to::Symbol, originalname_or_aliaspairs::Union{Symbol, Pair{Symbol, Symbol}}...)
    completed_pairs = ntuple(length(originalname_or_aliaspairs)) do i
        item = originalname_or_aliaspairs[i]
        item isa Symbol ? item => item : item
    end
    varnames = first.(completed_pairs)
    aliases = last.(completed_pairs)
    Route{typeof(from), typeof(to), length(varnames)}(from, to, varnames, aliases)
end

struct SharedContext{from_name} end
contextname(st::Type{SharedContext{name}}) where {name} = name
contextname(st::SharedContext{name}) where {name} = name
contextname(::Any) = nothing

struct SharedVars{from_name, varnames, aliases} end
get_fromname(::Type{SharedVars{from_name}}) where {from_name} = from_name
get_fromname(::SharedVars{from_name}) where {from_name} = from_name
get_varname(::Type{SharedVars{from_name, varnames, aliases}}) where {from_name, varnames, aliases} = varnames
get_aliasname(::Type{SharedVars{from_name, varnames, aliases}}) where {from_name, varnames, aliases} = aliases
contextname(sv::Type{SharedVars{from_name}}) where {from_name} = from_name
contextname(sv::SharedVars{from_name}) where {from_name} = from_name

function Base.iterate(r::Union{SharedVars{F,V,A}, Type{SharedVars{F,V,A}}}, state = 1) where {F,V,A}
    if state > length(V)
        return nothing
    else
        return ( (V[state], A[state]), state + 1 )
    end
end

function to_sharedvars(reg::NameSpaceRegistry, r::Route)
    name = static_find_name(reg, r.from)
    SharedVars{name, r.varnames, r.aliases}()
end


########################
    ### SUBCONTEXT ###
########################

"""
A subcontext can share share in two ways:
    1) Whole subcontext shares:         The entire subcontext is shared between processes
    2) Variable shares through shared vars: Only specific variables are shared between subcontexts, 
                                                defined by shared vars with optional aliases
"""
struct SubContext{Name, T<:NamedTuple, S, R} <: AbstractSubContext
    data::T
    sharedcontexts::S # Whole subcontext shares
    sharedvars::R # Variable shares with aliases
end

getdata(sc::SubContext) = getfield(sc, :data)
getsharedcontexts(sc::SubContext) = getfield(sc, :sharedcontexts)
getsharedvars(sc::SubContext) = getfield(sc, :sharedvars)

function SubContext(name, data::NamedTuple, sharedcontexts, sharedvars)
    SubContext{name, typeof(data), typeof(sharedcontexts), typeof(sharedvars)}(data, sharedcontexts, sharedvars)
end

function newdata(sc::SubContext, data::NamedTuple)
    SubContext{getname(sc), typeof(data), getsharedcontext_types(sc), getsharedvars_types(sc)}(data, getsharedcontexts(sc), getsharedvars(sc))
end

@inline Base.isempty(sc::SubContext) = isempty(getdata(sc))
@inline getname(sct::Type{<:SubContext}) = sct.parameters[1]
@inline get_datatype(sct::Type{<:SubContext}) = sct.parameters[2]

@inline function getsharedcontext_types(sct::Type{<:SubContext})
    params = sct.parameters[3].parameters
    return tuple(params...)
end
@inline function getsharedvars_types(sct::Type{<:SubContext})
    params = sct.parameters[4].parameters
    return tuple(params...)
end

@inline getname(sc::SubContext) = getname(typeof(sc))
@inline get_datatype(sc::SubContext) = get_datatype(typeof(sc))
@inline getsharedcontext_types(sc::SubContext) = getsharedcontext_types(typeof(sc))
@inline getsharedvars_types(sc::SubContext) = getsharedvars_types(typeof(sc))

@inline function getsharedcontext_names(sct::Type{<:SubContext})
    shared_context_types = getsharedcontext_types(sct)
    if isempty(shared_context_types)
        return tuple()
    end
    contextname.(shared_context_types)
end

@inline Base.pairs(sc::SubContext) = pairs(getdata(sc))
@inline Base.getproperty(sc::SubContext, name::Symbol) = getproperty(getdata(sc), name)
@inline function Base.merge(sc::SubContext{Name, T, S, R}, args::NamedTuple) where {Name, T, S, R}
    merged = merge(getdata(sc), args)
    SubContext{Name,typeof(merged), S, R}(merged, getsharedcontexts(sc), getsharedvars(sc))
end

@inline function Base.merge(args::NamedTuple, sc::SubContext{Name, T, S, R}) where {Name, T, S, R}
    merged = merge(args, getdata(sc))
    SubContext{Name,typeof(merged), S, R}(merged, getsharedcontexts(sc), getsharedvars(sc))
end



@inline Base.fieldnames(sct::Type{<:SubContext}) = fieldnames(sct.parameters[2])
@inline Base.keys(sc::SubContext) = propertynames(getdata(sc))

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

Base.@constprop :aggressive function Base.getproperty(pc::ProcessContext, name::Symbol)
    return getproperty(get_subcontexts(pc), name)
end

Base.@constprop :aggressive function Base.getindex(pc::ProcessContext, name::Symbol)
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
    merged_globals = merge(getfield(get_subcontexts(pc), :globals), args)
    newsubs = (; get_subcontexts(pc)..., globals = merged_globals)
    return ProcessContext{typeof(newsubs), typeof(get_registry(pc))}(newsubs, get_registry(pc))
end

### BASE EXTENSIONS
"""
Merge keys into subcontext by args = (;subcontextname1 = (;var1 = val1,...), subcontextname2 = (;...), ...)
    Assumes that the subcontext names exist in the context, otherwise it errors
"""
@inline function merge_into_subcontexts(pc::ProcessContext{D}, args) where {D}
    subs = subcontexts(pc)
    subnames = propertynames(subs)
    subvalues = values(subs)
    merged_subvalues = ntuple(length(subnames)) do i
        if hasproperty(args, subnames[i])
            return merge(getproperty(subs, subnames[i]), getproperty(args, subnames[i]) )
        else
            return getproperty(subs, subnames[i])
        end
    end
    for name in propertynames(args)
        if !(name in subnames)
            error("Trying to merge into unknown subcontext $(name) in ProcessContext")
        end
    end
    newsubs = NamedTuple{subnames}(merged_subvalues)
    return ProcessContext{typeof(newsubs), typeof(get_registry(pc))}(newsubs, get_registry(pc))
end

# @inline Base.pairs(pc::ProcessContext) = pairs(pc.subcontexts)
# @inline Base.getproperty(pc::ProcessContext, name::Symbol) = getproperty(pc.subcontexts, name)

"""
Get a subcontext view for a specific subcontext
"""
@inline Base.view(pc::ProcessContext, instance) = SubContextView{typeof(pc), getname(instance), typeof(instance)}(pc, instance)


##########################
#### Subcontext views ####
##########################
"""
Go from a local variable to the location in the full context
Type can be
    - :local
    - :shared
    - :routed
"""
struct VarLocation{Type}
    subcontextname::Symbol
    originalname::Symbol
end

function get_subcontextname(vl::VarLocation)
    return vl.subcontextname
end

function get_originalname(vl::VarLocation)
    return vl.originalname
end

#######################
### SUBCONTEXT VIEW ###
#######################
struct SubContextView{CType, SubName, T} <: AbstractContext
    context::CType
    instance::T # instance for which the view is created
end

@inline this_instance(scv::SubContextView) = getfield(scv, :instance)

@inline getglobal(scv::SubContextView, name::Symbol) = getglobal(getcontext(scv), name)
@inline getglobal(scv::SubContextView) = getglobal(getcontext(scv))

@inline getcontext(scv::SubContextView) = getfield(scv, :context)
@inline getsubcontext(scv::SubContextView{CType, SubName}) where {CType, SubName} = getproperty(getcontext(scv), SubName)

"""
Generate a namedtuple of localtuple => VarLocation
"""
@inline @generated function get_varlocations(scv::Union{SubContextView{CType, SubName}, Type{<:SubContextView{CType, SubName}}}) where {CType, SubName}
    # First get the subcontext type
    subcontext_type = Processes.subcontext_type(CType, SubName)

    local_varnames = fieldnames(get_datatype(subcontext_type))

    localst = ntuple(i ->VarLocation{:local}(SubName, local_varnames[i]), length(local_varnames))
    locals = NamedTuple{(local_varnames...,)}(localst)

    ### All shared vars heaped together
    shared_context_names = getsharedcontext_names(subcontext_type)
    sharedcontexts = NamedTuple()
    for name in shared_context_names
        shared_subcontext_type = Processes.subcontext_type(CType, name)
        shared_varnames = fieldnames(shared_subcontext_type)
        sharedt = ntuple(i ->VarLocation{:shared}(name, shared_varnames[i]), length(shared_varnames))
        sharednt = NamedTuple{(shared_varnames...)}(sharedt)
        sharedcontexts = (;sharedcontexts..., sharednt...)
    end

    ### Shared vars resolved separately per subcontext
    sharedvars = getsharedvars_types(subcontext_type)
    sharedvar_locations = tuple()
    sharedvar_names = tuple()
    for sharedvar in sharedvars
        sharedvar_from = get_fromname(sharedvar)
        for var_to_alias in sharedvar
            alias = last(var_to_alias)
            varname = first(var_to_alias)
            sharedvar_locations = (sharedvar_locations..., VarLocation{:routed}(sharedvar_from, varname))
            sharedvar_names = (sharedvar_names..., alias)
        end
    end
    sharedvars = NamedTuple{(sharedvar_names...)}(sharedvar_locations)

    all_vars = (;locals = locals, sharedcontexts = sharedcontexts, sharedvars = sharedvars)
    # all_vars = (;locals..., shared..., routed...)
    return :( $all_vars )
end

@inline function get_all_locations(sctv::Type{<:SubContextView})
    v_l = get_varlocations(sctv)
    return (;v_l.locals..., v_l.sharedcontexts..., v_l.sharedvars...)
end

@inline get_all_locations(scv::SubContextView) = get_all_locations(typeof(scv))


Base.@constprop :aggressive function Base.getproperty(sct::SubContextView, vl::VarLocation)
    subcontext = @inline getproperty(getcontext(sct), vl.subcontextname)
    return @inline getproperty(subcontext, vl.originalname)
end

Base.@constprop :aggressive function Base.getproperty(sct::SubContextView{CType, SubName}, name::Symbol) where {CType, SubName}
    locations = get_all_locations(sct)
    if hasproperty(locations, name)
        vl = getproperty(locations, name)
        subcontext = @inline getproperty(getcontext(sct), vl.subcontextname)
        return @inline getproperty(subcontext, vl.originalname)
    else
        error("Trying to access unknown variable $(name) from SubContextView $(SubName)")
    end
end

"""
Get the type of the original subcontext from the view
"""
@inline subcontext_type(scv::SubContextView{CType, SubName}) where {CType<:ProcessContext, SubName} = subcontext_type(CType, SubName)
@inline subcontext_type(scvt::Type{<:SubContextView{CType, SubName}}) where {CType<:ProcessContext, SubName} = subcontext_type(CType, SubName)

@inline Base.keys(scv::SubContextView) = propertynames(get_all_locations(scv))
@inline Base.propertynames(scv::SubContextView) = propertynames(get_all_locations(scv))

"""
Returns a merged context by merging the provided named tuple into the appropriate subcontexts

"""
@generated function Base.merge(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    # this_subcontext = subcontext_type(scv)
    keys_to_merge = fieldnames(args)
    
    locations = get_all_locations(scv)
    merge_expressions_by_subcontext = NamedTuple()
    for localname in keys_to_merge
        if hasproperty(locations, localname) # If the local variable exists
            target_subcontext = get_subcontextname(getproperty(locations, localname))

            this_mergetuple = NamedTuple()
            if hasproperty(merge_expressions_by_subcontext, target_subcontext) # If subcontext was already targeted, merge into
                this_mergetuple = getproperty(merge_expressions_by_subcontext, target_subcontext)
            end

            targetname = get_originalname( getproperty(locations, localname) )
            getvalue_expr = :( getproperty(args, $(QuoteNode(localname))) )
            this_mergetuple = (;this_mergetuple..., targetname => getvalue_expr)
        else
            error("Trying to merge unknown variable $(localname) from SubContext $(SubName)")
        end
        merge_expressions_by_subcontext = (;merge_expressions_by_subcontext..., target_subcontext => this_mergetuple)
    end
        
    return quote
        mergetuple = $(merge_expressions_by_subcontext)
        newcontext = merge_into_subcontexts(getcontext(scv), mergetuple)
        return newcontext
    end
end

Base.merge(scv::SubContextView, ::Nothing) = getcontext(scv)

"""
Instead of merging, replace the subcontext entirely with the provided args named tuple
Returns new context

This is to be used during the prepare phase, where entire subcontexts are replaced
"""
function Base.replace(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    names = propertynames(args)
    # Error if trying to replace any other subcontext than the one in the view
    if any( n -> n != SubName, names)
        error("Trying to replace subcontext $(n) from SubContextView $(SubName), only $(SubName) can be replaced")
    end
    newsubcontext = newdata(subcontext_type(scv), getproperty(args, SubName))
    old_context = getcontext(scv)
    return replace(old_context, (; SubName => newsubcontext))
end

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
    shared_names = shared_types === Tuple{} ? Symbol[] : contextname.(shared_types)
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
            val = Base.getproperty(sc, name)
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
        sc = Base.getproperty(subs, name)
        branch = idx == last_idx ? "`-- " : "|-- "
        stem = idx == last_idx ? "    " : "|   "
        println(io, branch, name)
        for line in _subcontext_var_lines(sc)
            println(io, stem, "| ", line)
        end
    end
    return nothing
end
