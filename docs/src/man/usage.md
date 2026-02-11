# [Usage Guide](@id usage)

This guide walks you through the core workflow of Processes.jl: defining algorithms, composing them, running them in loops, and retrieving data.

## The Two Building Blocks: `ProcessAlgorithm` and `ProcessState`

Everything in Processes.jl is built from two primitives that together describe **what to compute** and **what data to prepare**.

### `ProcessAlgorithm` — Defining a Step

A `ProcessAlgorithm` is a singleton struct that describes a single step of computation. You subtype it and implement `Processes.step!`:

```julia
struct Fib <: ProcessAlgorithm end

function Processes.step!(::Fib, context)
    (; fiblist) = context                          # destructure the context
    push!(fiblist, fiblist[end] + fiblist[end-1])
    return (;)                                     # return updated variables as a NamedTuple
end
```

The `context` argument is a view into the process's data store. You destructure it to get the variables you need. The return value is a `NamedTuple` of any variables you want to **write back** into the context. Returning `(;)` (an empty `NamedTuple`) means nothing is overwritten — useful when you mutate data in-place (like `push!` above).

If a variable needs to be *replaced* rather than mutated, you return it:

```julia
function Processes.step!(::MyAlgo, context)
    (; counter) = context
    counter += 1                  # creates a new Int, doesn't mutate
    return (; counter)            # write the new value back into context
end
```

#### Why `NamedTuple` returns?

This pattern keeps everything type-stable. The context is an immutable structure of `SubContext`s stored inside a `ProcessContext`. When `step!` returns a `NamedTuple`, the framework merges those values back into the correct subcontext at compile-time. The compiler sees the types of both the context and the return value, so it can fully inline the merge operation.

#### Convenience: the `@ProcessAlgorithm` macro

If you prefer a more concise style, the `@ProcessAlgorithm` macro generates the struct and `step!` method from a function definition:

```julia
@ProcessAlgorithm function Fib(fiblist)
    push!(fiblist, fiblist[end] + fiblist[end-1])
end
```

This expands to a `struct Fib <: ProcessAlgorithm end` and a `step!` method that destructures `fiblist` from the context automatically. The macro inspects the function arguments (other than `context`) and generates the appropriate destructuring code.

### `ProcessState` — Declaring State

A `ProcessState` describes data that should be **prepared** before the algorithm loop begins. You subtype it and implement `Processes.prepare`:

```julia
struct FibState <: ProcessState end

function Processes.prepare(::FibState, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)   # allocate based on expected iterations
    return (; fiblist)
end
```

`prepare` receives the current context (which may already contain data from other states or inputs) and returns a `NamedTuple` of new variables to add to this state's subcontext.

#### Convenience: the `@ProcessState` macro

```julia
@ProcessState function FibState()
    fiblist = Int[0, 1]
    return (; fiblist)
end
```

### Combining `prepare` on a `ProcessAlgorithm`

A `ProcessAlgorithm` can also define its own `prepare` — it acts as both an algorithm and a state provider:

```julia
struct Fib <: ProcessAlgorithm end

function Processes.prepare(::Fib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)
    return (; fiblist)
end

function Processes.step!(::Fib, context)
    (; fiblist) = context
    push!(fiblist, fiblist[end] + fiblist[end-1])
    return (;)
end
```

This is the most common pattern for simple algorithms: one struct that both prepares its data and defines its step.

### `cleanup` — Post-loop Processing

Optionally, you can define `Processes.cleanup` to run after the loop finishes:

```julia
function Processes.cleanup(::Fib, context)
    (; fiblist) = context
    # post-process, e.g. trim the list
    return (; fiblist = fiblist[1:100])
end
```

### `Destructure` — Injecting External Objects as State

Sometimes you want to pass an existing object into a simulation and have its fields become part of the context. `Destructure` is a `ProcessState` that does exactly this:

```julia
struct MyModel
    weights::Matrix{Float64}
    bias::Vector{Float64}
end

model = MyModel(rand(10,10), zeros(10))

# Destructure the model: its fields (weights, bias) become context variables,
# plus a reference to the whole object as :mymodel
algo = CompositeAlgorithm((MyStep(), Destructure(model)), (1, 1))
```

## Composing Algorithms

Individual `ProcessAlgorithm`s and `ProcessState`s are composed into larger structures using two containers.

### `CompositeAlgorithm` — Parallel Composition with Intervals

A `CompositeAlgorithm` runs multiple algorithms inside a **single loop iteration**, each at its own interval (frequency):

```julia
algo = CompositeAlgorithm(
    (Fib(), Luc()),     # algorithms to run
    (1, 2)              # intervals: Fib runs every step, Luc every 2nd step
)
```

