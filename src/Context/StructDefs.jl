#######################################
############# CONTEXT #################
#######################################
"""
Previously args system
This stores the context of a process
"""
mutable struct ProcessContext{D,Reg} <: AbstractContext
# struct ProcessContext{D,Reg} <: AbstractContext
    subcontexts::D
    registry::Reg
    function ProcessContext{D,Reg}(subcontexts::D, registry::Reg) where {D,Reg}
        new{D,Reg}(subcontexts, registry)
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
struct SubContext{Name, T<:NamedTuple} <: AbstractSubContext
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
