export SimpleAlgo, CompositeAlgorithm, Routine
export step!, init, getmultiplier, getoptions, setoptions, get_shares, get_routes

"""
Return the execution plan carried by a loop wrapper.

For plan nodes this returns the plan itself, so callers can accept either an
unresolved plan (`CompositeAlgorithm`/`Routine`) or a runtime `LoopAlgorithm`
without branching.
"""
@inline getplan(la::LoopAlgorithm) = getfield(la, :plan)
@inline getplan(plan::Union{CompositeAlgorithm, Routine}) = plan

"""
Build or rebuild a concrete `LoopAlgorithm` runtime wrapper.

This constructor keeps the plan type stable and swaps only runtime/lifecycle
fields such as states, registry, context, inputs, and overrides.
"""
LoopAlgorithm(plan::LoopAlgorithm; states = getstates(plan), options = getoptions(plan), registry = getregistry(plan), context = getstoredcontext(plan), inits = getstoredinits(plan), overrides = getstoredoverrides(plan), id = getid(plan)) =
    LoopAlgorithm{typeof(getplan(plan)), typeof(states), typeof(options), typeof(registry), typeof(context), typeof(inits), typeof(overrides), id}(getplan(plan), states, options, registry, context, inits, overrides)

LoopAlgorithm(plan::Union{CompositeAlgorithm, Routine}; states = (), options = (), registry = nothing, context = nothing, inits = (), overrides = (), id = getid(plan)) =
    LoopAlgorithm{typeof(plan), typeof(states), typeof(options), typeof(registry), typeof(context), typeof(inits), typeof(overrides), id}(plan, states, options, registry, context, inits, overrides)

@inline routing_sharedcontexts(routing::StepRouting) = getfield(routing, :sharedcontexts)
@inline routing_sharedvars(routing::StepRouting) = getfield(routing, :sharedvars)
@inline routing_childwiring(routing::StepRouting) = getfield(routing, :childwiring)

@inline getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
@inline Base.getkey(cla::LoopAlgorithm, obj) = getkey(getregistry(cla), obj)
@inline getoptions(cla::LoopAlgorithm) = getfield(cla, :options)
@inline getstates(cla::LoopAlgorithm) = getfield(cla, :states)
@inline getregistry(cla::LoopAlgorithm) = getfield(cla, :reg)
@inline getstoredcontext(cla::LoopAlgorithm) = getfield(cla, :context)
@inline getstoredinits(cla::LoopAlgorithm) = getfield(cla, :inits)
@inline getstoredoverrides(cla::LoopAlgorithm) = getfield(cla, :overrides)
@inline context(cla::LoopAlgorithm) = getstoredcontext(cla)

@inline getalgos(cla::LoopAlgorithm) = getalgos(getplan(cla))
@inline getalgo(cla::LoopAlgorithm, idx) = getalgo(getplan(cla), idx)
@inline subalgorithms(cla::LoopAlgorithm) = subalgorithms(getplan(cla))
@inline getinc(cla::LoopAlgorithm) = getinc(getplan(cla))
@inline inc(cla::LoopAlgorithm) = inc(getplan(cla))
@inline intervals(cla::LoopAlgorithm) = intervals(getplan(cla))
@inline intervals(cla::LoopAlgorithm, idx) = intervals(getplan(cla), idx)
@inline interval(cla::LoopAlgorithm, idx) = interval(getplan(cla), idx)
@inline repeats(cla::LoopAlgorithm) = repeats(getplan(cla))
@inline repeats(cla::LoopAlgorithm, idx::Int) = repeats(getplan(cla), idx)
@inline repeats(cla::LoopAlgorithm, idx::Val{I}) where {I} = repeats(getplan(cla), idx)
@inline multipliers(cla::LoopAlgorithm) = multipliers(getplan(cla))
@inline multiplier(cla::LoopAlgorithm, idx) = multiplier(getplan(cla), idx)
@inline get_resume_idxs(cla::LoopAlgorithm) = get_resume_idxs(getplan(cla))
@inline resume_idx(cla::LoopAlgorithm, idx) = resume_idx(getplan(cla), idx)
@inline resume_idxs(cla::LoopAlgorithm) = resume_idxs(getplan(cla))
@inline set_resume_point!(cla::LoopAlgorithm, idx::Int, loopidx::Int) = set_resume_point!(getplan(cla), idx, loopidx)

get_shares(cla::LA) where {LA<:AbstractLoopAlgorithm} = @inline filter_by_type(Share, getoptions(cla))
get_routes(cla::LA) where {LA<:AbstractLoopAlgorithm} = @inline filter_by_type(Route, getoptions(cla))

@inline getoptions(la::LA, T::Type{O}) where {LA<:AbstractLoopAlgorithm, O} = filter_by_type(O, getoptions(la))
setoptions(la::LA, options) where {LA<:AbstractLoopAlgorithm} = error("setoptions not implemented for $(typeof(la))")

function setoptions(la::LoopAlgorithm{Plan, S, O, R, C, Inits, Overrides, id}, options) where {Plan, S, O, R, C, Inits, Overrides, id}
    LoopAlgorithm{Plan, S, typeof(options), R, C, Inits, Overrides, id}(getplan(la), getstates(la), options, getregistry(la), getstoredcontext(la), getstoredinits(la), getstoredoverrides(la))
end

