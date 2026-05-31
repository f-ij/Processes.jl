# 3D Graph LLVM Findings

These notes compare the optimized LLVM dumps for the `InteractiveIsing.jl/examples/3D Graph.jl` workload:

- `diagnostics/llvm/3d_graph_latest_nongenerated.ll`
- `diagnostics/llvm/3d_graph_latest_generated.ll`
- `diagnostics/llvm/3d_graph_latest_runtimegenerated.ll`

The current branch state shows `Generated()` and `RuntimeGenerated()` compiling to the same optimized shape for this workload. The remaining performance gap is between the new OnDemand/backmerge aggregate shape and the old `NonGenerated()` whole-context shape.

## High Level

`Generated()` and `RuntimeGenerated()` have identical line counts and identical coarse instruction-pattern counts after LLVM optimization:

| path | lines | call | br | load | store | alloca | memcpy |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `NonGenerated()` | 1491 | 136 | 73 | 219 | 231 | 53 | 56 |
| `Generated()` | 1208 | 113 | 45 | 187 | 206 | 38 | 65 |
| `RuntimeGenerated()` | 1208 | 113 | 45 | 187 | 206 | 38 | 65 |

This strongly suggests that the RuntimeGeneratedFunctions wrapper is not the hot runtime cost here. LLVM has inlined/erased that boundary enough that `Generated()` and `RuntimeGenerated()` end up with the same aggregate behavior.

`NonGenerated()` has more code and roughly two copies of the Metropolis body because it performs a pre-step plus the loop body. Even with more arithmetic and calls, it can still be faster, so the important difference is not raw instruction count. The likely difference is how the loop-carried context/subcontext aggregate is shaped for SROA and copying.

## Copy Shape

The clearest difference is the memcpy size distribution.

`NonGenerated()`:

| size | count |
| ---: | ---: |
| 7 | 14 |
| 16 | 11 |
| 24 | 4 |
| 56 | 5 |
| 80 | 5 |
| 88 | 2 |
| 96 | 7 |
| 104 | 8 |

`Generated()` and `RuntimeGenerated()`:

| size | count |
| ---: | ---: |
| 7 | 14 |
| 16 | 5 |
| 24 | 4 |
| 32 | 18 |
| 56 | 3 |
| 64 | 9 |
| 80 | 1 |
| 88 | 1 |
| 96 | 9 |
| 112 | 1 |

The generated paths split the carried state into many 32- and 64-byte chunks. The old `NonGenerated()` path keeps more 80-, 96-, and 104-byte chunks. That points at a different SROA partition, not a missing inline on the step function itself.

## Hot Loop Evidence

In `Generated()`, the loop body starts around `L59` in `3d_graph_latest_generated.ll`. The backmerge/loop-carried region copies reconstructed `new::SubContext` and `new::NamedTuple` pieces back into the loop-carried slots:

- `new::SubContext.sroa.0.sroa.0` copied as 96 bytes.
- `new::NamedTuple.sroa.0.sroa.5` copied as 32 bytes.
- `new::NamedTuple.sroa.0.sroa.5.144.sroa_idx` copied as 64 bytes.
- `new::NamedTuple.sroa.0.sroa.5.208.sroa_idx` copied as 32 bytes.

Those repeated copies appear around the generated loop backedge and are mirrored in `RuntimeGenerated()`. This is consistent with `backmerge_subcontext_by_wiring(...)=merge(subcontext, patch)` creating a fresh NamedTuple/SubContext reconstruction shape that LLVM then has to partition and copy.

`NonGenerated()` keeps the old whole-context path. It uses `SubContextView` / context merge semantics and carries a coarser `ProcessContext`-derived aggregate through the loop. The emitted code has more total operations, but the aggregate copy pattern is less fragmented in the hot state update.

## What This Means

The current evidence does not support chasing `RuntimeGeneratedFunction` as the runtime problem. For this workload, `Generated()` and `RuntimeGenerated()` are effectively the same after optimization.

The runtime gap is more likely from the generated backmerge shape:

- `OnDemandContext` itself is thin enough and does not obviously survive as a runtime object in the hot path.
- Symbol/Val property access is not showing up as a direct dynamic dispatch problem in optimized LLVM.
- The problem area is the creation and merge-back of returned variables into the subcontext aggregate.

## Likely Nudge

The next reasonable nudge is a Generated-only no-widening backmerge path for stable subcontexts:

1. Detect at generation time that every returned subcontext field already exists in the current subcontext data type.
2. Reconstruct the subcontext data directly with only the actually written variables replaced.
3. Avoid the generic `merge(subcontext, patch)` shape for that stable case.
4. Error or route away from this path for widening, since widening is meant to be disallowed for `Generated()`.

