struct ValueEntry{T}
    value::T
    multiplier::Float64
end

getmultiplier(cla::ComplexLoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getname(cla::ComplexLoopAlgorithm, obj) = getname(getregistry(cla), obj)

struct RegistryTypeEntry{T,DE,S,D}
    default::DE  # Default instance and its multiplier
    static::S   # isbits(x) == true
    dynamic::D  # isbits(x) == false
    # default::Td
    # default_mult::Float64
    # auto::Ti
    # auto_mults::Tim
    # explicit::Tie
    # explicit_mults::Tiem
end

function RegistryTypeEntry(obj::T) where T
    if obj isa Type
        return RegistryTypeEntry{obj}(nothing, 0., (), (), (), ())
    else
        return RegistryTypeEntry{T}(nothing, 0., (), (), (), ())
    end
end
RegistryTypeEntry{T}() where {T} = RegistryTypeEntry{T,Nothing,Tuple{},Tuple{},Tuple{},Tuple{}}(nothing, 0., (), (), (), ())
RegistryTypeEntry{T}(default::Td, dmult::Float64, instances::Ti, auto_mults::Tim, explicit::Tie, explicit_mults::Tiem) where {T,Td,Ti,Tim,Tie,Tiem} = RegistryTypeEntry{T,Td,Ti,Tim,Tie,Tiem}(default, dmult, instances, auto_mults, explicit, explicit_mults)
# RegistryTypeEntry{T}(default::Td, instances::Ti) where {T,Td,Ti} = RegistryTypeEntry{T,Td,Ti}(default, instances)

same_entry(rte1::RegistryTypeEntry{T1}, rte2::RegistryTypeEntry{T2}) where {T1,T2} = T1 == T2

gettype(rte::Type{<:RegistryTypeEntry{T}}) where T = T
gettype(rte::RegistryTypeEntry) = gettype(typeof(rte))

hasdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = !(Td <: Nothing)
getdefault(rte::RegistryTypeEntry{T,Td}) where {T,Td} = rte.default

getindex_auto(rte::RegistryTypeEntry{T,Td,Ti}, idx::Int) where {T,Td,Ti} = rte.auto[idx]
getindex_explicit(rte::RegistryTypeEntry{T,Td,Ti,Tie}, idx::Int) where {T,Td,Ti,Tie} = rte.explicit[idx]

function scale_multipliers(rte::RegistryTypeEntry{T}, factor) where T
    new_dmult = rte.default_mult * factor
    new_auto_mults = map(x -> x * factor, rte.auto_mults)
    new_explicit_mults = map(x -> x * factor, rte.explicit_mults)
    return RegistryTypeEntry{T}(rte.default, new_dmult, rte.auto, new_auto_mults, rte.explicit, new_explicit_mults)
end

function getinstance(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return getdefault(rte)
    elseif location == :auto
        return getindex_auto(rte, idx)
    elseif location == :explicit
        return getindex_explicit(rte, idx)
    else
        error("Unknown location symbol: $location")
    end
end

function getmultiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int = nothing) where {T}
    if location == :default
        return rte.default_mult
    elseif location == :auto
        return rte.auto_mults[idx]
    elseif location == :explicit
        return rte.explicit_mults[idx]
    else
        error("Unknown location symbol: $location")
    end
end

"""
Instances that need an automatic name
"""
function add_auto(rte::RegistryTypeEntry{T}, val, multiplier) where {T}
    fidx = findinstance_auto(rte, val)
    if isnothing(fidx) # New instance, give it a name
        named_val = Autoname(val, length(rte.auto) + 2) # +2 because 1 is reserved for default
        newauto = (rte.auto..., named_val)
        newmults = (rte.auto_mults..., multiplier)
        return RegistryTypeEntry{T}(rte.default, rte.default_mult, newauto, newmults, rte.explicit, rte.explicit_mults), val
    else # Existing instance, bump multiplier
        newmults = Base.setindex(rte.auto_mults, rte.auto_mults[fidx] + multiplier, fidx)
        return RegistryTypeEntry{T}(rte.default, rte.default_mult, rte.auto, newmults, rte.explicit, rte.explicit_mults), getindex_auto(rte, fidx)
    end
end

"""
Instances that already have a name
"""
function add_explicit(rte::RegistryTypeEntry{T}, val, multiplier = 1.) where {T}
    fidx = findinstance_explicit(rte, val)
    if isnothing(fidx) # New instance, add to end
        newexplicit = (rte.explicit..., val)
        newmults = (rte.explicit_mults..., multiplier)
        return RegistryTypeEntry{T}(rte.default, rte.default_mult, rte.auto, rte.auto_mults, newexplicit, newmults), val
    else
        newmults = Base.setindex(rte.explicit_mults, rte.explicit_mults[fidx] + multiplier, fidx)
        return RegistryTypeEntry{T}(rte.default, rte.default_mult, rte.auto, rte.auto_mults, rte.explicit, newmults), getindex_explicit(rte, fidx)
    end
end


function add_default(rte::RegistryTypeEntry{T,Td}, val, multiplier = 1.) where {T,Td}
    if isnothing(rte.default)
        named_val = Autoname(val, 1)
        return RegistryTypeEntry{T}(named_val, multiplier, rte.auto, rte.auto_mults, rte.explicit, rte.explicit_mults), val
    else
        new_dmult = rte.default_mult + multiplier
        return RegistryTypeEntry{T}(rte.default, new_dmult, rte.auto, rte.auto_mults, rte.explicit, rte.explicit_mults), getdefault(rte)
    end
end

function add(rte::RegistryTypeEntry{T}, obj, multiplier = 1.) where {T}
    if obj isa Type
        val = obj()
        return add_default(rte, val, multiplier)
    elseif hasname(obj)
        return add_explicit(rte, obj, multiplier)
    else
        return add_auto(rte, obj, multiplier)
    end
end


function multiply_multiplier(rte::RegistryTypeEntry{T}, location::Symbol, idx::Int, factor::Number) where {T}
    if location == :default
        new_dmult = rte.default_mult * factor
        return RegistryTypeEntry{T}(rte.default, new_dmult, rte.auto, rte.auto_mults, rte.explicit, rte.explicit_mults)
    elseif location == :auto
        new_auto_mults = Base.setindex(rte.auto_mults, rte.auto_mults[idx] * factor, idx)
        return RegistryTypeEntry{T}(rte.default, rte.default_mult, rte.auto, new_auto_mults, rte.explicit, rte.explicit_mults)
    elseif location == :explicit
        new_explicit_mults = Base.setindex(rte.explicit_mults, rte.explicit_mults[idx] * factor, idx)
        return RegistryTypeEntry{T}(rte.default, rte.default_mult, rte.auto, rte.auto_mults, rte.explicit, new_explicit_mults)
    else
        error("Unknown location symbol: $location")
    end
end

function multiply_multiplier(rte::RegistryTypeEntry{T}, obj, factor::Number) where {T}
    if obj isa Type # Multiply default
        return RegistryTypeEntry{T}(rte.default, rte.default_mult * factor, rte.auto, rte.auto_mults, rte.explicit, rte.explicit_mults)
    end

    fidx, location = findinstance(rte, obj)
    if isnothing(fidx)
        error("Object not found in registry")
    end
    return multiply_multiplier(rte, location, fidx, factor)
end

"""
match only instance
"""
function findinstance_auto(rte::RegistryTypeEntry{T}, obj) where {T}
    for (idx, inst) in enumerate(rte.auto)
        if isinstance(inst, obj)
            return idx
        end
    end
    return nothing
end

"""
match instance and name
"""
function findinstance_explicit(rte::RegistryTypeEntry{T}, obj) where {T}
    for (idx, inst) in enumerate(rte.explicit)
        if isinstance(inst, obj) && getname(inst) == getname(obj)
                 return idx
        end
    end
    return nothing
end

function findinstance(rte::RegistryTypeEntry{T}, obj) where {T}
    if hasname(obj)
        return findinstance_explicit(rte, obj), :explicit
    else
        return findinstance_auto(rte, obj), :auto
    end
end

function Base.merge(entry1::RegistryTypeEntry, entry2::RegistryTypeEntry)
    @assert gettype(entry1) == gettype(entry2)

    # Merge default, prefer default of 1 if both exist
    newdefault = entry1.default
    if isnothing(newdefault) && !isnothing(entry2.default)
        newdefault = entry2.default
    end
    newdefault_mult = entry1.default_mult + entry2.default_mult

    # Merge auto and dedupe by instance. If instances match, take name of the furst and add multipliers
    newauto = entry1.auto
    newauto_mults = entry1.auto_mults
    for (idx, inst) in enumerate(entry2.auto)
        fidx = findinstance_auto(entry1, inst)
        if isnothing(fidx) # New instance
            newauto = (newauto..., inst)
            newauto_mults = (newauto_mults..., entry2.auto_mults[idx])
        else # Existing instance, bump multiplier
            newauto_mults = Base.setindex(newauto_mults, newauto_mults[fidx] + entry2.auto_mults[idx], fidx)
        end
    end

    # Merge explicit and dedupe by instance+name. If instances match, take name of the first and add multipliers
    newexplicit = entry1.explicit
    newexplicit_mults = entry1.explicit_mults
    for (idx, inst) in enumerate(entry2.explicit)
        fidx = findinstance_explicit(entry1, inst)
        if isnothing(fidx) # New instance
            newexplicit = (newexplicit..., inst)
            newexplicit_mults = (newexplicit_mults..., entry2.explicit_mults[idx])
        else # Existing instance, bump multiplier
            newexplicit_mults = Base.setindex(newexplicit_mults, newexplicit_mults[fidx] + entry2.explicit_mults[idx], fidx)
        end
    end

    return RegistryTypeEntry{gettype(entry1)}(newdefault, newdefault_mult, newauto, newauto_mults, newexplicit, newexplicit_mults)
end

"""
Take an old RegistryTypeEntry and use all the names of a base RegistryTypeEntry
"""
function updatenames(old::RegistryTypeEntry, base::RegistryTypeEntry)
    newdefault = base.default

    newauto = old.auto
    for (idx, inst) in enumerate(old.auto)
        fidx = findinstance_auto(base, inst)
        if isnothing(fidx)
            error("Instance in old registry not found in base registry")
        end
        newauto = Base.setindex(old.auto, getindex_auto(base, fidx), idx)
    end

    updated_registry = RegistryTypeEntry{gettype(old)}(newdefault, old.default_mult, newauto, old.auto_mults, old.explicit, old.explicit_mults)
end


########################
  ##### REGISTRY #####
########################

"""
Namespace registry but with static type_same instead of dict
    (# Tuple for type 1 (namedinstance1, namedinstance2, ...), # Tuple for type 2 (...), ...)
"""
struct NameSpaceRegistry{T}
    instances::T # Tuple of RegistryTypeEntry
end

NameSpaceRegistry() = NameSpaceRegistry(tuple())

Base.getindex(reg::NameSpaceRegistry, idx::Int) = reg.instances[idx]

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

@generated function _findtype(reg::NameSpaceRegistry{T}, typ::Type{TT}) where {T,TT}
    it = gettypes_iterator(reg)
    index = findfirst(t -> TT <: t, it)
    return :( $index )
end

findtype(reg::NameSpaceRegistry, obj) = _findtype(reg, typeof(obj))
findtype(reg::NameSpaceRegistry, typ::Type) = _findtype(reg, typ)

"""
Add an instance and get new registry and a named instance back
"""
function add_instance(reg::NameSpaceRegistry{T}, obj, multiplier = 1.) where {T}
    fidx = findtype(reg, obj)
    if isnothing(fidx) # New Entry
ß        newentry = RegistryTypeEntry(obj)
        newentry, namedobj = add(newentry, obj, multiplier)
        return NameSpaceRegistry((reg.instances..., newentry)), namedobj
    else # Type was found
        entry = reg.instances[fidx]
        newentry, namedobj = add(entry, obj, multiplier)
        newinstances = Base.setindex(reg.instances, newentry, fidx)
        return NameSpaceRegistry(newinstances), namedobj
    end
end

@generated function getnamedinstance(reg::NameSpaceRegistry{T}, obj) where {T}
    _type_index = findtype(reg, obj)
    if _isnothing(_type_index)
        error("Object of type $(obj) not found in registry")
    end

    return quote
        f_idx, location = findinstance(reg.instances[$_type_index], obj)
        if isnothing(f_idx)
            error("Object not found in registry")
        end
        return getinstance(reg[$_type_index], location, f_idx)
    end
end

getname(reg::NameSpaceRegistry{T}, obj) where {T} = getname(getnamedinstance(reg, obj))

@generated function getmultiplier(reg::NameSpaceRegistry{T}, obj) where {T}
    _type_index = findtype(reg, obj)
    if _isnothing(_type_index)
        error("Object of type $(obj) not found in registry")
    end

    return quote
        f_idx, location = findinstance(reg.instances[$_type_index], obj)
        if isnothing(f_idx)
            error("Object not found in registry")
        end
        return getmultiplier(reg[$_type_index], location, f_idx)
    end
end

function scale_multipliers(reg::NameSpaceRegistry{T}, factor::Number) where {T}
    newinstances = map(entry -> scale_multipliers(entry, factor), reg.instances)
    return NameSpaceRegistry{typeof(newinstances)}(newinstances)
end

function Base.merge(registry1::NameSpaceRegistry, registry2::NameSpaceRegistry)
    entries1 = registry1.instances
    entries2 = registry2.instances

    newentries = deepcopy(entries1)
    for entry2 in entries2
        fidx = findfirst(x -> same_entry(x, entry2), newentries)
        if isnothing(fidx) # New entry
            newentries = (newentries..., entry2)
        else
            entry1 = registry1.instances[fidx]
            mergedentry = merge(entry1, entry2)
            newentries = Base.setindex(newentries, mergedentry, fidx)
        end
    end
    return NameSpaceRegistry(newentries)
end