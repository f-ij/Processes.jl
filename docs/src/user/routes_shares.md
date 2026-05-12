# [Routes and Shares](@id routes_shares_user)

`Route` and `Share` make values from one algorithm or state visible to another.

Each algorithm or state owns a subcontext: its named part of the full process
context. A route exposes selected names from one subcontext. A share exposes all
names from one subcontext.

## Referencing Algorithms

Recap:

- Use the same reference style you used in composition (type, saved instance, or saved `Unique` variable).
- Do not target with a fresh object unless that exact object was inserted in the composition.

For full examples, see [Referencing Algorithms](@ref referencing_algorithms_user).

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

If no alias is given, the target sees the same name as the source.

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

Default is bidirectional (`directional = false`), so both sides can read the
other side's values. Use `directional = true` for a one-way share from the first
argument to the second.

## Read and Write Semantics

Routed and shared names point back to stored values. If the target returns one
of those names from `step!`, the source subcontext can be updated.

This enables coupling patterns like:

- algorithm B reading and damping algorithm A's `velocity`, then returning updated `velocity`.

## Current Limitation: Routes Are Instance-Bound

Routes are currently resolved per final process context, not per usage site inside a parent `CompositeAlgorithm` or `Routine`.

Practical effect:

- Reusing the same algorithm or composite instance in multiple parents/phases implies the same routing structure for that reused instance.
- The same reused component cannot currently have different local route configurations in different parts of a `Routine`.

If you need different routing in different parents/phases, create distinct instances, typically with [`Unique(...)`](@ref value_semantics_user), and route those separately.

This is a current limitation of the routing model and may be relaxed in a future release.