The earlier direct reconstruction attempt broke a widening-like precompile/FuncWrapper case because it tried to read fields that did not exist in the current subcontext. So this should not be added as an unconditional replacement for `merge`. It needs either a strict no-widen guard or a generated error for unsupported widening cases.

## Current Conclusion

To move `Generated()` toward the old `NonGenerated()` runtime performance, the target is the backmerge/SROA shape, not the RuntimeGenerated entrypoint. The generated path needs to make LLVM see one stable subcontext aggregate with direct field replacement, instead of a patch-merge that fragments the carried state into many small `NamedTuple` pieces.

## Follow-Up Implementation Check

I implemented a narrow Generated-only stable backmerge in `OnDemandContext.jl`: when a child return only writes fields that already exist in the active subcontext and the field types match exactly, `backmerge_subcontext_by_wiring` now rebuilds the subcontext data directly with `withdata` instead of calling generic `merge(subcontext, patch)`. Widening or type-changing cases keep the previous merge fallback for now so existing package paths keep compiling.

Correctness/perf diagnostics after that change:

- `diagnostics/inline_scalar_dependency_probe.jl`: still 0 allocations, still at plain-loop parity.
- `test/RuntimeInputsLifecycleTest.jl`: 95/95 passing.
- `test/CompositeDSLTest.jl`: 165/165 passing.

For the 3D Graph optimized LLVM, this direct stable backmerge did not change the emitted hot-loop shape. The generated path still has the same line count and memcpy distribution as before. That means LLVM was already lowering the old `merge(subcontext, patch)` into the same direct reconstruction for this concrete Metropolis case.

I also tested carrying a `subcontexts` aggregate through the Generated loop while still exposing top-level subcontext names to child blocks. That also optimized to the same LLVM shape, so I reverted that experiment rather than keeping a source-level change with no codegen effect.

So the remaining gap is not fixed by replacing the local patch merge alone. The next likely experiment would need to be more structural, probably making the Generated path deliberately preserve a whole-context or whole-subcontexts aggregate shape closer to `NonGenerated()`. That should be discussed before changing because it pushes against the current design constraint that the generated loop body should avoid a full `context` inside the loop.

## GeneratedOld Check

I added and dumped the old full-context generated path as `GeneratedOld()`:

- `diagnostics/llvm/3d_graph_generatedold.ll`
- `diagnostics/llvm/3d_graph_generatedold_after_plan.ll`
- `diagnostics/llvm/3d_graph_generatedold_after_runtime_interval.ll`
- `diagnostics/llvm/3d_graph_generatedold_nongenerated_ref.ll`

The first two attempted source nudges did not change optimized LLVM for this workload:

- Bind `step_plan = getplan(algo)` in the generated loop and expand `step!_expr_old` from the plan type instead of the root `LoopAlgorithm` type.
- Make the old composite expression load `algos` and `interval(plan, i)` from the plan value, matching `NonGenerated()` instead of embedding interval values from type data.

The optimized counts stayed identical for `GeneratedOld()` after both changes:

| path | lines | call | br | load | store | getelementptr | alloca | memcpy |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `GeneratedOld()` | 1574 | 153 | 73 | 174 | 249 | 364 | 49 | 78 |
| `NonGenerated()` reference | 1491 | 125 | 73 | 171 | 231 | 338 | 43 | 56 |

The arithmetic/control-flow shape is basically the same as `NonGenerated()` for this case, but the aggregate state is worse:

`GeneratedOld()`:

| size | count |
| ---: | ---: |
| 7 | 18 |
| 16 | 6 |
| 24 | 4 |
| 32 | 18 |
| 56 | 8 |
| 64 | 9 |
| 80 | 2 |
| 88 | 2 |
| 96 | 9 |
| 112 | 2 |

`NonGenerated()` reference:

| size | count |
| ---: | ---: |
| 7 | 14 |
| 16 | 11 |
| 24 | 4 |
| 56 | 5 |
| 80 | 5 |
| 88 | 2 |
| 96 | 7 |
| 104 | 8 |

The main SROA difference is that `GeneratedOld()` splits the context/subcontext tail into separate 32-, 64-, and 32-byte pieces:

- `new::NamedTuple.sroa.0.sroa.5`
- `new::NamedTuple.sroa.0.sroa.5.144.sroa_idx`
- `new::NamedTuple.sroa.0.sroa.5.208.sroa_idx`
- matching loop-carried copies such as `%.sroa.0.sroa.11`, `%.sroa.0.sroa.12`, and `%.sroa.0.sroa.13`

