struct RegistryLocation{T, Int} end
RegistryLocation(T, idx) = RegistryLocation{T, idx}()
gettype(loc::RegistryLocation{T, idx}) where {T, idx} = T
getidx(loc::RegistryLocation{T, idx}) where {T, idx} = idx


getentries(reg::NameSpaceRegistry{T}) where {T} = getfield(reg, :entries)
Base.getindex(reg::NameSpaceRegistry, idx::Int) = getentries(reg)[idx]
Base.length(reg::NameSpaceRegistry) = length(getentries(reg))

@inline function Base.setindex(reg::NameSpaceRegistry{T}, newentry, idx::Int) where {T}
    old_entries = getentries(reg)
    new_entries = @inline tuple_setindex(old_entries, newentry, idx)
    return NameSpaceRegistry{typeof(new_entries)}(new_entries)
end

@inline function Base.setindex(reg::NameSpaceRegistry, newentry, T::Type)
    fidx = find_typeidx(reg, T)
    if isnothing(fidx)
        error("Type $T not found in registry")
    end
    return Base.setindex(reg, newentry, fidx)
end

@inline function StaticArrays.push(reg::NameSpaceRegistry{T}, newentry) where {T}
    if !(newentry isa RegistryTypeEntry)
        error("Cannot push a RegistryTypeEntry type: $(typeof(newentry)) to a NameSpaceRegistry")
    end
    old_entries = getentries(reg)
    new_entries = (old_entries..., newentry)
    return NameSpaceRegistry{typeof(new_entries)}(new_entries)
end

@inline function StaticArrays.pushfirst(reg::NameSpaceRegistry{T}, newentry) where {T}
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
@inline function entrytypes(reg::Union{NameSpaceRegistry{T}, Type{NameSpaceRegistry{T}}}) where {T}
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
@inline function entrytypes_iterator(reg::Union{NameSpaceRegistry{T}, Type{NameSpaceRegistry{T}}}) where {T}    
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

### _find_typeidx in generated functions folder ###

# """
# Non-generated helper of find_typeidx for use in other generated functions
# """
# function nongen_find_typeidx(reg::Type{<:NameSpaceRegistry}, typ::Type{T}) where {T}
#     it = entrytypes_iterator(reg)
#     index = findfirst(t -> T <: t, it)
#     return index
# end



# registry_entrytype(tt::Type{Type{T}}) where T = match_by(T) # For generated function compatibility




########################################
############## Interface ###############
########################################



#########################
######### ADDING ########
#########################
"""
Add an instance and get new registry and a named instance back
"""
function add(reg::NameSpaceRegistry{T}, obj, multiplier = 1.; withkey = nothing) where {T}
    if obj isa NameSpaceRegistry
        error("Cannot add a NameSpaceRegistry to another NameSpaceRegistry")
    end

    @DebugMode "Adding object: $obj to registry: $reg with multiplier: $multiplier and name: $withkey"
    entry_t = assign_entrytype(obj)
    fidx = find_typeidx(reg, entry_t)
    if isnothing(fidx) # New Entry
        newentry = RegistryTypeEntry{entry_t}()
        newentry, keyed_obj = add(newentry, obj, multiplier; withkey)
        if entry_t <: ProcessState # States go first
            newreg = StaticArrays.pushfirst(reg, newentry)
        else
            newreg = StaticArrays.push(reg, newentry)
        end
        return newreg, keyed_obj
    else # Type was found
        entry = reg.entries[fidx]
        
        newentry, keyed_obj = add(entry, obj, multiplier; withkey)
        # return newentry
        return Base.setindex(reg, newentry, fidx), keyed_obj
    end
end

"""
Add multiple objects to the registry with the same multiplier
"""
function addall(reg::NSR, objs::O, mults::M) where {NSR<:NameSpaceRegistry,O<:Tuple,M<:Tuple}
    reg = unrollreplace(reg, zip(objs, mults)...) do r, obj_mult
        obj, mult = obj_mult
        newreg, _ = add(r, obj, mult)
        return newreg
    end
end
# @inline function addall(reg::NSR, objs::O, mults::M) where {NSR<:NameSpaceRegistry,O<:Tuple,M<:Tuple}
#     _addall_unrolled(reg, objs, mults)
# end

# @generated function _addall_unrolled(reg::R, objs::O, mults::M) where {R,O<:Tuple,M<:Tuple}
#     N = length(O.parameters)
#     N == length(M.parameters) || error("objs/mults length mismatch")

#     ex = :(reg)
#     for i in 1:N
#         ex = quote
#             local r = $ex
#             local rnew, _ = add(r, getfield(objs, $i), getfield(mults, $i))
#             rnew
#         end
#     end
#     return ex
# end

# function _addall(reg::R, this_obj, this_mult, objs, mults) where R
#         if isempty(objs)
#             new_reg, _ = add(reg, this_obj, this_mult)
#             return new_reg
#         end
#         newreg, _ = add(reg, this_obj, this_mult)
#         return _addall(newreg, gethead(objs), gethead(mults), gettail(objs), gettail(mults))
# end

# @inline function addall(reg::NSR, objs::Union{Tuple, AbstractArray}, multipliers = RepeatOne()) where {NSR <: NameSpaceRegistry}
#     return @inline _addall(reg, gethead(objs), gethead(multipliers), gettail(objs), gettail(multipliers))
#     reg
# end


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
@inline function _get_by_matcher(matcher, entries) 
    if isempty(entries)
        error("Matcher $matcher not found in registry entries: $entries")
    end
    head = gethead(entries)
    headmatcher = match_by(head)
    if headmatcher == matcher
        return head
    else
        tail = gettail(entries)
        return _get_by_matcher(matcher, tail)
    end
