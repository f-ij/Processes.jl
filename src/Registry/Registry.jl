export get_registry, add_instance, add, find_entry, find_typeidx
## BUILDS ON THINCONTAINERS
include("Utils.jl")
include("PreferWeakKeyDict.jl")

include("TypeEntries.jl")
include("Registries.jl")
include("SimpleRegistry.jl")
include("Updating.jl")
include("Matchers.jl")
# include("Prepare.jl")

