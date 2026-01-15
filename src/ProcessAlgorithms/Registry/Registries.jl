########################
  ##### REGISTRY #####
########################

"""
Namespace registry but with static type_same instead of dict
    (# Tuple for type 1 (namedinstance1, namedinstance2, ...), # Tuple for type 2 (...), ...)
"""
struct NameSpaceRegistry{T}
    entries::T # Tuple of RegistryTypeEntry
end

function Base.show(io::IO, reg::NameSpaceRegistry)
    types = gettypes_iterator(reg)
    print(io, "NameSpaceRegistry with types: ", types)
end

NameSpaceRegistry() = NameSpaceRegistry(tuple())

Base.getindex(reg::NameSpaceRegistry, idx::Int) = reg.entries[idx]
# function Base.getindex(reg::NameSpaceRegistry, obj)
#     if !(obj isa Type)
#         obj = typeof(obj)
#     end
#     fidx = findtype(reg, obj)
#     return reg.entries[fidx]
# end

"""
Instances types
"""
@generated function gettypes(reg::Type{NameSpaceRegistry{T}}) where {T}
    entrytypes = T.parameters
    datatypes = gettype.(entrytypes)
    Tt = Tuple{datatypes...}
    return :($Tt)
end

@generated function gettypes_iterator(reg::Type{NameSpaceRegistry{T}}) where {T}
    entrytypes = T.parameters
    datatypes = gettype.(entrytypes)
    Tt = tuple(datatypes...)
    return :($Tt)
end
gettypes_iterator(reg::NameSpaceRegistry) = gettypes_iterator(typeof(reg))

@generated function _findtype(reg::Type{<:NameSpaceRegistry{T}}, typ::Type{TT}) where {T,TT}
    TT_non_scoped = strip_scope(TT)
    regt = reg.parameters[1]
    it = gettypes_iterator(regt)
    index = findfirst(t -> TT_non_scoped <: t, it)
    return :( $index )
end

findtype(regt::Type{<:NameSpaceRegistry}, obj) = _findtype(reg, typeof(obj))
findtype(regt::Type{<:NameSpaceRegistry}, typ::Type) = _findtype(regt, typ)
findtype(reg::NameSpaceRegistry, obj) = findtype(typeof(reg), obj)

"""
Add an instance and get new registry and a named instance back
"""
function add_instance(reg::NameSpaceRegistry{T}, obj, multiplier = 1.) where {T}
    fidx = findtype(reg, obj)
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

@generated function getnamedinstance(reg::NameSpaceRegistry{T}, obj) where {T}
    _type_index = findtype(reg, obj)
    if isnothing(_type_index)
        error("Object of type $(obj) not found in registry")
    end

    return quote
        @show obj
        @show reg
        f_idx, location = find_instance_entry(reg.entries[$_type_index], obj)
        if isnothing(f_idx)
            error("Object not found in registry")
        end
        return getinstance(reg[$_type_index], location, f_idx)
    end
end

getname(reg::NameSpaceRegistry{T}, obj) where {T} = getname(getnamedinstance(reg, obj))

@generated function getmultiplier(reg::NameSpaceRegistry{T}, obj) where {T}
    _type_index = findtype(reg, obj)
    if isnothing(_type_index)
        error("Object of type $(obj) not found in registry")
    end

    return quote
        f_idx, location = find_instance_entry(reg.entries[$_type_index], obj)
        if isnothing(f_idx)
            error("Object not found in registry")
        end
        return getmultiplier(reg[$_type_index], location, f_idx)
    end
end

function scale_multipliers(reg::NameSpaceRegistry{T}, factor::Number) where {T}
    newentries = map(entry -> scale_multipliers(entry, factor), reg.entries)
    return NameSpaceRegistry{typeof(newentries)}(newentries)
end

Base.merge(entry1::NameSpaceRegistry, other...) = merge(merge(entry1, other[1]), other[2:end]...)
function Base.merge(registry1::NameSpaceRegistry, registry2::NameSpaceRegistry)
    entries1 = registry1.entries
    entries2 = registry2.entries

    newentries = deepcopy(entries1)
    for entry2 in entries2
        fidx = findfirst(x -> same_entry_type(x, entry2), newentries)
        if isnothing(fidx) # New entry
            newentries = (newentries..., entry2)
        else
            entry1 = registry1.entries[fidx]
            mergedentry = merge(entry1, entry2)
            newentries = Base.setindex(newentries, mergedentry, fidx)
        end
    end
    return NameSpaceRegistry(newentries)
end
Base.merge(e1::NameSpaceRegistry) = e1



########################
    ### ACCESSORS ###
########################    
@generated function get_type_entries(reg::NameSpaceRegistry, typ::Type{T}) where {T}
    _type_index = findtype(reg, T)
    if isnothing(_type_index)
        error("Type $(typ) not found in registry")
    end
    return :( reg.entries[$_type_index] )
end

get_type_entries(reg::NameSpaceRegistry, obj) = get_type_entries(reg, typeof(obj))


function dynamic_lookup(reg::NameSpaceRegistry, val) 
    entries = get_type_entries(reg, val)
    return dynamic_lookup(entries, val)
end

function static_lookup(reg::NameSpaceRegistry, v::Val{val}) where val
    entries = get_type_entries(reg, val)
    return static_lookup(entries, v)
end

########################
    ### UTILITIES ###
########################
function update_instance(func, registry::NameSpaceRegistry)
    # name = getname(registry, func)
    scoped_instance = lookup
    if isnothing(name)
        error("No name found for function $(func) in registry")
    else
        return ScopedAlgorithm(func, name)
    end
end

########################
    ### Lookup ###
########################
#=
    We can enter either

    Type            : Return default if exists
    ____
    Scoped Type     : Match with id or instance |
    Arbitrary value : Match Value               | These need matching function
    ____
=#

### STATIC LOOKUP ###

### DYNAMIC LOOKUP ###
