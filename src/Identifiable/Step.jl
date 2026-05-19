@inline step!(sa::IdentifiableAlgo{F}, context::C) where {F, C <: AbstractContext} = @inline step!(sa, context, Stable())

@inline function step!(sa::IdentifiableAlgo{F}, context::C, ::Stable) where {F, C <: AbstractContext}
    contextview = @inline view(context, sa)
    retval = @inline step!(getalgo(sa), contextview)
    @inline merge(contextview, retval) # Merge into view
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::Wiring, ::Stable) where {F, C <: AbstractContext}
    if isempty(wiring)
        return @inline step!(sa, context, Stable())
    end
    contextview = @inline view(
        context,
        sa;
        sharedcontexts = shares(wiring),
        sharedvars = routes(wiring),
    )
    retval = @inline step!(getalgo(sa), contextview)
    @inline merge(contextview, retval)
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::Wiring, process::P, lifetime::LT, ::Stable) where {F, C <: AbstractContext, P<:AbstractProcess, LT<:Lifetime}
    return @inline step!(sa, context, wiring, Stable())
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::PlanWiring, ::Stable) where {F<:AbstractLoopAlgorithm, C <: AbstractContext}
    error("Identifiable loop algorithm step! requires explicit process and lifetime. Call step!(sa, context, routing, process, lifetime, Stable()).")
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::PlanWiring, process::P, lifetime::LT, ::Stable) where {F<:AbstractLoopAlgorithm, C <: AbstractContext, P<:AbstractProcess, LT<:Lifetime}
    contextview = @inline view(
        context,
        sa;
        sharedcontexts = (),
        sharedvars = (),
    )
    retval = @inline step!(getalgo(sa), contextview, wiring, process, lifetime, Stable())
    @inline merge(contextview, retval)
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, ::Unstable) where {F, C <: AbstractContext}
    contextview = @inline view(context, sa)
    retval = @inline step!(getalgo(sa), contextview)
    @inline unstablemerge(contextview, retval) # Merge into view
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::Wiring, ::Unstable) where {F, C <: AbstractContext}
    if isempty(wiring)
        return @inline step!(sa, context, Unstable())
    end
    contextview = @inline view(
        context,
        sa;
        sharedcontexts = shares(wiring),
        sharedvars = routes(wiring),
    )
    retval = @inline step!(getalgo(sa), contextview)
    @inline unstablemerge(contextview, retval)
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::Wiring, process::P, lifetime::LT, ::Unstable) where {F, C <: AbstractContext, P<:AbstractProcess, LT<:Lifetime}
    return @inline step!(sa, context, wiring, Unstable())
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::PlanWiring, ::Unstable) where {F<:AbstractLoopAlgorithm, C <: AbstractContext}
    error("Identifiable loop algorithm step! requires explicit process and lifetime. Call step!(sa, context, routing, process, lifetime, Unstable()).")
end

@inline function step!(sa::IdentifiableAlgo{F}, context::C, wiring::PlanWiring, process::P, lifetime::LT, ::Unstable) where {F<:AbstractLoopAlgorithm, C <: AbstractContext, P<:AbstractProcess, LT<:Lifetime}
    contextview = @inline view(
        context,
        sa;
        sharedcontexts = (),
        sharedvars = (),
    )
    retval = @inline step!(getalgo(sa), contextview, wiring, process, lifetime, Unstable())
    @inline unstablemerge(contextview, retval)
end

@inline _profile_step_algo(sa::AbstractIdentifiableAlgo) = getalgo(sa)
@inline _profile_step_context(sa::AbstractIdentifiableAlgo, context) = view(context, sa)

@inline function _merge_expr(stability::Symbol, contextview::Symbol, returnvals::Symbol)
    if stability === :stable
        return :(context = @inline stablemerge($contextview, $returnvals))
    elseif stability === :unstable
        return :(context = @inline unstablemerge($contextview, $returnvals))
    else
        error("Unknown step!_expr stability $(stability). Expected :stable or :unstable.")
    end
end

"""
Expression form of the scoped step! to inline view/merge and the inner step! call.
"""
function step!_expr(sa::Type{<:IdentifiableAlgo}, context::Type{C}, funcname::Symbol, stability::Symbol) where {C<:AbstractContext}
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        local contextview = @inline view(context, $funcname)
        local returnvals = @inline step!(getalgo($funcname), contextview)
        $(_merge_expr(stability, :contextview, :returnvals))
    end
end
