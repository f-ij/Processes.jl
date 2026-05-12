# [Inputs and Overrides](@id inputs_overrides_user)

Inputs and overrides are passed when creating a process.

Both forms target one algorithm or state. Use the same reference style you used
when adding that target to the composition: the type, the saved instance, a
saved `Unique(...)` value, or an explicit symbol key.

## API

```julia
Input(target_algo, :name => value, ...)
Override(target_algo, :name => value, ...)
```

Targets are resolved through the composed algorithm registry: the table of
registered algorithms and states for the final process.

## When They Apply

`initcontext` applies them in this order:

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
    repeats = 100,
)
```

Use `repeats = 100` for a fixed number of process loop iterations, or
`lifetime = Repeat(100)` if you want to pass the lifetime object explicitly.

## Targeting and Identity

When choosing targets, use the same references you used in composition.

For exact patterns and examples, see [Referencing Algorithms](@ref referencing_algorithms_user).
