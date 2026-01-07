unique_instances(a::Any) = (a,)
unique_instances(r::Union{Routine, CompositeAlgorithm}) = r.instances
function unique_instances(tuple::Tuple)
    insts = collect(Base.Flatten(unique_instances.(tuple)))
    filtered_instances = []
    for (inst_i, inst) in enumerate(insts)
        if any(map(x -> x === inst, insts[1:inst_i-1]))
            continue
        else
            push!(filtered_instances, inst)
        end
    end
    return (filtered_instances...,)
end
# instances(tuple::Tuple, rc::Union{Routine, CompositeAlgorithm}) = instances((tuple..., rc.instances...))
