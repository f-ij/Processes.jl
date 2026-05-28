"""
Internal loop-runtime step for an identifiable algorithm.

The public extension point remains `step!(algo, context)` on the wrapped
`ProcessAlgorithm`. This method is only the loop engine's view/merge wrapper.
"""
@inline function _step!(sa::IA, context::C, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, W <: Union{Wiring, PlanWiring}, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = nothing
    if !isempty(wiring)
        contextview = @inline view(
            context,
            sa;
            sharedcontexts = (@inline shares(wiring)),
            sharedvars = (@inline routes(wiring))
        )
    else
        contextview = @inline view(context, sa)
    end
    
    retval = @inline step!(getalgo(sa), contextview)
    
    if S <: Unstable
        return @inline unstablemerge(contextview, retval)
    else
        return @inline merge(contextview, retval)
    end
end

"""
Terminate the loop-runtime step chain at a plain process algorithm.

Plain algorithms are user-extensible through `step!(algo, context)`. The extra
runtime arguments exist only while traversing loop plans and are intentionally
not part of the public algorithm API.
"""
@inline function _step!(algo::A, context::C, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, W <: Union{Wiring, PlanWiring}, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    return @inline step!(algo, context)
end

# TODO MOVE THESE!!
@inline _profile_step_algo(sa::AbstractIdentifiableAlgo) = getalgo(sa)
@inline _profile_step_context(sa::AbstractIdentifiableAlgo, context) = view(context, sa)

"""
Expression form of the scoped step! to inline view/merge and the inner step! call.
"""
function step!_expr(sa::Type{<:IdentifiableAlgo}, context::Type{C}, funcname::Symbol, stability::Symbol) where {C<:AbstractContext}
    returnexp = if stability === :stable
        :(context = @inline stablemerge(contextview, returnvals))
    elseif stability === :unstable
        :(context = @inline unstablemerge(contextview, returnvals))
    else
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    end

    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        local contextview = @inline view(context, $funcname)
        local returnvals = @inline step!(getalgo($funcname), contextview)
        $(returnexp)
    end
end
