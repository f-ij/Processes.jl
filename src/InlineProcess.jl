export InlineProcess, InlineProcessAlgorithm, isthreaded, run!, reset!
"""
A fully typed process that is meant for inlining into other Functions
Mainly used to compose algorithms in tight loops, plugging into the ProcessLoopAlgorithm system

This doesn't provide the multitasking features of Process, but is faster to restart
"""
mutable struct InlineProcess{TD, As, Threaded} <: AbstractProcess
    const id::UUID
    const taskdata::TD
    context::As
    loopidx::UInt
    lifetime::Int
    starttime ::Union{Nothing, Float64, UInt64}
    endtime::Union{Nothing, Float64, UInt64}
end

function InlineProcess(func::F; threaded = false, lifetime = 1, context...) where F
    # if !(func isa ProcessLoopAlgorithm)
    #     func = SimpleAlgo(func)
    # end

    nrepeats = Repeat(lifetime)
    # tf = PreparedData(func; lifetime = nrepeats, args...)
    tf = TaskData(func; lifetime = nrepeats, context...)
    # prepared_context = prepare_args(tf)
    context = init_context(tf)
    context = prepare_context(tf, context)

    p = InlineProcess{typeof(tf), typeof(context), threaded}(uuid1(), tf, context, UInt(1), lifetime, nothing, nothing)
    return p
end

isthreaded(ip::InlineProcess{F, TD, T}) where {F, TD, T} = T == :threaded
isasync(ip::InlineProcess{F, TD, T}) where {F, TD, T} = T == :async

# getlidx(ip::InlineProcess) = Int(ip.loopidx)
shouldrun(ip::InlineProcess) = true
lifetime(ip::InlineProcess) = Repeat(ip.lifetime)
getcontext(ip::InlineProcess) = ip.context

set_starttime!(ip::InlineProcess) = (ip.starttime = time_ns())
set_endtime!(ip::InlineProcess) = (ip.endtime = time_ns())
run(ip::InlineProcess) = true
taskdata(ip::InlineProcess) = ip.taskdata

context(ip::InlineProcess, c) = (ip.context = c)
context(ip::InlineProcess) = ip.context

function (p::InlineProcess)()
    algo = p.taskdata.func
    context = p.context
    p.loopidx = 1
    runtime_context = @inline merge_into_globals(context, (;proc = p))

    if isthreaded(p)
        return Threads.@spawn processloop(p, algo, runtime_context, lifetime(p))
    elseif isasync(p)
        return @async processloop(p, algo, runtime_context, lifetime(p))
    else
        return @inline processloop(p, algo, runtime_context, lifetime(p))
    end
end

function reset!(p::InlineProcess)
    p.loopidx = 1
    makecontext!(p)
    return true 
end

@inline function run!(p::InlineProcess, lifetime = p.lifetime)
    p.lifetime = lifetime
    @inline p()
end
    
