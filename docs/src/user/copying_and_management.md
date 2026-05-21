# [Copying and Process Management](@id copying_and_management_user)

```@meta
CurrentModule = Processes
```

This page documents process-copy helpers and the worker orchestration utilities.

A process copy is rebuilt from the saved construction data, not by copying the
live context directly. A process manager keeps several worker processes
available and gives jobs to whichever worker is free.

## Why Copy Instead of `deepcopy`

`Process` contexts are often built from `Init(...)` values that point at external storage,
buffers, or data views. A raw `deepcopy` of the live context can therefore copy the wrong
thing or preserve sharing that should be rebuilt per process.

The copying helpers work from the initialized loop algorithm and the normal
lifecycle init pipeline instead:

- copy the stored loop algorithm recipe,
- replace selected inputs and overrides,
- initialize a fresh context for each copy.

The saved recipe is the initialized loop algorithm: it stores the resolved
algorithm, persistent context, and replayable `Init`/`Override` specs.

## Copy APIs

```@docs
Processes.copyinputs
Processes.copyoverrides
Processes.copyprocess
```

## Typical Copy Pattern

```julia
template = Process(
    MyAlgo,
    Init(MyAlgo; start = 0, buffer = Int[]),
    Override(MyAlgo; delta = 2);
    repeats = 10,
)

p = copyprocess(
    template,
    Init(MyAlgo; start = 100, buffer = Int[]),
)

run(p)
wait(p)
close(p)
```

If the context needs custom rebuilding logic, provide a fully prepared
`context = ...` directly.

## Worker Orchestration

`ProcessManager` keeps a fixed set of workers busy. A worker is usually a
`Process`. A job is one item of work, such as one sample, one trajectory, or
one simulation case.

The manager is meant to be long-lived when worker contexts are expensive. Build
it once, then call `run!(manager, jobs)` many times. The same slots and workers
are reused on every call.

### Whole Manager Workflow

A manager run has four parts:

1. Construction creates the fixed worker slots. If you pass `workers = ...`,
   those worker objects are wrapped as-is. If you omit `workers`, the recipe must
   define `makeworker`; the manager builds a template worker, then copies it for
   the other slots. For `Process` workers, `makecontext` can build separate
   per-slot contexts while keeping the same algorithm.
2. Dispatch assigns one job to one free slot. The manager stores the job in
   `slot.job`, clears the previous `slot.result` and `slot.error`, runs
   `prepare!`, calls `runarguments`, then launches the worker. Use `prepare!` for
   persistent worker context changes. Use `runarguments` for runtime `@input`
   values by returning a named tuple, which is passed to
   `run(slot.worker; kwargs...)`.
3. Completion is detected by polling. When a slot finishes, the manager runs
   `finalize!`, `afterrun!`, `consume!`, and `release!`, then marks the slot free
   so another job can use the same worker.
4. Flushing is manager-level synchronization. `flush_policy` decides when
   `flush!` runs. Use `flush!` to merge worker-local buffers into manager state,
   external storage, or another object.

All lifecycle callbacks run on the thread that is driving the manager. Worker
tasks may run elsewhere, but `consume!` and `flush!` are manager-side hooks. This
means users can keep synchronization simple by only merging data after a worker
has finished.

The recipe is stored directly in `ProcessManager{Recipe,...}`. A named tuple of
closures therefore keeps the concrete closure types visible to Julia. For lower
overhead, also pass `job_type`, `result_type`, `scratch_type`, or `error_type`
when those slot field types are known.

### Worker Ownership

The usual form is to let the manager create and own its workers:

```julia
recipe = (;
    makeworker = (idx, manager) -> Process(MyAlgo; repeats = 1),

    prepare! = (slot, job, manager) -> begin
        ctx = context(slot.worker)[MyAlgo]
        ctx.value[] = job.value
        resetworker!(slot)
    end,
)

manager = ProcessManager(recipe; nworkers = 4)
```

In this form, `makeworker` is called once per slot when the manager is created.
The manager stores those workers and their contexts in `slots(manager)`. Later
calls to `run!(manager, jobs)` do not create new workers or new contexts unless
your own recipe does so.

