# [Copying and Process Management](@id copying_and_management_user)

```@meta
CurrentModule = ProcessesExtensionsDocs
```

This page documents the process-copy and bounded-process-management utilities implemented in
`src/Copy.jl` and `src/ProcessManager.jl`.

At the moment these files are standalone utilities in the repository and are not yet included
from `Processes.jl`, so the examples here assume those files have been loaded in the same way
as the docs and tests do.

## Why Copy Instead of `deepcopy`

`Process` contexts are often built from `Input(...)` values that point at external storage,
buffers, or data views. A raw `deepcopy` of the live context can therefore copy the wrong
thing or preserve sharing that should be rebuilt per process.

The copying helpers work from `TaskData` and the normal init pipeline instead:

- copy the task description,
- replace selected inputs and overrides,
- initialize a fresh context for each copy.

## Copy APIs

```@docs
copyinputs
copyoverrides
copytaskdata
copyprocess
```

## Typical Copy Pattern

```julia
template = Process(
    MyAlgo,
    Input(MyAlgo, :start => 0, :buffer => Int[]),
    Override(MyAlgo, :delta => 2);
    lifetime = 10,
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

## Managed Execution

`ProcessManager` and `manageprocesses` are for running many processes while limiting how many
are active at once.

This is useful when you have a list of job properties and want to:

- build one process per property,
- keep at most `N` running concurrently,
- save large results to disk as soon as each process finishes.

```@docs
ManagedProcessResult
ProcessManager
manageprocesses
savecontext
```

## Property-Driven Manager Example

```julia
jobs = [
    (; start = 1, buffer = Int[]),
    (; start = 10, buffer = Int[]),
    (; start = 100, buffer = Int[]),
]

results = manageprocesses(jobs; max_running = 2) do job, idx
    process = Process(
        MyAlgo,
        Input(MyAlgo, :start => job.start, :buffer => job.buffer),
        Override(MyAlgo, :delta => 3);
        lifetime = 20,
    )

    (; process, savefile = "job_$idx.jld2")
end
```

The result vector stays in the same order as `jobs`, even when completion order differs.

## Template-Based Manager Example

```julia
template = Process(
    MyAlgo,
    Input(MyAlgo, :start => 0, :buffer => Int[]),
    Override(MyAlgo, :delta => 3);
    lifetime = 20,
)

results = manageprocesses(template, jobs,
    job -> (;
        inputs = Input(MyAlgo, :start => job.start, :buffer => job.buffer),
        savefile = "job_$(job.start).jld2",
    );
    max_running = 2,
    savefolder = "saved_contexts",
)
```

When `savefolder` is provided, finished contexts are written to JLD2 files and omitted from the
in-memory result payload.
