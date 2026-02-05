getentries(reg::NameSpaceRegistry{T}) where {T} = reg.entries
Base.getindex(reg::NameSpaceRegistry, idx::Int) = reg.entries[idx]

function Base.setindex(reg::NameSpaceRegistry{T}, newentry, idx::Int) where {T}
    old_entries = getentries(reg)
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

function StaticArrays.push(reg::NameSpaceRegistry{T}, newentry) where {T}
    if !(newentry isa RegistryTypeEntry)
        error("Cannot push a RegistryTypeEntry type: $(typeof(newentry)) to a NameSpaceRegistry")
    end
    old_entries = getentries(reg)
    new_entries = (old_entries..., newentry)
    return NameSpaceRegistry{typeof(new_entries)}(new_entries)
end

function StaticArrays.pushfirst(reg::NameSpaceRegistry{T}, newentry) where {T}
    if !(newentry isa RegistryTypeEntry)
        error("Cannot push a RegistryTypeEntry type: $(typeof(newentry)) to a NameSpaceRegistry")
    end
    old_entries = getentries(reg)
    new_entries = (newentry, old_entries...)
    return NameSpaceRegistry{typeof(new_entries)}(new_entries)
end

"""
Types of entries as a tuple type Tuple{Type1, Type2, ...}
"""
# @generated function entrytypes(reg::Type{NameSpaceRegistry{T}}) where {T}
#     entrytypes = T.parameters
#     datatypes = gettype.(entrytypes)
#     Tt = Tuple{datatypes...}
#     return :($Tt)
# end
function entrytypes(reg::Union{NameSpaceRegistry{T}, Type{NameSpaceRegistry{T}}}) where {T}
    param_svec = T.parameters
    if isempty(param_svec)
        return Tuple{}
    end
    entrytypes = T.parameters[1].parameters
    datatypes = gettype.(entrytypes)
    Tt = Tuple{datatypes...}
    return Tt
end

"""
Types of entries as a tuple statically (Type1, type2, ...)
"""
# @generated function entrytypes_iterator(reg::Type{NameSpaceRegistry{T}}) where {T}
#     entrytypes = T.parameters
#     datatypes = gettype.(entrytypes)
#     Tt = tuple(datatypes...)
#     return :($Tt)
# end
function entrytypes_iterator(reg::Union{NameSpaceRegistry{T}, Type{NameSpaceRegistry{T}}}) where {T}    
    param_svec = T.parameters
    if isempty(param_svec)
        return tuple()
    end
    datatypes = ntuple(i -> gettype(param_svec[i]), length(param_svec))
    return datatypes
end

entrytypes_iterator(reg::NameSpaceRegistry) = entrytypes_iterator(typeof(reg))

"""
Find the index in the entries for a given type T
"""
@inline find_typeidx(regt::Type{<:NameSpaceRegistry}, obj) = _find_typeidx(regt, typeof(obj))
@inline find_typeidx(regt::Type{<:NameSpaceRegistry}, typ::Type) = _find_typeidx(regt, typ)
@inline find_typeidx(reg::NameSpaceRegistry, obj) = find_typeidx(typeof(reg), obj)

@generated function _find_typeidx(reg::Type{NSR}, typ::Type{T}) where {NSR <: NameSpaceRegistry, T}
    it = entrytypes_iterator(NSR)
    index = findfirst(t -> T <: t, it)
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        idx = $index
        return idx
    end
end

"""
Non-generated helper of find_typeidx for use in other generated functions
"""
function nongen_find_typeidx(reg::Type{<:NameSpaceRegistry}, typ::Type{T}) where {T}
    it = entrytypes_iterator(reg)
    index = findfirst(t -> T <: t, it)
    return index
end


"""
Which type entry is an object assigned?
"""
function assign_entry_type(obj)
    if obj isa AbstractIdentifiableAlgo
        return algotype(obj)
    else
        return typeof(obj)
    end
end

