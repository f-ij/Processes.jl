# [Value Semantics and `Unique`](@id value_semantics_user)

This page explains why identity behavior differs between values, types, and `Unique` wrappers.

## Default Matching Rules

For process entities (`ProcessAlgorithm`/`ProcessState`):

- instance value matches by value (`match_by(pe) = pe`)
- type matches by type (`match_by(::Type{<:ProcessEntity}) = T`)

So `Fib()` and `Fib` are different identities.

## Why `isbits` Matters

Registry lookup uses a static path for `Type` and `isbits` values.

For non-`isbits` values, lookup falls back to type-level matching in `NameSpaceRegistry.getindex`.

Practical effect:

- `isbits` instances can preserve more value-specific lookup behavior.
- non-`isbits` instances tend to behave as type-targeted unless wrapped with stronger identity.

## `Unique`

`Unique(x)` wraps `x` in `IdentifiableAlgo` with a UUID identity.

That gives a guaranteed separate registry identity and thus separate subcontext key, even when:

- two wrapped values are otherwise equal,
- or they are hard to distinguish by default value semantics.

## Recommended Patterns

- One logical instance per type: plain type or instance is fine.
- Multiple logical instances of same algorithm: use `Unique(...)` and keep references.
- Inputs/routes/shares for those distinct instances: reference the same `Unique` values you inserted into composition.
