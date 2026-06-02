@inline _merge_step_return(contextview, retval, ::Wiring) = @inline merge(contextview, retval)
@inline _merge_step_return(contextview, ::Nothing, ::PlanWiringView, namespace::Namespace) = @inline merge(contextview, nothing)
@inline _merge_step_return(contextview, retval::NamedTuple, wiring::PlanWiringView, namespace::Namespace) =
    @inline merge(contextview, retval, return_demand(wiring, namespace))

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

@inline function _step!(algo::A, context::C, runtimecontext::RC, wiring::W, namespace::Namespace{Name}, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, RC <: AbstractContext, W <: Union{Wiring,PlanWiringView}, Name, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    contextview = @inline view(
        context,
        runtimecontext,
        algo,
        namespace;
        sharedcontexts = (@inline shares(wiring)),
        sharedvars = (@inline routes(wiring)),
    )
    retval = @inline step!(algo, contextview)

    return wiring isa PlanWiringView ?
        (@inline _merge_step_return(contextview, retval, wiring, namespace)) :
        (@inline _merge_step_return(contextview, retval, wiring))
end

"""
Terminate the loop-runtime step chain at a plain process algorithm.

Plain algorithms are user-extensible through `step!(algo, context)`. The extra
runtime arguments exist only while traversing loop plans and are intentionally
not part of the public algorithm API.
"""
@inline function _step!(algo::A, context::C, runtimecontext::RC, wiring::W, process::P, lifetime::LT, stability::S = Stable()) where {A <: ProcessAlgorithm, C <: AbstractContext, RC <: AbstractContext, W <: Union{Wiring, PlanWiringView, PlanWiring}, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
    retval = @inline step!(algo, context)
    runtimecontext = wiring isa PlanWiringView ?
        (@inline merge_owner_runtime_return(runtimecontext, Val(:_runtime), retval, return_demand(wiring, Namespace{:_runtime}()))) :
        (@inline merge_owner_runtime_return(runtimecontext, Val(:_runtime), retval))
    return context, runtimecontext
end

# TODO MOVE THESE!!
@inline _profile_step_algo(sa::AbstractIdentifiableAlgo) = getalgo(sa)
@inline _profile_step_context(sa::AbstractIdentifiableAlgo, context) = view(context, sa)
