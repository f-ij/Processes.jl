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
