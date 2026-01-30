get_entries(reg::NameSpaceRegistry{T}) where {T} = reg.entries

Base.getindex(reg::NameSpaceRegistry, idx::Int) = reg.entries[idx]
function Base.setindex(reg::NameSpaceRegistry{T}, newentry, idx::Int) where {T}
    old_entries = get_entries(reg)
    new_entries = Base.setindex(old_entries, newentry, idx)
    return NameSpaceRegistry{typeof(new_entries)}(new_entries)
end
function Base.setindex(reg::NameSpaceRegistry, newentry, T::Type)
    fidx = find_typeidx(reg, T)
    if isnothing(fidx)
        error("Type $T not found in registry")
    end
    return Base.setindex(reg, newentry, fidx)
end

"""
Types of entries as a tuple type Tuple{Type1, Type2, ...}
"""
@generated function gettypes(reg::Type{NameSpaceRegistry{T}}) where {T}
    entrytypes = T.parameters
    datatypes = gettype.(entrytypes)
    Tt = Tuple{datatypes...}
    return :($Tt)
end

"""
Types of entries as a tuple statically (Type1, type2, ...)
"""
@generated function gettypes_iterator(reg::Type{NameSpaceRegistry{T}}) where {T}
    entrytypes = T.parameters
    datatypes = gettype.(entrytypes)
    Tt = tuple(datatypes...)
    return :($Tt)
end

gettypes_iterator(reg::NameSpaceRegistry) = gettypes_iterator(typeof(reg))

"""
Find the index in the entries for a given type T
"""
@generated function _find_typeidx(reg::Type{<:NameSpaceRegistry}, typ::Type{T}) where {T}
    T_non_scoped = contained_type(T) # Containers are categorized give the type of the obj inside
    regt = reg.parameters[1]
    it = gettypes_iterator(regt)
    index = findfirst(t -> T_non_scoped <: t, it)
    return :( $index )
end
"""

"""
@inline find_typeidx(regt::Type{<:NameSpaceRegistry}, obj) = _find_typeidx(regt, typeof(obj))
@inline find_typeidx(regt::Type{<:NameSpaceRegistry}, typ::Type) = _find_typeidx(regt, typ)
@inline find_typeidx(reg::NameSpaceRegistry, obj) = find_typeidx(typeof(reg), obj)


########################################
############## Interface ###############
########################################


#########################
######### ADDING ########
#########################
"""
Add an instance and get new registry and a named instance back
"""
function add_instance(reg::NameSpaceRegistry{T}, obj, multiplier = 1.) where {T}
    fidx = find_typeidx(reg, obj)
    if isnothing(fidx) # New Entry
        newentry = RegistryTypeEntry(obj)
        newentry, namedobj = add(newentry, obj, multiplier)
        return NameSpaceRegistry((reg.entries..., newentry)), namedobj
    else # Type was found
        entry = reg.entries[fidx]
        newentry, namedobj = add(entry, obj, multiplier)
        newentries = Base.setindex(reg.entries, newentry, fidx)
        return NameSpaceRegistry(newentries), namedobj
    end
end

"""
Add multiple objects to the registry with the same multiplier
"""
@inline function add(reg::NameSpaceRegistry, objs::Any...; multiplier = 1.)
    reg = UnrollReplace(reg, objs...) do r, o
        registry, _ = add_instance(r, o, multiplier)
        return registry
    end
end

#######################
####### FINDING #######
#######################

function find_entry(reg::NameSpaceRegistry, obj::O) where O
    return  get_type_entries(reg, obj)
end


########################

function scale_multipliers(reg::NameSpaceRegistry{T}, factor::Number) where {T}
    newentries = map(entry -> scale_multipliers(entry, factor), reg.entries)
    return NameSpaceRegistry{typeof(newentries)}(newentries)
end

inherit(reg::NameSpaceRegistry, other...; multipliers = repeat([1.], length(other))) = inherit(inherit(reg, other[1], multipliers[1]), other[2:end]...; multipliers = multipliers[2:end])
function inherit(registry1::NameSpaceRegistry, registry2::NameSpaceRegistry, multiplier = 1.)
    entries1 = registry1.entries
    entries2 = scale_multipliers(registry2, multiplier).entries
    # @show entries2[1].default
    
    newentries = deepcopy(entries1)
    for entry2 in entries2
        fidx = findfirst(x -> same_entry_type(x, entry2), newentries)
        if isnothing(fidx) # New entry
            newentries = (newentries..., entry2)
        else
            entry1 = newentries[fidx]
            mergedentry = merge(entry1, entry2)
            newentries = Base.setindex(newentries, mergedentry, fidx)
        end
    end
    return NameSpaceRegistry(newentries)
end
inherit(e1::NameSpaceRegistry; kwargs...) = e1

##########################
##### UPDATING NAMES #####
##########################



########################
    ### ACCESSORS ###
########################   

"""
Get entries for a given type T
"""
@generated function get_type_entries(reg::NameSpaceRegistry, typ::Type{T}) where {T}
    find_this_type = contained_type(T) # For containers, get the contained type
    _type_index = find_typeidx(reg, find_this_type)
    if isnothing(_type_index)
        # error("typ: $typ, T: $T, find_this_type: $find_this_type, reg: $reg")
        error("Type $(find_this_type) not found in registry")
    end
    return :( reg.entries[$_type_index] )
end

function get_type_entries(reg::NameSpaceRegistry, obj)
    ctype = contained_type(obj)
    get_type_entries(reg, ctype)
