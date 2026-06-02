# [Interactive Contexts](@id interactive_user)

`Processes` supports scheduled external reads and writes through `ContextExchange`.

Use this when code outside normal `step!` methods needs a polled view of process
state, or needs to queue a value change while a process is running.

## Overview

Declare the exchange-local names in the `ContextExchange` constructor:

```julia
algo = resolve(CompositeAlgorithm(
    :target => MyAlgo(),
    ContextExchange(:value),
    (1, 10),
    Route(:target => :_exchange, :value),
))
```

The names are stored in the `ContextExchange` type. On each scheduled exchange
step, generated code reads those names from the exchange view. `Route` and
`Share` decide where those names come from and where queued writes go.

The exchange owns a persistent subcontext named `:_exchange`.

## Polling

`view(context, :value)` returns an `InteractiveVar` for the exchange-local
`:value` slot:

```julia
ref = view(context, :value)
ref[]
```

`ref[]` reads the last value published by a scheduled exchange step. Before the
first exchange step, the value is `missing`.

With an interval of `10`, published values refresh every 10 composite steps.

## Writes

Assigning to the ref queues a write:

```julia
ref[] = 4
```

The write is applied on the next scheduled exchange step. The generated exchange
step converts the pending value to the type of the currently routed value, then
returns it under the same exchange-local name. Normal merge and route machinery
then applies the update.

Programmatic writes use the same exchange-local names:

```julia
interact!(context, :value => 5)
interact!(process, :value => 5)
```

## Explicit Exchange Key

The default exchange key is `:_exchange`. You can address it explicitly:

```julia
ref = view(context, Var(:_exchange, :value))
ref = view(context, :value; exchange = :_exchange)
interact!(context, :value => 2; exchange = :_exchange)
```

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
    ContextExchange(:value),
    (1, 1),
    Route(:target => :_exchange, :value),
))

context = initcontext(algo; lifetime = Repeat(3))
ref = view(context, :value)

ref[] === missing

ref[] = 4
context = Processes._step!(algo, context, Processes.Stable())

ref[] == 4.0
context.target.value == 4.0
```

The interactive API is covered in `test/ContextExchangeTest.jl`.
