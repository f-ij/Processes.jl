"""
Holds a scope wrapped algorithm value and a multiplier (i.e. how many times per loop that algorithm will be called)
    Can match with a non-scoped value
"""
abstract type ScopedValueEntry{T} end

"""
SVE needs to be first argument in match
"""
match(val, te::Union{ScopedValueEntry,Type{<:ScopedValueEntry}}) = match(te, val)

multiplier(ve::ScopedValueEntry) = ve.multiplier
value(ve::ScopedValueEntry) = getvalue(ve)
scale_multiplier(ve::ScopedValueEntry{T}, factor::Number) where T = setmultiplier(ve, ve.multiplier * factor)
add_multiplier(ve::ScopedValueEntry{T}, addend::Number) where T = setmultiplier(ve, ve.multiplier + addend)

ScopedValueEntry(val, mult, type::Symbol) = type == :static ? StaticEntry(val, mult) : DynamicEntry(val, mult)
struct DynamicEntry{T} <: ScopedValueEntry{T}
    value::T # If isbits, Val{value}()
    multiplier::Float64
end
match(set::Type{DynamicEntry{T}}, val) where T = error("Cannot match type DynamicEntry with value")
match(de::DynamicEntry{T}, val) where T = isinstance(val, getvalue(de))
getvalue(de::DynamicEntry{T}) where T = de.value
setvalue(de::DynamicEntry{T}, newval) where T = DynamicEntry{T}(newval, de.multiplier)
setmultiplier(de::DynamicEntry{T}, newmult) where T = DynamicEntry{T}(de.value, newmult)

struct StaticEntry{T, V} <: ScopedValueEntry{T} # T is typeof(V)
    multiplier::Float64
end
StaticEntry(val, mult = 0.) = StaticEntry{typeof(val), val}(mult)
match(set::Type{StaticEntry{T,V}}, val) where {T,V} = isinstance(V, val)
match(se::StaticEntry{T,V}, val) where {T,V} = isinstance(V, val)

setvalue(se::StaticEntry{T,V}, newval) where {T,V} = StaticEntry{T, newval}(se.multiplier)
setmultiplier(se::StaticEntry{T,V}, newmult) where {T,V} = StaticEntry{T,V}(newmult)
getvalue(se::StaticEntry{T,V}) where {T,V} = V
getvalue(set::Type{StaticEntry{T,V}}) where {T,V} = V

