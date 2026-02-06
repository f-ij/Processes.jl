function Base.length(te::RegistryTypeEntry)
    return length(te.entries)
end

function Base.setindex(rte::RegistryTypeEntry, new, idx::Int)
    entries = getentries(rte)
    Base.setindex(entries, new, idx)
end


getentries(rte::RegistryTypeEntry) = getfield(rte, :entries)
getdynamic(rte::RegistryTypeEntry) = getfield(rte, :dynamic)
getdynamiclookup(rte::RegistryTypeEntry) = getfield(rte, :dynamic_lookup)
getmultipliers(rte::RegistryTypeEntry) = getfield(rte, :multipliers)
getmultiplier(rte::RegistryTypeEntry, idx::Int) = getmultipliers(rte)[idx]

getentries(rtetype::Type{<:RegistryTypeEntry{T,S}}) where {T,S} = tuple(S.parameters...)

setentries(rte::RegistryTypeEntry{T}, newentries) where {T} = RegistryTypeEntry{T,typeof(getdefault(rte)),typeof(newentries), typeof(getdynamic(rte))}(getdefault(rte), newentries, getdynamic(rte), getdynamiclookup(rte))
setdynamic(rte::RegistryTypeEntry{T}, newdynamic) where {T} = RegistryTypeEntry{T,typeof(getdefault(rte)),typeof(getentries(rte)), typeof(newdynamic)}(getdefault(rte), getentries(rte), newdynamic, getdynamiclookup(rte))

function add_dynamic_link!(obj, location::Symbol, idx::Int, rte::RegistryTypeEntry)
    matching_obj = match_by(obj)
    getdynamiclookup(rte)[matching_obj] = idx
    return nothing
end

###############################
##### TYPE INFO ##############
###############################

"""
Get the types of static entries
"""
entry_types(rte::Type{<:RegistryTypeEntry{T,E}}) where {T,E} = E.parameters

"""
Is a registry type the same as another
"""
same_entry_type(rte1::RegistryTypeEntry{T1}, rte2::RegistryTypeEntry{T2}) where {T1,T2} = T1 == T2

gettype(rte::Type{<:RegistryTypeEntry{T}}) where T = T
gettype(rte::RegistryTypeEntry) = gettype(typeof(rte))

hasdefault(rtetype::Type{<:RegistryTypeEntry{T,Td}}) where {T,Td} = !(Td <: Nothing)
hasdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = !(Td <: Nothing)

###############################
##### CHANGING MULTIPLIER #####
###############################

function scale_multipliers!(rte::RegistryTypeEntry{T}, factor) where {T}
    getmultipliers(rte) .*= factor
    return rte
end

function add_multiplier!(rte::RegistryTypeEntry{T}, idx::Int, num::Number) where {T}
    getmultipliers(rte)[idx] += num
    return rte
end
function scale_multiplier!(rte::RegistryTypeEntry{T}, idx::Int, factor::Number) where {T}
    getmultipliers(rte)[idx] *= factor
    return rte
end

############################
######### Finding ##########
############################

@inline function static_findfirst_match(rte::RegistryTypeEntry, val)
    @DebugMode "Looking for static match of value: $val in RegistryTypeEntry $(rte)"
    if !isbits(val)
        # TODO: This is a bit hacky
        @DebugMode "Value: $val is not bits, skipping static match"
        return static_findfirst_match(rte, Val(typeof(val)))

    end
    static_findfirst_match(rte, Val(val))
end

@inline @generated function static_findfirst_match(rte::RegistryTypeEntry{T,S}, v::Val{value}) where {T,S,value}
    idx = findfirst(x -> match(value, x), entry_types(rte))
    return :($idx)
end

@inline dynamic_find_match(rte::RegistryTypeEntry{T}, val) where {T} = get(getdynamiclookup(rte), val, nothing)

##########################
######## GETTERS #########
##########################
Base.getindex(te::RegistryTypeEntry, obj) = static_get(te, obj)

function Base.getindex(te::RegistryTypeEntry, idx::Int)
    getentries(te)[idx]
end

"""
Match Exact with value
"""
@inline function static_get(rte::RegistryTypeEntry, val::V) where V 
    idx = static_findfirst_match(rte, Val(val))
    if isnothing(idx)
        error("No matching entry found for value: $val")
    end
    return getentries(rte)[idx]
end


##########################
##### ADDING ENTRIES #####
##########################

