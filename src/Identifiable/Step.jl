"""
Internal loop-runtime step for an identifiable algorithm.

The public extension point remains `step!(algo, context)` on the wrapped
`ProcessAlgorithm`. This method is only the loop engine's view/merge wrapper.
"""
@inline function _step!(sa::IA, context::C, runtimecontext::RC, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, RC <: AbstractContext, W <: Wiring{Tuple{}, Tuple{}}, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(context, runtimecontext, sa)
    retval = @inline step!(getalgo(sa), contextview)

    return @inline merge(contextview, retval)
end

@inline function _step!(sa::IA, context::C, runtimecontext::RC, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, RC <: AbstractContext, W <: Wiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(
        context,
        runtimecontext,
        sa;
        sharedcontexts = (@inline shares(wiring)),
        sharedvars = (@inline routes(wiring)),
    )
    retval = @inline step!(getalgo(sa), contextview)

    return @inline merge(contextview, retval)
end

@inline function _step!(sa::IA, context::C, runtimecontext::RC, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {F, IA <: IdentifiableAlgo{F}, C <: AbstractContext, RC <: AbstractContext, W <: PlanWiring, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    return @inline _step!(sa, context, runtimecontext, global_wiring(wiring), process, lifetime, stability)
end

"""
Internal loop-runtime step for a raw child algorithm with an explicit namespace.

Resolved loop plans carry raw `ProcessAlgorithm` children and a parallel
`Namespace{Name}` tuple. This method rebuilds the same view the old
`IdentifiableAlgo` hot path used, but takes the context key from the namespace
type instead of from a wrapper value.
"""
@inline function _step!(algo::A, context::C, runtimecontext::RC, wiring::W, namespace::Namespace{Name}, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, RC <: AbstractContext, W <: Wiring{Tuple{}, Tuple{}}, Name, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(context, runtimecontext, algo, namespace)
    retval = @inline step!(algo, contextview)

    return @inline merge(contextview, retval)
end

@inline function _step!(algo::A, context::C, runtimecontext::RC, wiring::W, namespace::Namespace{Name}, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, RC <: AbstractContext, W <: Wiring, Name, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(
        context,
        runtimecontext,
        algo,
        namespace;
        sharedcontexts = (@inline shares(wiring)),
        sharedvars = (@inline routes(wiring)),
    )
    retval = @inline step!(algo, contextview)

    return @inline merge(contextview, retval)
end

"""
Terminate the loop-runtime step chain at a plain process algorithm.

Plain algorithms are user-extensible through `step!(algo, context)`. The extra
runtime arguments exist only while traversing loop plans and are intentionally
not part of the public algorithm API.
"""
@inline function _step!(algo::A, context::C, runtimecontext::RC, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, RC <: AbstractContext, W <: Union{Wiring, PlanWiring}, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    retval = @inline step!(algo, context)
    runtimecontext = @inline merge_owner_runtime_return(runtimecontext, Val(:_runtime), retval)
    return context, runtimecontext
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
        context, runtimecontext = @inline _step!($funcname, context, runtimecontext, $wiringname, process, lifetime, $stability_expr)
    end
end
