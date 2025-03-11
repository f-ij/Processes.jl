push!(LOAD_PATH,"../src/")

using Documenter
using Processes

deploydocs(
    repo = "github.com/f-ij/Processes.jl.git",
)

makedocs(
    sitename = "Processes",
    format = Documenter.HTML(),
    # modules = [Processes],
    # checkdocs=:exports,
    pages = [
        "Index" => "index.md",
        "General Usage" => "man/usage.md"
    ]
)

