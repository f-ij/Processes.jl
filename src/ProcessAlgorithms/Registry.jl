
getmultiplier(cla::ComplexLoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getname(cla::ComplexLoopAlgorithm, obj) = getname(getregistry(cla), obj)

"""
Namespace registry but with static type_same instead of dict
    (# Tuple for type 1 (namedinstance1, namedinstance2, ...), # Tuple for type 2 (...), ...)
"""
struct NameSpaceRegistry{T,TT}
    instances::T
    multipliers::TT
end

"""
get the deduped types from the registry
"""
@generated function gettypes(reg::Type{NameSpaceRegistry{T,TT}}) where {T,TT}
    tupletypes = T.parameters
    typess = getproperty.(tupletypes, :parameters)
    firsttypes = first.(typess)
    algtypes = map(ft -> ft <: NamedAlgorithm ? ft.parameters[1] : ft, firsttypes)
    Tt = Tuple{algtypes...}
    return :($Tt)
end

@generated function gettypes_iterator(reg::Type{NameSpaceRegistry{T,TT}}) where {T,TT}
    tupletypes = T.parameters
    typess = getproperty.(tupletypes, :parameters)
    firsttypes = first.(typess)
    algtypes = tuple(map(ft -> ft <: NamedAlgorithm ? ft.parameters[1] : ft, firsttypes)...)

    return :($algtypes)
end

gettypes(reg::NameSpaceRegistry) = gettypes(typeof(reg))
gettypes_iterator(reg::NameSpaceRegistry) = gettypes_iterator(typeof(reg))

findinstance(typeref::Tuple, obj) = findfirst(inst -> isinstance(inst, obj), typeref)

"""
Get the name of a registered object if it's in the registry
"""
@generated function getname(reg::NameSpaceRegistry{T,TT}, obj::O) where {T,TT,O}
    types = gettypes_iterator(reg)
    index = findfirst(typ -> typ == O, types)
    if index === nothing
        error("Object of type $(O) not found in registry")
    end
    
    return quote 
        f_idx = findinstance(reg.instances[$index], obj)
        if f_idx === nothing
            error("Object not found in registry")
        end
        reg.instances[$index][f_idx] |> getname
    end
end

@generated function getmultiplier(reg::NameSpaceRegistry{T,TT}, obj::O) where {T,TT,O}
    types = gettypes_iterator(reg)
    index = findfirst(typ -> typ == O, types)
    if index === nothing
        error("Object of type $(O) not found in registry")
    end
    return quote 
        f_idx = findinstance(reg.instances[$index], obj)
        if f_idx === nothing
            error("Object not found in registry")
        end
        reg.multipliers[$index][f_idx]
    end
end

hastype(reg::NameSpaceRegistry{T,TT}, typ) where {T,TT} = typ in gettypes_iterator(reg)

"""
Expects a non-named object and returns a new registry and the assigned name
    Can accept a number of multipliers of how many times this instances is added
"""
function add_instance(reg::NameSpaceRegistry{T}, obj, count = 1.) where {T}
    all_instances = reg.instances
    all_multipliers = reg.multipliers
    obj_type = typeof(obj)
    for (first_idx, instances_of_type) in enumerate(all_instances)
        multipliers_by_type = all_multipliers[first_idx]
        if algotype(instances_of_type[1]) == obj_type
            for (second_idx, inst) in enumerate(instances_of_type)
                if isinstance(inst, obj)
                    new_multipliers_by_type = Base.setindex(multipliers_by_type, multipliers_by_type[second_idx] + count, second_idx)
                    new_multipliers = Base.setindex(all_multipliers, new_multipliers_by_type, first_idx)
                    newreg = NameSpaceRegistry(all_instances, new_multipliers)
                    return newreg, inst
                end
            end
            inst_name = Symbol(:_, nameof(obj_type), :_, length(instances_of_type) + 1)
            named_obj = NamedAlgorithm(obj, inst_name)
            new_instances_of_type = (instances_of_type..., named_obj)
            new_all_instances = Base.setindex(all_instances, new_instances_of_type, first_idx)
            new_multipliers_by_type = (multipliers_by_type..., count)
            new_multipliers = Base.setindex(all_multipliers, new_multipliers_by_type, first_idx)
            newreg = NameSpaceRegistry(new_all_instances, new_multipliers)
            return newreg, named_obj
        end
    end

    inst_name = Symbol(:_, nameof(obj_type), :_, 1)
    named_obj = NamedAlgorithm(obj, inst_name)
    new_all_instances = (all_instances..., (named_obj,))
    new_all_multipliers = (all_multipliers..., (count,))
    newreg = NameSpaceRegistry(new_all_instances, new_all_multipliers)
    return newreg, named_obj
end

function get_named_instance(reg::NameSpaceRegistry, obj, count = 1.)
    return add_instance(reg, obj, count)
end

"""
Scale every multiplier in the registry by a constant factor.
"""
function scale_multipliers(reg::NameSpaceRegistry, factor::Number)
    factor == 1 && return reg
    scaled_groups = map(reg.multipliers) do group
        map(mult -> mult * factor, group)
    end
    return NameSpaceRegistry(reg.instances, scaled_groups)
end

"""
Merge two registries, returning a combined registry and the name replacements that must be applied
    to the objects coming from `reg2` so their namespaces agree with `reg1`.
"""
function merge_registries(reg1::NameSpaceRegistry, reg2::NameSpaceRegistry)
    replacements = Pair{Symbol,Symbol}[]
    base_instances = reg1.instances
    base_multipliers = reg1.multipliers
    type_positions = Dict{Any,Int}()
    for (idx, typ) in enumerate(gettypes_iterator(reg1))
        type_positions[typ] = idx
    end

    reg_instances = reg2.instances
    reg_multipliers = reg2.multipliers
    types = gettypes_iterator(reg2)
    for (type_idx, typ) in enumerate(types)
        existing_idx = get(type_positions, typ, 0)
        if existing_idx == 0
            base_instances = (base_instances..., reg_instances[type_idx])
            base_multipliers = (base_multipliers..., reg_multipliers[type_idx])
            type_positions[typ] = length(base_instances)
        else
            type_instances1 = base_instances[existing_idx]
            type_instances2 = reg_instances[type_idx]
            multipliers_by_type1 = base_multipliers[existing_idx]
            multipliers_by_type2 = reg_multipliers[type_idx]
            new_type_instances, new_multipliers_by_type, repls = merge_by_type(type_instances1, type_instances2, multipliers_by_type1, multipliers_by_type2)
            base_instances = Base.setindex(base_instances, new_type_instances, existing_idx)
            base_multipliers = Base.setindex(base_multipliers, new_multipliers_by_type, existing_idx)
            append!(replacements, repls)
        end
    end

    newreg = NameSpaceRegistry(base_instances, base_multipliers)
    return newreg, replacements
end

"""
Already found that instances1 and instances2 are of the same types
    Merge them and return the new instances and multipliers

    I.e. take the names out of instances 2 and add them to instances1 with new names if needed
"""
function merge_by_type(instances1, instances2, multipliers1, multipliers2)
    new_instances = instances1
    new_multipliers = multipliers1
    replacements = Pair{Symbol,Symbol}[]
    for (inst2_idx, inst2) in enumerate(instances2)
        count2 = multipliers2[inst2_idx]
        match_idx = findfirst(inst1 -> inst1 === inst2, new_instances)
        if match_idx === nothing
            inst_name = Symbol(:_, nameof(algotype(inst2)), :_, length(new_instances) + 1)
            renamed = changename(inst2, inst_name)
            new_instances = (new_instances..., renamed)
            new_multipliers = (new_multipliers..., count2)
            push!(replacements, getname(inst2) => inst_name)
        else
            new_multipliers = Base.setindex(new_multipliers, new_multipliers[match_idx] + count2, match_idx)
        end
    end
    return new_instances, new_multipliers, replacements
end


#### CONSTRUCTORS #####
NameSpaceRegistry() = NameSpaceRegistry(tuple(), tuple())

"""
Should only be used if all items that need a name are already named
"""
function NameSpaceRegistry(items_tuple::Tuple)
    regs = NameSpaceRegistry.(items_tuple)
    isempty(regs) && return NameSpaceRegistry()
    reg = regs[1]
    for next_reg in regs[2:end]
        reg, _ = merge_registries(reg, next_reg)
    end
    return reg
end

function NameSpaceRegistry(item::Any)
    if needsname(item)
        if !hasname(item)
            error("Item of type $(typeof(item)) needs a name but has none")
        end
        return NameSpaceRegistry(((item,),), ((1,),))
    else
        return NameSpaceRegistry()
    end
end

function Base.iterate(flat::Iterators.Flatten{<:NameSpaceRegistry}, state = (1, 1))
    outer_idx, inner_state = state
    if outer_idx > length(flat.it.instances)
        return nothing
    end
    current_iter = flat.it.instances[outer_idx]
    next_item = iterate(current_iter, inner_state)
    if next_item === nothing
        return iterate(flat, (outer_idx + 1, 1))
    else
        item, new_inner_state = next_item
        return item, (outer_idx, new_inner_state)
    end
end
