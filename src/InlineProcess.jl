export InlineProcess, InlineProcessAlgorithm, isthreaded, run, reset!
"""
A fully typed process that is meant for inlining into other Functions
Mainly used to compose algorithms in tight loops, plugging into the ProcessLoopAlgorithm system

This doesn't provide the multitasking features of Process, but is faster to restart
"""
mutable struct InlineProcess{TD,As,Lt,Mode} <: AbstractProcess
    const id::UUID
    const taskdata::TD
    context::As
    loopidx::UInt
    lifetime::Lt
    starttime::Union{Nothing,Float64,UInt64}
    endtime::Union{Nothing,Float64,UInt64}
end

@inline function _inline_process_mode(threaded)
    if threaded === true || threaded === :threaded
        return :threaded
    elseif threaded === false || threaded === :sync
        return :sync
    elseif threaded === :async
        return :async
    else
        error("Unsupported InlineProcess execution mode `$threaded`. Use `true`, `false`, `:threaded`, or `:async`.")
    end
end

@inline function _inline_process_lifetime(func, repeats, lifetime)
    if !isnothing(repeats)
        isnothing(lifetime) || error("Pass either `repeats` or `lifetime` to `InlineProcess`, not both.")
        lifetime = repeats
    elseif isnothing(lifetime)
        lifetime = 1
    end

    if lifetime isa Integer
        return lifetime == 0 ? Indefinite() : Repeat(lifetime)
    elseif lifetime isa Lifetime
        return lifetime
    else
        error("Unsupported InlineProcess lifetime `$lifetime` for `$func`.")
    end
end

function InlineProcess(func, inputs_overrides...; threaded=false, repeats=nothing, lifetime=nothing, context=nothing)
    if !(func isa LoopAlgorithm || func isa Type{<:LoopAlgorithm})
        func = SimpleAlgo(func)
    end

    lifetime = _inline_process_lifetime(func, repeats, lifetime)
    empty_context = ProcessContext(func)
    reg = getregistry(empty_context)

    inputs = filter(x -> x isa Input, inputs_overrides)
    overrides = filter(x -> x isa Override, inputs_overrides)

    named_inputs = to_named(reg, inputs...)
    named_overrides = to_named(reg, overrides...)

    tf = TaskData(func; lifetime, overrides=named_overrides, inputs=named_inputs)
    prepared_context = isnothing(context) ? init_context(tf) : context
    mode = _inline_process_mode(threaded)

    p = InlineProcess{typeof(tf),typeof(prepared_context),typeof(lifetime),mode}(uuid1(), tf, prepared_context, UInt(1), lifetime, nothing, nothing)
    return p
end

@inline isthreaded(ip::InlineProcess{TD,As,Lt,Mode}) where {TD,As,Lt,Mode} = Mode == :threaded
@inline isasync(ip::InlineProcess{TD,As,Lt,Mode}) where {TD,As,Lt,Mode} = Mode == :async

# getlidx(ip::InlineProcess) = Int(ip.loopidx)
@inline shouldrun(ip::InlineProcess) = true
@inline lifetime(ip::InlineProcess) = ip.lifetime
@inline getcontext(ip::InlineProcess) = ip.context

@inline set_starttime!(ip::InlineProcess) = (ip.starttime = time_ns())
@inline set_endtime!(ip::InlineProcess) = (ip.endtime = time_ns())
taskdata(ip::InlineProcess) = ip.taskdata

@inline context(ip::InlineProcess, c) = (ip.context = c)
@inline context(ip::InlineProcess) = ip.context

@inline function reset!(p::InlineProcess)
    p.loopidx = 1
    makecontext!(p)
    return true
end

@inline function Base.run(p::InlineProcess, repeat=nothing)
    algo = p.taskdata.func
    context = p.context
    p.loopidx = 1
    runtime_context = @inline merge_into_globals(context, (; process=p))
    loopdispatch = isnothing(repeat) ? lifetime(p) : _inline_process_lifetime(algo, repeat, nothing)

    # @inline processloop(p, algo, runtime_context, (@inline repeats(p)))

    if isthreaded(p)
        return Threads.@spawn generated_processloop(p, algo, runtime_context, loopdispatch)
    elseif isasync(p)
        return @async generated_processloop(p, algo, runtime_context, loopdispatch)
    else
        return @inline generated_processloop(p, algo, runtime_context, loopdispatch)
    end
end

    