function assign_entry_type(objT::Type)
    if objT <: AbstractIdentifiableAlgo
        return algotype(objT)
    else
        return objT
    end
end

########################################
############## Interface ###############
########################################



#########################
######### ADDING ########
#########################
"""
Add an instance and get new registry and a named instance back
"""
function add(reg::NameSpaceRegistry{T}, obj, multiplier = 1.; withname = nothing) where {T}
    if obj isa NameSpaceRegistry
        error("Cannot add a NameSpaceRegistry to another NameSpaceRegistry")
    end

    entry_t = assign_entry_type(obj)
    fidx = find_typeidx(reg, entry_t)
    if isnothing(fidx) # New Entry
        newentry = RegistryTypeEntry{entry_t}()
        newentry, keyed_obj = add(newentry, obj, multiplier; withname)
        
        if entry_t <: ProcessState # States go first
            newreg = StaticArrays.pushfirst(reg, newentry)
        else
            newreg = StaticArrays.push(reg, newentry)
        end
        return newreg, keyed_obj
    else # Type was found
        entry = reg.entries[fidx]
        newentry, keyed_obj = add(entry, obj, multiplier; withname)
        return Base.setindex(reg, newentry, fidx), keyed_obj
    end
end

"""
Add multiple objects to the registry with the same multiplier
"""
@inline function addall(reg::NameSpaceRegistry, objs::Union{Tuple, AbstractArray}; multiplier = 1., withnames = nothing, withname = nothing)
    @assert !(withnames !== nothing && withname !== nothing) "Cannot specify both withnames and withname"
    unrollidx = 1
    reg = UnrollReplace(reg, objs...) do r, o
        thisname = nothing
        if !isnothing(withname)
            thisname = withname
        elseif !isnothing(withnames) && length(withnames) >= unrollidx
            thisname = withnames[unrollidx]
        end
        registry, _ = add(r, o, multiplier; withname=thisname)
        unrollidx += 1
        return registry
    end
    reg
end


########################

function scale_multipliers!(reg::NameSpaceRegistry{T}, factor::Number) where {T}
    map(entry -> scale_multipliers!(entry, factor), reg.entries)
    reg
end

inherit(reg::NameSpaceRegistry, other...; multipliers = repeat([1.], length(other))) = inherit(inherit(reg, other[1], multipliers[1]), other[2:end]...; multipliers = multipliers[2:end])
"""
One registry inherits from another, scaling the multipliers by the given factor
    The multiplier is usually the multiplier of a LoopAlgorithm in it's parent LoopAlgorithm
"""
function inherit(registry1::NameSpaceRegistry, registry2::NameSpaceRegistry, multiplier = 1.)
    entries2 = deepcopy(registry2.entries) # Deepcopy in order to not change multipliers of original registry
    scale_multipliers!.(entries2, multiplier)
    @DebugMode "Reg1: $registry1 inheriting entries: $entries2"

    

    for entry in entries2
        for (identifiable, mult) in entry
            @DebugMode "Inheriting identifiable: $identifiable with multiplier: $mult"
            registry1, identifiable = add(registry1, identifiable, mult)
        end
    end
    return registry1
end
inherit(e1::NameSpaceRegistry; kwargs...) = e1

##########################
##### UPDATING NAMES #####
##########################



########################
    ### ACCESSORS ###
########################   

"""
Get entries for an obj
"""
@generated function get_type_entries(reg::NameSpaceRegistry, typ::Union{T, Type{T}}) where {T}
    assigned_T = assign_entry_type(T)
    idx = nongen_find_typeidx(reg, assigned_T)
    if isnothing(idx)
        types = entrytypes_iterator(reg)
        available = isempty(types) ? "<none>" : join(string.(types), ", ")
        requested = string(assigned_T)
        msg = "Unknown algo/type referenced in registry lookup.\n" *
              "Requested: " * requested * "\n" *
              "Available entry types: " * available * "\n" *
              "If this came from a Share or Route, the referenced algo/type is not registered."
        return :( error($msg) )
    end
    return :( getentries(reg)[ $idx ] )
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

