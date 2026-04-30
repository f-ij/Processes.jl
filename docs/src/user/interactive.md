# [Interactive Contexts](@id interactive_user)

`Processes` supports buffered interactive updates through `ContextInjector`.

This lets you:

- queue a value change from outside normal `step!` code,
- validate and convert that value before it reaches the runtime state,
- apply queued updates only every `check_every` steps,
- work with one variable at a time through a ref-like `view(context, Var(...))` handle.

The feature is designed to preserve the package's normal context-type stability rules:
updates are converted up front, and the injector only applies already-resolved, already-typed writes.

## Overview

Use a `ContextInjector` as one component of a resolved algorithm:

```julia
algo = resolve(CompositeAlgorithm(
    :target => MyAlgo(),
    :injector => ContextInjector(check_every = 2),
    (1, 1),
))

context = initcontext(algo; lifetime = Repeat(10))
```

The injector owns a small state subcontext with:

- a buffer of pending writes,
- a lock protecting that buffer,
- a step counter.

Each buffered write stores a fully resolved target `(subcontext, variable)` pair and a value that has already been converted to the target variable's current type.

## Checking Whether a Context Is Interactive

Use `isinteractive(...)` to test whether a context or process has at least one `ContextInjector` in its registry.

```julia
isinteractive(context)
isinteractive(process)
```

This is equivalent to asking whether the registry contains a `ContextInjector` target that `interact!(...)` or `view(context, Var(...))` can use.

If you call the interactive APIs on a context without an injector, they throw an error.

## Programmatic Updates With `interact!`

`interact!(context, input)` resolves an `Input(...)`, `Override(...)`, or `Var(...) => value` pair into concrete context variables and appends typed buffered writes into the injector state.

Example:

```julia
interact!(context, Input(:target, :value => 2))
```

This does **not** update the target immediately. It only appends a buffered write.

The update becomes visible when the injector is stepped:

```julia
context = Processes.step!(algo[:injector], context, Processes.Stable())
```

If `check_every > 1`, the injector will wait until its step counter reaches the configured cadence before applying buffered values.

### Example: Buffered Application Every Two Steps

```julia
algo = resolve(CompositeAlgorithm(
    :target => MyAlgo(),
    :injector => ContextInjector(check_every = 2),
    (1, 1),
))

context = initcontext(algo; lifetime = Repeat(5))

interact!(context, Input(:target, :value => 2))
length(context.injector.buffer) == 1

context = Processes.step!(algo, context, Processes.Unstable())
context.target.value == 1.0

context = Processes.step!(algo, context, Processes.Stable())
context.target.value == 2.0
isempty(context.injector.buffer)
```

This is the same behavior exercised in [test/ContextInjectorTest.jl](../../../test/ContextInjectorTest.jl).

## Ref-Like Interactive Access With `view(context, Var(...))`

`view(context, Var(...))` returns an `InteractiveVar`, a small ref-like object for one concrete target variable.

It supports:

- `ref[]` to read the current value,
- `ref[] = value` to enqueue a buffered update through the injector.

Example:

```julia
ref = view(context, Var(:target, :value))

ref[]
ref[] = 4
```

Like `interact!(...)`, assigning through the ref queues a write but does not apply it immediately.

```julia
ref = view(context, Var(:target, :value))
ref[] == 1.0

ref[] = 4
ref[] == 1.0
length(context.injector.buffer) == 1

context = Processes.step!(algo[:injector], context, Processes.Stable())
ref[] == 4.0
```

### Typed Selector Example

If the registry contains a unique algorithm of a given type, you can also use the type selector form:

```julia
typed_ref = view(context, Var(MyAlgoType, :value); injector = :injector)
typed_ref[] = 5
context = Processes.step!(algo[:injector], context, Processes.Stable())
typed_ref[] == 5.0
```

If multiple algorithms of that type exist, interactive lookup will ask you to disambiguate by key or by concrete algorithm instance.

## Input Forms Accepted by `interact!`

The injector supports the same user-facing naming styles already used elsewhere in the package:

- `Input(:target, :value => 2)`
- `Override(:target, :value => 2)`
- `Var(:target, :value) => 2`
- `Input(MyAlgoType, :value => 2)` when that target resolves uniquely

Internally, these are resolved through the registry before the update is queued.

## Type Conversion Rules

The injector validates types before writing into its buffer.

If the target variable currently has type `Float64` and you enqueue `2`, the injector converts that to `2.0` immediately and stores the typed value.

If conversion fails, `interact!(...)` or `ref[] = value` throws before the bad value reaches the buffer.

Example:

```julia
interact!(context, Input(:target, :value => 2))      # accepted
interact!(context, Input(:target, :value => "bad"))  # throws
```

This means the injector step itself does not need to guess how to stabilize a type change at runtime.

## Missing Targets at Apply Time

Buffered writes are resolved when they are queued, but the injector still checks that the target exists when it applies them.

If the target subcontext or variable is no longer present in the current context shape, the injector:

- emits a warning,
- skips that buffered update,
- continues applying the rest of the queue.

That fallback lives inside the injector so missing runtime targets do not have to be handled in the loop machinery.

## Choosing an Injector

If a context contains exactly one `ContextInjector`, `interact!(...)` and `view(context, Var(...))` use it automatically.

If the context contains multiple injectors, pass one explicitly:

```julia
ref = view(context, Var(:target, :value); injector = :ui)
interact!(context, Input(:target, :value => 2); injector = :ui)
```

Without an explicit choice, multiple injectors are treated as ambiguous and an error is thrown.

## Process Overload

There is also a convenience overload:

```julia
interact!(process, Input(:target, :value => 2))
```

This enqueues updates through the process' stored backing context.

For the clearest semantics, the examples in this page use direct context stepping, because injector application is defined in terms of stepping the context that owns the injector state.

## Relationship to `Var`

`InteractiveVar` builds directly on `Var(...)` selectors.

See [Vars (`Var` Selectors)](@ref vars_user) for the selector forms themselves, and [Contexts and Indexing](@ref contexts_user) for how context lookups and registry-based targeting work.

## Complete Example

```julia
using Processes

struct InteractiveTarget <: ProcessAlgorithm end

function Processes.init(::InteractiveTarget, context)
    return (; value = 1.0)
end

function Processes.step!(::InteractiveTarget, context)
    return (;)
end

algo = resolve(CompositeAlgorithm(
    :target => InteractiveTarget(),
    :injector => ContextInjector(),
    (1, 1),
))

context = initcontext(algo; lifetime = Repeat(3))

isinteractive(context)

ref = view(context, Var(:target, :value))
ref[] == 1.0

ref[] = 4
length(context.injector.buffer) == 1

context = Processes.step!(algo[:injector], context, Processes.Stable())
ref[] == 4.0

interact!(context, Input(:target, :value => 5))
context = Processes.step!(algo[:injector], context, Processes.Stable())
ref[] == 5.0
```

## Tested Behavior

The interactive API is covered in [test/ContextInjectorTest.jl](../../../test/ContextInjectorTest.jl), including:

- buffered updates via `interact!(...)`,
- `view(context, Var(...))` reads and writes,
- typed selector lookup,
- missing-injector errors,
- missing runtime target warnings.