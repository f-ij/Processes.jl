@inline function step!(sa::ScopedAlgorithm{F, Name}, context::AbstractContext) where {F, Name}
    contextview = view(context, sa)
    merge(contextview, @inline step!(getfunc(sa), contextview)) # Merge into view
end

# @inline function step!(sa::ScopedAlgorithm{F, Name}, args) where {F, Name}
#     # args = (;getproperty(args, Name)..., args)
#     @inline step!(sa.func, args)
# end