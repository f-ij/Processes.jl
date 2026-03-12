# Processes.jl

Processes.jl is a type-stable framework for composing simulation/process loops from small `ProcessAlgorithm` and `ProcessState` building blocks.

This documentation is split into two tracks:

- Internal docs: how registries, contexts, routing, and loop generation work.
- User API docs: how to define algorithms/states, compose them, run processes, and inspect data.

## Internal Docs

- [Registry Internals](@ref registry_internals)
- [Context Internals](@ref context_internals)
- [Routes and Shares Internals](@ref routes_shares_internals)
- [Process Pipeline Internals](@ref process_pipeline_internals)

## User API Docs

- [Algorithms and States](@ref algorithms_states_user)
- [Referencing Algorithms](@ref referencing_algorithms_user)
- [Contexts and Indexing](@ref contexts_user)
- [Routes and Shares](@ref routes_shares_user)
- [Inputs and Overrides](@ref inputs_overrides_user)
- [Vars (`Var` Selectors)](@ref vars_user)
- [Lifetime](@ref lifetime_user)
- [Running, Wait, Fetch](@ref running_user)
- [Value Semantics and `Unique`](@ref value_semantics_user)

## Legacy Entry

- [Usage Guide (Legacy Entry Point)](@ref usage)
