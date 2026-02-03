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

include("VarAlias.jl")
include("StructDef.jl")
include("IdentifiableAlgos.jl")
include("Prepare.jl")
include("Step.jl")