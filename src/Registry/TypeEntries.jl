struct ScopedValueEntry{T, V} 
    multiplier::Float64
end

ScopedValueEntry(val, mult = 0.) = ScopedValueEntry{typeof(val), val}(mult)
"""
Entries don't wrap themselves
"""
ScopedValueEntry(sve::ScopedValueEntry{T,V}) where {T,V} = ScopedValueEntry{T,V}(sve.multiplier)

setvalue(se::ScopedValueEntry{T,V}, newval) where {T,V} = ScopedValueEntry{T, newval}(se.multiplier)
setmultiplier(se::ScopedValueEntry{T,V}, newmult) where {T,V} = ScopedValueEntry{T,V}(newmult)

getvalue(se::ScopedValueEntry{T,V}) where {T,V} = V
getvalue(set::Type{ScopedValueEntry{T,V}}) where {T,V} = V

isdefault(rte::ScopedValueEntry{T}) where {T} = isdefault(T)
isdefault(rte::Type{<:ScopedValueEntry{T}}) where {T} = isdefault(T)

getname(se::ScopedValueEntry{T,V}) where {T,V} = getname(getvalue(se))

function match(se::Union{ScopedValueEntry{T,V}, Type{ScopedValueEntry{T,V}}}, val) where {T,V}
    if isdefault(V) # Default values match both by value and type
        if val isa Type
            return T <: val
        else
            return getalgorithm(V) === val
        end
    end
    isinstance(V, val)
end

# match(::EmptryEntry, ::Any) = false
match(val, te::Union{ScopedValueEntry,Type{<:ScopedValueEntry}}) = match(te, val)

match(::Union{Nothing, Type{<:Nothing}}, ::Any) = false
match(::Any, ::Union{Nothing, Type{<:Nothing}}) = false

multiplier(ve::ScopedValueEntry) = ve.multiplier

value(ve::ScopedValueEntry) = getvalue(ve)
value(a::Any) = a
value(::Nothing) = nothing

scale_multiplier(n::Nothing, factor::Number) = nothing
scale_multiplier(ve::ScopedValueEntry{T}, factor::Number) where T = setmultiplier(ve, ve.multiplier * factor)
add_multiplier(ve::ScopedValueEntry{T}, num::Number) where T = setmultiplier(ve, ve.multiplier + num)

struct RegistryTypeEntry{T,DE,S}
    default::DE  # Default instance and its multiplier
    entries::S   # isbits(x) == true, 
    dynamic_lookup::Dict{Any,Tuple{Symbol, Int}} # Map from object to (location, index)
end


function RegistryTypeEntry(obj::T) where T
    if obj isa Type
        return RegistryTypeEntry{obj}(nothing, (), Dict{Any,Tuple{Symbol, Int}}())
    else
        EntryType = algotype(obj)
        return RegistryTypeEntry{EntryType}(nothing, (), Dict{Any,Tuple{Symbol, Int}}())
    end
end

RegistryTypeEntry{T}() where {T} = RegistryTypeEntry{T,Nothing,Tuple{}}(nothing, (), Dict{Any,Tuple{Symbol, Int}}())
RegistryTypeEntry{T}(default::DE, entries::E, lookup) where {T,DE,E} = RegistryTypeEntry{T,DE,E}(default, entries, lookup)


function setfield(rte::RegistryTypeEntry, new, location)
    if location == :default
        return setdefault(rte, new)
    elseif location == :entries
        return setentries(rte, new)
    else
        error("Unknown location symbol: $location")
    end
end

default(rte::RegistryTypeEntry) = rte.default
default(rtetype::Type{<:RegistryTypeEntry{T,DE}}) where {T,DE} = DE
setdefault(rte::RegistryTypeEntry{T}, newdefault) where {T} = RegistryTypeEntry{T,typeof(newdefault),typeof(rte.entries)}(newdefault, rte.entries, rte.dynamic_lookup)    
setentries(rte::RegistryTypeEntry{T}, newentries) where {T} = RegistryTypeEntry{T,typeof(rte.default),typeof(newentries)}(rte.default, newentries, rte.dynamic_lookup)

"""
Get the types of static entries
"""
entry_types(rte::Type{<:RegistryTypeEntry{T,DE,S}}) where {T,DE,S} = S.parameters

# @inline static_findfirst(rte::RegistryTypeEntry, val::Any) = @inline static_findfirst(rte, Val(val))

