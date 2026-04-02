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

#### Macro-Generated Algorithm Semantics

`@ProcessAlgorithm` supports a richer function-first DSL than the simple example above.

The signature is split into:

- plain positional arguments: runtime values read during `Processes.step!`
- `@managed(...)` positional arguments: local algorithm state created during `Processes.init`
- normal keyword arguments: runtime keyword-style values read during `Processes.step!`
- optional trailing `@input((; ...))` / `@inputs((; ...))` / `@init((; ...))`: init-time inputs used while constructing managed state
- optional `@config ...` declarations before the function: struct fields on the generated algorithm type

Example:

```julia
@ProcessAlgorithm begin
    @config n::Int = 8
    @config damp = 1.0

    function MyAlgo(
        signal,
        @managed(buffer = zeros(n)),
        @managed(scale),
        @managed(metric = 0.0);
        @inputs((; scale = 2.0))
    )
        @inbounds for i in eachindex(signal)
            buffer[i] = damp * scale * signal[i]
        end
        metric = sum(buffer)
        return (; buffer, scale, metric)
    end
end
```

Rules worth knowing:

- `@managed(name)` captures `name` from the init context into local managed state.
- `@managed(name = expr)` evaluates `expr` during `Processes.init`.
- `@managed(a, b = expr, c = expr2)` expands to multiple managed locals in order.
- `@input/@inputs/@init` may only appear once and must be the last keyword-like item.
- `@config` fields must have defaults and become fields on the generated struct.
  You can write them in a surrounding block or as a prelude like `@ProcessAlgorithm @config seed = 1 function MyAlgo(...) ... end`.
- inside the algorithm body, config fields are available directly by name.
  Use `seed`, not `config.seed`.
- plain positional arguments are runtime-only and are not available while constructing managed state.
- `where` signatures are supported.

For a macro-generated algorithm `MyAlgo`, the main entrypoints are:

- direct/bootstrap call: `step!(MyAlgo(), args...; @inputs((; ...)))`
- init hook: `Processes.init(MyAlgo(), context)`
- step hook: `Processes.step!(MyAlgo(), context)`

Internally the macro defines:

- `struct MyAlgo <: ProcessAlgorithm end` or `Base.@kwdef struct MyAlgo ... end`
- a hidden implementation function containing the user body
- public `Processes.step!(algo::MyAlgo, ...)` methods for direct calls
- generated `Processes.init` and `Processes.step!` methods that feed the implementation

Type annotations and `where` clauses are preserved on the generated public call signatures and
the hidden implementation function. The runtime context extraction methods currently bind simple
locals before forwarding into that typed implementation.

#### Analysis-Friendly Forms

If you want `ContextAnalyser` to discover dependencies more reliably:

- use `@inputs((; ...))` to make init-time requirements explicit
- use `context.name` or `(; name) = context` for required reads
- use `get(context, :name, default)` for optional reads
- return plain `NamedTuple`s from `init` and `step!`

See [Init Analysis](@ref init_analysis_user) for the analyzer workflow and limitations.

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
