export InlineProcess, InlineProcessAlgorithm, isthreaded, run!, reset!
"""
A fully typed process that is meant for inlining into other Functions
Mainly used to compose algorithms in tight loops, plugging into the ProcessLoopAlgorithm system

This doesn't provide the multitasking features of Process, but is faster to restart
"""
mutable struct InlineProcess{TD, As, Threaded} <: AbstractProcess
    const id::UUID
    const taskdata::TD
    args::As
    loopidx::UInt
    lifetime::Int
    starttime ::Union{Nothing, Float64, UInt64}
    endtime::Union{Nothing, Float64, UInt64}
end

function InlineProcess(func::F; threaded = false, lifetime = 1, args...) where F
    if !(func isa ProcessLoopAlgorithm)
        func = SimpleAlgo(func)
    end

    nrepeats = Repeat(lifetime)
    # tf = PreparedData(func; lifetime = nrepeats, args...)
    tf = TaskData(func; lifetime = nrepeats, args...)
    prepared_args = prepare_args(tf)
    p = InlineProcess{typeof(tf), typeof(prepared_args), threaded}(uuid1(), tf, prepared_args, UInt(1), lifetime, nothing, nothing)
    return p
end

isthreaded(ip::InlineProcess{F, TD, T}) where {F, TD, T} = T
# getlidx(ip::InlineProcess) = Int(ip.loopidx)
shouldrun(ip::InlineProcess) = true
lifetime(ip::InlineProcess) = Repeat(ip.lifetime)
getargs(ip::InlineProcess) = ip.args

set_starttime!(ip::InlineProcess) = (ip.starttime = time_ns())
set_endtime!(ip::InlineProcess) = (ip.endtime = time_ns())
run(ip::InlineProcess) = true

# function preparedata!(process::InlineProcess)
#     @static if DEBUG_MODE
#         println("Creating task for process $(process.id)")
#     end
#     func = process.taskdata.func
#     reset!(func) # Reset the loop counters for Routines and CompositeAlgorithms
#     lifetime = Repeat(process.lifetime)
#     overrides = process.taskdata.overrides
#     inputargs = process.taskdata.inputargs

#     pd = Taskdata(func; lifetime = lifetime, overrides = overrides, inputargs...)
#     # @show pd
#     return pd
# end

function (p::InlineProcess)()
    algo = p.taskdata.func
    args = p.args
    p.loopidx = 1
    finalargs = (;proc = p, args...)

    if isthreaded(p)
        return Threads.@spawn processloop(p, algo, finalargs, lifetime(p))
    else
        return @inline processloop(p, algo, finalargs, lifetime(p))
    end
end

function reset!(p::InlineProcess)
    p.loopidx = 1
    preparedata!(p)
    return true 
end

function run!(p::InlineProcess, lifetime = p.lifetime)
    p.lifetime = lifetime
    p()
end
    



