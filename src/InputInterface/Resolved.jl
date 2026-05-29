"""
Return whether a lifecycle input or override targets a resolved namespace.

Resolved lifecycle specs carry the registry key as their target type parameter.
Values delegate to that type data, so this trait behaves the same for
`isresolved(spec)` and `isresolved(typeof(spec))`.
"""
@inline isresolved(::Union{Init{Target}, Type{<:Init{Target}}}) where {Target} = Target isa Symbol
@inline isresolved(::Union{Override{Target}, Type{<:Override{Target}}}) where {Target} = Target isa Symbol

