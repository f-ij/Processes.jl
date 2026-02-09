#######################################
############# CONTEXT #################
#######################################
"""
Previously args system
This stores the context of a process
"""
struct ProcessContext{D,Reg} <: AbstractContext
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
A subcontext can share share in two ways:
    1) Whole subcontext shares:         The entire subcontext is shared between processes
    2) Variable shares through shared vars: Only specific variables are shared between subcontexts, 
                                                defined by shared vars with optional aliases
"""
struct SubContext{Name, T<:NamedTuple, S, SV} <: AbstractSubContext
    data::T
    sharedcontexts::S # Whole subcontext shares
    sharedvars::SV # Variable shares with aliases
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
