export ContextExchange, InteractiveVar, interact!, isinteractive

"""
Buffered update for one concrete context variable.

The target is already resolved to a `(subcontext, variable)` pair before it is
stored, so `ContextExchange` does not perform registry or view lookup while it is
stepping.
"""
struct BufferedContextUpdate{Subcontext, Varname, T}
    value::T
end

BufferedContextUpdate(subcontext::Symbol, varname::Symbol, value) =
    BufferedContextUpdate{subcontext, varname, typeof(value)}(value)

@inline _update_subcontext(::BufferedContextUpdate{Subcontext}) where {Subcontext} = Subcontext
@inline _update_varname(::BufferedContextUpdate{Subcontext, Varname}) where {Subcontext, Varname} = Varname
@inline _update_value(update::BufferedContextUpdate) = getfield(update, :value)

"""
Mutable two-way exchange buffers shared by `ContextExchange` and `InteractiveVar`.

`buffer` stores inbound writes from external code. `watched` records the context
variables external refs are polling. `values` stores the last value published by
the scheduled exchange step.
"""
mutable struct ContextExchangeStore
    buffer::Vector{Any}
    watched::Set{Tuple{Symbol, Symbol}}
    values::Dict{Tuple{Symbol, Symbol}, Any}
end

ContextExchangeStore() = ContextExchangeStore(Any[], Set{Tuple{Symbol, Symbol}}(), Dict{Tuple{Symbol, Symbol}, Any}())

"""
Apply queued context updates and publish watched context values.

Use `interact!(context, input)` to enqueue values programmatically, or
`view(context, Var(...))` to obtain a ref-like `InteractiveVar`.
"""
const context_exchange_key = :_exchange
const context_exchange_id = ValMatcher(:ContextExchange)
const context_exchange_aliases = VarAliases()

struct ContextExchange <: AbstractIdentifiableAlgo{
    ContextExchange,
    context_exchange_id,
    context_exchange_aliases,
    Symbol(),
    context_exchange_key,
} end

@inline Base.getkey(::Union{ContextExchange, Type{<:ContextExchange}}) = context_exchange_key
@inline getalgo(exchange::ContextExchange) = exchange
@inline getalgos(exchange::ContextExchange) = (exchange,)
@inline setcontextkey(exchange::ContextExchange, ::Symbol) = exchange
@inline setid(exchange::ContextExchange, newid) = exchange
@inline setvaraliases(exchange::ContextExchange, newaliases) = exchange
@inline match_by(::Union{ContextExchange, Type{<:ContextExchange}}) = context_exchange_id
@inline registry_entrytype(::Type{<:ContextExchange}) = ContextExchange
@inline isstaticallyfindable(::ContextExchange) = true

function _context_exchange_state(::ContextExchange)
    store = ContextExchangeStore()
    return (; store, buffer = store.buffer)
end

Processes.init(exchange::ContextExchange, ::NamedTuple = (;)) = _context_exchange_state(exchange)

function Processes.init(exchange::ContextExchange, context::AbstractContext)
    return replace(context, NamedTuple{(context_exchange_key,)}((_context_exchange_state(exchange),)))
end

@inline Processes.cleanup(::ContextExchange, context::AbstractContext) = context

@inline Processes.step!(exchange::ContextExchange, context::C) where {C<:ProcessContext} =
    Processes.step!(exchange, context, Stable())

@inline Processes.step!(exchange::ContextExchange, context::C, ::Stable) where {C<:ProcessContext} =
    _step_context_exchange(exchange, context)

# Buffered updates are converted before they enter the queue, so the unstable
# pass can use the same exact-type-preserving merge path as the stable pass.
@inline Processes.step!(exchange::ContextExchange, context::C, ::Unstable) where {C<:ProcessContext} =
    _step_context_exchange(exchange, context)

"""Step the exchange on the full process context even inside raw resolved plans."""
@inline Processes._step!(exchange::ContextExchange, context::C, runtimecontext::RC, ::PlanWiringView, ::Namespace, process::P, lifetime::LT, stability::S = Stable()) where {C<:ProcessContext, RC<:ProcessContext, P<:AbstractProcess, LT<:Lifetime, S<:Stability} =
    (Processes.step!(exchange, context, stability), runtimecontext)

@inline Processes._step!(exchange::ContextExchange, context::C, ::PlanWiringView, ::Namespace, process::P, lifetime::LT, stability::S = Stable()) where {C<:ProcessContext, P<:AbstractProcess, LT<:Lifetime, S<:Stability} =
    Processes.step!(exchange, context, stability)

@inline function _step_context_exchange(::ContextExchange, context::C) where {C<:ProcessContext}
    store = _context_exchange_store(context)
    updates = getfield(store, :buffer)

    if !isempty(updates)
        @inbounds for i in eachindex(updates)
            context = @inline _apply_buffered_update(context, updates[i])
        end
        empty!(updates)
    end

    _publish_watched_values!(store, context)
    return context::C
