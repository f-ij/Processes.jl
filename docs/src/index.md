# Processes.jl

**Type-stable, composable simulation loops in Julia.**

Processes.jl is a framework for writing simulations that are **type-stable**, **composable**, and optionally **interactive**. It provides a structured way to define algorithmic steps and their associated state, compose them into larger algorithms, and run them in loops that can be paused, resumed, and inspected at will — all without sacrificing performance.

## Why Processes.jl?

Writing high-performance simulation code in Julia often means hand-rolling tight loops with carefully managed state. The moment you want to compose multiple algorithms, run them at different rates, share data between them, or pause mid-execution, the code becomes difficult to maintain and extend. Processes.jl solves this by providing:

- **Type stability throughout**: All data flows through a statically-typed `ProcessContext`. The compiler can infer every type, enabling full inlining and zero-overhead abstraction.
- **Composability**: Small algorithm steps (`ProcessAlgorithm`) and state declarations (`ProcessState`) are the building blocks. These are composed into `CompositeAlgorithm`s and `Routine`s — hierarchical structures that the compiler can unroll and inline.
- **Interactive loops**: A `Process` runs its algorithm on a separate thread. You can `pause`, `run`, and `close` it from the REPL or a GUI, making it ideal for real-time simulations and interactive exploration.
- **Inlineable loops**: An `InlineProcess` runs synchronously and is designed to be fully inlined by the compiler — useful when a simulation loop is itself part of a larger computation.

## Core Concepts at a Glance

| Concept | What it is |
|---|---|
| `ProcessAlgorithm` | A single step of computation — defines `step!` |
| `ProcessState` | A piece of state — defines `prepare` |
| `CompositeAlgorithm` | Multiple algorithms running in a single loop, each at its own interval |
| `Routine` | Multiple algorithms running sequentially, each for a given number of repetitions |
| `Process` | A threaded, interactive runner that can be paused and resumed |
| `InlineProcess` | A synchronous, inlineable runner for embedding in tight loops |
| `ProcessContext` | The type-stable data container that flows through every step |

## Quick Example

```julia
using Processes

# 1. Define an algorithm step
struct Fib <: ProcessAlgorithm end

function Processes.prepare(::Fib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)  # pre-allocate based on lifetime
    return (; fiblist)
end

function Processes.step!(::Fib, context)
    (; fiblist) = context
    push!(fiblist, fiblist[end] + fiblist[end-1])
    return (;)  # return a NamedTuple of updated variables (empty here)
end

# 2. Create a process and run it
p = Process(Fib(), lifetime = 1000)
run(p)
wait(p)

# 3. Retrieve the data
ctx = getcontext(p)
ctx.fiblist  # [0, 1, 1, 2, 3, 5, 8, 13, ...]
```

Read on in the [Usage Guide](@ref usage) for a complete walkthrough.
