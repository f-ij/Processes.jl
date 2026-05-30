# Inline Route-Heavy Diagnostics Findings

Date: 2026-05-30

## Scope

This note records the route-heavy inline-process benchmark work and the follow-up
allocation/SROA investigation. The active diagnostic files are:

- `diagnostics/inline_route_heavy_benchmark.jl`
- `diagnostics/inline_route_heavy_breakdown.jl`
- `diagnostics/inline_route_type_stability.jl`

The benchmark target is intentionally real route-heavy scalar work: five
`ProcessAlgorithm`s (`sensor`, `filter`, `controller`, `plant`, `audit`) with
cross-algorithm routed dependencies, plus a plain scalar loop that performs the
same semantic work.

## Main Conclusions

Type-preserving routed writes currently do not allocate new objects in the hot
loop. That is a narrow statement: it does **not** mean the context is stack
allocated or scalar-replaced. With mutable `SubContext`, the context already
contains heap-backed subcontext objects, and the hot loop mutates fields inside
those objects.

Mutable `SubContext` does allocate at context creation/reset. That is the main
cost paid by the mutable approach: each subcontext is a heap object, so reset and
construction allocate even for tiny scalar subcontexts.

The remaining tiny-scalar performance problem is exactly the SROA/stack-local
problem. An ad hoc two-algorithm scalar replace probe performs no fresh
allocation in the loop, but is still about `6.5x` slower than an equivalent
plain scalar loop at 100k steps. That means "allocation-free" is insufficient:
the scalar values are not behaving like compiler-promoted local variables.
Pointer indirection through heap-backed subcontexts plus view/step/context
machinery dominates when each algorithm only updates a couple of scalar fields.

The checked-in Fib/Luc list-push benchmark is different. It is still close to
the naive loop in the current run, around `1.05x` to `1.11x` depending on
sample. That benchmark is dominated by vector mutation/push work and does not
isolate the tiny scalar replace/SROA case.

## Chronology

### Route-Heavy Benchmark

Added `inline_route_heavy_benchmark.jl` with:

- five real `ProcessAlgorithm`s
- route-heavy dependencies between those algorithms
- a semantic plain scalar loop baseline
- correctness checks against the plain loop
- end-to-end timing from `run(process)` to completion
- reset between samples, with reset excluded from the timed expression

Initial route-heavy measurements were roughly `1.9x` to `2x` slower than the
plain scalar loop.

### Breakdown Diagnostic

Added `inline_route_heavy_breakdown.jl` to isolate layers:

- `run(process)`
- direct `Processes.loop(...)`
- generated process-loop entrypoint
- direct manual `ProcessContext` loop using `merge_into_subcontexts`
- diagnostic-only batched context loop
- direct `_step!` plan loop

The key observation was that the manual context loop was still near the routed
runtime cost, while the batched context loop was near plain-loop speed. The
batched loop is not generally valid, because later algorithms in the same loop
must see earlier context mutations, but it isolated the cost to repeated
per-child context writeback.

### Type Stability

Added `inline_route_type_stability.jl`.

`run(process)` was initially type-unstable because the keyword arguments
`context` and `lifetime` were reassigned after starting as `nothing`. That made
the public run return type infer as `Any`.

The fix in `src/InlineProcess.jl` binds separate locals:

- `run_context`
- `run_lifetime`

Current inference diagnostic:

```text
public_run_inferred=true
direct_loop_inferred=true
generated_processloop_inferred=true
direct_plan_inferred=true
```

## Merge Writeback Investigation

The `merge_into_subcontexts` hot path was not heap-allocating, but the immutable
subcontext implementation still caused aggregate copying. LLVM showed repeated
copies of the full `subcontexts` aggregate when rebuilding one field.

Two changes were made in `src/Context/ProcessContexts.jl`:

- `merge_into_subcontext_rebuild` now binds `old_subcontexts = get_subcontexts(pc)`
  once before reading unchanged fields.
- Type-preserving `merge_into_subcontext_mutate` now mutates only the target
  subcontext's `data` field.

`SubContext` was changed from immutable to mutable in
`src/Context/StructDefs.jl`, and `newdata` now uses `setfield!`.

Important tradeoff: this removes aggregate rebuild traffic for type-preserving
stable writes, but subcontexts are now heap-backed objects rather than inline
isbits fields inside the context named tuple. Therefore this cannot preserve the
old tiny-scalar SROA behavior by construction.

## Allocation Results

Measured allocation facts after the mutable `SubContext` change and the
`_strip_runtime_inputs` shortcut:

Route-heavy component probe:

```text
merge_inputs_b = 0
before_b = 0
cleanup_b = 0
strip_b = 0
store_b = 0
unstable_step_b = 0
stable_step_b = 0
after_b = 0
```

Route-heavy benchmark, current sample:

```text
inline_route_heavy_steps=20000
inline_route_heavy_runs=20
inline_route_run_seconds_per_run=0.001611185
plain_loop_seconds_per_run=0.001551658
seconds_ratio=1.038
inline_route_run_bytes_per_run=0.0
plain_loop_bytes_per_run=10.4
```

