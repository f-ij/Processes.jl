# Processes.jl

Processes.jl helps you build Julia loops from small named pieces.

An **algorithm** is a piece of loop code. It is a subtype of
`ProcessAlgorithm` and usually defines `Processes.step!`.

A **state** is a piece of setup data. It is a subtype of `ProcessState` and
usually defines `Processes.init`.

A **process** combines algorithms, states, inputs, and stop rules into a running
loop. While it runs, values live in a **context**. Each algorithm or state gets
its own named part of that context, called a **subcontext**.

The package keeps context shapes stable after setup, so tight loops can stay
fast while still letting you compose larger workflows.

Start with the user documentation if you want to build processes with the package.
The internals section is for understanding how registries, contexts, routing, and generated loops are implemented.

If you are new to the package, read these first:

1. [Algorithms and States](@ref algorithms_states_user)
2. [Running, Wait, Fetch](@ref running_user)
3. [Contexts and Indexing](@ref contexts_user)
4. [Inputs and Overrides](@ref inputs_overrides_user)
5. [Routes and Shares](@ref routes_shares_user)

## User Documentation

- [Algorithms and States](@ref algorithms_states_user)
- [Referencing Algorithms](@ref referencing_algorithms_user)
- [Contexts and Indexing](@ref contexts_user)
- [Init Analysis](@ref init_analysis_user)
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
