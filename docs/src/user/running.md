# [Running, Wait, Fetch](@id running_user)

## Create and Run

```julia
p = Process(algo, Input(...), Override(...); lifetime = 1_000)
run(p)
```

`run(p)` starts the process loop task.

## Lifetime

The `lifetime` keyword defines stop behavior:

- `lifetime = 1000` -> run a fixed number of iterations.
- omitted -> default lifetime behavior for that algorithm type.
- advanced: `Processes.Repeat(...)`, `Processes.Indefinite()`, `Processes.Until(...)`, `Processes.RepeatOrUntil(...)`.

See [Lifetime](@ref lifetime_user) for full details.
For selector syntax used in `Until`, see [Vars (`Var` Selectors)](@ref vars_user).

## Control

- `pause(p)`: stop loop while keeping resumable state.
- `run(p)`: resume after pause.
- `close(p)`: stop and finalize task state.
- `reprepare(p)`: pause, rebuild context with init pipeline, run again.

## Waiting and Fetching

- `wait(p)`: block until task completes.
- `fetch(p)`: return task return value (the loop return context).

For typical inspection, use `getcontext(p)`.

## Status Helpers

- `isrunning(p)`
- `ispaused(p)`
- `isdone(p)`
- `isidle(p)`

## Inline Process

Use `InlineProcess` when you want synchronous execution without a separate process task:

```julia
ip = InlineProcess(algo; repeats = 10_000)
run(ip)
```