The intervals specify *how often* each algorithm fires. An interval of `1` means every iteration, `2` means every other iteration, and so on. This is useful when some computations are expensive and don't need to run as frequently.

Under the hood, the `CompositeAlgorithm` statically unrolls its sub-algorithms. The compiler sees the exact tuple of algorithm types and intervals at compile time, so the generated loop body is fully inlined with no dynamic dispatch.

When all intervals are `1`, the `CompositeAlgorithm` is internally stored as a `SimpleAlgo` — an optimised type alias that skips interval checks entirely.

You can also pass `ProcessState`s as additional options to inject shared state:

```julia
algo = CompositeAlgorithm(
    (StepA(), StepB()),
    (1, 1),
    MySharedState()          # ProcessState added as an option
)
```

### `Routine` — Sequential Composition with Repetitions

A `Routine` runs its sub-algorithms **sequentially**, each for a specified number of repetitions:

```julia
routine = Routine(
    (Fib(), Luc()),
    (100, 50)           # run Fib 100 times, then Luc 50 times
)
```

Unlike `CompositeAlgorithm` (where algorithms interleave within a single loop), a `Routine` fully completes one sub-algorithm before moving to the next. Routines are also **resumable** — if the process is paused, it remembers where it stopped and can continue from there.

### Nesting

Both `CompositeAlgorithm` and `Routine` are themselves `LoopAlgorithm`s, so they can be nested:

```julia
inner = CompositeAlgorithm((Fib(), Luc()), (1, 2))
outer = Routine((inner, AnotherAlgo()), (30, 10))
```

### `Unique` — Multiple Instances of the Same Algorithm

If you use the same algorithm type more than once, the framework needs to distinguish between the instances (since each gets its own subcontext). Wrap one in `Unique`:

```julia
algo = CompositeAlgorithm(
    (Fib(), Unique(Fib()), Luc()),
    (1, 1, 2)
)
```

`Unique` assigns a random UUID to the instance, making it a distinct entity with its own state in the context. Without it, two bare `Fib()` instances would collide.

### Data Sharing: `Route` and `Share`

When composing algorithms, you often want one algorithm to read data produced by another. Two mechanisms are provided:

#### `Route` — Share Specific Variables

A `Route` makes a specific variable from one algorithm's subcontext visible (as a read-through reference) in another's:

```julia
algo = CompositeAlgorithm(
    (Fib(), Luc()),
    (1, 1),
    Route(Fib(), Luc(), :fiblist)   # Luc can read Fib's fiblist
)
```

You can also alias the variable under a different name:

```julia
Route(Fib(), Luc(), :fiblist => :input_list)
# Luc sees it as `context.input_list`
```

#### `Share` — Share an Entire Subcontext

A `Share` makes the *entire* subcontext of one algorithm visible to another:

```julia
algo = CompositeAlgorithm(
    (Fib(), Luc()),
    (1, 1),
    Share(Fib(), Luc())   # Luc can see all of Fib's prepared variables
)
```

### Packaging: `PackagedAlgo`

For more complex compositions, you can `package` a `CompositeAlgorithm`. Packaging flattens the algorithm tree and converts `Route`s into internal variable aliases (`VarAliases`), producing a `PackagedAlgo` that acts like a single `ProcessAlgorithm` but contains the full composed logic:

```julia
packed = package(algo)
p = Process(packed, lifetime = 100)
```

This is particularly useful when you want to embed a composed algorithm inside yet another composition without worrying about registry collisions.

## Running a Simulation

### `Process` — Interactive, Threaded Loops

A `Process` wraps an algorithm and runs it on a separate thread:

```julia
p = Process(Fib(), lifetime = 1000)
run(p)          # starts the loop on a worker thread
```

#### Lifetime

The `lifetime` keyword controls how long the loop runs:

- `lifetime = n` (integer): run for exactly `n` iterations.
- Omitted or `lifetime = Indefinite()`: run forever until manually stopped.

```julia
p_finite   = Process(Fib(), lifetime = 500)
p_infinite = Process(Fib())    # runs indefinitely
```

For `Routine`s, the default lifetime is a single pass through the sequence (equivalent to `lifetime = 1`).

#### Controlling a Process

```julia
run(p)          # start (or resume) the loop
pause(p)        # pause — the loop stops but can be resumed
close(p)        # stop the loop and finalize
wait(p)         # block until the process finishes
```

`pause` is non-destructive: the process remembers its loop index and context so it can be resumed later with `run`. This is what makes processes truly *interactive* — you can pause a simulation, inspect its state, tweak parameters, and continue.

