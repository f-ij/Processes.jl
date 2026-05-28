# [Threaded Process Managers](@id threaded_process_managers_user)

```@meta
CurrentModule = Processes
```

Use a `ProcessManager` when you already have a `Process` definition and want to
run many independent jobs on Julia threads. The manager is not another way to
write algorithms. It is a runtime layer that reuses initialized processes,
loads one job into each process, runs those processes, and collects the results.

The main threaded entry point is:

```julia
runthreaded!(manager, jobs)
```

You can also pass a thread schedule explicitly:

```julia
run!(manager, jobs, Dynamic())
run!(manager, jobs, Static())
run!(manager, jobs, Greedy())
```

## Terms

- A **job** is one item of work, such as one sample, one trajectory, or one
  simulation case.
- A **managed process** is a reusable `Process` that handles one job at a time.
- A **slot** is the manager record for one managed process. It stores the
  process, the current job, the latest result, and any error from that run.
- A **recipe** tells the manager how to load jobs, run processes, collect
  outputs, and reset state between jobs.
- `manager.state` is manager-owned runtime data, commonly used for output
  buffers, counters, and shared parameters.

The API uses the word `worker` for a managed process because a manager can also
wrap non-`Process` worker objects. For ordinary threaded `Processes.jl` usage,
read `worker` as "the reusable process in this slot".

## Whole Manager Workflow

A threaded manager run has four parts:

1. Construction creates the fixed slots. If you pass `workers = ...`, those
   process objects are wrapped as-is. If you omit `workers`, the recipe must
   define `makeworker`; the manager builds the processes for you. For `Process`
   workers, `makecontext` can build separate per-slot contexts while keeping
   the same algorithm.
2. Dispatch assigns one job to one available slot. The manager stores the job
   in `slot.job`, clears the previous `slot.result` and `slot.error`, runs
   `prepare!`, calls `runarguments`, then starts the process. Use `prepare!` for
   persistent context changes. Use `runarguments` for runtime `@input` values by
   returning a named tuple, which is passed to `run(slot.worker; kwargs...)`.
3. Completion happens inside the threaded job iteration. When a process
   finishes, the manager runs `finalize!`, `afterrun!`, `consume!`, and
   `release!`, then makes the slot available for another job.
4. Flushing is manager-level synchronization. `flush_policy` decides when
   `flush!` runs. Use `flush!` to merge slot-local buffers into `manager.state`,
   external storage, or another object.

In threaded mode, default `Process` workers run inline inside a
`Threads.@threads` iteration. This avoids one task spawn per job. Recipe
callbacks still run as part of the slot lifecycle, so `consume!` and `flush!`
remain the right places to move finished values out of process contexts.

The recipe is stored directly in `ProcessManager{Recipe,...}`. A named tuple of
closures therefore keeps the concrete closure types visible to Julia. For lower
overhead, also pass `job_type`, `result_type`, `scratch_type`, or `error_type`
when those slot field types are known.

## Worker Ownership

The usual form is to let the manager create and own its processes:

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

In this form, `makeworker` is called when the manager is created. The manager
stores those processes and their contexts in `slots(manager)`. Later calls to
`runthreaded!(manager, jobs)` do not create new processes or new contexts unless
your recipe does so.

For `Process` workers, the manager can also build the algorithm once and let the
recipe build each process context separately:

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
including slot 1. The manager installs each returned context on a process that
uses the template task description. Use this when all processes should run the
same algorithm, but each process needs separate buffers, random state, or
initial values.

You can inspect manager-owned processes with:

```julia
slots(manager)
workers(manager)
```

Closing an owning manager also closes its processes:

```julia
close(manager)
```

You can also pass processes that were built elsewhere:

```julia
manager = ProcessManager(recipe; workers = existing_workers)
```

This wraps the existing processes in new slots. It does not create contexts.
Use this form when some other object owns the processes or when the processes
must be constructed before the manager exists.

## Threaded Scheduling

`runthreaded!(manager, jobs)` uses `Dynamic()` scheduling by default.

```julia
runthreaded!(manager, jobs)
runthreaded!(manager, jobs, Static())
runthreaded!(manager, jobs, Greedy())
```

Use `Dynamic()` when job runtimes may vary. Slots are borrowed from a bounded
pool, so the number of concurrently running jobs is limited by the number of
manager slots.

Use `Static()` when each thread should use a stable slot index. Static mode
requires at least `Threads.maxthreadid()` slots.

