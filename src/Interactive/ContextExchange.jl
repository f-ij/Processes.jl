export ContextExchange, InteractiveVar, interact!, isinteractive

struct ContextExchangeNoUpdate end
const context_exchange_no_update = ContextExchangeNoUpdate()

"""
Mutable two-way exchange buffers shared by `ContextExchange` and `InteractiveVar`.

`published` holds the last values read by the scheduled exchange step. `pending`
holds external writes that will be returned through the normal route/merge path
on the next exchange step. Both named tuples have the keys carried by the
`ContextExchange` type.
"""
mutable struct ContextExchangeStore{Names, Published, Pending}
    published::Published
    pending::Pending
end

function ContextExchangeStore(::Val{Names}) where {Names}
    published = NamedTuple{Names}(ntuple(_ -> Ref{Any}(missing), Val(length(Names))))
    pending = NamedTuple{Names}(ntuple(_ -> Ref{Any}(context_exchange_no_update), Val(length(Names))))
    return ContextExchangeStore{Names, typeof(published), typeof(pending)}(published, pending)
end

"""
Scheduled two-way exchange for a fixed set of view-local variables.

Construct it as `ContextExchange(:value, :seen)`. Those names are stored in the
type, so the exchange step can unroll reads from its `SubContextView`. Use
ordinary `Route`/`Share` wiring to decide where the names come from and where
external writes are merged back.
"""
struct ContextExchange{Names} <: AbstractIdentifiableAlgo{
    ContextExchange,
    ValMatcher(:ContextExchange),
    VarAliases(),
    Symbol(),
    :_exchange,
} end

ContextExchange(names::Symbol...) = ContextExchange{names}()

@inline exchange_names(::Union{ContextExchange{Names}, Type{<:ContextExchange{Names}}}) where {Names} = Names
@inline Base.getkey(::Union{ContextExchange, Type{<:ContextExchange}}) = :_exchange
@inline getalgo(exchange::ContextExchange) = exchange
@inline getalgos(exchange::ContextExchange) = (exchange,)
@inline setcontextkey(exchange::ContextExchange, ::Symbol) = exchange
@inline setid(exchange::ContextExchange, newid) = exchange
@inline setvaraliases(exchange::ContextExchange, newaliases) = exchange
@inline match_by(::Union{ContextExchange, Type{<:ContextExchange}}) = ValMatcher(:ContextExchange)
@inline registry_entrytype(::Type{<:ContextExchange}) = ContextExchange
@inline isstaticallyfindable(::ContextExchange) = true

function _context_exchange_state(exchange::ContextExchange)
    store = ContextExchangeStore(Val(exchange_names(exchange)))
    return (; store)
end

Processes.init(exchange::ContextExchange, ::NamedTuple = (;)) = _context_exchange_state(exchange)

function Processes.init(exchange::ContextExchange, context::AbstractContext)
    return replace(context, NamedTuple{(:_exchange,)}((_context_exchange_state(exchange),)))
end

@inline Processes.cleanup(::ContextExchange, context::AbstractContext) = context

"""
Run one exchange step through a generated, key-unrolled view read.

For every declared exchange name, the current routed value is published to the
external ref slot. Pending external writes are returned under the same names, so
the existing view merge logic and routes perform the actual context update.
"""
@inline @generated function Processes.step!(exchange::ContextExchange{Names}, context::C) where {Names, C<:SubContextView}
    reads = Expr[]
    values = Any[]

    push!(reads, :(store = getproperty(context, :store)))
    push!(reads, :(published = getfield(store, :published)))
    push!(reads, :(pending = getfield(store, :pending)))

    for name in Names
        current = Symbol(:current_, name)
        pending_value = Symbol(:pending_, name)
        returned_value = Symbol(:returned_, name)

        push!(reads, :($current = getproperty(context, $(QuoteNode(name)))))
        push!(reads, :($pending_value = getproperty(pending, $(QuoteNode(name)))[]))
        push!(reads, :($returned_value = $pending_value === context_exchange_no_update ? $current : convert(typeof($current), $pending_value)))
        push!(reads, :(getproperty(published, $(QuoteNode(name)))[] = $returned_value))
        push!(reads, :(getproperty(pending, $(QuoteNode(name)))[] = context_exchange_no_update))
        push!(values, returned_value)
    end

    return quote
        $(reads...)
        return NamedTuple{$Names}(($(values...),))
    end
end

@inline function _context_exchange_store(context::ProcessContext, exchange::Symbol = :_exchange)
    return getfield(getdata(getfield(get_subcontexts(context), exchange)), :store)
end

function _context_exchanges(context::ProcessContext)
    reg = getregistry(context)
    exchange = haskey(reg, :_exchange) ? reg[:_exchange] : nothing
    isnothing(exchange) ? () : (exchange,)
end

@inline isinteractive(context::ProcessContext) = !isempty(_context_exchanges(context))
@inline isinteractive(process::AbstractProcess) = isinteractive(context(process))

@inline function _exchange_slot(store::ContextExchangeStore{Names}, ::Val{name}) where {Names, name}
    name in Names || error("ContextExchange does not expose variable $(name). Available variables are $(Names).")
    return getproperty(getfield(store, :published), name), getproperty(getfield(store, :pending), name)
end

"""
    interact!(context, :name => value; exchange = :_exchange)

Queue an external write to one exchange-local variable. The next scheduled
`ContextExchange` step returns that value under `:name`, and normal route/merge
machinery applies it to the routed target.
"""
function interact!(context::ProcessContext, pair::Pair{Symbol, <:Any}; exchange::Symbol = :_exchange)
    _, pending = _exchange_slot(_context_exchange_store(context, exchange), Val(first(pair)))
    pending[] = last(pair)
    return context
end

interact!(process::AbstractProcess, pair::Pair{Symbol, <:Any}; exchange::Symbol = :_exchange) =
    interact!(context(process), pair; exchange)

"""
Ref-like view of one exchange-local variable.

`ref[]` reads the last value published by the scheduled exchange step.
`ref[] = value` queues a write for the next exchange step.
"""
struct InteractiveVar{ExchangeKey, Varname, Published, Pending}
    published::Published
    pending::Pending
end

@inline _interactive_varname(::InteractiveVar{ExchangeKey, Varname}) where {ExchangeKey, Varname} = Varname

function InteractiveVar(context::ProcessContext, varname::Symbol; exchange::Symbol = :_exchange)
    published, pending = _exchange_slot(_context_exchange_store(context, exchange), Val(varname))
    return InteractiveVar{exchange, varname, typeof(published), typeof(pending)}(published, pending)
end

function Base.view(context::ProcessContext, varname::Symbol; exchange::Symbol = :_exchange)
    return InteractiveVar(context, varname; exchange)
end

function Base.view(context::ProcessContext, ::Var{Exchange, Varname}) where {Exchange, Varname}
    return InteractiveVar(context, Varname; exchange = Exchange)
end

@inline Base.getindex(ref::InteractiveVar) = getfield(ref, :published)[]

function Base.setindex!(ref::InteractiveVar, value)
    getfield(ref, :pending)[] = value
    return value
end
