"""
ProcessAlgorithm package with explicitly scoped child algorithms.

`Package` is registered as one root process algorithm. Its children are
`SubPackage` wrappers that carry package-local identity and aliases, so the
children can resolve views and call multipliers through the containing package
without being root registry entries themselves.

`funcs` contains only stepped children. `states` are initialized before those
children and seed the shared package subcontext. `registry` is package-local:
it aggregates matching child execution points so init-time tools such as
`processsizehint!` can ask how often a child algorithm will step without making
children root registry entries. `Intervals` and `CustomName` are type
parameters so schedule and registry-generated names stay compile-time visible.
"""
struct Package{Funcs, States, Intervals, CustomName, Registry} <: ProcessAlgorithm
    funcs::Funcs
    states::States
    inc::Base.RefValue{Int}
    registry::Registry
end