function _with_lifecycle(la::LoopAlgorithm{Plan, S, O, R, OldC, OldI, OldOv, id}, context::C, inits::I, overrides::Ov) where {Plan, S, O, R, OldC, OldI, OldOv, id, C, I, Ov}
    LoopAlgorithm{Plan, S, O, R, C, I, Ov, id}(getplan(la), getstates(la), getoptions(la), getregistry(la), context, inits, overrides)
end

@inline _attach_registry(la::LoopAlgorithm{Plan, S, O, OldR, C, Inits, Overrides, id}, registry::R) where {Plan, S, O, OldR, C, Inits, Overrides, id, R<:NameSpaceRegistry} =
    LoopAlgorithm{Plan, S, O, R, C, Inits, Overrides, id}(getplan(la), getstates(la), getoptions(la), registry, getstoredcontext(la), getstoredinits(la), getstoredoverrides(la))

@inline isresolved(la::LoopAlgorithm) = !isnothing(getregistry(la))
@inline getid(la::Union{LoopAlgorithm{Plan,S,O,R,C,I,Ov,id}, Type{<:LoopAlgorithm{Plan,S,O,R,C,I,Ov,id}}}) where {Plan,S,O,R,C,I,Ov,id} = id
@inline hasid(la::Union{LoopAlgorithm{Plan,S,O,R,C,I,Ov,id}, Type{<:LoopAlgorithm{Plan,S,O,R,C,I,Ov,id}}}) where {Plan,S,O,R,C,I,Ov,id} = !isnothing(id)
@inline id(la::Union{LoopAlgorithm{Plan,S,O,R,C,I,Ov,id}, Type{<:LoopAlgorithm{Plan,S,O,R,C,I,Ov,id}}}) where {Plan,S,O,R,C,I,Ov,id} = id

"""
Trait for setup
"""
@inline iscomposite(::Any) = false
@inline iscomposite(::Type{<:AbstractLoopAlgorithm}) = false
@inline iscomposite(::Type{<:CompositeAlgorithm}) = true
@inline iscomposite(::Type{<:LoopAlgorithm{Plan}}) where {Plan} = iscomposite(Plan)
@inline iscomposite(la::LA) where {LA<:AbstractLoopAlgorithm} = iscomposite(typeof(la))

statetypes(::Type{<:LoopAlgorithm{Plan,S}}) where {Plan,S} = S.parameters
algotypes(::Type{<:LoopAlgorithm{Plan}}) where {Plan} = algotypes(Plan)
@inline functypes(::Union{LoopAlgorithm{Plan}, Type{<:LoopAlgorithm{Plan}}}) where {Plan} = functypes(Plan)
@inline subalgotypes(::Union{LoopAlgorithm{Plan}, Type{<:LoopAlgorithm{Plan}}}) where {Plan} = subalgotypes(Plan)
@inline numalgos(::Union{LoopAlgorithm{Plan}, Type{<:LoopAlgorithm{Plan}}}) where {Plan} = numalgos(Plan)
@inline getalgotype(::Union{LoopAlgorithm{Plan}, Type{<:LoopAlgorithm{Plan}}}, idx) where {Plan} = getalgotype(Plan, idx)

# Reset needs to be implemented
@inline reset!(a::Any) = a

"""
Get the numbers Val(1), Val(2), ... Val(N) for the N algorithms in a composite or routine, as a tuple.
"""
@generated function algonvalumbers(ca::LA) where {LA<:AbstractLoopAlgorithm}
    nums = ntuple(i -> Val(i), numalgos(ca))
    return :($nums)
end

Base.@constprop :aggressive @inline function Base.getindex(cla::LA, name::Symbol) where {LA<:AbstractLoopAlgorithm}
    getproperty(cla, name)
end

@inline function Base.getindex(cla::LA, idx::Int) where {LA<:AbstractLoopAlgorithm}
    getalgos(cla)[idx]
end

Base.@constprop :aggressive @inline function Base.getproperty(ca::LA, name::Symbol) where {LA<:AbstractLoopAlgorithm}
    keyloc = findkey(ca, name)
    isnothing(keyloc) && error("No algorithm or state with name $(name) found in LoopAlgorithm $(ca)")
    return ca[keyloc]
end

@inline Base.propertynames(ca::LA) where {LA<:AbstractLoopAlgorithm} = keys(ca)

@inline Base.length(la::LoopAlgorithm) = length(getplan(la))
@inline Base.eachindex(la::LoopAlgorithm) = eachindex(getplan(la))
@inline reset!(la::LoopAlgorithm) = reset!(getplan(la))
@inline inc!(la::LoopAlgorithm) = inc!(getplan(la))
@inline step!(la::LoopAlgorithm, context::C, typestable::S = Stable()) where {C<:AbstractContext, S} =
    error("LoopAlgorithm step! requires explicit process and lifetime. Call step!(la, context, step_wiring, process, lifetime, stability).")
@inline step!(la::LoopAlgorithm, context::C, step_wiring::SW, typestable::S = Stable()) where {C<:AbstractContext, SW<:Tuple, S} =
    error("LoopAlgorithm step! requires explicit process and lifetime. Call step!(la, context, step_wiring, process, lifetime, stability).")
@inline step!(la::LoopAlgorithm, context::C, step_wiring::SW, process::P, lifetime::LT, typestable::S = Stable()) where {C<:AbstractContext, SW<:Tuple, P<:AbstractProcess, LT<:Lifetime, S} =
    step!(getplan(la), context, step_wiring, process, lifetime, typestable)