For `Process` workers, the manager can also build the algorithm once and let the
recipe build each worker context separately:

```julia
recipe = (;
    makeworker = (idx, manager) -> Process(MyAlgo; repeats = 1),

    makecontext = (idx, manager, template) -> begin
        initialized = init(
            getalgo(template),
            Init(MyAlgo; seed = idx),
        )
        context(initialized)
    end,
)

manager = ProcessManager(recipe; nworkers = 4)
```

Here `makeworker` is still called once. `makecontext` is called once per slot,
including slot 1. The manager installs each returned context on a worker that
uses the template task description. Use this when all workers should run the
same algorithm, but each worker needs separate buffers, random state, or initial
values.

You can inspect manager-owned workers with:

```julia
slots(manager)
workers(manager)
```

Closing an owning manager also closes its workers:

```julia
close(manager)
```

You can also pass workers that were built elsewhere:

```julia
manager = ProcessManager(recipe; workers = existing_workers)
```

This wraps the existing workers in new slots. It does not create worker
contexts. Use this form when some other object owns the workers or when the
workers must be constructed before the manager exists.

### Run Lifecycle

For each job, the manager uses this order:

1. Wait for a free slot.
2. Store the job in `slot.job`.
3. Call `prepare!(slot, job, manager)`.
4. Call `runarguments(slot, job, manager)`.
5. Call `run(slot.worker; kwargs...)`, where `kwargs` is the named tuple returned
   by `runarguments`.
6. Poll active workers until one finishes.
7. Call `finalize!(slot, job, manager)`, or `wait(slot.worker); close(slot.worker)`
   if no `finalize!` callback exists.
8. Call `afterrun!(slot, job, manager)`.
9. Call `consume!(slot, job, manager)`.
10. Call `release!(slot, job, manager)`.
11. Mark the slot free.

If a recipe defines `start!(slot, job, manager)`, that callback replaces steps 4
and 5. Use `start!` only when you want to take over worker launch completely.

For `Process` workers, the default start/finalize behavior is:

```julia
run(slot.worker)
wait(slot.worker)
close(slot.worker)
```

`close(worker)` stores the finished process context back on the worker when the
process returns a context. That makes `consume!` the right place to read final
worker context values.

If a job needs to affect both persistent context and loop-level runtime inputs,
use two different steps: prepare the context in `prepare!`, then pass runtime
inputs from `runarguments`.

### Chunked Inline Workers

Use `InlineChunkWorker` when each worker should keep an `InlineProcess` on one
task for several examples. `runchunks!` groups examples into vector chunks, and
each chunk is dispatched as one manager job. Inside that chunk task, the recipe
loads one example at a time into the inline process context and runs the inline
process synchronously.

```julia
worker = InlineChunkWorker(InlineProcess(MyAlgo; repeats = 1))

recipe = (;
    resetexample! = (process, example, slot, manager) -> begin
        ctx = context(process)[MyAlgo]
        empty!(ctx.buffer)
    end,

    loadexample! = (process, example, slot, manager) -> begin
        ctx = context(process)[MyAlgo]
        ctx.x[] = example.x
    end,

    afterexample! = (process, example, result, slot, manager) -> begin
        ctx = context(process)[MyAlgo]
        push!(manager.state.outputs, ctx.y[])
    end,
)

manager = ProcessManager(
    recipe;
    workers = (worker,),
    job_type = Vector{eltype(dataset)},
)

runchunks!(manager, dataset; chunksize = 128)
```

`resetexample!` is optional. If it is omitted, context state carries from one
example to the next inside a chunk. `loadexample!` is required. `beforechunk!`
and `afterchunk!` are optional hooks around the whole chunk.

### Recipe Callbacks

A recipe can be a named tuple or an object with methods for these callbacks.
Callbacks can accept fewer trailing arguments if they do not need all of them.
The recipe object is stored as a concrete field of the manager, so anonymous
functions in a named tuple are part of the manager type.

