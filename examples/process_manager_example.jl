using Processes

import Processes: Process, TaskData, Input, Override, NamedInput, NamedOverride,
    ProcessContext, normalize_process_algo, getregistry, to_named, get_target_name,
    getinputs, getoverrides, getlifetime, getalgo, taskdata, initcontext,
    processlist, remove_process!, RuntimeListeners, context, task, deletekeys

# `ProcessManager.jl` and `Copy.jl` are currently standalone utilities.
include(joinpath(@__DIR__, "..", "src", "Copy.jl"))
include(joinpath(@__DIR__, "..", "src", "ProcessManager.jl"))

struct ManagedAccumulator <: Processes.ProcessAlgorithm end

function Processes.init(::ManagedAccumulator, context)
    (; start) = context
    return (; value = start)
end

function Processes.step!(::ManagedAccumulator, context)
    return (; value = context.value + context.delta)
end

jobs = [
    (; start = 1, delta = 2, steps = 4),
    (; start = 10, delta = 3, steps = 5),
    (; start = 100, delta = 10, steps = 3),
]

results = manageprocesses(jobs; max_running = 2, throw = true) do job, _
    Process(
        ManagedAccumulator,
        Input(ManagedAccumulator, :start => job.start),
        Override(ManagedAccumulator, :delta => job.delta);
        lifetime = job.steps,
    )
end

println("Process manager results:")
for result in results
    final_value = result.context[ManagedAccumulator].value
    println(
        "job ", result.idx,
        ": start=", result.property.start,
        ", delta=", result.property.delta,
        ", steps=", result.property.steps,
        ", final value=", final_value,
    )
end
