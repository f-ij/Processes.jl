push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))

using Documenter
using Processes

module ProcessesExtensionsDocs
using UUIDs
using JLD2
using Processes

import ..Processes: Process, TaskData, Input, Override, NamedInput, NamedOverride,
    ProcessContext, normalize_process_algo, getregistry, to_named, get_target_name,
    getinputs, getoverrides, getlifetime, getalgo, taskdata, init_context,
    processlist, remove_process!, RuntimeListeners, context, task, deletekeys

include(joinpath(@__DIR__, "..", "src", "Copy.jl"))
include(joinpath(@__DIR__, "..", "src", "ProcessManager.jl"))
end

makedocs(
    modules = [ProcessesExtensionsDocs],
    checkdocs = :exports,
    sitename = "Processes",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "User Documentation" => [
            "Algorithms and States" => "user/algorithms_states.md",
            "Referencing Algorithms" => "user/referencing_algorithms.md",
            "Contexts and Indexing" => "user/contexts.md",
            "Routes and Shares" => "user/routes_shares.md",
            "Inputs and Overrides" => "user/inputs_overrides.md",
            "Vars (Var Selectors)" => "user/vars.md",
            "Lifetime" => "user/lifetime.md",
            "Running, Wait, Fetch" => "user/running.md",
            "Copying and Process Management" => "user/copying_and_management.md",
            "Value Semantics and Unique" => "user/value_semantics.md",
        ],
        "Internals" => [
            "Registry" => "internals/registry.md",
            "Contexts" => "internals/contexts.md",
            "Routes and Shares" => "internals/routes_shares.md",
            "Process Pipeline" => "internals/process_pipeline.md",
        ],
    ],
)

deploydocs(
    repo = "github.com/f-ij/Processes.jl.git",
    devbranch = "main",
    versions = ["stable" => "dev", "dev" => "dev"],
)
