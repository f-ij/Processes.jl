"""
Rebuild by applying func to all entries in the registry
"""
function rebuild(func::F, registry::NameSpaceRegistry) where {F}
    type_entries = get_entries(registry)
    new_entries = func.(type_entries)
    setfield(registry, :entries, new_entries)
end

"""
Rebuild all entries by applying a func to the ScopedValueEntry
"""
function rebuild_type_entries(func::F, registry::NameSpaceRegistry) where {F}
    rebuild(registry) do entry
        rebuild(func, entry)
    end
end

"""
Scoped Algorithms or thin_wrapped scoped algorithms that need an updated name
    Can be matched with a new registry and rebuilt accordingly
"""
function update_names(func::F, reg::NameSpaceRegistry) where {F}
    if contains_type(func, ScopedAlgorithm)
        return rebuild_from(x -> x isa ScopedAlgorithm, 
            x -> begin 
                # println("Updating name of ScopedAlgorithm: ", getname(x), " for func: $func")
                ScopedAlgorithm(unwrap_container(x), getname(reg, x), id(x))
            end,
            func)
    end
    return func
end

"""
Changes all the names in target_reg to match those in ground_reg
    Matched by thincontainer contained_type

    Can be supplied with a Dict of changed names to fill
"""
function update_names(target_reg::NameSpaceRegistry,  ground_reg::NameSpaceRegistry, changed_names = Dict{Symbol,Symbol}())
    # changed_names = Dict{Symbol,Symbol}() # old name => new name
    all_entries = entries_iterator(target_reg)
    for target_entry in all_entries
        oldname = getname(target_entry)
        groundval = static_get_match(ground_reg, target_entry)
        if isnothing(groundval) # TODO: Assume it's supposed to be there?
            continue
        end
        # if !isnothing(changed_names)
        changed_names[oldname] = getname(groundval)
        # end
    end
    target_reg = replacenames(target_reg, changed_names)
    return target_reg
end


##################################
###### REPLACING ALL NAMES #######
##################################

function replace_all_names(reg::NameSpaceRegistry, name::Symbol)
    func = valentry -> changename(valentry, name)
    rebuild_type_entries(func, reg)
end

# """
# Replace all names in the registry to a given name
# """
# function replace_all_names(reg::NameSpaceRegistry, name::Symbol)
#     new_type_entries = replace_all_names.(get_entries(reg), name)
#     setfield(reg, :entries, new_type_entries)
# end

# function replace_all_names(func::T, name::Symbol) where {T}
#     if contains_type(T, ScopedAlgorithm)
#         return rebuild_from(x -> x isa ScopedAlgorithm, 
#             x -> begin 
#                 changename(x, name)
#             end,
#             func)
#     end
#     return func
# end

function replace_all_names(cla::LoopAlgorithm, name::Symbol)
    newfuncs = replace_all_names.(getfuncs(cla), name)
    new_registry = replace_all_names(get_registry(cla), name)
    cla = setfield(cla, :funcs, newfuncs)
    cla = setfield(cla, :registry, new_registry)
    return cla
end