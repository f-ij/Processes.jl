# Processes.jl

Processes.jl is a type-stable framework for building process loops from small, composable `ProcessAlgorithm` and `ProcessState` building blocks.

Start with the user documentation if you want to build processes with the package.
The internals section is for understanding how registries, contexts, routing, and generated loops are implemented.

## User Documentation

- [Algorithms and States](@ref algorithms_states_user)
- [Referencing Algorithms](@ref referencing_algorithms_user)
- [Contexts and Indexing](@ref contexts_user)
- [Routes and Shares](@ref routes_shares_user)
- [Inputs and Overrides](@ref inputs_overrides_user)
- [Vars (`Var` Selectors)](@ref vars_user)
- [Lifetime](@ref lifetime_user)
- [Running, Wait, Fetch](@ref running_user)
- [Copying and Process Management](@ref copying_and_management_user)
- [Value Semantics and `Unique`](@ref value_semantics_user)

## Internals

- [Registry Internals](@ref registry_internals)
- [Context Internals](@ref context_internals)
- [Routes and Shares Internals](@ref routes_shares_internals)
- [Process Pipeline Internals](@ref process_pipeline_internals)
