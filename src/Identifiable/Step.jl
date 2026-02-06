@inline function step!(sa::IdentifiableAlgo{F}, context::C) where {F, C <: AbstractContext}
    contextview = @inline view(context, sa)
    @inline merge(contextview, @inline step!(getalgo(sa), contextview)) # Merge into view
end

"""
Expression form of the scoped step! to inline view/merge and the inner step! call.
"""
function step!_expr(sa::Type{<:IdentifiableAlgo}, context::Type{C}, funcname::Symbol) where {C<:AbstractContext}
    return quote
        contextview = @inline view(context, $funcname)
        returnvals = @inline step!(getalgo($funcname), contextview)
        context = @inline merge(contextview, returnvals)
    end
end