# TODO: Move these
getmultiplier(cla::ComplexLoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getname(cla::ComplexLoopAlgorithm, obj) = getname(getregistry(cla), obj)

isdefault(rte::ScopedValueEntry{T}) where {T} = id(T) == :default

struct RegistryTypeEntry{T,DE,S,D}
    default::DE  # Default instance and its multiplier
    static::S   # isbits(x) == true, 
    dynamic::D  # isbits(x) == false
    dynamic_lookup::Dict{Any,Tuple{Symbol, Int}} # Dynamic lookup for all, encodes (:location, index)
end

function setfield(rte::RegistryTypeEntry, new, location)
    if location == :default
        return setdefault(rte, new)
    elseif location == :static
        return setstatic(rte, new)
    elseif location == :dynamic
        return setdynamic(rte, new)
    else
        error("Unknown location symbol: $location")
    end
end

default(rte::RegistryTypeEntry) = rte.default
default(rtetype::Type{<:RegistryTypeEntry{T,DE}}) where {T,DE} = DE
setdefault(rte::RegistryTypeEntry{T,DE,S,D}, newdefault::DE) where {T,DE,S,D} = RegistryTypeEntry{T,DE,S,D}(newdefault, rte.static, rte.dynamic, rte.dynamic_lookup)    
setstatic(rte::RegistryTypeEntry{T,DE,S,D}, newstatic::S) where {T,DE,S,D} = RegistryTypeEntry{T,DE,S,D}(rte.default, newstatic, rte.dynamic, rte.dynamic_lookup)
setdynamic(rte::RegistryTypeEntry{T,DE,S,D}, newdynamic::D) where {T,DE,S,D} = RegistryTypeEntry{T,DE,S,D}(rte.default, rte.static, newdynamic, rte.dynamic_lookup)

"""
Get the types of static entries
"""
static_types(rte::Type{<:RegistryTypeEntry{T,DE,S}}) where {T,DE,S} = S.parameters

function dynamic_lookup(rte::RegistryTypeEntry, val)
    location, idx = rte.dynamic_lookup[val]
    if location == :default
        return rte.default
    else
        return getfield(rte, location)[idx]
    end
end

@inline static_lookup(rte::RegistryTypeEntry, val::Any) = @inline dynamic_lookup(rte, Val(val))
@inline @generated static_lookup(rte::RegistryTypeEntry{T,DE,S,D}, v::Val{value}) where {T,DE,S,D,value} = begin
    if isbits(value)
        default_type = default(rte)
        if match(value, default_type)
            return :( rte.default )
        end
        idx = findfirst(x -> match(value, x), static_types(rte))
        return :( getindex(rte.static, $idx) )
    elseif value isa Type && isbitstype(value)
        default_type = default(rte)
        if default_type <: Nothing
            return :( error("Value $value not found in static registry") )
        else
            return :( rte.default )
        end
    else
        # @warn "Value $value is not isbits, using dynamic lookup instead of static"
        return quote 
            @warn "Value $value is not isbits, using dynamic lookup instead of static"
            dynamic_lookup(rte, value)
        end
    end
end

function RegistryTypeEntry(obj::T) where T
    if obj isa Type
        return RegistryTypeEntry{obj}(nothing, (), (), Dict{Any,Tuple{Symbol, Int}}())
    else
        return RegistryTypeEntry{T}(nothing, (), (), Dict{Any,Tuple{Symbol, Int}}())
    end
end

RegistryTypeEntry{T}() where {T} = RegistryTypeEntry{T,Nothing,Tuple{},Tuple{}}(nothing, (), (), Dict{Any,Tuple{Symbol, Int}}())
RegistryTypeEntry{T}(default::DE, static::S, dynamic::D, lookup) where {T,DE,S,D} = RegistryTypeEntry{T,DE,S,D}(default, static, dynamic, lookup)

same_entry_type(rte1::RegistryTypeEntry{T1}, rte2::RegistryTypeEntry{T2}) where {T1,T2} = T1 == T2

gettype(rte::Type{<:RegistryTypeEntry{T}}) where T = T
gettype(rte::RegistryTypeEntry) = gettype(typeof(rte))

hasdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = !(Td <: Nothing)
getdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = rte.default

# getindex_auto(rte::RegistryTypeEntry{T,Td,Ti}, idx::Int) where {T,Td,Ti} = rte.auto[idx]
# getindex_explicit(rte::RegistryTypeEntry{T,Td,Ti,Tie}, idx::Int) where {T,Td,Ti,Tie} = rte.explicit[idx]

function scale_multipliers(rte::RegistryTypeEntry{T}, factor) where T
    default = scale_multiplier(rte.default, factor)
    statics = map(se -> scale_multiplier(se, factor), rte.static)
    dynamics = map(de -> scale_multiplier(de, factor), rte.dynamic)
    return RegistryTypeEntry{T}(default, statics, dynamics, rte.dynamic_lookup)
end

function getinstance(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return getdefault(rte)
    elseif location == :static
        return value(rte.static[idx])
    elseif location == :dynamic
        return value(rte.dynamic[idx])
    else
        error("Unknown location symbol: $location")
    end
end

function getmultiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return multiplier(rte.default)
    elseif location == :static
        return multiplier(rte.static[idx])
    elseif location == :dynamic
        return multiplier(rte.dynamic[idx])
    else
        error("Unknown location symbol: $location")
    end
end

function find_instance_entry(rte::RegistryTypeEntry{T}, obj) where {T}
    # If type is given, auto match with default
    if obj isa Type && T <: Type 
        if hasdefault(rte)
            return 0, :default
        else
            return nothing, nothing
        end
    end

    #No type, check default
    if hasdefault(rte) && match(rte.default, obj)
        return 0, :default
    end
    

    location = nothing
    if isbits(obj)
        location = :static
    else
        location = :dynamic
    end
    for (idx, inst) in enumerate(getfield(rte, location))
        if match(inst, obj)
                return idx, location
        end
    end
    return nothing, nothing
end

"""
Target location of obj
"""
target_location(::Type{T}) where T = isbitstype(T) ? :static : :dynamic
target_location(obj) = isbits(obj) ? :static : :dynamic

function add_default(rte::RegistryTypeEntry{T,Td}, val, multiplier = 1.) where {T,Td}
    if isnothing(rte.default)
        named_val = DefaultScope(val) # 0 is reserved for default
        target = target_location(val)
        entry = ScopedValueEntry(named_val, multiplier, target)
        rte.dynamic_lookup[val] = (:default, 0)
        rte.dynamic_lookup[typeof(val)] = (:default, 0)
        return RegistryTypeEntry{T}(entry, rte.static, rte.dynamic, rte.dynamic_lookup), named_val
    else
        new_default = add_multiplier(rte.default, multiplier)
        return RegistryTypeEntry{T}(new_default, rte.static, rte.dynamic, rte.dynamic_lookup), getdefault(rte)
    end
end

function add(rte::RegistryTypeEntry{T}, obj, multiplier = 1.) where {T}
    if obj isa Type
        val = obj()
        return add_default(rte, val, multiplier)
    else
        fidx, location = find_instance_entry(rte, obj)
        if isnothing(fidx) #add new
            location = target_location(obj)
            target_collection = getfield(rte, location)
            current_length = length(target_collection)
            named_val = Autoname(obj, current_length + 1)
            entry = ScopedValueEntry(named_val, multiplier, location)
            newcollection = tuple(entry)
            rte.dynamic_lookup[obj] = (location, current_length + 1)
            return setfield(rte, newcollection, location), named_val
        else # Existing instance, bump multiplier and get the named version
            return add_multiplier(rte, location, fidx, multiplier), getinstance(rte, location, fidx)
        end
        
    end
end

function change_multiplier(rte::RegistryTypeEntry, location::Symbol, idx::Int, num, changetype::Symbol)
    changefunc = changetype == :add ? add_multiplier : scale_multiplier
    if location == :default
        new_default = changefunc(rte.default, addend)
        return setdefault(rte, new_default)
    elseif location == :static || location == :dynamic
        target_collection = getfield(rte, location)
        entry = target_collection[idx]
        new_entry = changefunc(entry, addend)
        new_collection = Base.setindex(target_collection, new_entry, idx)
        return setfield(rte, new_collection, location)
    else
        error("Unknown location symbol: $location")
    end
end

add_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, addend::Number) where {T} = change_multiplier(rte, location, idx, addend, :add)
scale_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, factor::Number) where {T} = change_multiplier(rte, location, idx, factor, :scale)