@inline @generated function static_findfirst(rte::RegistryTypeEntry{T,DE,S}, v::Val{value}) where {T,DE,S,value}
    if value isa Type
        if value <: T
            if hasdefault(rte)
                return :default, 0
            end
        end
        return :(nothing, nothing)
    end


    _isdefault = isdefault(value)
    if _isdefault
        return :( :default, 0)
    end

    # Try to match static entries
    default_entry_type = default(rte)
    if match(value, default_entry_type)
        return :( :default, 0)
    end

    idx = findfirst(x -> match(value, x), entry_types(rte))
    if isnothing(idx)
        return :( nothing, nothing )
    end

    return :( :entries, $idx )
end

@inline static_findfirst(rte::RegistryTypeEntry, val) = static_findfirst(rte, Val(val))

"""
Match Exact with value
"""
@inline function static_get(rte::RegistryTypeEntry, val) 
    location, idx = static_findfirst(rte, Val(val))
    if isnothing(location)
        return nothing
    end
    return getentry(rte, location, idx)
end


same_entry_type(rte1::RegistryTypeEntry{T1}, rte2::RegistryTypeEntry{T2}) where {T1,T2} = T1 == T2

gettype(rte::Type{<:RegistryTypeEntry{T}}) where T = T
gettype(rte::RegistryTypeEntry) = gettype(typeof(rte))

hasdefault(rtetype::Type{<:RegistryTypeEntry{T,Td}}) where {T,Td} = !(Td <: Nothing)
hasdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = !(Td <: Nothing)
getdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = rte.default

# getindex_auto(rte::RegistryTypeEntry{T,Td,Ti}, idx::Int) where {T,Td,Ti} = rte.auto[idx]
# getindex_explicit(rte::RegistryTypeEntry{T,Td,Ti,Tie}, idx::Int) where {T,Td,Ti,Tie} = rte.explicit[idx]

function scale_multipliers(rte::RegistryTypeEntry{T}, factor) where T
    default = scale_multiplier(rte.default, factor)
    entries = map(se -> scale_multiplier(se, factor), rte.entries)
    return RegistryTypeEntry{T}(default, entries, rte.dynamic_lookup)
end

function getentry(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return getdefault(rte)
    elseif location == :entries
        return rte.entries[idx]
    else
        error("Unknown location symbol: $location")
    end
end

getvalue(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T} = value(getentry(rte, location, idx))

function getmultiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return multiplier(rte.default)
    elseif location == :entries
        return multiplier(rte.entries[idx])
    else
        error("Unknown location symbol: $location")
    end
end

"""
Find a match in the entry, either default
    or other entries
"""
function find_match(rte::RegistryTypeEntry{T}, obj) where {T}
    # If type is given, auto match with default
    if obj isa Type && T <: Type 
        if hasdefault(rte)
            return 0, :default
        else
            return nothing, nothing
        end
    end

    #No type, check default
    if match(rte.default, obj)
        return 0, :default
    end

    return match_entry(rte, obj)
end

"""
Match with one of the entries
"""
function match_entry(rte::RegistryTypeEntry{T}, obj) where {T}
    for (idx, inst) in enumerate(rte.entries)
        if match(inst, obj)
                return idx, :entries
        end
    end
    return nothing, nothing
end

##########################
##### ADDING ENTRIES #####
##########################

### ADD returns a new registry and a scoped value

function add_default(rte::RegistryTypeEntry{T,Td}, val, multiplier = 1.) where {T,Td}
    if isnothing(val)
        return rte, nothing
    end

    if isnothing(rte.default)
        named_val = DefaultScope(val) # 0 is reserved for default
        entry = ScopedValueEntry(named_val, multiplier)
        # rte.dynamic_lookup[val] = (:default, 0)
        rte.dynamic_lookup[typeof(val)] = (:default, 0)
        return RegistryTypeEntry{T}(entry, rte.entries, rte.dynamic_lookup), named_val
    else
        new_default = add_multiplier(rte.default, multiplier)
        return RegistryTypeEntry{T}(new_default, rte.entries, rte.dynamic_lookup), value(getdefault(rte))
    end
end

add_entry(rte::RegistryTypeEntry, entry::ScopedValueEntry) = add_entry(rte, entry, multiplier(entry))

function add_entry(rte::RegistryTypeEntry{T}, obj, multiplier = 1.) where {T}
    if isnothing(obj)
        return rte, nothing
    end

    fidx, _ = match_entry(rte, obj)
    if isnothing(fidx) #add new
        obj = value(obj) # Strip the entry
        # @show obj
        entries = rte.entries
        current_length = length(entries)
        named_val = Autoname(obj, current_length + 1)
        entry = ScopedValueEntry(named_val, multiplier)
        newentries = (entries..., entry)
        rte.dynamic_lookup[obj] = (:entries, current_length + 1)
        return setfield(rte, newentries, :entries), named_val
    else # Existing instance, bump multiplier and get the named version
        return add_multiplier(rte, :entries, fidx, multiplier), value(getentry(rte, :entries, fidx))
    end
end

function add(rte::RegistryTypeEntry{T}, obj, multiplier = 1.) where {T}
    if obj isa Type # Add to default
        val = obj()
        return add_default(rte, val, multiplier)
    else
        return add_entry(rte, obj, multiplier)
    end
end

function add_default(rte::RegistryTypeEntry, entry::ScopedValueEntry)
    old_default = getdefault(rte)
    if isnothing(old_default)
        rte = setdefault(rte, entry)
        rte.dynamic_lookup[typeof(strip_scope(value(entry)))] = (:default, 0)
        return rte, value(entry)
    else
        new_default = add_multiplier(old_default, multiplier(entry))
        rte = setdefault(rte, new_default)
        return rte, value(new_default)
    end
end

function change_multiplier(rte::RegistryTypeEntry, location::Symbol, idx::Int, num, changetype::Symbol)
    changefunc = changetype == :add ? add_multiplier : scale_multiplier
    if location == :default
        new_default = changefunc(rte.default, num)
        return setdefault(rte, new_default)
    elseif location == :entries
        entries = getfield(rte, location)
        entry = entries[idx]
        new_entry = changefunc(entry, num)
        new_collection = Base.setindex(entries, new_entry, idx)
        return setfield(rte, new_collection, location)
    else
        error("Unknown location symbol: $location")
    end
end

add_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, num::Number) where {T} = change_multiplier(rte, location, idx, num, :add)
scale_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, factor::Number) where {T} = change_multiplier(rte, location, idx, factor, :scale)