end

@inline function _context_exchange_store(context::ProcessContext)
    getfield(getdata(getfield(get_subcontexts(context), context_exchange_key)), :store)
end

@inline function _context_exchange_buffer(context::ProcessContext)
    getfield(_context_exchange_store(context), :buffer)
end

@inline context_exchange_buffer_isempty(context) = false
@inline context_exchange_buffer_isempty(context::ProcessContext) = isempty(_context_exchange_buffer(context))

@inline function _apply_buffered_update(context::C, update::BufferedContextUpdate{Subcontext, Varname}) where {C<:ProcessContext, Subcontext, Varname}
    value = _update_value(update)
    return (@inline merge_into_subcontexts(context, NamedTuple{(Subcontext,)}((NamedTuple{(Varname,)}((value,)),))))::C
end

function _context_exchanges(context::ProcessContext)
    reg = getregistry(context)
    exchange = haskey(reg, context_exchange_key) ? reg[context_exchange_key] : nothing
    isnothing(exchange) ? () : (exchange,)
end

@inline isinteractive(context::ProcessContext) = !isempty(_context_exchanges(context))
@inline isinteractive(process::AbstractProcess) = isinteractive(context(process))

function _resolve_scoped_target(context::ProcessContext, target)
    reg = getregistry(context)
    if target isa Symbol
        return reg[target]
    elseif target isa Type
        matches = findall(target, reg)
        if isempty(matches)
            error("No algorithm matching $(target) was found in the registry.")
        elseif length(matches) > 1
            error("Context has multiple algorithms matching $(target): $(getkey.(matches)). Pass a specific key or algorithm instance.")
        end
        return only(matches)
    end
    return reg[target]
end

function _resolve_exchange(context::ProcessContext, exchange = nothing)
    reg = getregistry(context)
    if isnothing(exchange)
        resolved = haskey(reg, context_exchange_key) ? reg[context_exchange_key] : nothing
        isnothing(resolved) && error("Cannot create an interactive variable view because this context has no ContextExchange in its registry.")
        return resolved
    elseif exchange isa Symbol
        resolved = reg[exchange]
    else
        resolved = reg[exchange]
    end
    getalgo(resolved) isa ContextExchange || error("Requested context exchange $(exchange) resolved to $(resolved), not a ContextExchange.")
    return resolved
end

@inline function _resolve_target_key(context::ProcessContext, target)
    if target isa Symbol
        isasubcontext(context, target) || error("Target subcontext $(target) not found in context.")
        return target
    end
    scoped = _resolve_scoped_target(context, target)
    return getkey(scoped)
end

function _convert_for_context_variable(context::ProcessContext, subcontext::Symbol, varname::Symbol, value)
    # Resolve against the concrete context layout instead of the Val-based helper,
    # which is intended for compile-time keys.
    subcontext in get_subcontexts_fieldnames(typeof(context)) || error("Target subcontext $(subcontext) not found in context.")
    subctx = getproperty(context, subcontext)
    haskey(getdata(subctx), varname) || error("Target variable $(subcontext).$(varname) not found. Interactive updates can only modify existing variables.")
    current = getproperty(subctx, varname)
    target_type = typeof(current)
    try
        return convert(target_type, value)
    catch err
        error("Cannot buffer interactive update for $(subcontext).$(varname): value $(repr(value)) of type $(typeof(value)) is not convertible to existing type $(target_type). Original error: $(err)")
    end
end

function _resolved_update(context::ProcessContext, subcontext::Symbol, varname::Symbol, value)
    typed = _convert_for_context_variable(context, subcontext, varname, value)
    return BufferedContextUpdate(subcontext, varname, typed)
end

function _resolved_target_from_view(context::ProcessContext, target, varname::Symbol)
    scoped = _resolve_scoped_target(context, target)
    scv = view(context, scoped)
    subcontext_varname = algo_to_subcontext_names(scv, varname)
    locations = get_all_locations(scv)
    haskey(locations, subcontext_varname) || error("Variable $(varname) is not available in view $(getkey(scoped)). Available variables are $(keys(locations)).")

    location = getproperty(locations, subcontext_varname)
    location isa VarLocation{:injected} && error("Cannot interactively update injected variable $(varname); it is not stored in the context.")
    target_subcontext = get_subcontextname(location)
    target_varname = get_originalname(location)
    target_varname isa Tuple && error("Cannot interactively update $(varname) because it maps to multiple context variables $(target_varname).")
    return target_subcontext, target_varname
end

function _resolved_update_from_view(context::ProcessContext, target, varname::Symbol, value)
    target_subcontext, target_varname = _resolved_target_from_view(context, target, varname)
    return _resolved_update(context, target_subcontext, target_varname, value)
end

