push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))

using Documenter
using Processes

makedocs(
    sitename = "Processes",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "Internals" => [
            "Registry" => "internals/registry.md",
            "Contexts" => "internals/contexts.md",
            "Routes and Shares" => "internals/routes_shares.md",
            "Process Pipeline" => "internals/process_pipeline.md",
        ],
        "User API" => [
            "Algorithms and States" => "user/algorithms_states.md",
            "Contexts and Indexing" => "user/contexts.md",
            "Routes and Shares" => "user/routes_shares.md",
            "Inputs and Overrides" => "user/inputs_overrides.md",
            "Running, Wait, Fetch" => "user/running.md",
            "Value Semantics and Unique" => "user/value_semantics.md",
        ],
        "Usage Guide (Legacy)" => "man/usage.md",
    ],
)

deploydocs(
    repo = "github.com/f-ij/Processes.jl.git",
    devbranch = "main",
    versions = ["v#.#", "dev" => "dev"],
)