@inline function static_get_match(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    @DebugMode "Static get match for value: $val in entries: $entries"

    idx = static_findfirst_match(entries, val)
    if isnothing(idx)
        return nothing
    end

    return getentries(entries)[idx]
end
#######################
####### FINDING #######
#######################
"""
Statically Find the name in the registry
"""
function static_find_name(reg::NameSpaceRegistry, val)
    found_scoped_value = static_get(reg, val)
    if isnothing(found_scoped_value)
        return nothing
    else
        return getkey(found_scoped_value)
    end
end

function Base.in(val, reg::NameSpaceRegistry)
    found_scoped_value = static_get(reg, val)
    return !isnothing(found_scoped_value)
end

#########################
    ##### GETTERS #####
#########################
"""
Get the static entry from the registry
"""


function static_get(reg::NameSpaceRegistry, v::V) where {V}
    entries = get_type_entries(reg, v)
    return static_get(entries, v)
end

function dynamic_get(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    loc = dynamic_lookup(entries, val)
    return getentry(entries, loc...)
end

function getmultiplier(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    entry_idx = static_findfirst_match(entries, val)
    if isnothing(entry_idx)
        return 0
    end
    return getmultiplier(entries, entry_idx)
end

"""
Statically Get the name from the registry
"""
function getkey(reg::NameSpaceRegistry, val)
    entry = static_get(reg, val)
    if isnothing(entry)
        return nothing
    end
    return getkey(entry)
end


function dynamic_value_get(reg::NameSpaceRegistry, v::V) where {V}
    return value(dynamic_get(reg, v))
end

"""
Get the value from the registry
"""
@inline function Base.getindex(reg::NameSpaceRegistry{T}, obj) where {T}
    if obj isa Type || isbits(obj)
        return static_get(reg, obj)
    else
        return dynamic_value_get(reg, obj)
    end
end

@inline function Base.get(reg::NameSpaceRegistry, obj, default = nothing)
    if obj isa Type || isbits(obj)
        try
            return static_get(reg, obj)
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

function all_names(reg::Union{NameSpaceRegistry, Type{<:NameSpaceRegistry}})
    flat_collect_broadcast(all_names, reg.entries)
end

# function find_location_by_name(reg::NameSpaceRegistry, name::Symbol)
#     for (entry_idx, entry) in enumerate(reg.entries)
#         loc = find_location_by_name(entry, name)
#         if !isnothing(loc)
#             return (entry_idx, loc...)
#         end
#     end
#     return nothing
# end

function replacecontextkeyss(reg::NameSpaceRegistry, changed_names::Dict{Symbol,Symbol})
    newentries = map(entry -> replacecontextkeyss(entry, changed_names), reg.entries)
    return NameSpaceRegistry{typeof(newentries)}(newentries)
end
    

########################
##### PREPARING ########
########################
"""
Return all named objects
    First ProcessStates, then rest
"""
function all_algos(reg::NameSpaceRegistry)
    return flat_collect_broadcast(getentries, getentries(reg))
end

# @generated function funcs_in_prepare_order(reg::NameSpaceRegistry{T}) where {T}
#     entrytypes = tuple(T.parameters...)
#     _all_types = flat_collect_broadcast(entry_types, entrytypes)
#     all_values = getvalue.(_all_types)
#     process_states = filter(x -> getalgo(x) isa ProcessState, all_values)
#     other = filter(x -> !(getalgo(x) isa ProcessState), all_values)
#     all_in_order = (process_states..., other...)
#     return :( $all_in_order )
# end
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

function all_entries(reg::NameSpaceRegistry)
    typeentries = getentries(reg)
    return flat_collect_broadcast(getentries, typeentries)
end

########################
  ##### SHOW #####
########################

function Base.show(io::IO, reg::NameSpaceRegistry)
    types = entrytypes_iterator(reg)
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
        if idx < length(getentries(reg))
            print(io, "\n")
        end
    end
end
