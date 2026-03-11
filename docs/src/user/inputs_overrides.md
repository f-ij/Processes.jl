# [Inputs and Overrides](@id inputs_overrides_user)

Inputs and overrides are passed when creating a process.

## API

```julia
Input(target_algo, :name => value, ...)
Override(target_algo, :name => value, ...)
```

Targets are resolved through the composed algorithm registry.

## When They Apply

`init_context` applies them in this order:

1. Inputs merged first.
2. `init(...)` executes.
3. Overrides merged after init.

So:

- `Input` is for values needed during initialization.
- `Override` force-replaces initialized values.

## Example

```julia
algo = CompositeAlgorithm(Walker, InsertNoise, (1, 2))

p = Process(
    algo,
    Input(Walker, :dt => 0.01),
    Override(InsertNoise, :seed => 1234),
    lifetime = 100,
)
```

## Targeting and Identity

When choosing targets, use the same references you used in composition.

For exact patterns and examples, see [Referencing Algorithms](@ref referencing_algorithms_user).
