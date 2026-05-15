# [Process Pipeline Internals](@id process_pipeline_internals)

This page documents the runtime path from loop algorithm construction to loop
execution.

## 1. Construction

`Process(func, inputs_overrides...; repeats, lifetime, timeout)` (`src/Process.jl`):

1. Wrap bare `ProcessAlgorithm` as `SimpleAlgo`.
2. Normalize stop behavior: `repeats = n` becomes `Repeat(n)`, `lifetime` accepts `Lifetime` objects, and `Routine` defaults to `Repeat(1)` when no lifetime is provided.
3. Resolve the loop algorithm when needed.
4. Run lifecycle `init(algo, specs...; lifetime)` unless an initialized context is already provided.
5. Store the initialized loop algorithm on the process.

There is no `TaskData` layer. The initialized loop algorithm carries the
persistent context plus stored init/override specs.

## 2. Init Phase

`init(la::LoopAlgorithm, specs...)` (`src/LoopAlgorithms/RuntimeInputs.jl`) applies:

1. Resolve `Init`/`Override` specs through the registry.
2. Merge passed specs over stored specs per target.
3. Build a fresh persistent `ProcessContext` with `algo` and `lifetime` in globals.
4. Merge `Init` values into target subcontexts.
5. Run `init(algo, input_context)`.
6. Merge `Override` values after init.
7. Return a loop algorithm with stored context, inits, and overrides.

For loop algorithms, `init(::LoopAlgorithm, ::ProcessContext)` iterates all registry entities in order (`src/LoopAlgorithms/Init.jl`).

`partialinit(la, specs...)` uses the same target resolution but only rebuilds
the targeted subcontexts.

## 3. Running

`run(p; kwargs...)` (`src/ProcessInteraction.jl`) calls `makeloop!` (`src/Process.jl`).

`makeloop!`:

- validates runtime keyword arguments against the loop algorithm's `@input` metadata,
- injects `process` into globals,
- passes runtime inputs as a positional `NamedTuple` to `loop`,
- spawns the loop task.

`run(la::LoopAlgorithm; kwargs...)` runs an initialized loop algorithm directly
and returns a loop algorithm with the next persistent context.

## 4. Loop Bootstrap and Runtime Inputs

The loop wrappers in `src/Loops.jl` merge runtime inputs before the while/for
loop:

```julia
loop(process, algo, context, lifetime, inputs)
```

An empty input tuple is a no-op. A non-empty tuple is merged into the transient
`:_input` subcontext. The bootstrap/first step may change the transient context
type. After bootstrap, steady-state steps must preserve context type.

Repeat and indefinite loops are defined in `src/Loops.jl`; generated loops live
in `src/GeneratedCode/GeneratedLoops.jl`.

High-level structure:

1. `before_while(process)`
2. one unstable/bootstrap step
3. repeat/while body with stable step calls
4. tick/index increments
5. `after_while(process, algo, context)`

Step bodies are produced by `step!_expr` (`src/LoopAlgorithms/GeneratedStep.jl` and `src/Identifiable/Step.jl`) so composite/routine structures can be unrolled and specialized to concrete algorithm/context types.

## 5. Cleanup Behavior

`after_while` (`src/Loops.jl`) does:

- interrupted or indefinite: store current context, return it.
- natural finite completion: store `cleanup(func, context)` into process context, then return the loop result.

Before context is stored, `_stored_loop_context` removes the transient
`:_input` subcontext and strips the `process` global. Runtime inputs are never
stored in the initialized loop algorithm or process after the run.
