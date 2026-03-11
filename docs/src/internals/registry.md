# [Registry Internals](@id registry_internals)

The registry layer is what assigns stable subcontext names to algorithms/states and makes value/type lookups predictable.

Core types:

- `NameSpaceRegistry`: top-level registry (`src/Registry/StructDefs.jl`).
- `RegistryTypeEntry{T}`: one partition per entry type (`src/Registry/StructDefs.jl`).
- `IdentifiableAlgo{F,Id,...,Key}`: wrapped process entity with identity and assigned context key (`src/Identifiable/StructDef.jl`).

## 1. Type Partitions and Matching

Entries are grouped by `assign_entrytype(obj)` (`src/Registry/Traits.jl`).

- Default entry type: the object's type wrapper.
- `IdentifiableAlgo` overrides this via `registry_entrytype(::Type{<:IdentifiableAlgo{T}}) = T` (`src/Identifiable/IdentifiableAlgos.jl`).

Within each `RegistryTypeEntry`, matches use `match_by` (`src/Matching.jl`, `src/ProcessEntities/ProcessEntities.jl`):

- Process entity instance (`Fib()`): matches by value (`match_by(pe) = pe`).
- Process entity type (`Fib`): matches by type (`match_by(::Type{<:ProcessEntity}) = T`).

This is why instance-based and type-based registrations are distinct identities.

## 2. Key Assignment

`add(reg, obj, multiplier)` (`src/Registry/Registries.jl`, `src/Registry/TypeEntries.jl`) does:

1. Find/create the correct `RegistryTypeEntry`.
2. If no match exists, create a key with `Autokey` (`TypeName_index`) and wrap as `IdentifiableAlgo`.
3. If a match exists, reuse the existing key and increase multiplier.

Key consequences:

- Same value entered repeatedly: same key reused.
- Same type entered repeatedly: same key reused for that type identity.
- Type-entered value vs value-entered value can still be different identities.
- This stays true across nested `CompositeAlgorithm`/`Routine` trees because `setup_registry` flattens all entities into one registry pass before context creation.

## 3. `Unique` and Distinguishability

`Unique(f)` builds an `IdentifiableAlgo` with a fresh UUID identity (`src/Identifiable/StructDef.jl`).

That gives a guaranteed distinct match identity even when the wrapped value is otherwise indistinguishable.

This is the mechanism used when you need multiple logically separate instances of the same algorithm in one composition.

## 4. Lookup Behavior

`ProcessContext` lookups by value/type eventually call registry `getindex` (`src/Context/ProcessContexts.jl`, `src/Registry/Registries.jl`).

Important runtime detail in `NameSpaceRegistry.getindex`:

- `obj isa Type || isbits(obj)`: lookup by full static match.
- otherwise: lookup falls back to `typeof(obj)`.

So isbits values preserve value-level semantics better at lookup time; non-isbits values are effectively type-targeted unless wrapped with identity-bearing types (for example via `Unique`).

## 5. Multipliers

Each registry entry tracks a multiplier (`RegistryTypeEntry.multipliers`).

For loop algorithms this is derived from composition structure (intervals/repeats), and is used by utilities such as `processsizehint!`/`num_calls` (`src/Tools.jl`).

## 6. Order Guarantees

`setup_registry` adds:

1. `ProcessState`s first.
2. Then flattened algorithms.

(see `src/LoopAlgorithms/Setup.jl`)

That ordering controls init/cleanup traversal order through `all_algos(registry)`.
