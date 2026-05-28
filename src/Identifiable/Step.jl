"""
Internal loop-runtime step for an identifiable algorithm.

The public extension point remains `step!(algo, context)` on the wrapped
`ProcessAlgorithm`. This method is only the loop engine's view/merge wrapper.
"""
@inline function _step!(sa::IA, context::C, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, W <: Wiring{Tuple{}, Tuple{}}, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(context, sa)
    retval = @inline step!(getalgo(sa), contextview)

    if S <: Unstable
        return @inline unstablemerge(contextview, retval)
    else
        return @inline merge(contextview, retval)
    end
end

"""Forward namespace-aware stepping through nested loop plans."""
@inline function _step!(algo::LA, context::C, wiring::W, ::Namespace, process::P, lifetime::LT, stability::S = Stable()) where {LA <: AbstractLoopAlgorithm, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    return @inline _step!(algo, context, wiring, process, lifetime, stability)
end

@inline function _step!(sa::IA, context::C, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, W <: Wiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(
        context,
        sa;
        sharedcontexts = (@inline shares(wiring)),
        sharedvars = (@inline routes(wiring)),
    )
    retval = @inline step!(getalgo(sa), contextview)

    if S <: Unstable
        return @inline unstablemerge(contextview, retval)
    else
        return @inline merge(contextview, retval)
    end
end

@inline function _step!(sa::IA, context::C, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    return @inline _step!(sa, context, global_wiring(wiring), process, lifetime, stability)
end

"""
Internal loop-runtime step for a raw child algorithm with an explicit namespace.

Resolved loop plans carry raw `ProcessAlgorithm` children and a parallel
`Namespace{Name}` tuple. This method rebuilds the same view the old
`IdentifiableAlgo` hot path used, but takes the context key from the namespace
type instead of from a wrapper value.
"""
@inline function _step!(algo::A, context::C, wiring::W, namespace::Namespace{Name}, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, W <: Wiring{Tuple{}, Tuple{}}, Name, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(context, algo, namespace)
    retval = @inline step!(algo, contextview)

    if S <: Unstable
        return @inline unstablemerge(contextview, retval)
    else
        return @inline merge(contextview, retval)
    end
end

@inline function _step!(algo::A, context::C, wiring::W, namespace::Namespace{Name}, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, W <: Wiring, Name, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(
        context,
        algo,
        namespace;
        sharedcontexts = (@inline shares(wiring)),
        sharedvars = (@inline routes(wiring)),
    )
    retval = @inline step!(algo, contextview)

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
function step!_expr(sa::Type{<:IdentifiableAlgo}, context::Type{C}, funcname::Symbol, wiringname::Symbol, stability::Symbol) where {C<:AbstractContext}
    stability_expr = if stability === :stable
        :(Stable())
    elseif stability === :unstable
        :(Unstable())
    else
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    end

    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        context = @inline _step!($funcname, context, $wiringname, process, lifetime, $stability_expr)
    end
end
