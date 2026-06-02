#######################################
############# CONTEXT #################
#######################################
"""
Persistent state for a resolved process.

`ProcessContext` stores only named subcontexts and the registry needed to resolve
external references. Hot loop contexts use the same type with `reg::Nothing`.
Runtime inputs, loop handles, and transient step returns live in a separate hot
runtime `ProcessContext`.
"""
struct ProcessContext{D,R} <: AbstractContext
    subcontexts::D
    reg::R

    function ProcessContext{D,R}(subcontexts::D, reg::R) where {D,R}
        new{D,R}(subcontexts, reg)
    end
end

const HotContext = ProcessContext{D,Nothing} where {D}

"""
Combined execution frame used by finalization and views.

The state context remains persistent-state-only. The runtime context is a second
hot context that can be read through views while the loop kernel is active.
"""
struct ExecutionContext{StateC,RuntimeC} <: AbstractContext
    context::StateC
    runtimecontext::RuntimeC
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
