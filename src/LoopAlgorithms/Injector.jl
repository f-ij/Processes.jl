export Injector

"""
Inject queued updates into an existing context.
Payloads are (algo, name, value).
"""
struct Injector <: ProcessAlgorithm
    capacity::Int
end

Injector() = Injector(32)

@inline function Processes.step!(sa::AbstractIdentifiableAlgo{Injector}, context::C) where {C<:AbstractContext}
    return @inline step!(getalgo(sa), getcontext(context))
end

@inline function step!(inj::Injector, context::ProcessContext)
    channel = _channel(context, inj)
    return @inline _drain!(context, channel)
end

@inline function _drain!(context::ProcessContext, channel)
    while isready(channel)
        payload = take!(channel)
        context = @inline _inject(context, payload)
    end
    return context
end

function Processes.prepare(inj::Injector, input::NamedTuple = (;))
    channel = get(input, :channel, Channel{Tuple{Any, Symbol, Any}}(inj.capacity))
    return (;channel)
end

@inline function _inject(context::ProcessContext, payload::Tuple{Any, Symbol, Any})
    algo, name, value = payload
    scv = @inline view(context, algo)
    typed = @inline _coerce_payload(scv, NamedTuple{(name,)}((value,)))
    return @inline merge(scv, typed)
end

@inline function _coerce_payload(scv::SubContextView, payload::NamedTuple)
    names = fieldnames(typeof(payload))
    values = ntuple(length(names)) do i
        name = names[i]
        current = @inline getproperty(scv, name)
        return convert(typeof(current), getproperty(payload, name))
    end
    return NamedTuple{names}(values)
end

@inline function _channel(pc::ProcessContext, inj::Injector)
    name = getkey(getregistry(pc), inj)
    subcontext = getproperty(pc, name)
    return getproperty(subcontext, :channel)
end
