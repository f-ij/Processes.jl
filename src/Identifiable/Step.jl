@inline function step!(sa::IdentifiableAlgo{F}, context::C) where {F, C <: AbstractContext}
    contextview = @inline view(context, sa)
    retval = @inline step!(getalgo(sa), contextview)
    @inline merge(contextview, retval) # Merge into view
end

"""
Expression form of the scoped step! to inline view/merge and the inner step! call.
"""
function step!_expr(sa::Type{<:IdentifiableAlgo}, context::Type{C}, funcname::Symbol) where {C<:AbstractContext}
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        contextview = @inline view(context, $funcname)
        returnvals = @inline step!(getalgo($funcname), contextview)
        context = @inline merge(contextview, returnvals)
    end
end