###########################
##### MERGING ENTRIES #####
###########################

function Base.merge(entry1::RegistryTypeEntry{T}, entry2::RegistryTypeEntry{T}) where {T}
    # Merging default entries
    entry1, _ = add_default(entry1, entry2.default)

    for entry2 in entry2.entries
        entry1, _ = add_entry(entry1, value(entry2), multiplier(entry2))
    end

    return entry1
end

#############################
##### VALUE LOOKUPS #########
#############################

#=
Match either a scoped or non scope value with one of the entries
=#

dynamic_lookup(rte::RegistryTypeEntry{T}, val) where {T} = get(rte.dynamic_lookup, val, nothing)


##########################
######## GETTERS #########
##########################

function Base.length(te::RegistryTypeEntry)
    return length(te.entries) + (hasdefault(te) ? 1 : 0)
end

function Base.getindex(te::RegistryTypeEntry, idx::Int)
    if idx > length(te.entries) 
        error("Index $idx out of bounds for Registry with length $(length(te))")
    end

    if hasdefault(te)
        if idx == 1
            return value(getdefault(te))
        else
            return value(getentry(get_type_entries(te, gettype(te)), :entries, idx - 1))
        end
    else
        return value(getentry(get_type_entries(te, gettype(te)), :entries, idx))
    end
end

function Base.iterate(te::RegistryTypeEntry, state = 1)
    if state > length(te)
        return nothing
    end
    return (te[state], state + 1)
end

Base.getindex(te::RegistryTypeEntry, obj) = static_value_get(te, obj)

###############################
########## Names #############
###############################
function all_named_algos(te::RegistryTypeEntry)
    algos = tuple()
    if hasdefault(te)
        algos = (getvalue(te.default),)
    end
    return (algos..., getvalue.(te.entries)...)
end

function all_names(te::RegistryTypeEntry)
    names = tuple()
    if hasdefault(te)
        names = (getname(te.default),)
    end
    return (names..., getname.(te.entries)...)
end

###############################
##### SHOWING ENTRIES ##########
###############################

function Base.show(io::IO, rte::RegistryTypeEntry{T}) where {T}
    println(io, "RegistryTypeEntry for type: $(T)")
    if hasdefault(rte)
        println(io, "\t:default => ", value(rte.default), " x ", multiplier(rte.default))
    else
    end
    if length(rte.entries) == 0
    else
        entries = rte.entries
        limit = get(io, :limit, false)
        n = length(entries)
        head = 3
        tail = 2
        if !limit || n <= head + tail + 1
            for (idx, entry) in enumerate(entries)
                println(io, "\t", idx, " \t => ", value(entry), " x ", multiplier(entry))
            end
        else
            for idx in 1:head
                entry = entries[idx]
                println(io, "\t", idx, " \t => ", value(entry), " x ", multiplier(entry))
            end
            println(io, "\t...")
            for idx in (n - tail + 1):n
                entry = entries[idx]
                println(io, "\t", idx, " \t => ", value(entry), " x ", multiplier(entry))
            end
        end
    end
end