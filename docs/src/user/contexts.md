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

## Globals

`ProcessContext` includes a `globals` field.

Common globals used internally:

- `lifetime`
- `algo`
- `process` (in runtime loop context)

Use `getglobals(context)` inside entity methods when you need them.
