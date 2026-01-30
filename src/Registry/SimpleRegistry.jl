# """
# Simple mapping from a name to a function or value.

# This is a minimal registry used for single, explicitly named entries. It wraps
# one `ScopedValueEntry` and uses the same matching semantics as the main registry
# system, but does not perform auto-naming, scoped lookup across multiple entries,
# or multiplier aggregation.
# """
# struct SimpleRegistry{Name, T} <: AbstractRegistry
#     funcentry::T 
# end

# SimpleRegistry(func::T) where {T} = SimpleRegistry{Symbol, T}(Symbol(nameof(typeof(func))), ScopedValueEntry(ScopedAlgorithm(func, nameof(typeof(func))), 1))

# getname(reg::SimpleRegistry, func::T) where {T} = match(reg.funcentry, func) ? reg.funcentry.name : nothing
# static_get(reg::SimpleRegistry, val) = match(reg.funcentry, val) ? reg.funcentry : nothing
# static_value_get(reg::SimpleRegistry, v) = match(reg.funcentry, v) ? value(reg.funcentry) : nothing
