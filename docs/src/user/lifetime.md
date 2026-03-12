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
- `Processes.RepeatOrUntil(condition, n, selector)`

## `Until`: Stop on a Condition

`Until` checks a value from context each loop.  
Here, `condition(value)` is a **stop condition**:

- `true` -> stop now
- `false` -> continue

A practical pattern is to use `Var(...)` as selector:

```julia
counter = Counter()

p = Process(
    counter;
    lifetime = Processes.Until(
        x -> x >= 100,
        Var(counter, :count),
    ),
)
```

## `RepeatOrUntil`: Max Iterations Or Condition

`RepeatOrUntil` combines:

- a maximum number of iterations (`n`)
- a stop condition like `Until`

The loop stops at whichever happens first:

1. repeat count reaches `n`, or
2. condition becomes `true`.

Example:

```julia
counter = Counter()

p = Process(
    counter;
    lifetime = Processes.RepeatOrUntil(
        x -> x >= 100,   # stop condition
        1_000,           # hard max iterations
        Var(counter, :count),
    ),
)
```

Important:

- Use the same algorithm reference you used in `Process(...)` (same instance or same `Unique` variable).
- `Var(:name)` reads from globals (for example `Var(:process)`).
- The safest current `Until` usage is a single selector value.

For full `Var` details, see [Vars (`Var` Selectors)](@ref vars_user).

## Notes

- `Lifetime` types are currently not exported, so use the `Processes.` prefix.
- Manual stop/pause still works regardless of lifetime (`pause`, `close`, `shouldrun` path).
