# Dagger Microbench Results

Date: 2026-03-23

Command:

```bash
julia --project 'manual tests/DaggerMicrobench.jl'
```

Method:
- standalone benchmark, outside the `Processes` Dagger backend
- plain `Threads.@spawn` vs plain `Dagger.@spawn`
- parent results are passed directly into child tasks
- task-local state is represented as plain `NamedTuple` bases plus plain `NamedTuple` deltas
- hot functions were explicitly specialized with `where` parameters
- medians from `BenchmarkTools`, `samples = 8`, `evals = 1`

## Vector DAG

Graph shape:
- two roots
- multiple joins
- reused intermediates
- vector-valued deltas

Results:
- Sequential median: `0.023861 s`
- Threads median: `0.012539 s`
- Dagger median: `0.014814 s`
- Threads / Sequential: `0.526x`
- Dagger / Sequential: `0.621x`
- Dagger / Threads: `1.181x`
- Threads bytes: `4976`
- Dagger bytes: `654896`

Coarse Dagger variant:
- Dagger median: `0.017184 s`
- Dagger / Sequential: `0.720x`
- Dagger / Threads: `1.370x`
- Dagger bytes: `164080`

## Scalar-heavy DAG

Graph shape:
- same dependency graph
- compute-heavy scalar deltas

Results:
- Sequential median: `0.058985 s`
- Threads median: `0.039178 s`
- Dagger median: `0.041226 s`
- Threads / Sequential: `0.664x`
- Dagger / Sequential: `0.699x`
- Dagger / Threads: `1.052x`
- Threads bytes: `4144`
- Dagger bytes: `609488`

Coarse Dagger variant:
- Dagger median: `0.046235 s`
- Dagger / Sequential: `0.784x`
- Dagger / Threads: `1.180x`
- Dagger bytes: `155712`

## Takeaway

- Explicit specialization changed the standalone results materially, especially on the vector DAG.
- With specialization in place, the pure Dagger graph concept is not showing the catastrophic slowdowns seen in the package experiments.
- On the standalone graph, fine-grained Dagger is about `5%` slower than Threads for the scalar-heavy case and about `18%` slower for the vector DAG.
- A coarser Dagger graph reduced allocations substantially but made runtime worse in both standalone cases.
- That still strongly suggests the `Processes` Dagger lowering/runtime is the main source of the large regressions, not the basic “spawn a DAG of dependent Dagger tasks” idea by itself.
