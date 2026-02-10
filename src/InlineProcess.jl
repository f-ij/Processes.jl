export InlineProcess, InlineProcessAlgorithm, isthreaded, run, reset!
"""
A fully typed process that is meant for inlining into other Functions
Mainly used to compose algorithms in tight loops, plugging into the ProcessLoopAlgorithm system

This doesn't provide the multitasking features of Process, but is faster to restart
"""
mutable struct InlineProcess{TD,As,Threaded} <: AbstractProcess
    const id::UUID
    const taskdata::TD
    context::As
    loopidx::UInt
    repeats::Int
    starttime::Union{Nothing,Float64,UInt64}
    endtime::Union{Nothing,Float64,UInt64}
end

function InlineProcess(func::F; threaded=false, repeats=1, context...) where F
    # if !(func isa ProcessLoopAlgorithm)
    #     func = SimpleAlgo(func)
    # end

    nrepeats = Repeat(repeats)
    # tf = PreparedData(func; lifetime = nrepeats, args...)
    tf = TaskData(func; lifetime=nrepeats, context...)
    # prepared_context = prepare_args(tf)
    context = prepare_context(tf)

    p = InlineProcess{typeof(tf),typeof(context),threaded}(uuid1(), tf, context, UInt(1), repeats, nothing, nothing)
    return p
end

@inline isthreaded(ip::InlineProcess{F,TD,T}) where {F,TD,T} = T == :threaded
@inline isasync(ip::InlineProcess{F,TD,T}) where {F,TD,T} = T == :async

# getlidx(ip::InlineProcess) = Int(ip.loopidx)
@inline shouldrun(ip::InlineProcess) = true
@inline repeats(ip::InlineProcess) = Repeat(ip.repeats)
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
    if !isnothing(repeat)
        p.repeats = repeat
    end
    algo = p.taskdata.func
    context = p.context
    p.loopidx = 1
    runtime_context = @inline merge_into_globals(context, (; process=p))

    # @inline processloop(p, algo, runtime_context, (@inline repeats(p)))

    if isthreaded(p)
        return Threads.@spawn generated_processloop(p, algo, runtime_context, (@inline repeats(p)))
    elseif isasync(p)
        return @async generated_processloop(p, algo, runtime_context, (@inline repeats(p)))
    else
        return @inline generated_processloop(p, algo, runtime_context, (@inline repeats(p)))
    end
end

    