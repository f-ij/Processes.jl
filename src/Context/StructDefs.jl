#######################################
############# CONTEXT #################
#######################################
"""
Previously args system
This stores the context of a process
"""
# mutable struct ProcessContext{D,Reg,R,I} <: AbstractContext
struct ProcessContext{D,Reg,R,I} <: AbstractContext
    subcontexts::D
    registry::Reg
    _runtime::R
    _input::I
    _widened::Any
    function ProcessContext{D,Reg,R,I}(
        subcontexts::D,
        registry::Reg,
        runtime::R,
        input::I,
        widened = (;),
    ) where {D,Reg,R,I}
        new{D,Reg,R,I}(subcontexts, registry, runtime, input, widened)
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