`close` fully stops the process and runs `cleanup`. After closing, you can still inspect the context.

#### Status Queries

```julia
isrunning(p)    # currently executing
ispaused(p)     # paused, can be resumed  
isdone(p)       # finished its lifetime
isidle(p)       # not doing anything (done, paused, or never started)
```

### `InlineProcess` — Synchronous, Inlineable Loops

When you need a loop that is **part of a larger computation** and should be fully inlined by the compiler, use `InlineProcess`:

```julia
ip = InlineProcess(Fib(); repeats = 1000)
run(ip)     # runs synchronously, returns when done
```

`InlineProcess` does not spawn a thread. It is designed for cases where the simulation loop lives inside another hot function and you want zero overhead. The compiler can inline the entire loop body.

## Retrieving Data

After a process has run (or while it's paused), you access its data through `getcontext`:

```julia
ctx = getcontext(p)
```

This returns the full `ProcessContext`. You can access individual algorithm subcontexts by property name:

```julia
ctx.Fib_1.fiblist    # the Fibonacci list from the first Fib instance
```

The subcontext names are automatically generated from the algorithm type name and an index (e.g. `Fib_1`, `Luc_1`). For processes with a single algorithm wrapped in a `SimpleAlgo`, the naming follows the same pattern.

For a finished process with a finite lifetime, `fetch(p)` waits for completion and returns the context (or the cleaned-up context if `cleanup` is defined).

!!! note "Planned: `getindex` on Process"
    A `getindex` method on `Process` that forwards to `getcontext` is planned, so you will be able to write `p[:fiblist]` or `p[Fib()]` directly.

### Inputs and Overrides

You can pass external data into a process at creation time:

```julia
# Input: available during `prepare`
p = Process(MyAlgo(), Input(MyAlgo(), :param => 42))

# Override: replaces a prepared variable after prepare runs
p = Process(MyAlgo(), Override(MyAlgo(), :param => 99))
```

`Input` provides values to `prepare` through the context. `Override` replaces values *after* `prepare` has run, which is useful for injecting test data or overriding defaults without changing the algorithm code.

## The ProcessContext: How Data Flows

Understanding the `ProcessContext` is key to understanding how Processes.jl achieves type stability.

A `ProcessContext` is a struct containing:
- **SubContexts**: one per algorithm/state, each a named `NamedTuple` of that entity's variables.
- **A Registry**: maps algorithm instances to their subcontext names, enabling type-stable lookups.
- **Globals**: shared variables like `process` (the `Process` instance), `lifetime`, and `algo` (the top-level algorithm).

When `step!` runs, it doesn't receive the raw `ProcessContext`. Instead, it receives a **`SubContextView`** — a lightweight view that exposes only the variables belonging to that algorithm (plus any `Route`d or `Share`d variables). This view is constructed at compile time, so accessing `context.fiblist` in a `step!` function compiles down to a direct field access.

The flow is:

1. **`prepare`** is called for each entity. Each returns a `NamedTuple` that becomes the entity's `SubContext`.
2. These are assembled into a `ProcessContext`.
3. During the loop, each `step!` call receives a `SubContextView` and returns a `NamedTuple` of updates.
4. The updates are merged back into the `ProcessContext` (compile-time merge, zero allocation).
5. After the loop, `cleanup` is called for each entity.

Because all types are known at compile time — the algorithm tuple, the intervals, the context structure — the Julia compiler can unroll the entire loop body, inline all `step!` calls, and eliminate the abstraction overhead entirely.

## Utility Functions

### `processsizehint!`

Call this inside `prepare` to pre-allocate arrays based on the process lifetime and the algorithm's call frequency:

```julia
function Processes.prepare(::Fib, context)
    fiblist = Int[0, 1]
    processsizehint!(fiblist, context)   # smart pre-allocation
    return (; fiblist)
end
```

### `savecontext`

Saves the process context to a JLD2 file:

```julia
savecontext(p, "my_simulation")
```

## Summary

The typical workflow is:

1. **Define** `ProcessAlgorithm`s (step logic) and optionally `ProcessState`s (extra shared state).
2. **Compose** them with `CompositeAlgorithm` (interleaved, with intervals) or `Routine` (sequential, with repetitions). Use `Route` / `Share` to wire data between algorithms.
3. **Create** a `Process` (interactive, threaded) or `InlineProcess` (synchronous, inlineable).
4. **Run** with `run(p)`.
5. **Inspect** with `getcontext(p)`, or `pause(p)` to interactively explore mid-simulation.
6. **Close** with `close(p)` when done.

