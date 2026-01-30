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

"""
A location of a variable in subcontext: subcontextname and which has the local name there: originalname
the type parameter indicates whether its a local, shared or routed variable
TODO: is type really neccesary anywhere?
"""
struct VarLocation{Type, subcontextname, originalname} end
VarLocation{Type}(subcontextname::Symbol, originalname::Symbol) where {Type} = VarLocation{Type, subcontextname, originalname}()
VarLocation(type, subcontextname::Symbol, originalname::Symbol) = VarLocation{type, subcontextname, originalname}()

@inline get_subcontextname(vl::Union{VarLocation{T, SCN, ON}, Type{<:VarLocation{T, SCN, ON}}}) where {T, SCN, ON} = SCN
@inline get_originalname(vl::Union{VarLocation{T, SCN, ON}, Type{<:VarLocation{T, SCN, ON}}}) where {T, SCN, ON} = ON


struct SubContextView{CType, SubName, T, NT, VarAliases} <: AbstractContext
    context::CType
    instance::T # ScopedInstance for which the view is created
    inject::NT

    function SubContextView{CType, SubName, T, NT}(context::CType, instance::T; inject::NT = (;)) where {CType, SubName, T, NT}
        new{CType, SubName, T, typeof(inject), varaliases(instance)}(context, instance, inject)
    end
end
