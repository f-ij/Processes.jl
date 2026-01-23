@inline function step!(sa::ScopedAlgorithm{F, Name}, context::AbstractContext) where {F, Name}
    contextview = @inline view(context, sa)
    merge(contextview, @inline step!(getfunc(sa), contextview)) # Merge into view
end