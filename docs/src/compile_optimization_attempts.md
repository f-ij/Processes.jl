# Compile Optimization Attempts

This file records compile-latency experiments so failed paths are not repeated.

## Kept Changes

- Captured concrete loop algorithm types in helper signatures.
  This replaced several `Type{<:T}` method arguments with `Type{Concrete} where Concrete <: T` when the method reads the exact type.

- Added constructor-time `ProcessManager` precompile scheduling.
  The hook runs after manager construction and targets concrete manager, slot, and job types.

- Avoided empty process setup work.
  Empty input/override construction now skips a throwaway context build, and empty `initcontext` paths avoid vararg filtering.

- Moved `setfield` debug rendering out of generated-function generation.
  Large debug strings are now built only on the error path.

## Reverted Or Rejected

- `@nospecialize` on process precompile helpers.
  Julia accepts both formal-argument and statement-position `@nospecialize`, but the tested changes made latency noisier or worse.

- Generated location caching for subcontext views.
  The idea was to cache location computation in generated helpers. In the tested pattern it did not improve the target benchmark.

- Refactoring `stablemerge`/`unstablemerge` merge planning.
  Several versions using grouped plans and helper functions were neutral or slower.

- Structural helpers for `_global_context_type` and related loop precompile signatures.
  They passed tests but worsened construction/first-run latency.

- Reusing the input-resolution `ProcessContext` through a public `TaskData` keyword option.
  This avoided one duplicate context build, but introduced a new constructor specialization path and did not produce a stable win.

- Reusing the input-resolution `ProcessContext` through a narrow internal `Process` constructor path.
  This avoided one duplicate context build for `Process(algo, Input(...), Override(...))`, but did not improve the compile-latency benchmark. The first call is dominated by compilation of resolution, merge, init, and run paths; after compilation, warm process construction is already small enough that the saved context build is below benchmark noise. This was removed to keep the constructor path simpler.

- Splitting `TaskData` into a typed positional internal helper.
  This was meant to avoid keyword dispatch in `Process` construction. It increased cold-stage latency in the compile benchmark.

- Adding type parameters directly to the public `TaskData` keyword constructor.
  This also worsened compile-facing benchmark numbers and was reverted.

## Current Benchmark Notes

- `manual tests/ProcessHotLoopBenchmark.jl` checks normal hot-loop runtime.
  Recent larger runs did not show a normal `Process` hot-loop regression against clean `HEAD`.

- `manual tests/ProcessCompileLatencyBenchmark.jl` breaks compile-facing work into:
  algorithm construction, input resolution, `TaskData`, `initcontext`, `Process` constructor, first run, and warmed hot runs.

- The current benchmark suggests the next useful target is not simple `TaskData` specialization. Metadata reuse should stay on narrow internal paths and avoid changing the public `TaskData` keyword constructor shape.
