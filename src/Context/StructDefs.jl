#######################################
############# CONTEXT #################
#######################################
"""
Previously args system
This stores the context of a process
"""
# mutable struct ProcessContext{D,Reg,R,I,W} <: AbstractScopedContext
struct ProcessContext{D,Reg,R,I,W} <: AbstractScopedContext
    subcontexts::D
    registry::Reg
    _runtime::R
    _input::I
    _widened::W
    function ProcessContext{D,Reg,R,I,W}(
        subcontexts::D,
        registry::Reg,
        runtime::R,
        input::I,
        widened::W,
    ) where {D,Reg,R,I,W}
        new{D,Reg,R,I,W}(subcontexts, registry, runtime, input, widened)
    end
end

"""
Transient scoped context rebuilt only at the leaf `step!(algo, context)` API.

Loop plans in the `NonGenerated()` path thread subcontexts, runtime, inputs,
and widened state separately. When a concrete `ProcessAlgorithm` needs the
existing context/view API, those local bindings are wrapped in an
`OnDemandContext` instead of rebuilding the entire outer `ProcessContext`.
"""
struct OnDemandContext{D,Reg,R,I,W} <: AbstractScopedContext
    subcontexts::D
    registry::Reg
    _runtime::R
    _input::I
    _widened::W

    function OnDemandContext{D,Reg,R,I,W}(
        subcontexts::D,
        registry::Reg,
        runtime::R,
        input::I,
        widened::W,
    ) where {D,Reg,R,I,W}
        new{D,Reg,R,I,W}(subcontexts, registry, runtime, input, widened)
    end
end


########################
    ### SUBCONTEXT ###
########################

"""
Named local data bucket for one registered process entity.

Route/share metadata deliberately does not live on `SubContext`. Plan routing is
applied through `SubContextView` at step time so context shape stays independent
from execution-plan wiring.
"""
struct SubContext{T<:NamedTuple} <: AbstractSubContext
    name::Symbol
    data::T
end

export inject
#######################
### SUBCONTEXT VIEW ###
#######################

"""
Go from a local variable to the location in the full context
Type can be
    - :local
    - :shared
    - :routed
"""
