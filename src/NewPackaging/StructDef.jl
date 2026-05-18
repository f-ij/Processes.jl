"""
ProcessAlgorithm package that owns its child execution locally.

`NewPackage` is intentionally not an `AbstractIdentifiableAlgo` and does not
register its children as subpackages. The outer process sees one normal
`ProcessAlgorithm`; package init/step then orchestrate the enclosed algorithms
inside the package subcontext.
"""
struct NewPackage{Funcs, InitFuncs, Intervals, CustomName} <: ProcessAlgorithm
    funcs::Funcs
    initfuncs::InitFuncs
    inc::Base.RefValue{Int}
end
