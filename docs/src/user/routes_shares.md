# [Routes and Shares](@id routes_shares_user)

`Route` and `Share` connect subcontexts between process entities.

## Referencing Algorithms

You can reference endpoints by:

- type (`Fib`)
- instance (`Fib()`)
- explicitly unique wrapper (`u = Unique(Fib())`)

These resolve against registry identities, so be consistent with how you register and reference endpoints.

## `Route`: Specific Variables

Route selected variables from source to target, optionally aliased:

```julia
CompositeAlgorithm(
    Source, Target,
    (1, 1),
    Route(Source => Target, :value => :input_value),
)
```

Target sees `context.input_value`.

### Transform Route Values

You can provide `transform = f` (single mapping route) to expose transformed source values:

```julia
Route(Source => Target, :series => :latest, transform = x -> x[end])
```

### Transform From Multiple Source Variables

A transform route can also read multiple source variables by using a tuple on the left-hand side:

```julia
Route(
    Source => Target,
    (:x, :y) => :norm_xy,
    transform = (x, y) -> sqrt(x^2 + y^2),
)
```

Important constraints from the current implementation:

- If `transform` is provided, the route must define exactly one mapping.
- Multi-source tuple mappings are for derived read values in the target view.
- Writing back to that transformed alias is not supported (merging into multiple source variables is currently an error).

## `Share`: Whole Subcontext

Expose all source variables to target:

```julia
Share(Source, Target)
```

Default is bidirectional (`directional = false`). Use `directional = true` for one-way share.

## Read and Write Semantics

Routed/shared names are real view locations. If target returns those names from `step!`, the merge can update the source subcontext.

This enables coupling patterns like:

- algorithm B reading and damping algorithm A's `velocity`, then returning updated `velocity`.