The `NonGenerated()` reference keeps the analogous region coalesced as a 16-byte piece plus a 104-byte piece:

- `new::NamedTuple.sroa.0.sroa.5.8..sroa_idx`
- `new::NamedTuple.sroa.5.128..sroa_idx`
- matching loop-carried copies such as `%.sroa.0775.sroa.0.sroa.11` and `%.sroa.0775.sroa.12.sroa.0`

So `GeneratedOld()` is not recovering the old merge quality just by using the whole-context `_step!` calls inside a fully generated loop. The likely reason is the fully spliced generated block changes LLVM's SROA partitioning compared with the separate generated `_step!` function boundary used by `NonGenerated()`. A more aggressive experiment would be to make `GeneratedOld()` call the plan `_step!` function directly from the generated loop, but that is structurally much closer to `NonGenerated()` than to the revived old fully-expanded generated path, so I did not make that change without discussion.

## GeneratedOld Global-Context Block Merge

I then changed `GeneratedOld()` to avoid concrete child `_step!` calls. The path now expands child blocks directly, builds an `OnDemandContext` for the leaf, calls the public `step!(algo, context)` extension point, and merges the child return into one loop-level `context` variable.

Two merge forms were tested:

- `3d_graph_generatedold_global_context.ll`: merge the returned child patch through the existing context merge helpers.
- `3d_graph_generatedold_global_context_direct.ll`: merge by directly rebuilding updated `SubContext` values and calling `withsubcontexts` once, with no widening or type-changing writes allowed.

Both optimized to the same LLVM for this workload:

| path | lines | call | br | load | store | getelementptr | alloca | memcpy |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| previous `GeneratedOld()` | 1574 | 153 | 73 | 174 | 249 | 364 | 49 | 78 |
| global-context block merge | 3367 | 345 | 115 | 275 | 927 | 924 | 55 | 154 |
| `NonGenerated()` reference | 1491 | 125 | 73 | 171 | 231 | 338 | 43 | 56 |

The global-context block form is therefore much worse for this case. It keeps the semantic shape requested for the experiment, but LLVM does not turn it into the old `NonGenerated()` merge shape. Instead, the repeated context rebuild inside the fully expanded block creates substantially more aggregate traffic:

| size | count |
| ---: | ---: |
| 7 | 19 |
| 16 | 34 |
| 24 | 32 |
| 32 | 20 |
| 40 | 14 |
| 56 | 9 |
| 64 | 10 |
| 80 | 2 |
| 88 | 2 |
| 96 | 10 |
| 112 | 2 |

So the global-context block-write idea did not nudge the generated code toward `NonGenerated()`. It suggests that simply preserving a single source-level `context` name is not enough; in the fully expanded generated loop, each merge still materializes as a large context reconstruction site before LLVM can coalesce it.

## RuntimeGenerated Full-Context Check

I overwrote `RuntimeGenerated()` to keep the runtime-generated function
boundaries, but changed the generated step contract:

- The generated function signature passes the plan or child, the full
  `ProcessContext`, process, and lifetime.
- Child wiring and namespaces are embedded in the generated function body.
- Concrete children use the old `SubContextView` machinery through `_step!`.
- The loop no longer extracts top-level subcontexts or carries patch-returning
  steps.
- The root step is owned by the resolved `algo` and is called as
  `generated_callfunc(step, algo, context, process, lifetime)`. The generated
  function gets its plan from the algo.

For 3D Graph, this did not recover the old `NonGenerated()` shape:

| path | lines | call | br | load | store | getelementptr | alloca | memcpy |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `NonGenerated()` reference | 1491 | 125 | 73 | 171 | 231 | 338 | 43 | 56 |
| `RuntimeGenerated()` | 1208 | 107 | 45 | 151 | 206 | 338 | 33 | 65 |
| full-context `RuntimeGenerated()` | 1217 | 112 | 45 | 151 | 206 | 341 | 34 | 70 |

Memcpy sizes for full-context `RuntimeGenerated()`:

| size | count |
| ---: | ---: |
| 7 | 14 |
| 16 | 5 |
| 24 | 4 |
| 32 | 18 |
| 56 | 8 |
| 64 | 9 |
| 80 | 1 |
| 88 | 1 |
| 96 | 9 |
| 112 | 1 |

This is much closer to the patch/subcontext `RuntimeGenerated()` than to
`NonGenerated()`. The old view machinery and full-context function signature are
not enough by themselves; the function boundary still does not produce the
`NonGenerated()` coalesced `104`-byte merge chunks for this case.