function add(rte::RegistryTypeEntry{T}, obj, multiplier = 1.; withname = nothing) where {T}
    if isnothing(obj)
        # return rte, nothing
        error("Trying to add `nothing` to RegistryTypeEntry of type $T")
    end

    fidx = static_findfirst_match(rte, obj)
    if isnothing(fidx) #add new
        entries = getentries(rte)
        current_length = length(entries)

        identifiable = nothing
        if !isnothing(withname) # If name is given, use that
            identifiable = IdentifiableAlgo(obj, withname)
        else
            identifiable = Autokey(obj, current_length + 1)
        end

        push!(getmultipliers(rte), multiplier) # Add the multiplier

        newentries = (entries..., identifiable)
        add_dynamic_link!(identifiable, :entries, current_length + 1, rte)
        return setfield(rte, :entries, newentries), identifiable
    else # Existing instance, bump multiplier and get the named version
        
        if !isnothing(withname) # Check name match, cannot add two matching objects with different names
            name = getkey(rte[fidx])
            if name != withname
                error("Trying to add an entry with name $withname but an entry with the same type already exists with name $name")
            end
        end

        return add_multiplier!(rte, fidx, multiplier), getentries(rte)[fidx]
    end
end

###########################
##### MERGING ENTRIES #####
###########################

@inline function Base.merge(entry1::RegistryTypeEntry{T}, entry2::RegistryTypeEntry{T}) where {T}
    for (identifiable, multiplier) in getentries(entry2)
        entry1, _ = @inline add(entry1, identifiable, multiplier)
    end

    return entry1
end

#############################
##### VALUE LOOKUPS #########
#############################

#=
Match either a scoped or non scope value with one of the entries
This is faster for runtime, slower for inlining
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
    else
        return ((getentries(te)[state], getmultipliers(te)[state]), state + 1)
    end
end


###############################
########## Names #############
###############################
function all_named_algos(te::Union{RegistryTypeEntry, Type{<:RegistryTypeEntry}})
    getentries_list = getentries(te)
end

"""
Context names
"""
function all_names(te::Union{RegistryTypeEntry, Type{<:RegistryTypeEntry}})
    getkey.(getentries(te))
end

# function findname_idx(te::RegistryTypeEntry, name::Symbol)
#     l = length(te)
#     entry_name = getkey(te[idx])
#     return findfirst(==(name), entry_name)
# end

"""
Change the context name of an entry
from oldname to newname
"""
function replacecontextkeys(te::RegistryTypeEntry, oldname, newname::Symbol)
    idx = findfirst(==(oldname), all_names(te))
    if isnothing(idx)
        return te
    end
    return setindex(te, setcontextkey(te[idx], newname), idx)
end

"""
From a dict that contains oldname => newname
Change all referenced context names in the RegistryTypeEntry
"""
function replacecontextkeyss(te::RegistryTypeEntry, changed_names::Dict{Symbol,Symbol})
    ps = pairs(changed_names)
    UnrollReplace(te, ps...) do rte, (oldname, newname)
        setcontextkey(rte, newname)
    end
end

###################################
########## REBUILDING #############
###################################

function rebuild(f, rte::RegistryTypeEntry)
    @DebugMode println("Rebuilding RegistryTypeEntry for type ", gettype(rte))
 
    new_entries = f.(getentries(rte))
    @DebugMode "New Entries: $(new_entries)"

    return setfield(rte, :default, new_default) |> x -> setfield(x, :entries, new_entries)
end



###############################
##### SHOWING ENTRIES ##########
###############################

function Base.show(io::IO, rte::RegistryTypeEntry{T}) where {T}
    println(io, "RegistryTypeEntry for type: $(T)")
    if length(getentries(rte)) == 0
    else
        entries = getentries(rte)
        limit = get(io, :limit, false)
        n = length(entries)
        head = 3
        tail = 2
        if !limit || n <= head + tail + 1
            for (idx, entry) in enumerate(entries)
                println(io, "\t", idx, " \t => ", entry, " x ", getmultiplier(rte,idx))
            end
        else
            for idx in 1:head
                entry = entries[idx]
                println(io, "\t", idx, " \t => ", entry, " x ", getmultiplier(rte,idx))
            end
            println(io, "\t...")
            for idx in (n - tail + 1):n
                entry = entries[idx]
                println(io, "\t", idx, " \t => ", entry, " x ", getmultiplier(rte,idx))
            end
        end
    end
end
