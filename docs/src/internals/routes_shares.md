# [Routes and Shares Internals](@id routes_shares_internals)

`Route` and `Share` are user options, resolved once during `ProcessContext(la)` construction.

Relevant files:

- Definitions: `src/RoutingInterface/RouteDef.jl`, `src/RoutingInterface/ShareDef.jl`
- Resolution backend: `src/RoutingInterface/Resolving.jl`, `src/RoutingInterface/Backend.jl`, `src/RoutingInterface/Sharing.jl`
- Context integration: `src/Context/Init.jl`

## 1. Route Resolution

`Route` stores:

- source endpoint (`from`)
- target endpoint (`to`)
- routed source variable names
- local aliases in target view
- optional transform function
- precomputed `match_by` identities for from/to

`resolve_options(reg, routes...)` converts each route into:

- target subcontext name => tuple of `SharedVars{from_name,varnames,aliases,transform}`.

`to_sharedvar` resolves endpoints by matcher identity in the registry, then binds concrete source/target keys.

Transform details:

- `Route(...; transform = f)` is restricted to exactly one mapping entry.
- That single mapping can still be multi-source by mapping `(:a, :b, ...) => :local_name`.
- At view-read time this becomes a `VarLocation` with tuple `originalname` and `func = f`, so the generated getter reads each source variable and calls `f(a, b, ...)`.
- Merge-back into tuple targets is currently disallowed in generated merge code, so transformed multi-source routes are effectively read-only derived inputs.

## 2. Share Resolution

`Share(a,b; directional=false)` is converted to `SharedContext` metadata:

- `a -> b`
- and also `b -> a` when non-directional.

This metadata is attached to target `SubContext.sharedcontexts`.

## 3. How Views See Them

When creating `SubContextView` locations (`src/Context/View/Locations.jl`):

- `SharedContext` contributes all variables from the shared subcontext.
- `SharedVars` contributes only specified routed vars (plus transform if provided).

Both become `VarLocation{:subcontext}` entries, so reads and writes are directed to the source subcontext.

That means returning a routed/shared variable from `step!` can update remote state, not only local state.

## 4. Errors and Validation

If route/share endpoints are not present in the registry, resolution throws explicit errors listing available keys (see `to_sharedvar` and `to_sharedcontext`).

## 5. Relation to Packaging

During `PackagedAlgo(comp)`, routes are translated into `VarAliases` for internal subpackages (`src/Packaging/Packaged.jl`, `src/Packaging/Utils.jl`).

## 6. Current Limitation: No Usage-Site-Specific Routes

Route resolution is performed once from the final registry during `ProcessContext(la)` construction, and the resolved `SharedVars` are stored in the target `SubContext` type.

This means routes are currently bound to registry/context identity, not to a specific parent call site. Reusing the same algorithm or composite instance in multiple parts of a larger composition therefore reuses the same routing shape.

Supporting different routes for the same reused component in different parents/phases would require a more usage-site-sensitive model, such as path-specific identities or caller-dependent views. That is not currently implemented.
