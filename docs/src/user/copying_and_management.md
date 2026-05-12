# [Copying and Process Management](@id copying_and_management_user)

```@meta
CurrentModule = Processes
```

This page documents process-copy helpers and the worker orchestration utilities.

A process copy is rebuilt from the saved construction data, not by copying the
live context directly. A process manager keeps several worker processes
available and gives jobs to whichever worker is free.

## Why Copy Instead of `deepcopy`

`Process` contexts are often built from `Input(...)` values that point at external storage,
buffers, or data views. A raw `deepcopy` of the live context can therefore copy the wrong
thing or preserve sharing that should be rebuilt per process.

The copying helpers work from `TaskData` and the normal init pipeline instead:

- copy the task description,
- replace selected inputs and overrides,
- initialize a fresh context for each copy.

`TaskData` is the saved recipe for building a process context: the algorithm,
the inputs, the overrides, and the lifetime.

## Copy APIs

```@docs
Processes.copyinputs
Processes.copyoverrides
Processes.copytaskdata
Processes.copyprocess
```

## Typical Copy Pattern

```julia
template = Process(
    MyAlgo,
    Input(MyAlgo, :start => 0, :buffer => Int[]),
    Override(MyAlgo, :delta => 2);
    repeats = 10,
)

p = copyprocess(
    template,
    Input(MyAlgo, :start => 100, :buffer => Int[]),
)

run(p)
wait(p)
close(p)
```

If the context needs custom rebuilding logic, pass `context_builder = (taskdata, original) -> ...`
or provide a fully prepared `context = ...` directly.

## Worker Orchestration

`ProcessManager` keeps a fixed set of workers busy. A worker is usually a
`Process`. A job is one item of work, such as one sample or one simulation
case.

The manager is controlled by a recipe. A recipe is an object or named tuple
with callbacks. The most common callbacks are:

- `initstate(config, manager)`: build state owned by the manager from user
  configuration.
- `makeworker(idx, manager)`: create worker `idx`.
- `prepare!(slot, job, manager)`: write the job into the worker context.
- `consume!(slot, job, manager)`: read one finished worker.
- `release!(slot, job, manager)`: clear or adjust local worker state after it
  has been consumed.
- `flush!(manager)`: move worker-local buffers into manager state or another
  destination.

`config` is user input. `state` is runtime data owned by the manager. Prefer
putting runtime buffers, parameters, counters, and logs in `initstate` rather
than passing them as external mutable objects.

`prepare!` is also where a worker can partially initialize its context for the
next run. Use `reinitworker!(slot, inputs_or_overrides...)` when you want the
normal `initcontext` path. Use direct context mutation when only a few local
fields or buffers need to change.

The default policy, `FlushAtEnd()`, runs all jobs first. Each worker writes only
to its own context. After all workers finish, the manager calls `flush!` once.
Because `flush!` runs on the manager side, plain buffers can be used there
without locks.

Other flush policies are:

- `NoFlush()` never flushes automatically.
- `FlushEvery(n; drain = true)` flushes after completed worker runs.

```@docs
Processes.ProcessManager
Processes.WorkerSlot
Processes.FlushPolicy
Processes.FlushAtEnd
Processes.NoFlush
Processes.FlushEvery
Processes.dispatch!
Processes.poll!
Processes.drain!
Processes.run!
Processes.resetworker!
Processes.reinitworker!
```

## Manager Example

```julia
template = Process(
    MyAlgo,
    Input(MyAlgo, :value => Ref(0), :local_buffer => Int[]),
    Override(MyAlgo, :delta => 3);
    repeats = 20,
)

recipe = (;
    initstate = config -> (;
        output = Int[],
        scale = config.scale,
    ),

    makeworker = (idx, manager) -> copyprocess(template; context = deepcopy(template.context)),

    prepare! = (slot, job, manager) -> begin
        ctx = slot.worker.context[MyAlgo]
        ctx.value[] = job.value * manager.state.scale
        resetworker!(slot)
    end,

    flush! = manager -> begin
        for slot in slots(manager)
            ctx = slot.worker.context[MyAlgo]
            append!(manager.state.output, ctx.local_buffer)
            empty!(ctx.local_buffer)
        end
    end,
)

manager = ProcessManager(
    recipe;
    nworkers = 4,
    config = (; scale = 2),
    flush_policy = FlushAtEnd(),
    job_type = eltype(jobs),
)

run!(manager, jobs)
manager.state.output
```

The manager calls `flush!` automatically according to `flush_policy`; normal code does not call
it directly.

If every job has the same type, pass `job_type = eltype(jobs)`. This keeps the stored job in each
worker slot concrete while still leaving the manager recipe unchanged.
