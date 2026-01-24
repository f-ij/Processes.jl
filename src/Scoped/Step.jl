@inline function step!(sa::ScopedAlgorithm{F, Name}, context::C) where {F, Name, C <: AbstractContext}
    contextview = @inline view(context, sa)
    @inline merge(contextview, @inline step!(getfunc(sa), contextview)) # Merge into view
end