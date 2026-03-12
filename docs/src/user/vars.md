# [Vars (`Var` Selectors)](@id vars_user)

`Var` is a small selector type used to read values from a `ProcessContext` by name.

## Two Forms

### 1. Subcontext variable

```julia
Var(entity_ref, :name)
```

This reads `:name` from the subcontext of `entity_ref`.

Example:

```julia
counter = Counter()
Var(counter, :count)
```

### 2. Global variable

```julia
Var(:name)
```

This reads `:name` from `context.globals`.

So:

- `Var(:process)` reads `context.globals.process`
- `Var(:algo)` reads `context.globals.algo`
- `Var(:lifetime)` reads `context.globals.lifetime`

## Common Use in `Until`

`Var` is commonly used with `Processes.Until(...)` to pick what value the stop condition should inspect.

Example with a subcontext variable:

```julia
counter = Counter()

lifetime = Processes.Until(x -> x >= 100, Var(counter, :count))
```

Example with a global variable (process object):

```julia
lifetime = Processes.Until(p -> loopidx(p) >= 10_000, Var(:process))
```

`Var(:process)` is useful when your stop rule depends on process-level state.

In `Until`/`RepeatOrUntil`, this function is a stop condition (`true => stop`, `false => continue`).
