# Looptype Codegen Findings (immutable_fix_manual)

Date: 2026-06-01

Goal: explain why `NonGenerated()` "blows up" codegen on the real workload while
being the fastest at runtime, and whether `RuntimeGenerated()` can match its
runtime without the compile blowup.

All numbers below were measured on this branch with a synthetic, parameterizable
workload (`diagnostics/scaling_probe*.jl`): a flat composite of `N` scalar
`ProcessAlgorithm`s, each owning a 4×`Float64` subcontext, chained by routes.
This reproduces the two phenomena in isolation. Probe scripts:

- `diagnostics/scaling_probe.jl` — compile + hot time vs `N`, both looptypes.
- `diagnostics/llvm_loop_probe.jl` / inline call audit — LLVM shape of the loop.
- `diagnostics/looptype_compile_probe.jl` — flat 5-algo route-heavy case.

## The two effects are two ends of ONE dial: inline depth

The leaf merge path is identical for both looptypes. Both `NonGenerated()` and
`RuntimeGenerated()` reach the exact same code:

```
view(context, algo, namespace) -> step!(algo, view) -> merge(view, retval)
  -> stablemerge -> merge_into_subcontexts -> merge_into_subcontext_(rebuild|mutate)
```

So the divergence is NOT the merge. The only structural difference is:

- `NonGenerated()`: composite/routine `_step!` is `@inline @generated`, so the
  whole plan tree + every leaf view/merge is spliced into ONE method (the loop /
  `runprocessinline!`). One giant function for LLVM to optimize.
- `RuntimeGenerated()`: each child is a `@RuntimeGeneratedFunction`. Children are
  still inlined into the root step, but they are independently inferred/compiled
  and cached first, so the monolithic-inference cost is avoided.

## Compile time (the real pain)

| N  | NonGen compile | RTGen compile | ratio |
|----|---------------:|--------------:|------:|
| 2  | 0.205 s | 0.036 s | 5.7× |
| 4  | 0.226 s | 0.058 s | 3.9× |
| 8  | 0.499 s | 0.147 s | 3.4× |
| 16 | 1.136 s | 0.439 s | 2.6× |
| 24 | 1.664 s | 0.807 s | 2.1× |

`NonGenerated()` is 2–6× slower to compile here, and grows superlinearly on the
real nested workload (routines + `@repeat` + InlineProcess specialization),
which is what produces the ~20-minute first-call latency on `main`.
`RuntimeGenerated()` does not have a monolithic-inference step, so it does not
blow up the same way.

## Runtime (the residual gap)

| N  | NonGen hot | RTGen hot | ratio |
|----|-----------:|----------:|------:|
| 8  | ~14 µs/loop | ~16 µs | 1.17 |
| 16 | ~23 µs | ~25 µs | 1.08 |
| 24 | ~34 µs | ~39 µs | 1.14 |

`RuntimeGenerated()` is ~7–17% slower on these micro workloads (where the fixed
per-step overhead dominates; the relative gap shrinks as per-step user work
grows).

## Root cause of the runtime gap: a partial-SROA blob (NOT a missing inline)

In the *real* `loop`, BOTH looptypes fully inline — `code_llvm` shows zero
out-of-line `RuntimeGeneratedFunction` calls and near-identical line counts
(N=16: NonGen 1797 vs RTGen 1836). So "everything is inlined" is already true.

The difference is **SROA**, visible in the loop's memcpy distribution (N=16):

```
NonGenerated     : 0 memcpys   (loop-carried ProcessContext fully scalar-replaced)
RuntimeGenerated : 2 × 656 B memcpy
```

The RTGen IR scalar-replaces the context field-by-field up to byte offset 640,
then **bails on a ~656-byte tail sub-aggregate** and carries it as an opaque
blob — copied once on the loop backedge and once into the return slot. The
`@RuntimeGeneratedFunction` return boundary introduces a return-slot
materialization (`sret_return` + `llvm.lifetime` alloca) that LLVM's SROA
promotes only partially, where the equivalent plain inlined generated `_step!`
in `NonGenerated()` promotes it fully.

## Cross-path memcpy on the CURRENT branch (correcting the RGF-only framing)

Measured `loop` memcpy for all three looptypes on this branch (not the old
3d_graph dumps):

| workload | NonGenerated | Generated | RuntimeGenerated |
|----------|-------------:|----------:|-----------------:|
| scalar N=16 (no arrays) | 0 | 0 | 2 × 656 B |
| scalar partial-update | 0 | 0 | 2 × 176 B |
| route-heavy (with Vectors) | 0 | 2 × 16 B | 2×16 B + 2×248 B |

On the current branch, `Generated()` is essentially as clean as
`NonGenerated()`; `RuntimeGenerated()` is the one that materializes a context
blob. This DIFFERS from the older `3d_graph_llvm_findings.md` (where Generated
and RuntimeGenerated were identical) — the recent "SROA friendly"/"better
merge"/"Generated path" commits appear to have cleaned up `Generated()` but not
`RuntimeGenerated()`.

Both clean paths (`NonGenerated`, `Generated`) are **monolithic**: the whole
plan tree is spliced into one method, so they keep the context as one SSA
aggregate (clean memcpy) but pay the compile blowup. `RuntimeGenerated()` splits
each child into a `@RuntimeGeneratedFunction`; its call path
(`(f)(args...) -> generated_callfunc(f, __args...)`, body does
`ctx = @inbounds __args[i]`) routes the context through a Vararg tuple / return
slot that LLVM SROA only partially promotes — hence the 2 blob copies (hoisted
to loop entry/exit, so the per-step cost is small but nonzero).

## The fundamental tension

- **Clean memcpy (NonGenerated runtime)** requires the loop-carried context to
  stay inside ONE method — no function boundary on its dataflow path.
- **Bounded compile (no blowup)** requires function boundaries that split the
  plan tree into independently-compiled methods.

These are the same lever. You cannot have a zero-boundary hot path AND bounded
per-method compile for the same monolithic context. The practical sweet spot is
to put boundaries where they're cheapest.

## Proposed fix (not yet implemented)

Use `NonGenerated()`'s typed `@generated _step!` recursion (clean, no Vararg,
no RGF) but drop `@inline` on the **composite/routine** `_step!` only (keep
leaves and the root inlined). Then:

- each composite/routine becomes its own bounded compiled method → kills the
  monolithic-inference blowup that makes the real nested workload take ~20 min;
- the root + leaves inside each composite stay inlined → the context stays an
  SSA aggregate within each method (clean merges), with a context-passing
  boundary only at intermediate composite calls (amortized over the leaves
  inside that composite).

This is strictly better than `RuntimeGenerated()` for runtime (no Vararg
materialization) and avoids `NonGenerated()`'s monolithic blowup. It needs a
nested-plan benchmark to validate the compile-vs-runtime trade.

## Conclusions / recommendation

1. `RuntimeGenerated()` (the current `sys_looptype` on this branch) is the right
   default: it removes the compile blowup and is already within ~10% of
   `NonGenerated()` runtime — and the inline hint is already satisfied.
2. The remaining gap is one partially-SROA'd ~656 B sub-aggregate at the RGF
   return boundary, not a missing inline and not the merge path.
3. Next lever to close it: make the RGF root/child step return path avoid the
   return-slot materialization that defeats full SROA (e.g. shrink/avoid the
   opaque tail, or change the step return contract so LLVM SROA sees the same
   SSA dataflow the inlined `_step!` gets). This is an LLVM-SROA tuning problem
   that needs iteration; it does NOT require reviving full-tree inlining (which
   would bring back the blowup).