- `initstate(config, manager)`: build `manager.state` from user configuration.
- `makeworker(idx, manager)`: create worker `idx` when `workers` is not passed.
- `makecontext(idx, manager, template)`: for manager-owned `Process` workers,
  build the context for slot `idx` from the template worker.
- `prepare!(slot, job, manager)`: write one job into a worker before it starts.
  This is the usual place to mutate context, call `reinitworker!`, or call
  `partialinitworker!`.
- `runarguments(slot, job, manager)`: return a named tuple of runtime keyword
  arguments for the implicit `run(...)` call. This callback may also run
  arbitrary manager-side code before launch. For example,
  `(; temperature = job.temperature)` becomes
  `run(slot.worker; temperature = job.temperature)`.
- `start!(slot, job, manager)`: advanced custom worker start. If this callback
  exists, it replaces `runarguments` and the implicit `run(...)` call.
- `isdone(slot, manager)`: custom completion check. Defaults to
  `isdone(worker)` for `Process` workers.
- `finalize!(slot, job, manager)`: custom finish step. Defaults to
  `wait(worker); close(worker)` for `Process` workers.
- `afterrun!(slot, job, manager)`: optional hook after finalization.
- `consume!(slot, job, manager)`: read a finished worker and accumulate output.
- `release!(slot, job, manager)`: clear local state after `consume!`.
- `flush!(manager)`: move worker-local buffers into manager state or another
  destination.
- `close!(slot, manager)`: custom worker close.
- `onerror!(slot, err, manager)`: custom error handling.
- `beforechunk!(process, chunk, slot, manager)`: optional chunk setup for
  `InlineChunkWorker`.
- `resetexample!(process, example, slot, manager)`: optional per-example reset
  for `InlineChunkWorker`.
- `loadexample!(process, example, slot, manager)`: required per-example context
  load for `InlineChunkWorker`.
- `afterexample!(process, example, result, slot, manager)`: optional
  per-example consume hook for `InlineChunkWorker`.
- `afterchunk!(process, chunk, slot, manager)`: optional chunk cleanup for
  `InlineChunkWorker`.

`config` is construction input. `state` is runtime data owned by the manager.
Prefer putting runtime buffers, counters, parameters, and logs in `initstate`
instead of keeping them as unrelated external mutable objects.

### Context Reuse

The manager reuses the same worker objects. Context reuse depends on what your
recipe does in `prepare!`.

Use direct mutation when only a few fields change:

```julia
prepare! = (slot, job, manager) -> begin
    ctx = context(slot.worker)[MyAlgo]
    ctx.x[] = job.x
    empty!(ctx.buffer)
    resetworker!(slot)
end
```

Use `reinitworker!` when the job should rebuild context through the normal
process init path:

```julia
prepare! = (slot, job, manager) -> reinitworker!(
    slot,
    Init(MyAlgo; x = job.x),
)
```

Use `partialinitworker!` when only one target needs to be rebuilt:

```julia
prepare! = (slot, job, manager) -> partialinitworker!(
    slot,
    Init(MyAlgo; x = job.x),
)
```

Use `runarguments` for loop-level runtime `@input` values:

```julia
runarguments = (slot, job, manager) -> (; temperature = job.temperature)
```

You can use both for the same job. The manager calls `prepare!` first, then
`runarguments`, then `run(slot.worker; temperature = job.temperature)`.

Direct mutation is usually faster. `reinitworker!` and `partialinitworker!` are
useful when the context shape, inputs, or initialized state must be rebuilt. Do
not create a new `Process` inside a callback unless you intentionally want to
give up worker context reuse.

### Result Collection

Use `consume!` to read one finished worker. This hook runs on the manager side,
after the worker has finished and been finalized.

If workers are reused, avoid storing mutable worker context objects for later
unless you know they will not be overwritten. Store copied values instead:

```julia
consume! = (slot, job, manager) -> begin
    ctx = context(slot.worker)[MyAlgo]
    push!(manager.state.outputs, (; value = ctx.value[], loss = ctx.loss[]))
end
```

### Flush Policies

