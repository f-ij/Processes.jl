# [Algorithms and States](@id algorithms_states_user)

## `ProcessAlgorithm` and `ProcessState`

- `ProcessAlgorithm`: defines runtime step behavior via `Processes.step!`.
- `ProcessState`: defines initialization-only state via `Processes.init`.

Both are process entities and are registered into subcontexts.

## Lifecycle

Framework lifecycle is:

1. `init` phase
2. looped `step!` phase
3. `cleanup` phase

Init/cleanup traversal order follows registry order (states first, then algorithms).

Notes:

- `cleanup` runs on natural finite completion.
- If stopped/paused/indefinite branch exits, loop exits without automatic cleanup in `after_while`.

### Optional `prepare!` Stage (User Pattern)

There is no built-in framework callback named `prepare!` in the current core pipeline.

If you want an extra stage between init and stepping, use a user convention, for example:

- run it inside `init`, or
- guard it on first `step!` with a boolean flag in state.

## Full Declaration Style

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

`@ProcessAlgorithm` creates the struct and a `step!` method from a function signature (`src/ProcessEntities/ProcessAlgorithms.jl`).

```julia
@ProcessAlgorithm function Accumulate(x, gain)
    x = x + gain
    return (; x)
end
```

You can still define `init` and `cleanup` manually for the generated type.

### `@ProcessState`

`@ProcessState` creates a `ProcessState` and an `init` method (`src/ProcessEntities/ProcessStates/ProcessStateMacros.jl`).

```julia
@ProcessState function SharedParams(dt)
    return (; dt)
end
```

## Composition

Use loop algorithms to compose entities:

- `CompositeAlgorithm(...)` for interleaved stepping with intervals.
- `Routine(...)` for sequential blocks with repeats.

Both can include `ProcessState`s and options (`Route`, `Share`).
