# [Running, Wait, Fetch](@id running_user)

This page covers the normal runtime flow: create a `Process`, run it, wait for it, and inspect the result.

## Create a Process

```julia
p = Process(algo, Input(...), Override(...); lifetime = 1_000)
```

`Process(...)` constructs the runtime context immediately, applying inputs, running `init`, and then applying overrides.

## Run and Resume

```julia
run(p)
```

`run(p)` starts the process loop task. If the process was paused, `run(p)` resumes it.

## Lifetime

The `lifetime` keyword defines stop behavior:

- `lifetime = 1000` -> run a fixed number of iterations.
- omitted -> default lifetime behavior for that algorithm type.
- advanced: `Processes.Repeat(...)`, `Processes.Indefinite()`, `Processes.Until(...)`, `Processes.RepeatOrUntil(...)`.

See [Lifetime](@ref lifetime_user) for full details.
For selector syntax used in `Until`, see [Vars (`Var` Selectors)](@ref vars_user).

## Control Operations

- `pause(p)`: stop loop while keeping resumable state.
- `run(p)`: start or resume.
- `close(p)`: stop the process and collect the final task result into the stored process context.
- `reinit(p)`: pause, rebuild context through the init pipeline, and run again.

## Waiting and Fetching

- `wait(p)`: block until task completes.
- `fetch(p)`: return the task return value.

In practice:

- use `wait(p)` when you just want to block until completion,
- use `fetch(p)` when you want the task's return value,
- use `getcontext(p)` when you want the process context in the most convenient form for inspection.

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
