#######################################
############# CONTEXT #################
#######################################
"""
Previously args system
This stores the context of a process
"""
# mutable struct ProcessContext{D,Reg,R,I,W} <: AbstractContext
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
Lightweight context used only inside leaf-step dispatch.

Runtime-generated child kernels pass the needed `SubContext{Name,T}` values
positionally. Leaf algorithm stepping then materializes this narrow context on
demand so the public two-argument `step!(algo, context)` interface can keep the
same semantics as the old `SubContextView` path.
"""
struct OnDemandContext{D,Reg,R,I,W} <: AbstractScopedContext
    subcontexts::D
    registry::Reg
    _runtime::R
    _input::I
    _widened::W
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

"""
    SubContext(name, data)

Construct a typed immutable subcontext whose logical key is stored in the type.
This keeps the subcontext identity available to generated and runtime-generated
merge paths without carrying an extra runtime field.
"""
@inline function SubContext(name::Symbol, data::T) where {T<:NamedTuple}
    return Core.apply_type(SubContext, name, T)(data)
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
