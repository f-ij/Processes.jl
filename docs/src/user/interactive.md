# [Interactive Contexts](@id interactive_user)

`ContextExchange` gives external code a polled read/write handle to selected
process variables.

## Selectors

Construct an exchange from `Var` selectors:

```julia
algo = resolve(CompositeAlgorithm(
    :target => MyAlgo(),
    ContextExchange(Var(:target, :value), Var(:target, :seen)),
    (1, 20),
))
```

Selectors are resolved during `initcontext`, when the registry and concrete
state layout are available. The resolved paths are stored in the exchange state
type, and `ContextExchange` uses a custom `_step!` instead of route/wiring
machinery.

For a different external name, use a pair:

```julia
ContextExchange(:display => Var(:target, :value))
```

Type selectors are also supported when they resolve uniquely:

```julia
ContextExchange(:display => Var(MyAlgo, :value))
```

## Polling And Writes

External code reads and writes exchange-local names:

```julia
ref = view(context, :value)
ref[]          # last published value, initially `missing`
ref[] = 4      # queued write
```

The next due exchange step converts pending writes to the current target field
type and writes directly into the resolved subcontext. Current values are also
published to the ref slots on due exchange steps.

Programmatic writes use the same names:

```julia
interact!(context, :value => 5)
interact!(process, :value => 5)
```

Default lookup expects one `ContextExchange` in the process. If there are
multiple exchanges, pass the exchange key explicitly.

## Scheduling

The outer loop schedule still controls how often the exchange child is called:

```julia
CompositeAlgorithm(target, ContextExchange(Var(:target, :value)), (1, 20))
```

The exchange also supports a wall-clock gate:

```julia
ContextExchange(Var(:target, :value); period = 0.05)
```

If the exchange is called before `period` seconds have elapsed, it returns
without reading selected variables or applying pending writes.

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
    ContextExchange(Var(:target, :value)),
    (1, 1),
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
