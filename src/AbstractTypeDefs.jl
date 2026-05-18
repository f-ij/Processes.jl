abstract type SteppableAlgorithm end

abstract type ProcessAlgorithm <: SteppableAlgorithm end
abstract type AbstractOption end
abstract type ProcessState <: AbstractOption end
abstract type ParserOption end

struct IfWrapped{A,C} <: ParserOption
    algo::A
    cond::C
end

"""
Supertype for loop-like algorithms and loop runtime wrappers.

`CompositeAlgorithm` and `Routine` are execution-plan nodes: they describe the
child algorithms, schedule metadata, and local plan wiring. `LoopAlgorithm` is
the concrete runtime wrapper that carries registry, context, input, override,
and root-state lifecycle data around one of those plans.
"""
abstract type AbstractLoopAlgorithm <: SteppableAlgorithm end

"""
Runtime wrapper for a loop execution plan.

The `plan` field is the stable "what runs" part, usually a `CompositeAlgorithm`
or `Routine`. The remaining fields describe the runtime environment in which
that plan is resolved or initialized: root states, resolved options, registry,
stored context, initializers, and overrides. Reinitialization should replace
this wrapper/lifecycle data without changing the type of the wrapped plan.
"""
struct LoopAlgorithm{Plan, S, O, R, C, Inits, Overrides, id} <: AbstractLoopAlgorithm
    plan::Plan
    states::S
    options::O
    reg::R
    context::C
    inits::Inits
    overrides::Overrides
end

"""
Attach a route/share option to the local plan node that emitted it.

Plain `Route` and `Share` values are top-level plan routing metadata. The DSL
uses this wrapper when a route/share belongs to a specific statement-local child
plan, including cases where the endpoint is nested or state-owned. Constructor
parsing keeps the option with that local plan node while preserving the original
option for normal route resolution.
"""
struct LocalPlanOption{Owner, Option} <: AbstractOption
    owner::Owner
    option::Option
end

"""
Resolved route/share wiring for one child step.

The concrete type parameters are the important part: `SharedContexts` and
`SharedVars` are tuples of already-resolved backend routing objects, and
`ChildWiring` is the nested per-child routing tuple for loop-algorithm children.
`SubContextView` construction and nested plan stepping can therefore specialize
on routing at compile time instead of resolving raw `Route`/`Share` options
during every `step!`.
"""
struct StepRouting{SharedContexts, SharedVars, ChildWiring}
    sharedcontexts::SharedContexts
    sharedvars::SharedVars
    childwiring::ChildWiring
end

StepRouting(sharedcontexts, sharedvars) = StepRouting(sharedcontexts, sharedvars, ())
StepRouting() = StepRouting((), (), ())

Base.iterate(la::ALA) where {ALA<:AbstractLoopAlgorithm} = iterate(getalgos(la))



abstract type AbstractContext end
abstract type AbstractSubContext end


abstract type AbstractAVec{T} <: AbstractVector{T} end

"""
And AbstractRegistry has some overlap in functionality with Sets
- However, identity is determined by the match_by
- Also registries need to have type stable getindex, so that types can be inferred
    at compile time
- This allows for unrollable loops over registry entries, which is important for performance in the contexts that use them
"""
abstract type AbstractRegistry end

"""
One should have a method for keys
Then one should match the type of idx item returned by static_findfirst_match
"""
Base.getindex(r::AbstractRegistry, key) = error("getindex not implemented for $(typeof(r))")
all_algos(r::AbstractRegistry) = error("all_algos not implemented for $(typeof(r))")
static_get(r::AbstractRegistry, key) = error("static_get not implemented for $(typeof(r))")
static_get_multiplier(r::AbstractRegistry, key) = error("static_get_multiplier not implemented for $(typeof(r))")
add(r::AbstractRegistry, obj, multiplier = 1.; withkey = nothing) = error("add not implemented for $(typeof(r))")
inherit(parent::AbstractRegistry, child::AbstractRegistry) = error("inherit not implemented for $(typeof(parent)) and $(typeof(child))")
static_findfirst_match(r::AbstractRegistry, val) = error("static_findfirst_match not implemented for $(typeof(r))")

"""
Get a key, errors if not present
"""
Base.getkey(r::AbstractRegistry, obj) = error("getkey not implemented for $(typeof(r))")
"""
Find a key, returns nothing if not present
"""
static_findkey(r::AbstractRegistry, obj) = error("static_findkey not implemented for $(typeof(r))")

#### Processloop type
abstract type FunctionType end
struct Generated <: FunctionType end
struct NonGenerated <: FunctionType end

struct Resuming{isresuming} end
"""
The type of loop to use for a process. This is determined by the system and can be used to switch between generated and non-generated loops.
"""
# const sys_looptype = @static if Sys.isapple() || Sys.iswindows()
#     NonGenerated()
# else
#     Generated()
# end
const sys_looptype = NonGenerated()
    

#### Type Stabliity of steps
abstract type Stability end
struct Stable <: Stability end
struct Unstable <: Stability end