function add_multiplier(rte::RegistryTypeEntry{T}, obj, addend::Number) where {T}
    if obj isa Type # Add to default
        return RegistryTypeEntry{T}(add_multiplier(rte.default, addend), rte.static, rte.dynamic, rte.dynamic_lookup)
    end
    fidx, location = find_instance_entry(rte, obj)
    if isnothing(fidx)
        error("Object not found in registry")
    end
    return add_multiplier(rte, location, fidx, addend)
end

function scale_multiplier(rte::RegistryTypeEntry{T}, obj, factor::Number) where {T}
    if obj isa Type # Multiply default
        return RegistryTypeEntry{T}(rte.default, rte.default_mult * factor, rte.auto, rte.auto_mults, rte.explicit, rte.explicit_mults)
    end
    fidx, location = find_instance_entry(rte, obj)
    if isnothing(fidx)
        error("Object not found in registry")
    end
    return scale_multiplier(rte, location, fidx, factor)
end


function Base.merge(entry1::RegistryTypeEntry, entry2::RegistryTypeEntry)
    @assert gettype(entry1) == gettype(entry2)

    # Merge default, prefer default of 1 if both exist
    newdefault = entry1.default
    if isnothing(newdefault) && !isnothing(entry2.default)
        newdefault = entry2.default
        entry1.dynamic_lookup[value(newdefault)] = (:default, 0)
    end
    # newdefault_mult = entry1.default_mult + entry2.default_mult
    newdefault = add_multiplier(newdefault, multiplier(entry2.default))

    # Merge static
    newstatic = entry1.static
    for inst in entry2.static
        _, fidx = find_instance_entry(entry1, value(inst))
        if isnothing(fidx) # New instance
            val = value(inst)
            namedval = Autoname(val, length(newstatic) + 1)
            newentry = StaticEntry(namedval, multiplier(inst))
            newstatic = (newstatic..., newentry)
            entry1.dynamic_lookup[value(inst)] = (:static, length(newstatic))
        else # Existing instance, bump multiplier
            newstatic = Base.setindex(newstatic, add_multiplier(newstatic[fidx], multiplier(inst)), fidx)
        end
    end

    # Merge dynamic
    newdynamic = entry1.dynamic
    for inst in entry2.dynamic
        _, fidx = find_instance_entry(entry1, value(inst))
        if isnothing(fidx) # New instance
            val = value(inst)
            namedval = Autoname(val, length(newdynamic) + 1)
            DynamicEntry(namedval, multiplier(inst))
            newdynamic = (newdynamic..., newentry)
            entry1.dynamic_lookup[value(inst)] = (:dynamic, length(newdynamic))
        else # Existing instance, bump multiplier
            newdynamic = Base.setindex(newdynamic, add_multiplier(newdynamic[fidx], multiplier(inst)), fidx)
        end
    end

    return RegistryTypeEntry{gettype(entry1)}(newdefault, newstatic, newdynamic, merge(entry1.dynamic_lookup, entry2.dynamic_lookup))

    # return RegistryTypeEntry{gettype(entry1)}(newdefault, newdefault_mult, newauto, newauto_mults, newexplicit, newexplicit_mults)
end


