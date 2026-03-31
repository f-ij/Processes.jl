# [Contexts and Indexing](@id contexts_user)

## What You Receive in `init`/`step!`/`cleanup`

Entity methods receive a `SubContextView`, not the raw `ProcessContext`.

That view exposes:

- local subcontext variables,
- routed/shared variables,
- globals via `getglobals(context)`.

## Reading Variables

```julia
function Processes.step!(::MyAlgo, context)
    (; state, dt) = context
    # ...
    return (;)
end
```

`context.name` and destructuring both map to generated view lookups.

## Writing Variables

Return a `NamedTuple` from `step!`/`init`/`cleanup`.

- Existing names update mapped targets.
- New names are added to local subcontext.
- Type changes are rejected at merge time for stability.

## Top-Level Context Access

From a process:

```julia
ctx = getcontext(p)
```

From a context, index by:

- symbol key: `ctx[:Fib_1]`
- registered value/type: `ctx[Fib]`, `ctx[Fib()]`, `ctx[my_unique_fib]`

This behavior comes from `ProcessContext.getindex(pc, obj)` resolving through the registry key.

Related symbol-based lookup also works on resolved loop algorithms and registries:

```julia
resolved = resolve(CompositeAlgorithm(Fib, Noise, (1, 2)))
reg = getregistry(resolved)

resolved[:Fib_1]   # same object as resolved.Fib_1
reg[:Fib_1]        # registered IdentifiableAlgo
ctx[:Fib_1]        # subcontext
```

Use loop-algorithm indexing when you want the registered algorithm/state object, and
context indexing when you want its current subcontext data.

## Re-Initializing One Subcontext

You can re-run `init` for one registered algorithm inside an existing context:

```julia
ctx = initcontext(resolved)

ctx = initcontext(ctx, :Fib_1)
ctx = initcontext(ctx, :Fib_1; inputs = (; seed = 123))
ctx = initcontext(ctx, resolved[:Fib_1]; overrides = (; value = 0.0))
```

This updates only the targeted subcontext.

- `inputs` are merged into that subcontext before `init(...)` runs.
- `overrides` are merged into that subcontext after `init(...)` returns.

## Globals

`ProcessContext` includes a `globals` field.

Common globals used internally:

- `lifetime`
- `algo`
- `process` (in runtime loop context)

Use `getglobals(context)` inside entity methods when you need them.

You can also select globals with `Var(:name)` in APIs like `Processes.Until(...)`.
See [Vars (`Var` Selectors)](@ref vars_user).
