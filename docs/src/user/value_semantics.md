# [Value Semantics and `Unique`](@id value_semantics_user)

Most users only need one rule here:

- if you use the same algorithm type once, plain types or instances are fine;
- if you need multiple logically distinct instances of the same algorithm, use `Unique(...)` and keep the returned value around.

`Unique` exists to give one inserted algorithm a guaranteed separate identity in the registry and therefore a separate subcontext in the process context.

## When You Need `Unique`

You usually need `Unique(...)` when you want more than one copy of the same algorithm in a composition and you need to target them separately in:

- `Route(...)`
- `Share(...)`
- `Input(...)`
- `Override(...)`
- `Var(...)`

Example:

```julia
producer_a = Producer()
producer_b = Unique(Producer())
consumer = Consumer()

algo = CompositeAlgorithm(
    producer_a, producer_b, consumer,
    (1, 1, 1),
    Route(producer_b => consumer, :value),
)
```

Without `Unique`, the framework may treat repeated equal values or repeated type-based entries as the same logical identity.

## Matching Rules

For process entities (`ProcessAlgorithm`/`ProcessState`):

- instance value matches by value (`match_by(pe) = pe`)
- type matches by type (`match_by(::Type{<:ProcessEntity}) = T`)

So `Fib()` and `Fib` are different identities.

## Why Instance Lookup Can Be Surprising

Registry lookup uses a static path for `Type` and `isbits` values.

For non-`isbits` values, lookup falls back to type-level matching in `NameSpaceRegistry.getindex`.

Practical effect:

- `isbits` instances can preserve more value-specific lookup behavior.
- non-`isbits` instances tend to behave more like type-targeted lookups unless wrapped with stronger identity.

## `Unique`

`Unique(x)` wraps `x` in `IdentifiableAlgo` with a UUID identity.

That gives a guaranteed separate registry identity and thus separate subcontext key, even when:

- two wrapped values are otherwise equal,
- they are non-`isbits`,
- or they are hard to distinguish by default value semantics.

## Recommended Patterns

- One logical instance per type: plain type or instance is fine.
- Multiple logical instances of same algorithm: use `Unique(...)` and keep references.
- Inputs/routes/shares for those distinct instances: reference the same `Unique` values you inserted into composition.
