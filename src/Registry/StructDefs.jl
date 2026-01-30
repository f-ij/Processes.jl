
"""
Abstract supertype for registry implementations.

Registries provide a static, type-driven name/lookup layer used by the Processes
system. The primary implementation is `NameSpaceRegistry`, which supports scoped
values, auto-naming, and multiplier tracking.
"""
abstract type AbstractRegistry end



################################
##### SCOPED VALUE ENTRY ######
################################
"""
Wraps scopedvalues statically with a multilier indicating how often per top-level call
    the an algorithm using this entry is expected to be called

    Multupliers are set by the algorithm composition system when building LoopAlgorithms
"""
struct ScopedValueEntry{T, V} 
    multiplier::Float64
end

ScopedValueEntry(val, mult = 0.) = ScopedValueEntry{typeof(val), val}(mult)
"""
Entries don't wrap themselves
"""
ScopedValueEntry(sve::ScopedValueEntry{T,V}) where {T,V} = ScopedValueEntry{T,V}(sve.multiplier)


###############################
##### REGISTRY TYPE ENTRY #####
###############################
"""
Holds scoped value entries for a specific type T
    DE: Default Entry Type
    S: Static Entries Type
    D: Dynamic Entries Type (Dict)
    DL: Dynamic Lookup Type (PreferStrongKeyDict)

I'm not super happy about the name, since it's easy to confuse with the ScopedValueEntries,
    but it's what we have for now.
"""

struct RegistryTypeEntry{T,DE,S,D}
    default::DE  # Default instance and its multiplier
    entries::S   # isbits(x) == true, 
    dynamic::D
    dynamic_lookup::PreferStrongKeyDict{Any,Tuple{Symbol, Int}} # Map from object to (location, index)
end

function RegistryTypeEntry(obj::T) where T
    entrytype = contained_type(obj)
    @DebugMode "Creating RegistryTypeEntry for obj: $obj and type: $entrytype"
    return RegistryTypeEntry{entrytype}(nothing, (), nothing, PreferStrongKeyDict{Any,Tuple{Symbol, Int}}())

end

RegistryTypeEntry{T}() where {T} = RegistryTypeEntry{T,Nothing,Tuple{}}(nothing, (), nothing, PreferStrongKeyDict{Any,Tuple{Symbol, Int}}())
RegistryTypeEntry{T}(default::DE, entries::E, dynamic::D, lookup) where {T,DE,E,D} = RegistryTypeEntry{T,DE,E,D}(default, entries, dynamic, lookup)
RegistryTypeEntry(rte::RegistryTypeEntry{T}, default, entries) where T = RegistryTypeEntry{T,typeof(default),typeof(entries),typeof(getdynamic(rte))}(default, entries, getdynamic(rte), getdynamiclookup(rte))

########################################
############## REGISTRY ################
########################################

"""
Namespace registry keyed by static types rather than a runtime dictionary.

Main responsibilities:
1) Orchestrate names between entries that were previously locally managed or assigned.
2) Auto-name entries that do not carry an assigned scope on entry, so scoping is opt-in
   for the user interface while still always enforced internally.
3) Provide static lookup by using values of `isbits` structs (and, via indirection, also
   non-`isbits` values) as keys that map to a symbol name. This performs a static conversion
   from an arbitrary scoped value—or an unscoped value through auto matching—to a symbol key.
   That key is later used by contexts.

Each entry is expected to contain only `ScopedAlgorithm` wrappers; no other payloads should be
stored directly in a registry entry. `ScopedAlgorithm` drives the matching system (via entry
matching), and it works together with thin containers so that wrapping layers do not affect
identity: a value and any amount of thin wrapping resolve to the same underlying identity.
Auto-scoped values (currently denoted by a `nothing` id, possibly changing to `:auto`)
can be matched by unrolling to the base struct, enabling the opt-in naming model where
the user supplies a struct and does not need to manage scope explicitly.

The registry also tracks a multiplier per entry; this is later used to infer how often an
algorithm will be called relative to the top level of a composed algorithm.

Structure:
    (# Tuple for type 1 (namedinstance1, namedinstance2, ...), # Tuple for type 2 (...), ...)
"""
struct NameSpaceRegistry{T} <: AbstractRegistry
    entries::T # Tuple of RegistryTypeEntry
end

NameSpaceRegistry() = NameSpaceRegistry(tuple())