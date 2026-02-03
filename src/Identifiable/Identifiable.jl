function nameoftype(f)
    if f isa Type
        return nameof(f)
    else
        return nameof(typeof(f))
    end
end

#################################
######## RELEVANT TRAITS ########
#################################
isidentifiable(obj) = false # Trait to signify that an algorithm has an identity

include("VarAlias.jl")
include("StructDef.jl")
include("IdentifiableAlgos.jl")
include("Prepare.jl")
include("Step.jl")