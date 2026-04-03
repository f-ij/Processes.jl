# [Process Pipeline Internals](@id process_pipeline_internals)

This page documents the runtime path from `Process(...)` to loop execution.

## 1. Construction

`Process(func, inputs_overrides...; lifetime, timeout)` (`src/Process.jl`):

1. Wrap bare `ProcessAlgorithm` as `SimpleAlgo`.
2. Normalize lifetime (`Repeat(n)`/`Indefinite()`, with `Routine` default `Repeat(1)` when `lifetime = nothing`).
3. Build empty context: `ProcessContext(func)`.
4. Convert `Input`/`Override` into named backend forms via registry (`resolve`).
5. Build `TaskData` and initialize context via `initcontext(td)`.

## 2. Init Phase

`initcontext` (`src/Init.jl`) applies:

1. Inputs merge (plus `algo` and `lifetime` into every target subcontext).
2. `init(algo, input_context)`.
3. Overrides merge.

For loop algorithms, `init(::LoopAlgorithm, ::ProcessContext)` iterates all registry entities in order (`src/LoopAlgorithms/Init.jl`).

## 3. Running

`run(p)` (`src/Interface.jl`) ensures context is ready and calls `makeloop!` (`src/Process.jl`).

`makeloop!`:

- injects `process` into globals,
- precompiles loop signature,
- spawns `generated_processloop` (`src/Running.jl`).

## 4. `generated_processloop`

Defined in `src/GeneratedCode/GeneratedLoops.jl` for `Repeat` and `Indefinite`.

High-level structure:

1. `before_while(process)`
2. repeat/while body with inlined generated step expression
3. tick/index increments
4. `after_while(process, algo, context)`

Step bodies are produced by `step!_expr` (`src/LoopAlgorithms/GeneratedStep.jl` and `src/Identifiable/Step.jl`) so composite/routine structures can be unrolled and specialized to concrete algorithm/context types.

## 5. Cleanup Behavior

`after_while` (`src/Loops.jl`) does:

- interrupted or indefinite: store current context, return it.
- natural finite completion: store `cleanup(func, context)` into process context, then return the loop context.

So process state storage and task return value are related but not identical paths.
