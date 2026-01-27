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

"""
Get the name of the scoped value entry
"""
getname(se::ScopedValueEntry{T,V}) where {T,V} = getname(getvalue(se))

"""
Change the name of the scoped value entry and return a new scoped value entry
"""
changename(se::ScopedValueEntry{T,V}, newname::Symbol) where {T,V} = setvalue(se, setname(getvalue(se), newname))

function match(se::Union{ScopedValueEntry{T,V}, Type{ScopedValueEntry{T,V}}}, val) where {T,V}
    if isdefault(V) # Default values match either type, or another default value by instance
        if val isa Type
            return T <: val
        elseif isdefault(val)
            return unwrap_container(V) === unwrap_container(val)
        else
            return false
        end
    end

    isinstance(V, val)
end

function match(se1::Union{ScopedValueEntry{T1,V1}, Type{ScopedValueEntry{T1,V1}}}, 
               se2::Union{ScopedValueEntry{T2,V2}, Type{ScopedValueEntry{T2,V2}}}) where {T1,V1,T2,V2}
    if isdefault(se1) # Default values match either type, or another default value by instance
        if se2 isa Type
            return T1 <: se2
        elseif isdefault(se2)
            return isinstance(unwrap_container(se1), unwrap_container(se2))
        else
            return false
        end
    end

    isinstance(unwrap_container(se1), unwrap_container(se2))
end

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

thincontainer(::Type{<:ScopedValueEntry}) = true
_contained_type(::Type{<:ScopedValueEntry{T,V}}) where {T,V} = T
_unwrap_container(se::ScopedValueEntry{T,V}) where {T,V} = getvalue(se)


###############################
##### REGISTRY TYPE ENTRY #####
###############################
struct RegistryTypeEntry{T,DE,S,D}
    default::DE  # Default instance and its multiplier
    entries::S   # isbits(x) == true, 
    dynamic::D
    dynamic_lookup::PreferWeakKeyDict{Any,Tuple{Symbol, Int}} # Map from object to (location, index)
end

function RegistryTypeEntry(obj::T) where T
    entrytype = contained_type(obj)
    @static if DEBUG_MODE
        println("Creating RegistryTypeEntry for obj: $obj and type: $entrytype")
    end
    return RegistryTypeEntry{entrytype}(nothing, (), nothing, PreferWeakKeyDict{Any,Tuple{Symbol, Int}}())

end

RegistryTypeEntry{T}() where {T} = RegistryTypeEntry{T,Nothing,Tuple{}}(nothing, (), nothing, PreferWeakKeyDict{Any,Tuple{Symbol, Int}}())
RegistryTypeEntry{T}(default::DE, entries::E, dynamic::D, lookup) where {T,DE,E,D} = RegistryTypeEntry{T,DE,E,D}(default, entries, dynamic, lookup)

function Base.length(te::RegistryTypeEntry)
    return length(te.entries) + (hasdefault(te) ? 1 : 0)
end

function setfield(rte::RegistryTypeEntry, location::Symbol, new)
    if location == :default
        return setdefault(rte, new)
    elseif location == :entries
        return setentries(rte, new)
    else
        error("Unknown location symbol: $location")
    end
end

function Base.setindex(rte::RegistryTypeEntry, new, idx::Int)
    location = hasdefault(rte) ? (idx == 1 ? :default : :entries) : :entries

    if location == :default
        return setdefault(rte, new)
    end

    entries = getentries(rte)
    entries_idx = hasdefault(rte) ? idx - 1 : idx
    newentries = Base.setindex(entries, new, entries_idx)
    return setentries(rte, newentries)
end


getdefault(rte::RegistryTypeEntry) = getfield(rte, :default)
getentries(rte::RegistryTypeEntry) = getfield(rte, :entries)
getdynamic(rte::RegistryTypeEntry) = getfield(rte, :dynamic)
getdynamiclookup(rte::RegistryTypeEntry) = getfield(rte, :dynamic_lookup)


default(rte::RegistryTypeEntry) = getdefault(rte)
default(rtetype::Type{<:RegistryTypeEntry{T,DE}}) where {T,DE} = DE

getdefault(rtetype::Type{<:RegistryTypeEntry{T,DE}}) where {T,DE} = DE
getentries(rtetype::Type{<:RegistryTypeEntry{T,DE,S}}) where {T,DE,S} = tuple(S.parameters...)

