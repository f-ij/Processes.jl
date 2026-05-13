# Compile Optimization Attempts

This file records compile-latency experiments so failed paths are not repeated.

## Kept Changes

- Captured concrete loop algorithm types in helper signatures.
  This replaced several `Type{<:T}` method arguments with `Type{Concrete} where Concrete <: T` when the method reads the exact type.

- Added constructor-time `ProcessManager` precompile scheduling.
  The hook runs after manager construction and targets concrete manager, slot, and job types.

- Kept constructor-time `Process` loop precompile scheduling.
  This is close enough to the first `run` call to reduce first-run latency without
  precompiling broad `LoopAlgorithm` metadata paths too early.

- Avoided empty process setup work.
  Empty input/override construction now skips a throwaway context build, and empty `initcontext` paths avoid vararg filtering.

- Moved `setfield` debug rendering out of generated-function generation.
  Large debug strings are now built only on the error path.

- Made input/override resolution require a resolved algorithm.
  `prepare_process_constructor` resolves the normalized algorithm before resolving
  inputs or overrides. `resolve_process_inputs_overrides` now reads the registry
  from that resolved algorithm and errors when called directly with an unresolved
  algorithm. This is mostly a contract cleanup; measured compile latency was
  neutral against the same benchmark using an already-resolved algorithm.

- Fused single-algorithm `resolve` registry build with algorithm keying.
  The single-argument path now uses the keyed algorithm returned while adding
  algorithms to the registry instead of building a registry and then doing a
  second registry lookup pass through `update_keys`. Multi-algorithm resolve
  still uses the shared-registry path.

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

- Constructor-time `LoopAlgorithm` metadata precompile.
  Immediate scheduling made nearby construction and input-resolution stages
  contend with background compilation. Adding an arbitrary sleep moved the
  contention but did not reliably improve immediate time-to-first-process-run.
  The hook, lock, type set, delay constant, and metadata precompile helper were
  removed.

- Splitting `setup_registry` into an `add_loopalgorithm_to_registry` helper.
  Both a fully specialized helper and a variant with `@nospecialize` on the loop
  algorithm were tested. The split made cold construction/first-run latency worse
  and also hurt warmed process-loop timing, so the original single-body registry
  setup remains preferable.

- Adding a `@noinline` unresolved-resolve boundary.
  The goal was to stop `Process` construction from compiling through the full
  resolve path. In practice it made first-run and warmed process-loop timing
  worse, which suggests the resolved algorithm type information is still useful
  to the later loop path.

- Adding `Base.@constprop :none` to `setup_registry`.
  This was meant to reduce caller-side compile work without changing semantics,
  but it worsened warmed loop timing and was removed.

- Rewriting `resolve(la::LoopAlgorithm)` as `resolve(la::LA) where
  {LA<:LoopAlgorithm}`.
  This did not improve the compile benchmark. Julia was already specializing the
  method sufficiently for this use case.

## Current Benchmark Notes

- `manual tests/ProcessHotLoopBenchmark.jl` checks normal hot-loop runtime.
  Recent larger runs did not show a normal `Process` hot-loop regression against clean `HEAD`.

- `manual tests/ProcessCompileLatencyBenchmark.jl` breaks compile-facing work into:
  algorithm construction, input resolution, `TaskData`, `initcontext`, `Process` constructor, first run, and warmed hot runs.

- `manual tests/ProcessResolveBenchmark.jl` measures fresh construction,
  `resolve`, already-resolved `resolve`, `initcontext`, `Process` construction,
  first run, and warmed fresh-resolve throughput for simple, routed, shared, and
  nested algorithms.

- The current benchmark suggests the next useful target is not simple `TaskData` specialization. Metadata reuse should stay on narrow internal paths and avoid changing the public `TaskData` keyword constructor shape.

## SnoopCompile Pass

Ran a temporary-environment SnoopCompile pass with `SnoopCompileCore.@snoop_inference`
on the compile benchmark workload. The project dependency files were not changed.

Important exclusive inference-time signals from the small benchmark:

- `step!` generated by `@ProcessAlgorithm`: about `55 ms`.
- `get_all_locations(::Type{<:SubContextView})`: about `51 ms` accumulated.
- `Base.getproperty(::SubContextView, ::Val)`: about `44 ms` accumulated.
- `merge_into_globals`: about `35 ms` accumulated.
- `merge_into_subcontext_rebuild`: about `28 ms` accumulated.
- `merge(::SubContextView, ::NamedTuple)`: about `25 ms`.
- `init` generated by `@ProcessAlgorithm`: about `25 ms`.
- `setup_registry`: about `19 ms`.

Important inclusive paths:

- `resolve(::CompositeAlgorithm)`: about `207 ms`, mostly through registry setup.
- `loop(::Process, ::CompositeAlgorithm, ::ProcessContext, ::Repeat, ::NonGenerated)`:
  about `122 ms`.
- `initcontext(::TaskData{... inputs/overrides ...})`: about `92 ms`.
- `Process(...; repeats=1)`: about `87 ms`.

The pass also showed inference under background precompile tasks launched from
`Process.jl`. Future SnoopCompile runs should either disable those tasks or run a
separate pass specifically for the precompile pipeline, otherwise normal workload
inference and background precompile inference are mixed together.

## LoopAlgorithm Metadata Precompile

The first SnoopCompile pass showed background metadata precompile tasks mixed into
normal first-call inference. The compile benchmark confirmed this was not just a
measurement artifact: launching metadata precompile immediately from
`LoopAlgorithm` construction made the next constructor stages contend with those
tasks.

Measured cold-stage comparison on the simple compile benchmark:

- Immediate background precompile:
  `algo construction ~= 106 ms`, `input resolution ~= 118 ms`,
  `Process constructor ~= 63 ms`, `first run ~= 137 ms`.
- Disabled metadata precompile:
  `algo construction ~= 105 ms`, `input resolution ~= 30 ms`,
  `Process constructor ~= 61 ms`, `first run ~= 151 ms`.
- Delayed metadata precompile by `0.2s`:
  `algo construction ~= 106 ms`, `input resolution ~= 27 ms`,
  `Process constructor ~= 54 ms`, `first run ~= 141 ms`.

Later measurements showed the best immediate construct-to-first-run path came
from removing the `LoopAlgorithm` constructor metadata precompile entirely while
keeping the `Process` constructor loop precompile:

- No `LoopAlgorithm` metadata precompile:
  `algo construction ~= 87-90 ms`, `input resolution ~= 26-33 ms`,
  `Process constructor ~= 53-55 ms`, `first run ~= 123-134 ms`.

The conclusion is that metadata precompile from `LoopAlgorithm` construction is
too early for this workload. It either contends with input resolution or, when
delayed, is less useful for the immediate first run. The retained precompile path
is the `Process` constructor loop precompile, which is closer to the actual code
that will run.