Use `Greedy()` for Julia's greedy threaded scheduling when it is available and
when jobs are uneven enough that the schedule is useful.

The convenience form below is equivalent to `runthreaded!`:

```julia
run!(manager, jobs, Dynamic())
```

## Run Lifecycle

For each job, the manager uses this order:

1. Borrow a free slot.
2. Store the job in `slot.job`.
3. Call `prepare!(slot, job, manager)`.
4. Call `runarguments(slot, job, manager)`.
5. Start the process with the named tuple returned by `runarguments`.
6. Wait for the process to finish. In threaded mode this means the inline
   process run has returned. In the polling mode this means `isdone` reported
   that the process is finished.
7. Call `finalize!(slot, job, manager)`, or `wait(slot.worker); close(slot.worker)`
   if no `finalize!` callback exists. This is the first hook after the process
   has finished and the last hook before result-reading callbacks run.
8. Call `afterrun!(slot, job, manager)`.
9. Call `consume!(slot, job, manager)`.
10. Call `release!(slot, job, manager)`.
11. Return the slot to the pool.

If a recipe defines `start!(slot, job, manager)`, that callback replaces steps 4
and 5. Use `start!` only when you want to take over process launch completely.

For `Process` workers, threaded mode runs the process inline inside the current
threaded iteration. The non-threaded manager run uses:

```julia
run(slot.worker)
wait(slot.worker)
close(slot.worker)
```

`close(worker)` stores the finished process context back on the worker when the
process returns a context. That makes `consume!` the right place to read final
context values.

If a job needs to affect both persistent context and loop-level runtime inputs,
use two different steps: prepare the context in `prepare!`, then pass runtime
inputs from `runarguments`.

## What `finalize!` Is For

`finalize!` is for making a just-finished process ready to be inspected. It is
called after the process run has completed, before `afterrun!`, `consume!`, and
`release!`.

For normal `Process` workers, the default finalization is:

```julia
wait(slot.worker)
close(slot.worker)
```

That default is important because `close` stores the returned context back on
the process. After that, `consume!` can read `context(slot.worker)` and see the
finished values.

Define `finalize!` yourself when the default wait-and-close behavior is not the
right finish step. Common cases are:

- a custom worker type needs a different method to retrieve the final result,
- the worker returns a value that should be placed in `slot.result`,
- close should be delayed because the worker is owned by another object,
- extra validation must run before `consume!` reads the finished context.

Do not use `finalize!` for normal result accumulation. Put that in `consume!`,
which runs immediately after finalization.

## Chunked Inline Workers

Use `InlineChunkWorker` when each slot should keep an `InlineProcess` on one
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

## Recipe Callbacks

A recipe can be a named tuple or an object with methods for these callbacks.
Callbacks can accept fewer trailing arguments if they do not need all of them.
The recipe object is stored as a concrete field of the manager, so anonymous
functions in a named tuple are part of the manager type.

- `initstate(config, manager)`: build `manager.state` from user configuration.
- `makeworker(idx, manager)`: create process `idx` when `workers` is not passed.
- `makecontext(idx, manager, template)`: for manager-owned `Process` workers,
  build the context for slot `idx` from the template process.
- `prepare!(slot, job, manager)`: write one job into a process before it starts.
  This is the usual place to mutate context, call `reinitworker!`, or call
  `partialinitworker!`.
- `runarguments(slot, job, manager)`: return a named tuple of runtime keyword
  arguments for the implicit `run(...)` call. This callback may also run
  arbitrary manager-side code before launch. For example,
  `(; temperature = job.temperature)` becomes
  `run(slot.worker; temperature = job.temperature)`.
- `start!(slot, job, manager)`: advanced custom process start. If this callback
  exists, it replaces `runarguments` and the implicit `run(...)` call.
- `isdone(slot, manager)`: custom completion check. Defaults to
  `isdone(worker)` for `Process` workers.
- `finalize!(slot, job, manager)`: custom finish step called after the process
  has completed and before `afterrun!` and `consume!`. Defaults to
  `wait(worker); close(worker)` for `Process` workers.
- `afterrun!(slot, job, manager)`: optional hook after finalization.
- `consume!(slot, job, manager)`: read a finished process and accumulate output.
- `release!(slot, job, manager)`: clear local state after `consume!`.
- `flush!(manager)`: move slot-local buffers into manager state or another
  destination.
- `close!(slot, manager)`: custom process close.
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

## Context Reuse

The manager reuses the same process objects. Context reuse depends on what your
recipe does in `prepare!`.

