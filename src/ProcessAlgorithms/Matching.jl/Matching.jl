
#=
This file is part of Processes.jl
It will define define how ProcessAlgorithms/ProcessStates or general objects that go into Registries 
    and subsequently Contexts are matched and located.

Matching is a trait that can be extended by extending the function match_by(obj)

Any object by default matches by its own identity (i.e. itself)

Isbits values can be statically mactched during compile time, which is important for performance of the registry
    system and context system.
    This makes values of structs work like constant symbols in Julia, which are matched to struct fields during compilation,
    similar to how Julia matches constant symbols to fields in structs during compilation.

Thin containers are containers that by definition don't change the matching identity of the object they contain. 
Thin containers might be deprecated in the future in favor of just using the id system.
=#


include("ThinContainers.jl")
include("Ids.jl")

match_by(obj::Any) = obj

function match(obj1, obj2)
    id1 = match_by(obj1)
    id2 = match_by(obj2)
    return id1 === id2
end