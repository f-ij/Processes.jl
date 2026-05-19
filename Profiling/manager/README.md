# ProcessManager Profiling

Run these scripts from the repository root with:

```powershell
julia --project=. Profiling/manager/manager_overhead.jl
julia --project=. Profiling/manager/process_churn.jl
julia --project=. Profiling/manager/process_churn.jl 1000 inline
julia --project=. Profiling/manager/process_churn.jl 1000 inline jet
```

`manager_overhead.jl` isolates scheduler overhead with a synchronous fake
worker. It is useful for checking type stability, allocations, and slot-search
costs without including `Process` task creation.

`process_churn.jl` uses a real `Process` worker and reports the per-job
allocation cost of the default manager `Process` protocol. That path includes
task creation, wait/fetch/close, runtime context merging, and cleanup.

Passing `inline` as the second argument switches the recipe to
`runprocessinline!`, which runs the `Process` loop synchronously and avoids
per-job task creation when manager-level concurrency is not needed.

Passing `jet` as the last argument adds `JET.@report_opt` checks. Keep it off
for timing runs because it can add compilation noise to short benchmarks.