function _resolved_updates(context::ProcessContext, input::Union{Input, Override})
    if isalltargets(input)
        resolved = resolve(getregistry(context), input)
        return Iterators.flatten(_resolved_updates(context, named) for named in resolved)
    elseif isresolved(input)
        target = get_target_name(input)
        return tuple((_resolved_update_from_view(context, target, first(pair), last(pair)) for pair in pairs(get_vars(input)))...)
    end

    resolved = resolve(getregistry(context), input)
    return Iterators.flatten(_resolved_updates(context, named) for named in resolved)
end

function _resolved_updates(context::ProcessContext, input::Pair{<:Var, <:Any})
    var, value = first(input), last(input)
    return (_resolved_update(context, var, value),)
end

function _resolved_update(context::ProcessContext, ::Var{Entity, Varname}, value) where {Entity, Varname}
    Entity == :globals && error("Interactive Var updates currently target subcontexts, not globals.")
    if Entity isa Symbol
        return _resolved_update(context, Entity, Varname, value)
    else
        return _resolved_update_from_view(context, Entity, Varname, value)
    end
end

function _resolved_target(context::ProcessContext, ::Var{Entity, Varname}) where {Entity, Varname}
    Entity == :globals && error("Interactive Var views currently target subcontexts, not globals.")
    if Entity isa Symbol
        _convert_for_context_variable(context, Entity, Varname, getproperty(getproperty(context, Entity), Varname))
        return Entity, Varname
    else
        return _resolved_target_from_view(context, Entity, Varname)
    end
end

function _buffer_storage(context::ProcessContext, exchange_key::Symbol)
    state = getproperty(context, exchange_key)
    return getfield(getproperty(state, :store), :buffer)
end

function _push_buffered_update!(context::ProcessContext, exchange_key::Symbol, update::BufferedContextUpdate)
    push!(_buffer_storage(context, exchange_key), update)
    return update
end

"""
    interact!(context, input; exchange = nothing)

Resolve `input`, convert each value to the existing context variable type, and
append the update to a `ContextExchange` buffer.
"""
function interact!(context::ProcessContext, input; exchange = nothing)
    scoped_exchange = _resolve_exchange(context, exchange)
    exchange_key = getkey(scoped_exchange)
    for update in _resolved_updates(context, input)
        _push_buffered_update!(context, exchange_key, update)
    end
    return context
end

interact!(process::AbstractProcess, input; exchange = nothing) =
    interact!(context(process), input; exchange)

"""
Ref-like view of one context variable through a scheduled `ContextExchange`.

`ref[]` reads the last value published by the exchange. `ref[] = value` enqueues
an inbound update that is applied the next time the exchange step runs.
"""
struct InteractiveVar{ExchangeKey, Subcontext, Varname, T, Store}
    store::Store
end

@inline _interactive_exchange_key(::InteractiveVar{ExchangeKey}) where {ExchangeKey} = ExchangeKey
@inline _interactive_subcontext(::InteractiveVar{ExchangeKey, Subcontext}) where {ExchangeKey, Subcontext} = Subcontext
@inline _interactive_varname(::InteractiveVar{ExchangeKey, Subcontext, Varname}) where {ExchangeKey, Subcontext, Varname} = Varname
@inline _interactive_type(::InteractiveVar{ExchangeKey, Subcontext, Varname, T}) where {ExchangeKey, Subcontext, Varname, T} = T
@inline _interactive_key(ref::InteractiveVar) = (_interactive_subcontext(ref), _interactive_varname(ref))

function InteractiveVar(context::ProcessContext, var::Var; exchange = nothing)
    scoped_exchange = _resolve_exchange(context, exchange)
    subcontext, varname = _resolved_target(context, var)
    store = _context_exchange_store(context)
    current = getproperty(getproperty(context, subcontext), varname)
    key = (subcontext, varname)
    push!(getfield(store, :watched), key)
    getfield(store, :values)[key] = current
    return InteractiveVar{getkey(scoped_exchange), subcontext, varname, typeof(current), typeof(store)}(store)
end

function Base.view(context::ProcessContext, var::Var; exchange = nothing)
    return InteractiveVar(context, var; exchange)
end

function Base.getindex(ref::InteractiveVar)
    values = getfield(getfield(ref, :store), :values)
    return values[_interactive_key(ref)]::_interactive_type(ref)
end

function Base.setindex!(ref::InteractiveVar, value)
    typed = convert(_interactive_type(ref), value)
    update = BufferedContextUpdate(_interactive_subcontext(ref), _interactive_varname(ref), typed)
    push!(getfield(getfield(ref, :store), :buffer), update)
    return value
end

"""Publish watched context values into the exchange store."""
function _publish_watched_values!(store::ContextExchangeStore, context::ProcessContext)
    watched = getfield(store, :watched)
    isempty(watched) && return store

    values = getfield(store, :values)
    subcontext_names = get_subcontexts_fieldnames(typeof(context))
    for key in watched
        subcontext, varname = key
        if subcontext in subcontext_names
            subctx = getproperty(context, subcontext)
            if haskey(getdata(subctx), varname)
                values[key] = getproperty(subctx, varname)
            end
        end
    end
    return store
end
