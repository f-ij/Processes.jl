"""
ProcessAlgorithm package with explicitly scoped child algorithms.

`NewPackage` is registered as one root process algorithm. Its children are
`NewSubPackage` wrappers that carry package-local identity and aliases, so the
children can resolve views and call multipliers through the containing package
without being root registry entries themselves.

`funcs` contains only stepped children. `states` are initialized before those
children and seed the shared package subcontext. `Intervals` and `ID` are type
parameters so schedule and package-child matching stay compile-time visible.
"""
struct NewPackage{Funcs, States, Intervals, ID} <: ProcessAlgorithm
    funcs::Funcs
    states::States
    inc::Base.RefValue{Int}
end
