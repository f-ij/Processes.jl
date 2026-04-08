"""
Update inherited routing options against a loop algorithm's current registry.

When a resolved child loop algorithm is composed into a parent, reuse the same
key-updating machinery for its options before carrying them upward. Unresolved
children keep their raw options unchanged.
"""
function update_option_keys(la::LoopAlgorithm)
    options = getoptions(la)
    options isa Tuple || return options
    isresolved(la) || return options
    return update_keys.(options, Ref(getregistry(la)))
end
