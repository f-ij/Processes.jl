
"""
Abstract supertype for registry implementations.

Registries provide a static, type-driven name/lookup layer used by the Processes
system. The primary implementation is `NameSpaceRegistry`, which supports scoped
values, auto-naming, and multiplier tracking.
"""
abstract type AbstractRegistry end


###############################
##### REGISTRY TYPE ENTRY #####
###############################
"""
Holds scoped value entries for a specific type T
    S: Entries
    M: Multipliers per entry
    D: Dynamic Entries Type (Dict)
    DL: Dynamic Lookup Type (PreferStrongKeyDict)

I'm not super happy about the name, since it's easy to confuse with the ScopedValueEntries,
    but it's what we have for now.
"""

struct RegistryTypeEntry{T,E}
    entries::E   # isbits(x) == true, 
    multipliers::Vector{Float64}
    dynamic_lookup::Dict{Any,Int} # Map from object to (location, index)
end

function RegistryTypeEntry(obj::T) where T
    entrytype = contained_type(obj)
    @DebugMode "Creating RegistryTypeEntry for obj: $obj and type: $entrytype"
    return RegistryTypeEntry{entrytype}(nothing, (), Dict{Any,Int}())
end

RegistryTypeEntry{T}() where {T} = RegistryTypeEntry{T,Tuple{}}((), Float64[], Dict{Any,Int}())
RegistryTypeEntry{T}(entries::E, multipliers, lookup) where {T,E,} = RegistryTypeEntry{T,E}(entries, multipliers, lookup)
RegistryTypeEntry(rte::RegistryTypeEntry{T}, entries) where T = RegistryTypeEntry{T, typeof(getentries(rte))}(entries, get_multipliers(rte), getdynamiclookup(rte))

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
4) Provide static iteration over (non-dynamic) entries in the registry

Each entry is expected to contain only `IdentifiableAlgo` wrappers; no other payloads should be
stored directly in a registry entry. `IdentifiableAlgo` drives the matching system (via entry
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
struct NameSpaceRegistry{E} <: AbstractRegistry
    entries::E # Tuple of RegistryTypeEntry
end

NameSpaceRegistry() = NameSpaceRegistry(tuple())