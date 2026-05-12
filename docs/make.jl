push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))

using Documenter
using Processes

Base.include(Processes, joinpath(@__DIR__, "..", "src", "ContextAnalyzer", "ContextAnalyzer.jl"))

makedocs(
    modules = [Processes],
    checkdocs = :none,
    sitename = "Processes",
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "User Documentation" => [
            "Algorithms and States" => "user/algorithms_states.md",
            "Referencing Algorithms" => "user/referencing_algorithms.md",
            "Contexts and Indexing" => "user/contexts.md",
            "Init Analysis" => "user/init_analysis.md",
            "Routes and Shares" => "user/routes_shares.md",
            "Inputs and Overrides" => "user/inputs_overrides.md",
            "Vars (Var Selectors)" => "user/vars.md",
            "Interactive Contexts" => "user/interactive.md",
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
