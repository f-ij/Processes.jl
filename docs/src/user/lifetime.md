# [Lifetime](@id lifetime_user)

`lifetime` controls when a process loop stops.

## Most Common Usage

### Fixed number of iterations

```julia
p = Process(algo; lifetime = 1_000)
```

Passing an integer is converted internally to `Processes.Repeat(1000)`.

### Default behavior

If you do not pass `lifetime`:

- most processes default to `Processes.Indefinite()`
- `Routine` defaults to one pass (`Processes.Repeat(1)`) when `lifetime = nothing`

## Explicit Lifetime Types

These types are available in code:

- `Processes.Repeat(n)`
- `Processes.Indefinite()`
- `Processes.Until(condition, selector)`

## `Until`: Stop on a Condition

`Until` checks a value from context each loop.  
The loop continues while `condition(value)` is `true`, and stops when it becomes `false`.

A practical pattern is to use `Var(...)` as selector:

```julia
counter = Counter()

p = Process(
    counter;
    lifetime = Processes.Until(
        x -> x < 100,
        Var(counter, :count),
    ),
)
```

Important:

- Use the same algorithm reference you used in `Process(...)` (same instance or same `Unique` variable).
- The safest current `Until` usage is a single selector value.

## Notes

- `Lifetime` types are currently not exported, so use the `Processes.` prefix.
- Manual stop/pause still works regardless of lifetime (`pause`, `close`, `shouldrun` path).

