# [Algorithms and States](@id algorithms_states_user)

`ProcessAlgorithm` and `ProcessState` are the two main building blocks you compose into a process.

- Use `ProcessAlgorithm` for something that actively participates in the loop by implementing `Processes.step!`.
- Use `ProcessState` for data that should be initialized into a subcontext and then shared or read by algorithms.

Both are process entities, and both are registered into subcontexts inside the final `ProcessContext`.

## Lifecycle Hooks

The framework lifecycle is:

1. `init` phase
2. looped `step!` phase
3. `cleanup` phase

Registry order matters here: states are initialized first, then algorithms. Cleanup follows the same order.

Two details from the implementation are worth knowing:

- `cleanup` runs on natural finite completion.
- If a process is interrupted, paused, or runs under `Indefinite()`, `after_while` stores the current context and returns without automatic cleanup.

There is no built-in `prepare!` hook in the current pipeline.
If you want a one-time preparation step, fold it into `init` or guard the first `step!` with a flag in state.

## Full Definitions

```julia
struct MyAlgo <: ProcessAlgorithm
    gain::Float64
end

function Processes.init(a::MyAlgo, context)
    x = 0.0
    return (; x)
end

function Processes.step!(a::MyAlgo, context)
    (; x) = context
    x = x + a.gain
    return (; x)
end

function Processes.cleanup(::MyAlgo, context)
    return (;)
end
```

```julia
struct MyState <: ProcessState end

function Processes.init(::MyState, context)
    return (; shared_buffer = Float64[])
end
```

## Macro Shortcuts

### `@ProcessAlgorithm`

`@ProcessAlgorithm` creates the struct and a `step!` method from a function signature.

```julia
@ProcessAlgorithm function Accumulate(x, gain)
    x = x + gain
    return (; x)
end
```

You can still define `init` and `cleanup` manually for the generated type.

### `@ProcessState`

`@ProcessState` creates a `ProcessState` and an `init` method.

```julia
@ProcessState function SharedParams(dt)
    return (; dt)
end
```

## Composition

Compose entities with loop algorithms:

- `CompositeAlgorithm(...)` for interleaved stepping with intervals.
- `Routine(...)` for sequential blocks with repeats.

Both can include `ProcessState`s and user options such as `Route` and `Share`.
