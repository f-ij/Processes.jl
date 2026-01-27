# function replacename(reg::NameSpaceRegistry, regidx, entryidx, newname::Symbol)
#     old_type_entry = get_entries(reg)[regidx]
#     oldentry = old_type_entry[entryidx]
#     newentry = changename(oldentry, newname)
#     new_type_entry = Base.setindex(old_type_entry, entryidx, newentry)
#     return Base.setindex(reg, regidx, new_type_entry)
# end

# function updatenames(target::NameSpaceRegistry,  groundtruth::NameSpaceRegistry)
#     target_type_entries = get_entries(target)
#     for target_entry in target_type_entries
#         for entry in target_entry
#             this_func = getfunc(entry)
#             true_name = getname(groundtruth, this_func)
#             if getname(entry) != true_name
#                 regidx = find_typeidx(target, typeof(this_func))
#                 entryidx = find_entryidx(target, typeof(this_func))
#                 target = replacename(target, regidx, entryidx, true_name)
#             end
#         end
#     end
#     return target
# end

function updatenames(target_reg::NameSpaceRegistry,  ground_reg::NameSpaceRegistry)
    changed_names = Dict{Symbol,Symbol}() # old name => new name
    all_entries = entries_iterator(target_reg)
    for target_entry in all_entries
        oldname = getname(target_entry)
        groundval = static_get_match(ground_reg, target_entry)
        if isnothing(groundval) # TODO: Assume it's supposed to be there?
            continue
        end
        changed_names[oldname] = getname(groundval)
    end
    target_reg = replacenames(target_reg, changed_names)
    return target_reg, changed_names
end