`flush_policy` controls when `flush!(manager)` is called.

- `FlushAtEnd()` is the default. It runs all jobs first, drains all active
  workers, then calls `flush!` once.
- `NoFlush()` never calls `flush!` automatically. Use this when `consume!`
  handles all result collection.
- `FlushEvery(n; drain = true)` calls `flush!` after every `n` completed worker
  runs. When `drain = true`, all active workers are finalized before flushing.
  When `drain = false`, only already-finished workers are flushed.

`flush!` runs on the manager side, so it can safely merge worker-local buffers
without making those buffers thread-safe.

### Scheduling

`run!(manager, jobs)` dispatches all jobs, keeps at most one job active per
slot, then drains remaining active workers at the end.

For manual control:

```julia
dispatch!(manager, job)
poll!(manager)
drain!(manager)
```

`poll_interval = 0.0` means the manager yields while waiting. A positive
`poll_interval` sleeps for that many seconds between checks when all workers
are busy.

### Type Hints

For lower overhead, pass concrete slot field types when they are known:

```julia
template_worker = Process(MyAlgo; repeats = 1)

manager = ProcessManager(
    recipe;
    nworkers = 4,
    job_type = eltype(jobs),
    result_type = typeof(template_worker),
)
```

Usually `job_type = eltype(jobs)` is the most important one. If a callback
stores a result in `slot.result`, set `result_type` to that result type.

The manager stores its slots in a tuple. This keeps the slot container type
fixed after construction and leaves room for workers with different concrete
types. `workers(manager)` returns the same fixed-shape tuple of worker objects.

```@docs
Processes.ProcessManager
Processes.WorkerSlot
Processes.FlushPolicy
Processes.FlushAtEnd
Processes.NoFlush
Processes.FlushEvery
Processes.slots
Processes.workers
Processes.copyworker
Processes.InlineChunkWorker
Processes.runchunks!
Processes.prepare!
Processes.runarguments
Processes.start!
Processes.beforechunk!
Processes.resetexample!
Processes.loadexample!
Processes.afterexample!
Processes.afterchunk!
Processes.dispatch!
Processes.poll!
Processes.drain!
Processes.run!
Processes.resetworker!
Processes.reinitworker!
Processes.partialinitworker!
```

## Manager-Owned Worker Example

```julia
template = Process(
    MyAlgo,
    Init(MyAlgo; value = Ref(0), local_buffer = Int[]),
    Override(MyAlgo; delta = 3);
    repeats = 20,
)

recipe = (;
    initstate = config -> (;
        output = Int[],
        scale = config.scale,
    ),

    makeworker = (idx, manager) -> copyprocess(template; context = deepcopy(context(template))),

    prepare! = (slot, job, manager) -> begin
        ctx = context(slot.worker)[MyAlgo]
        ctx.value[] = job.value * manager.state.scale
        resetworker!(slot)
    end,

    flush! = manager -> begin
        for slot in slots(manager)
            ctx = context(slot.worker)[MyAlgo]
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
    result_type = typeof(template),
)

run!(manager, jobs)
manager.state.output
```

The manager calls `flush!` automatically according to `flush_policy`; normal
code does not call it directly.

## Existing Worker Example

```julia
workers = [Process(MyAlgo; repeats = 1) for _ in 1:4]

recipe = (;
    prepare! = (slot, job, manager) -> begin
        ctx = context(slot.worker)[MyAlgo]
        ctx.value[] = job.value
        resetworker!(slot)
    end,

    consume! = (slot, job, manager) -> begin
        ctx = context(slot.worker)[MyAlgo]
        push!(manager.state.outputs, ctx.value[])
    end,

    initstate = config -> (; outputs = Int[]),
)

manager = ProcessManager(
    recipe;
    workers,
    config = (;),
    flush_policy = NoFlush(),
    job_type = eltype(jobs),
    result_type = eltype(workers),
)

run!(manager, jobs)
manager.state.outputs
```

Use existing workers only when they must be owned or prepared outside the
manager. Otherwise prefer the manager-owned form with `makeworker`.