end

#########################
### Lookup Utilities ###
#########################

"""
Gets the location in the corresponding type dynamically
"""
function dynamic_lookup(reg::NameSpaceRegistry, val) 
    entries = get_type_entries(reg, val)
    return dynamic_lookup(entries, val)
end

"""
Gets the static lookup in the registry
"""
function static_lookup(reg::NameSpaceRegistry, val) 
    entries = get_type_entries(reg, val) # Get the entries for the type
    return static_findfirst(entries, val)
end

function static_get_match(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    loc, idx = find_match(entries, val)
    if isnothing(loc)
        return nothing
    end
    return getentry(entries, loc, idx)
end

function get_default(reg::NameSpaceRegistry, typ)
    entries = get_type_entries(reg, typ)
    return getdefault(entries)
end

#########################
    ##### GETTERS #####
#########################
"""
Get the static entry from the registry
"""
function static_get(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    return static_get(entries, val)
end

function dynamic_get(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    loc = dynamic_lookup(entries, val)
    return getentry(entries, loc...)
end

function getmultiplier(reg::NameSpaceRegistry, val)
    entry = static_get(reg, val)
    if isnothing(entry)
        return nothing
    end
    return multiplier(entry)
end

"""
Statically Get the name from the registry
"""
function getname(reg::NameSpaceRegistry, val)
    entry = static_get(reg, val)
    if isnothing(entry)
        return nothing
    end
    return getname(entry)
end


#### TODO: Remove either of these and merge
"""
Statically Find the name in the registry
"""
function static_find_name(reg::NameSpaceRegistry, val)
    found_scoped_value = static_value_get(reg, val)
    if isnothing(found_scoped_value)
        return nothing
    else
        return getname(found_scoped_value)
    end
end

function static_value_get(reg::NameSpaceRegistry, v::V) where {V}
    entries = get_type_entries(reg, v)
    return value(static_get(entries, v))
end

function dynamic_value_get(reg::NameSpaceRegistry, v::V) where {V}
    return value(dynamic_get(reg, v))
end

"""
Get the value from the registry
"""
@inline function Base.getindex(reg::NameSpaceRegistry{T}, obj) where {T}
    if obj isa Type || isbits(obj)
        return static_value_get(reg, obj)
    else
        return dynamic_value_get(reg, obj)
    end
end

@inline function Base.get(reg::NameSpaceRegistry, obj, default = nothing)
    if obj isa Type || isbits(obj)
        try
            return static_value_get(reg, obj)
        catch e
            return default
        end
    else
        try 
            return dynamic_value_get(reg, obj)
        catch e
            return default
        end
    end
end

#######################
    ##### NAMES #####
#######################

function all_named_algos(reg::Union{NameSpaceRegistry, Type{<:NameSpaceRegistry}})
    flat_collect_broadcast(all_named_algos, reg.entries)
end

function all_types(reg::Union{NameSpaceRegistry, Type{<:NameSpaceRegistry}})
    flat_collect_broadcast(all_types, reg.entries)
end

function all_names(reg::Union{NameSpaceRegistry, Type{<:NameSpaceRegistry}})
    flat_collect_broadcast(all_names, reg.entries)
end

function find_location_by_name(reg::NameSpaceRegistry, name::Symbol)
    for (entry_idx, entry) in enumerate(reg.entries)
        loc = find_location_by_name(entry, name)
        if !isnothing(loc)
            return (entry_idx, loc...)
        end
    end
    return nothing
end

function replacenames(reg::NameSpaceRegistry, changed_names::Dict{Symbol,Symbol})
    newentries = map(entry -> replacenames(entry, changed_names), reg.entries)
    return NameSpaceRegistry{typeof(newentries)}(newentries)
end
    

########################
##### PREPARING ########
########################
"""
Return all named objects
    First ProcessStates, then rest
"""
@generated function funcs_in_prepare_order(reg::NameSpaceRegistry{T}) where {T}
    entrytypes = tuple(T.parameters...)
    _all_types = flat_collect_broadcast(all_types, entrytypes)
    all_values = getvalue.(_all_types)
    process_states = filter(x -> getfunc(x) isa ProcessState, all_values)
    other = filter(x -> !(getfunc(x) isa ProcessState), all_values)
    all_in_order = (process_states..., other...)
    return :( $all_in_order )
end
##########################
    ##### ITERATING #####
##########################

"""
Iterator for NameSpaceRegistry
"""
function Base.iterate(reg::NameSpaceRegistry, state = 1)
    if state > length(reg.entries)
        return nothing
    else
        return (reg[state], state + 1)
    end
end

function entries_iterator(reg::NameSpaceRegistry)
    typeentries = get_entries(reg)
    return flat_collect_broadcast(entries_iterator, typeentries)
end

########################
  ##### SHOW #####
########################

function Base.show(io::IO, reg::NameSpaceRegistry)
    types = gettypes_iterator(reg)
    println(io, "NameSpaceRegistry with types: ", types)
    if isempty(reg.entries)
        print(io, "  (empty)")
        return
    end
    limit = get(io, :limit, false)
    for (idx, entry) in enumerate(reg.entries)
        entry_str = repr(entry; context = IOContext(io, :limit => limit))
        lines = split(entry_str, '\n')
        for (line_idx, line) in enumerate(lines)
            if line_idx == 1
                print(io, "  [", idx, "] ", line)
            else
                print(io, "\n  ", line)
            end
        end
        if idx < length(reg.entries)
            print(io, "\n")
        end
    end
end
