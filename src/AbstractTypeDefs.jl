abstract type SteppableAlgorithm end

abstract type ProcessAlgorithm <: SteppableAlgorithm end
abstract type AbstractOption end
abstract type AbstractWiring end
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
Type-level namespace marker for a resolved plan child.

Resolved loop plans step raw child algorithms, so the child context key must be
carried beside the algorithm rather than inside an `IdentifiableAlgo` wrapper.
"""
struct Namespace{Name} end

"""Return the symbol carried by a `Namespace` value or type."""
@inline namesymbol(::Union{Namespace{Name}, Type{<:Namespace{Name}}}) where {Name} = Name

"""
Tuple-like child container whose names are stored in the type.

`TupleWithNames{Names,T}` keeps the raw child algorithm tuple in `container`
while preserving the registry namespace for every child in the `Names` type
parameter. Unlike `NamedTuple`, duplicate names are allowed.
"""
struct TupleWithNames{Names,T}
    container::T
end

"""Construct a named child tuple from a tuple of symbols and a raw tuple."""
@inline TupleWithNames(names::Names, container::T) where {Names<:Tuple, T<:Tuple} =
    TupleWithNames{names,T}(container)

"""Return the raw tuple stored by a named child tuple."""
@inline rawtuple(twn::TupleWithNames) = getfield(twn, :container)

"""Return the type-level names stored by a named child tuple."""
@inline tuplenames(::Union{TupleWithNames{Names}, Type{<:TupleWithNames{Names}}}) where {Names} = Names

@inline Base.length(twn::TupleWithNames) = length(rawtuple(twn))
@inline Base.getindex(twn::TupleWithNames, idx) = getfield(rawtuple(twn), idx)
@inline Base.iterate(twn::TupleWithNames) = iterate(rawtuple(twn))
@inline Base.iterate(twn::TupleWithNames, state) = iterate(rawtuple(twn), state)

"""Return raw child algorithms from either a plain tuple or `TupleWithNames`."""
@inline _raw_plan_funcs(funcs::Tuple) = funcs
@inline _raw_plan_funcs(funcs::TupleWithNames) = rawtuple(funcs)

"""Return type-level namespace symbols when a child tuple carries them."""
@inline _plan_func_names(::Tuple) = nothing
@inline _plan_func_names(funcs::TupleWithNames) = tuplenames(funcs)
@inline _plan_func_names_type(::Type{<:Tuple}) = nothing
@inline _plan_func_names_type(::Type{<:TupleWithNames{Names}}) where {Names} = Names

"""Reconstruct the namespace tuple for a resolved `TupleWithNames` from type data."""
@inline @generated function namespaces_from_type(::Type{<:TupleWithNames{Names,T}}) where {Names,T}
    return Expr(:tuple, (:(Namespace{$(QuoteNode(name))}()) for name in Names)...)
end

"""Return the namespace tuple carried by a resolved child container."""
@inline namespaces(funcs::TupleWithNames) = namespaces_from_type(typeof(funcs))

"""
Attach route/share wiring to the local plan node that emitted it.

Plain `Route` and `Share` values are top-level plan routing metadata. The DSL
uses this wrapper when a route/share belongs to a specific statement-local child
plan, including cases where the endpoint is nested or state-owned. Constructor
parsing keeps the option with that local plan node while preserving the original
option for normal route resolution.
"""
struct LocalPlanOption{Owner, Option} <: AbstractWiring
    owner::Owner
    option::Option
end

"""
Route and share sets passed through plan construction and execution.

`routes` and `shares` are kept in separate fields so generated view code can
specialize on the route and share tuples without filtering mixed values.
"""
struct Wiring{Routes, Shares} <: AbstractWiring
    routes::Routes
    shares::Shares
end

Wiring(routes::Routes, shares::Shares) where {Routes<:Tuple, Shares<:Tuple} = Wiring{Routes, Shares}(routes, shares)
Wiring() = Wiring((), ())

"""
Plan-level wiring propagated through composite and routine execution.

`global_wiring` records grouped plan-global wiring for inspection and
propagation during resolution. After resolution, global wiring is already
inlaid into the concrete child `Wiring` buckets. `child_wiring` is indexed by
child position and contains the exact wiring value passed to that child:
`Wiring` for concrete executable children and `PlanWiring` for nested loop
plans.
"""
struct PlanWiring{GlobalWiring, ChildWiring} <: AbstractWiring
    global_wiring::GlobalWiring
    child_wiring::ChildWiring
end

PlanWiring(global_wiring::GlobalWiring, child_wiring::ChildWiring) where {GlobalWiring, ChildWiring<:Tuple} =
    PlanWiring{GlobalWiring, ChildWiring}(global_wiring, child_wiring)
PlanWiring() = PlanWiring(Wiring(), ())

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