Use direct mutation when only a few fields change. After mutating the context,
call `resetworker!(slot)` if the next run should restart the process counters
from the beginning:

```julia
prepare! = (slot, job, manager) -> begin
    ctx = context(slot.worker)[MyAlgo]
    ctx.x[] = job.x
    empty!(ctx.buffer)
    resetworker!(slot)
end
```

`resetworker!` does not reset context values. For a `Process`, it sets
`loopidx = 1`, `tickidx = 1`, `paused = false`, `shouldrun = true`,
`starttime = nothing`, and `endtime = nothing`, then calls
`reset!(getalgo(slot.worker))`. It does not replace `runtime_context`,
`task`, or `lastresult`. Arrays, refs, and other values already stored in
`context(slot.worker)` remain unchanged. In the example above, `ctx.x[]` keeps
the value assigned from `job.x`, and `ctx.buffer` is cleared only because the
recipe calls `empty!`.

Use `reinitworker!` when the job should replace the whole process context
through the normal init path:

```julia
prepare! = (slot, job, manager) -> reinitworker!(
    slot,
    Init(MyAlgo; x = job.x),
)
```

`reinitworker!` runs `init(getalgo(slot.worker), ...)` and installs the new
context on the process. Use it when previous context contents should not carry
into the next job.

Use `partialinitworker!` when only one algorithm or state target should be
rebuilt through its `init` method:

```julia
prepare! = (slot, job, manager) -> partialinitworker!(
    slot,
    Init(MyAlgo; x = job.x),
)
```

`partialinitworker!` starts from the current context and replaces only the
targeted subcontext values. Other subcontexts keep their current values.

Use `runarguments` for loop-level runtime `@input` values:

```julia
runarguments = (slot, job, manager) -> (; temperature = job.temperature)
```

You can use both for the same job. The manager calls `prepare!` first, then
`runarguments`, then `run(slot.worker; temperature = job.temperature)`.

Direct mutation is usually faster. `reinitworker!` and `partialinitworker!` are
useful when the context shape, inputs, or initialized state must be rebuilt. Do
not create a new `Process` inside a callback unless you intentionally want to
give up context reuse.

## Result Collection

Use `consume!` to read one finished process. This hook runs after the process
has finished and been finalized.

If processes are reused, avoid storing mutable context objects for later unless
you know they will not be overwritten. Store copied values instead:

```julia
consume! = (slot, job, manager) -> begin
    ctx = context(slot.worker)[MyAlgo]
    push!(manager.state.outputs, (; value = ctx.value[], loss = ctx.loss[]))
end
```

## Flush Policies

`flush_policy` controls when `flush!(manager)` is called.

- `FlushAtEnd()` is the default. It runs all jobs first, drains all active
  slots, then calls `flush!` once.
- `NoFlush()` never calls `flush!` automatically. Use this when `consume!`
  handles all result collection.
- `FlushEvery(n; drain = true)` calls `flush!` after every `n` completed
  process runs. When `drain = true`, all active slots are finalized before
  flushing. When `drain = false`, only already-finished slots are flushed.

`flush!` runs after finished values are available, so it can merge slot-local
buffers without making those buffers thread-safe.

## Manual Non-Threaded Scheduling

The manager also has a lower-level, polling-based interface:

```julia
dispatch!(manager, job)
poll!(manager)
drain!(manager)
```

Use this only when you need manual control over dispatch and polling. For normal
threaded `Process` runs, prefer `runthreaded!`.

`poll_interval = 0.0` means the manager yields while waiting. A positive
`poll_interval` sleeps for that many seconds between checks when all slots are
busy.

## Type Hints

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
fixed after construction and leaves room for processes with different concrete
types. `workers(manager)` returns the same fixed-shape tuple of process objects.

```@docs
Processes.ProcessManager
Processes.WorkerSlot
Processes.FlushPolicy
Processes.FlushAtEnd
Processes.NoFlush
Processes.FlushEvery
Processes.ThreadsType
Processes.Static
Processes.Dynamic
Processes.Greedy
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
Processes.runthreaded!
Processes.resetworker!
Processes.reinitworker!
Processes.partialinitworker!
```

## Manager-Owned Process Example

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

runthreaded!(manager, jobs)
manager.state.output
```

The manager calls `flush!` automatically according to `flush_policy`; normal
code does not call it directly.

## Existing Process Example

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

runthreaded!(manager, jobs)
manager.state.outputs
```

Use existing processes only when they must be owned or prepared outside the
manager. Otherwise prefer the manager-owned form with `makeworker`.