Before the `_strip_runtime_inputs` shortcut, `run(process)` and direct loop
entrypoints still allocated about `240` bytes/run. Component probing showed all
of that came from `_strip_runtime_inputs(runtime_context, stored_context)`
rebuilding a fresh `ProcessContext` during `after_while`.

The shortcut now returns the existing runtime context when runtime globals,
runtime inputs, and legacy `:_input` storage are already unchanged. The previous
rebuild expression is left commented beside the new branch so it is easy to
restore for comparison.

Reset/construction allocation remains. Examples observed:

- tiny two-algorithm scalar reset: about `144` bytes
- scalar Fib/Luc reset: about `176` bytes
- route-heavy reset: about `496` bytes

This is expected with mutable subcontexts: reset creates fresh `SubContext`
objects.

## Checked-In Fib/Luc Benchmark

`test/InlineBenchmarkTest.jl` currently reports the inline Fib/Luc list-push
benchmark close to the naive list-push loop:

```text
InlineProcess time: 0.000427917 s
NoGen time:        0.000426209 s
Naive time:        0.000405166 s
Inline/Naive:      105.62 %
NoGen/Naive:       105.19 %
```

Separate direct runs also sampled around `109 %` to `112 %` of naive. This
benchmark therefore does not show the severe scalar-regression behavior.

## Ad Hoc Tiny Scalar Replace Probe

A focused scalar replace probe used two tiny process algorithms:

- `ScalarFib`: `(; prev::Int64, curr::Int64)`
- `ScalarLuc`: `(; prev::Int64, curr::Int64)`

Each step replaces two scalar fields in each subcontext. This is the tiny SROA
case; unlike the checked-in Fib/Luc list-push benchmark, there is almost no real
work to hide context access/writeback overhead.

Current result at `100_000` steps:

```text
reset_b = 176
merge_b = 0
stable_step_b = 0
strip_b = 0
after_b = 0
run_b = 0
plan_b = 0
run_t = 0.000202583
plan_t = 0.000202583
plain_t = 0.000030958
run_ratio = 6.544
plan_ratio = 6.544
```

Interpretation:

- There is no heap allocation in the hot scalar replace loop.
- Public `run` adds no measurable allocation after the strip shortcut.
- Direct plan timing equals public run timing, so the entrypoint wrapper is not
  the issue in this tiny case.
- The plain scalar loop is much faster, so the remaining problem is CPU overhead
  from the context/process abstraction itself.

This means mutable subcontexts are not causing fresh per-step heap allocation,
but they also cannot give the old "fully stack/SROA everything" behavior for
tiny scalar contexts, because the subcontext object itself is a heap object. For
this benchmark, the relevant regression is not allocation count; it is the loss
of scalar replacement and the extra pointer/load/store path.

## Process Loop Entrypoint

The generated process-loop entrypoint was tested in the breakdown diagnostic.
It is type-stable and allocation-free, but it did not materially change the
overall route-heavy story. In the route-heavy case, generated/direct/public
loop timings are close enough that the dominant cost is the child context
access/writeback path, not the public `run` wrapper.

Breakdown timings are noisy when run concurrently with other Julia processes,
so the stable facts to carry forward are:

- generated process loop is inferred
- generated process loop is allocation-free
- generated process loop is not a fix for the tiny scalar overhead

## Current Risk

The mutable `SubContext` fix is good for medium route-heavy scalar work because
it removes repeated aggregate rebuild traffic. It is risky for very small
scalar-only algorithms. Those now avoid fresh hot-loop allocations, but the
heap-backed subcontext representation and abstraction overhead can dominate the
actual work. The scalar Fib/Luc probe confirms this risk.

If a workload creates/resets processes frequently, mutable subcontexts can be
worse because reset/construction allocate one object per subcontext. If a
workload reuses a process for many loop steps, that allocation is amortized and
the hot loop remains allocation-free.

## Immutable Rebuild Trial

I also tested switching `SubContext` back to immutable while keeping the
`old_subcontexts = get_subcontexts(pc)` binding and rebuilding/replacing the
full `subcontexts` named tuple on type-preserving writes.

That does not recover the scalar behavior either:

```text
route-heavy seconds_ratio = 1.461
scalar replace run_ratio = 16.012
scalar replace plan_ratio = 16.010
```

So the simple immutable rebuild path is worse for both targets in the current
code. The original near-naive Fib/Luc behavior must have come from a different
fast path/shape than "immutable subcontext plus full named-tuple rebuild on each
write".

## Open Performance Question

The next target is not heap allocation. The next target is lowering CPU overhead
for tiny scalar subcontexts while preserving the requirement that later
algorithms in the same iteration see earlier context mutations.

Possible directions to test:

- a generated scalar-local loop for fully static inline processes, where
  context fields are cached into locals and written back after each child as
  needed
- a hybrid context representation that keeps immutable/isbits subcontexts for
  small type-preserving scalar writes and uses mutable cells only where aggregate
  copying is more expensive
- a specialized stable writeback path that avoids `SubContextView`/generic
  context access for simple local replacements

The batched-context loop remains only a diagnostic lower bound. It cannot be the
general implementation because it hides mutations from later algorithms in the
same loop iteration.
