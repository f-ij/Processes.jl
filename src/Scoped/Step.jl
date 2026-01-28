@inline function step!(sa::ScopedAlgorithm{F, Name}, context::C) where {F, Name, C <: AbstractContext}
    contextview = @inline view(context, sa)
    @inline merge(contextview, @inline step!(getfunc(sa), contextview)) # Merge into view
end

"""
Expression form of the scoped step! to inline view/merge and the inner step! call.
"""
# function step!_expr(sa::Type{<:ScopedAlgorithm}, context::Type{C}) where {C<:AbstractContext}
#     dt = sa
#     ft = dt.parameters[1]
#     name = dt.parameters[2]
#     scv_type = SubContextView{C, name, sa}
#     inner_expr = step!_expr(ft, scv_type)
#     return quote
#         contextview = @inline view(context, func)
#         inner_updates = begin
#             local func = getfunc(func)
#             local context = contextview
#             $(inner_expr)
#         end
#         context = @inline merge(contextview, inner_updates)
#     end
# end
# function step!_expr(sa::Type{<:ScopedAlgorithm}, context::Val{C}, funcname = :func) where {C<:AbstractContext}
#     return quote
#         contextview = @inline view(context, $(funcname))
#         returnvals = @inline step!(getfunc($(funcname)), contextview)
#         context = @inline merge(contextview, returnvals)
#     end
# end
function step!_expr(sa::Type{<:ScopedAlgorithm}, context::Type{C}, funcname::Symbol) where {C<:AbstractContext}
    return quote
        contextview = @inline view(context, $funcname)
        returnvals = @inline step!(getfunc($funcname), contextview)
        context = @inline merge(contextview, returnvals)
    end
end