setdefault(rte::RegistryTypeEntry{T}, newdefault) where {T} = RegistryTypeEntry{T,typeof(newdefault),typeof(getentries(rte)), typeof(getdynamic(rte))}(newdefault, getentries(rte), getdynamic(rte), getdynamiclookup(rte))    
setentries(rte::RegistryTypeEntry{T}, newentries) where {T} = RegistryTypeEntry{T,typeof(getdefault(rte)),typeof(newentries), typeof(getdynamic(rte))}(getdefault(rte), newentries, getdynamic(rte), getdynamiclookup(rte))
setdynamic(rte::RegistryTypeEntry{T}, newdynamic) where {T} = RegistryTypeEntry{T,typeof(getdefault(rte)),typeof(getentries(rte)), typeof(newdynamic)}(getdefault(rte), getentries(rte), newdynamic, getdynamiclookup(rte))

function add_dynamic_link!(obj, location::Symbol, idx::Int, rte::RegistryTypeEntry)
    all_contained = full_unwrap_container(obj)
    for contained in all_contained
        getdynamiclookup(rte)[contained] = (location, idx)
    end
    return nothing
end


function target_location(rte::RegistryTypeEntry{T}, obj) where {T}
    if obj isa Type
        @assert isbits(obj()) "Type based lookup/adding only supported for isbits values"
        return :default
    elseif isbits(obj)
        return :entries
    else 
        return :dynamic
    end
end

###############################
##### TYPE INFO ##############
###############################
"""
Get the types of static entries
"""
entry_types(rte::Type{<:RegistryTypeEntry{T,DE,S}}) where {T,DE,S} = S.parameters
"""
All types including default
"""
@inline function all_types(rte::Union{RegistryTypeEntry{T,DE,S}, Type{<:RegistryTypeEntry{T,DE,S}}}) where {T,DE,S}
    ptypes = fieldtypes(S)
    if hasdefault(rte)
        ptypes = (DE, ptypes...)
    end
    return ptypes
end

############################
##### STATIC GETTERS #######
############################

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

# getindex_auto(rte::RegistryTypeEntry{T,Td,Ti}, idx::Int) where {T,Td,Ti} = rte.auto[idx]
# getindex_explicit(rte::RegistryTypeEntry{T,Td,Ti,Tie}, idx::Int) where {T,Td,Ti,Tie} = rte.explicit[idx]

function scale_multipliers(rte::RegistryTypeEntry{T}, factor) where {T}
    default = scale_multiplier(getdefault(rte), factor)
    entries = map(se -> scale_multiplier(se, factor), getentries(rte))
    return RegistryTypeEntry{T}(default, entries, getdynamic(rte), getdynamiclookup(rte))
end

##########################
######## GETTERS #########
##########################
"""
Get entry from location and index
"""
function getentry(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return getdefault(rte)
    elseif location == :entries
        return getentries(rte)[idx]
    else
        error("Unknown location symbol: $location")
    end
end

getvalue(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T} = value(getentry(rte, location, idx))

function getmultiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return multiplier(getdefault(rte))
    elseif location == :entries
        return multiplier(getentries(rte)[idx])
    else
        error("Unknown location symbol: $location")
    end
end

Base.getindex(te::RegistryTypeEntry, obj) = static_value_get(te, obj)

function Base.getindex(te::RegistryTypeEntry, idx::Int)
    if idx > length(te) 
        error("Index $idx out of bounds for Registry with length $(length(te))")
    end

    if hasdefault(te)
        if idx == 1
            return value(getdefault(te))
        else
            return value(getentry(te, :entries, idx - 1))
        end
    else
        return value(getentry(te, :entries, idx))
    end
end




##########################
##### MATCHING  ##########
##########################
"""
Find a match in the entry, either default
    or other entries
"""
function find_match(rte::RegistryTypeEntry{T}, obj) where {T}
    # If type is given, auto match with default
    if obj isa Type && T <: Type 
        if hasdefault(rte)
            return :default, 0
        else
            return nothing, nothing
        end
    end

    #No type, check default
    if match(getdefault(rte), obj)
        return :default, 0
    end

    return find_match_in_entries(rte, obj)
end

"""
Match with one of the entries
"""
function find_match_in_entries(rte::RegistryTypeEntry{T}, obj) where {T}
    for (idx, inst) in enumerate(getentries(rte))
        if match(inst, obj)
                return :entries, idx
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

    if isnothing(getdefault(rte))
        named_val = DefaultScope(val) # 0 is reserved for default
        entry = ScopedValueEntry(named_val, multiplier)
        # getdynamiclookup(rte)[val] = (:default, 0)
        # getdynamiclookup(rte)[typeof(val)] = (:default, 0)
        add_dynamic_link!(val, :default, 0, rte)
        new_rte = setdefault(rte, entry)
        # return RegistryType
        RegistryTypeEntry{T}(entry, getentries(rte), getdynamic(rte), getdynamiclookup(rte)), named_val
        return new_rte, named_val
    else
        new_rte = setdefault(rte, add_multiplier(getdefault(rte), multiplier))
        # return RegistryTypeEntry{T}(new_default, getentries(rte), getdynamic(rte), getdynamiclookup(rte)), value(getdefault(rte))
        return new_rte, value(getdefault(rte))
    end
end

add_entry(rte::RegistryTypeEntry, entry::ScopedValueEntry) = add_entry(rte, entry, multiplier(entry))

function add_entry(rte::RegistryTypeEntry{T}, obj, multiplier = 1.) where {T}
    if isnothing(obj)
        return rte, nothing
    end

    location, fidx = find_match_in_entries(rte, obj)
    if isnothing(fidx) #add new
        obj = value(obj) # Strip the entry
        # @show obj
        entries = getentries(rte)
        current_length = length(entries)
        named_val = Autoname(obj, current_length + 1)
        entry = ScopedValueEntry(named_val, multiplier)
        newentries = (entries..., entry)
        add_dynamic_link!(named_val, :entries, current_length + 1, rte)
        return setfield(rte, :entries, newentries), named_val
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
        getdynamiclookup(rte)[typeof(contained_type(value(entry)))] = (:default, 0)
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
        new_default = changefunc(getdefault(rte), num)
        return setdefault(rte, new_default)
    elseif location == :entries
        entries = getfield(rte, location)
        entry = entries[idx]
        new_entry = changefunc(entry, num)
        new_collection = Base.setindex(entries, new_entry, idx)
        return setfield(rte,location, new_collection)
    else
        error("Unknown location symbol: $location")
    end
end

add_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, num::Number) where {T} = change_multiplier(rte, location, idx, num, :add)
scale_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, factor::Number) where {T} = change_multiplier(rte, location, idx, factor, :scale)

