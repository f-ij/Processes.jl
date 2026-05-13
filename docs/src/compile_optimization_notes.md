# Compile Optimization Notes

Potential next targets:

1. Reuse constructor metadata when resolving inputs.
   `resolve_process_inputs_overrides` can build a `ProcessContext` only to get a registry, then `TaskData` builds the real empty context again. Reuse the first registry/context when inputs or overrides are present.

2. Cache resolved algorithm metadata by concrete loop algorithm type.
   Registry setup, flat funcs/states/multipliers, and share/route resolution are mostly type-structural.

3. Keep `setfield` generation small.
   Avoid building large debug strings or helper expressions during normal generated-function expansion.

4. Reduce generated merge expression size.
   Split merge planning from merge execution so exact return payloads specialize smaller wrappers.

5. Precompile constructor paths.
   From a concrete algorithm type, precompile likely `TaskData`, `initcontext`, `Process`, `copyprocess`, and `makecontext!` calls.

6. Benchmark `copyprocess` and context copy cost separately.
   Learning workloads copy template contexts often; `deepcopy(context)` may be more expensive than a structural clone/init path.

7. Consider typed process contexts.
   `Process.context::AbstractContext` is flexible but may create inference barriers. A typed process variant would be more invasive.

8. Move debug-only work behind debug guards.
   Search constructor/setup paths for eager string interpolation or rendering.

9. Specialize empty tuple paths broadly.
   Empty inputs, overrides, options, shares, and routes are common and should avoid generic filtering/merging.

10. Keep a compile benchmark suite.
    Report package load, algorithm construction, input resolution, `TaskData`, `initcontext`, `Process`, first run, and warmed run separately.
