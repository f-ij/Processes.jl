# Compile Optimization Notes

Potential next targets, in the order they should be investigated:

1. Run a SnoopCompile pass on the compile benchmark.
   Use a call tree before changing more generated code. The current benchmark
   separates algorithm construction, `resolve`, lifecycle `init`,
   `Process` construction, first run, and warmed runs, but it does
   not show which callees dominate inference time.

2. Reduce generated merge expression size.
   `stablemerge`, `unstablemerge`, `merge_into_subcontexts`, and
   `merge_into_subcontext_*` are likely compile-heavy because they specialize on
   exact context and returned named tuple types. Keep the final setter fast, but
   try to move planning and error construction into smaller helpers. The first
   SnoopCompile pass also points at `get_all_locations` and
   `SubContextView` `getproperty`, so any merge work should include those view
   lookup paths.

3. Check first-step and steady-step duplication.
   Repeat loops compile an unstable first step and a stable steady loop. For
   algorithms whose context type cannot grow, there may be a way to skip or
   shrink the unstable generated path.

4. Isolate context init merge cost.
   Lifecycle `init` now resolves `Init`/`Override` specs and stores them on the
   initialized loop algorithm. The remaining cost is probably applying named
   specs through generated context merge/init code. Benchmark `init(la)` with
   and without specs separately.

5. Cache resolved algorithm metadata by concrete loop algorithm type.
   Registry setup, flat funcs/states/multipliers, and share/route resolution are
   mostly type-structural. This must account for mutable algorithm instances and
   options that are value-dependent.

6. Expand background precompile from constructed values.
   On `Process` or initialized loop algorithm construction, schedule precompile
   work from `typeof(algo)`, `typeof(context)`, and `typeof(lifetime)`.
   Likely targets are `initcontext`, `loop`, first `step!`, and common merge
   calls. Measure this separately from normal workload inference because
   background precompile tasks showed up in the first SnoopCompile pass.

7. Benchmark `copyprocess` and context copy cost separately.
   Learning workloads copy template contexts often. Measure whether
   `deepcopy(context)` or fresh structural init is more expensive for realistic
   contexts.

8. Consider typed process contexts.
   `Process.context::AbstractContext` is flexible but may create inference
   barriers. A typed process variant would be invasive and should only be tried
   after profiling confirms the barrier matters.

9. Keep empty tuple paths specialized.
   Empty inputs, overrides, options, shares, and routes are common and should
   avoid generic filtering/merging.

10. Keep the compile benchmark suite current.
    Report package load separately from stage timings, and keep cold and warm
    stage measurements separate.