end
@inline function get_by_matcher(reg::NameSpaceRegistry, matcher)
    all_entries = all_algos(reg)
    return _get_by_matcher(matcher, all_entries)
end

"""
Get entries for an obj
"""
function get_type_entries(reg::NameSpaceRegistry, obj)
    assigned_t = assign_entrytype(obj)
    idx = find_typeidx(reg, assigned_t)
    if isnothing(idx)
        error("Unknown algo/type referenced in registry lookup, for registry: $reg.\n" *
              "Requested type: $assigned_t\n" *
              "Requested value: $obj\n" *
              "Available entry types: $(entrytypes_iterator(reg))\n" *
              "If this came from a Share or Route, the referenced algo/type is not registered." )
    end
    return getentries(reg)[idx]
end
# @generated function get_type_entries(reg::NameSpaceRegistry, typ::Union{T, Type{T}}) where {T}
#     assigned_T = assign_entrytype(T)
#     idx = nongen_find_typeidx(reg, assigned_T)
#     if isnothing(idx)
#         types = entrytypes_iterator(reg)
#         available = isempty(types) ? "<none>" : join(string.(types), ", ")
#         requested = string(assigned_T)
#         # msg = "Unknown algo/type referenced in registry lookup.\n" *
#         #       "Requested: " * requested * "\n" *
#         #       "Available entry types: " * available * "\n" *
#         #       "If this came from a Share or Route, the referenced algo/type is not registered."
#         return quote
#             $(LineNumberNode(@__LINE__, @__FILE__))
#             requested = $requested
#             available = $available
#             error("Unknown algo/type referenced in registry lookup, for registry: $reg.\n" *
#                   "Requested type: $requested\n" *
#                   "Requested value: $typ\n" *
#                   "Available entry types: $available\n" *
#                   "If this came from a Share or Route, the referenced algo/type is not registered." ) 
#         end
#     end
#     return quote 
#         $(LineNumberNode(@__LINE__, @__FILE__)) 
#         getentries(reg)[ $idx ] 
#     end
# end

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


@inline function static_findfirst_match(reg::NameSpaceRegistry, val)
    entries = get_type_entries(reg, val)
    T = gettype(entries)

    idx = static_findfirst_match(entries, val)
    if isnothing(idx)
        return RegistryLocation(T, nothing)
    end
    return RegistryLocation(T, idx)
end

"""
From T, idx
"""
function Base.getindex(reg::NameSpaceRegistry, t::RegistryLocation{T, idx}) where {T, idx}
    if isnothing(T)
        error("No matching entry found for type: (nothing, nothing) in registry")
    end
    type_entries = get_type_entries(reg, T)
    return type_entries[idx]
end


"""
Statically Find the name in the registry
"""
@inline function static_findkey(reg::NameSpaceRegistry, val)
    location = @inline static_findfirst_match(reg, val)
    if isnothing(getidx(location))
        return nothing
    else
        return @inline getkey(reg[location])
    end
end

@inline function Base.in(val, reg::NameSpaceRegistry)
    found_scoped_value = @inline static_get(reg, val)
    return !isnothing(found_scoped_value)
end

# function findfirst_match(reg::NameSpaceRegistry, val)
#     function _findfirst_match_in_t(reg, first_idx)
#         this_match = static_findfirst_match(reg[first_idx], val)
#         return this_match
#     end 
#     function outer_recursion(reg, val, idx1, idx2)
#         if idx1 > length(reg)
#             return nothing, nothing
#         end
#         if !isnothing(idx2)
#             return idx1-1, idx2
#         end
#         this_match = _findfirst_match_in_t(reg, idx1)
#         return outer_recursion(reg, val, idx1 + 1, this_match)
#     end

#     return outer_recursion(reg, val, 1, nothing)
# end
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

## TODO : FIX
# function dynamic_get(reg::NameSpaceRegistry, val)
#     entries = get_type_entries(reg, val)
#     loc = dynamic_lookup(entries, val)
#     return getentry(entries, loc...)
# end

function static_get_multiplier(reg::NameSpaceRegistry, val)
    loc = static_findfirst_match(reg, val)
    if isnothing(getidx(loc))
        error("Found other values of type $(gettype(loc)), but no match found for value: $val in registry: $reg")
    end 
    type_entries = get_type_entries(reg, gettype(loc))
    return getmultiplier(type_entries, getidx(loc))
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
@inline function getkey(reg::NameSpaceRegistry, val)
    entry = static_get(reg, val)
    if isnothing(entry)
        return nothing
    end
    return getkey(entry)
end


# function dynamic_get(reg::NameSpaceRegistry, v::V) where {V}
#     return dynamic_get(reg, v)
# end

"""
Get the value from the registry
"""
@inline function Base.getindex(reg::NameSpaceRegistry{T}, obj) where {T}
    if obj isa Type || isbits(obj)
        return static_get(reg, obj)
    else
        return static_get(reg, typeof(obj)) 
        # return dynamic_get(reg, obj)
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
            return dynamic_get(reg, obj)
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

function all_keys(reg::Union{NameSpaceRegistry, Type{<:NameSpaceRegistry}})
    flat_collect_broadcast(all_keys, reg.entries)
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