###########################
##### MERGING ENTRIES #####
###########################

@inline function Base.merge(entry1::RegistryTypeEntry{T}, entry2::RegistryTypeEntry{T}) where {T}
    # Merging default entries
    entry1, _ = @inline add_default(entry1, entry2.default)
    # @show entry1
    # @show entry2
    for scopedentry2 in getentries(entry2)
        entry1, _ = @inline add_entry(entry1, value(scopedentry2), multiplier(scopedentry2))
    end

    return entry1
end

#############################
##### VALUE LOOKUPS #########
#############################

#=
Match either a scoped or non scope value with one of the entries
=#

dynamic_lookup(rte::RegistryTypeEntry{T}, val) where {T} = get(getdynamiclookup(rte), val, nothing)

@inline function dynamic_value_get(rte::RegistryTypeEntry{T}, val) where {T}
    loc_idx = dynamic_lookup(rte, val)
    if isnothing(loc_idx)
        return nothing
    end
    location, idx = loc_idx
    return getvalue(rte, location, idx)
end



############################
######## ITERATE  ##########
############################
function Base.iterate(te::RegistryTypeEntry, state = 1)
    if state > length(te)
        return nothing
    end
    return (te[state], state + 1)
end

function entries_iterator(te::RegistryTypeEntry)
    if hasdefault(te)
        return (getdefault(te), getentries(te)...)
    else
        return getentries(te)
    end
end

###############################
########## Names #############
###############################
function all_named_algos(te::Union{RegistryTypeEntry, Type{<:RegistryTypeEntry}})
    algos = tuple()
    if hasdefault(te)
        algos = (getvalue(getdefault(te)),)
    end
    return (algos..., getvalue.(getentries(te))...)
end

function all_names(te::Union{RegistryTypeEntry, Type{<:RegistryTypeEntry}})
    names = tuple()
    if hasdefault(te)
        names = (getname(getdefault(te)),)
    end
    return (names..., getname.(getentries(te))...)
end

function findname_idx(te::RegistryTypeEntry, name::Symbol)
    l = length(te)
    entry_name = getname(te[idx])
    return findfirst(==(name), entry_name)
end

function replacename(te::RegistryTypeEntry, oldname, newname::Symbol)
    idx = findfirst(==(oldname), all_names(te))
    if isnothing(idx)
        return te
    end
    return setindex(te, changename(te[idx], newname), idx)
end

function replacenames(te::RegistryTypeEntry, changed_names::Dict{Symbol,Symbol})
    ps = pairs(changed_names)
    UnrollReplace(te, ps...) do rte, (oldname, newname)
        changename(rte, newname)
    end
end

###############################
##### SHOWING ENTRIES ##########
###############################

function Base.show(io::IO, rte::RegistryTypeEntry{T}) where {T}
    println(io, "RegistryTypeEntry for type: $(T)")
    if hasdefault(rte)
        println(io, "\t:default => ", value(getdefault(rte)), " x ", multiplier(getdefault(rte)))
    else
    end
    if length(getentries(rte)) == 0
    else
        entries = getentries(rte)
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