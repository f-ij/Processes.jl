export CompositeAlgorithmRecipe, RoutineRecipe

"""
Unresolved `CompositeAlgorithm` recipe.

This is the constructor-time form before a registry is attached by `resolve` or
`ProcessContext`.
"""
const CompositeAlgorithmRecipe = CompositeAlgorithm{T, I, S, O, Nothing, Nothing, Tuple{}, Tuple{}, id} where {T, I, S, O, id}

"""
Unresolved `Routine` recipe.

This is the constructor-time form before a registry is attached by `resolve` or
`ProcessContext`.
"""
const RoutineRecipe = Routine{T, Repeats, S, MV, O, Nothing, id} where {T, Repeats, S, MV, O, id}
