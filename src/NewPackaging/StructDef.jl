"""
ProcessAlgorithm package that owns its child execution locally.

`NewPackage` is intentionally not an `AbstractIdentifiableAlgo` and does not
register its children as subpackages. The outer process sees one normal
`ProcessAlgorithm`; package init/step then orchestrate the enclosed algorithms
inside the package subcontext.

`funcs` are the only executable children. `states` are init-only process
states that seed the package subcontext, and `aliases` is a child-aligned tuple
of `VarAliases` objects used when creating each child view.
"""
struct NewPackage{Funcs, States, Intervals, Aliases, CustomName} <: ProcessAlgorithm
    funcs::Funcs
    states::States
    aliases::Aliases
    inc::Base.RefValue{Int}
end
