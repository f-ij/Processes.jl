export Process, getallocator, getnewallocator, threadid, getlidx

mutable struct Process <: AbstractProcess
    id::UUID
    taskdata::Union{Nothing,TaskData}
    task::Union{Nothing, Task}
    loopidx::UInt   
    # To make sure other processes don't interfere
    lock::ReentrantLock 
    @atomic run::Bool
    @atomic paused::Bool
    starttime ::Union{Nothing, Float64, UInt64}
    endtime::Union{Nothing, Float64, UInt64}
    linked_processes::Vector{Process} # Maybe do only with UUIDs for flexibility
    allocator::Allocator
    rls::RuntimeListeners
    threadid::Union{Nothing, Int}
end

export Process

function Process(func; lifetime = Indefinite(), overrides = (;), args...)
    
    if lifetime isa Integer
        lifetime = Repeat{lifetime}()
    elseif isnothing(lifetime)
        if func isa Routine # Standard lifetime for routines is 1
            lifetime = Repeat{1}()
        else
            lifetime = Indefinite()
        end
    end

    if !(func isa ProcessLoopAlgorithm)
        func = SimpleAlgo(func)
    end

    # tf = TaskData(func, (func, args) -> args, (func, args) -> nothing, args, (;), (), rt, 1.)
    tf = TaskData(func; lifetime, overrides, args...)
    p = Process(uuid1(), tf, nothing, 1, Threads.ReentrantLock(), false, false, nothing, nothing, Process[], Arena(), RuntimeListeners(), nothing)
    register_process!(p)
    preparedata!(p)
    finalizer(remove_process!, p)
    return p
end

function Process(func, repeats::Int; overrides = (;), args...) 
    lifetime = repeats == 0 ? Indefinite() : Repeat{repeats}()
    return Process(func; lifetime, overrides, args...)
end

import Base: ==
==(p1::Process, p2::Process) = p1.id == p2.id

getallocator(p::Process) = p.allocator
getlidx(p::Process) = Int(p.loopidx)

getinputargs(p::Process) = p.taskdata.args
function getargs(p::Process)
    if !isdone(p)   
        return p.taskdata.prepared_args
    else
        try
            return fetch(p)
        catch # if error state, just return args
            return p.taskdata.prepared_args
        end
    end
end
getargs(p::Process, args) = getargs(p)[args]
lifetime(p::Process) = p.taskdata.lifetime

set_starttime!(p::Process) = p.starttime = time_ns()
set_endtime!(p::Process) = p.endtime = time_ns()
reset_times!(p::Process) = (p.starttime = nothing; p.endtime = nothing)
loopint(p::Process) = Int(p.loopidx)
export loopint

runtimelisteners(p::Process) = p.rls

"""
different loopfunction can be passed to the process through overrides
"""
function getloopfunc(p::Process)
    get(p.taskdata.overrides, :loopfunc, processloop)
end

get_linked_processes(p::Process) = p.linked_processes

# List of processes in use
const processlist = Dict{UUID, WeakRef}()
register_process!(p) = let id = uuid1(); processlist[id] = WeakRef(p); id end
function remove_process!(p::Process)
    quit(p)
    delete!(processlist, p.id)
end

# function Base.finalizer(p::Process)
#     quit(p)
#     delete!(processlist, p.id)
# end

function runtime(p::Process)
    @assert !isnothing(p.starttime) "Process has not started"
    return runtime_ns(p) / 1e9
end

function runtime_ns(p::Process)
    @assert !isnothing(p.starttime) "Process has not started"
    timens = isnothing(p.endtime) ? time_ns() - p.starttime : p.endtime - p.starttime
    return Int(timens)
end
export runtime_ns, runtime

# Exact time the process stopped in hh:mm:ss
function stop_time(p::Process)
    if isdone(p)
        return Dates.format(Dates.DateTime(p.endtime), "HH:MM:SS")
    else
        return nothing
    end
end

function createfrom!(p1::Process, p2::Process)
    p1.taskdata = p2.taskdata
    preparedata!(p1)
end


@setterGetter Process lock run

function Base.show(io::IO, p::Process)
    if !isnothing(p.task) && p.task._isexception
        print(io, "Error in process")
        return display(p.task)
    end
    statestring = ""
    if ispaused(p)
        statestring = "Paused"
    elseif isrunning(p)
        statestring = "Running"
    elseif isdone(p)
        statestring = "Finished"
    end

    print(io, "$statestring Process")

    return nothing
end

function timedwait(p, timeout = wait_timeout)
    t = time()
    
    while !isdone(p) && time() - t < timeout
    end

    return isdone(p)
end

export newprocess

"""
Runs the prepared task of a process on a thread
"""
function spawntask!(p::Process; threaded = true) 
    @atomic p.paused = false
    @atomic p.run = true

    actual_args = (;p.taskdata.prepared_args..., overrides(p)...)
    if threaded
        p.task = spawntask(p, p.taskdata.func, actual_args, runtimelisteners(p), lifetime(p))
    else
        p.task = @async runloop(p, p.taskdata.func, actual_args, runtimelisteners(p), lifetime(p))
    end
    return p
end

@inline lock(p::Process) = lock(p.lock)
@inline lock(f, p::Process) = lock(f, p.lock)
@inline unlock(p::Process) =  unlock(p.lock)

function reset!(p::Process)
    p.loopidx = 1
    @atomic p.paused = false
    @atomic p.run = true
    reset_times!(p)
end

"""
Get value of run of a process, denoting wether it should run or not
"""
run(p::Process) = p.run
"""
Set value of run of a process, denoting wether it should run or not
"""
run(p::Process, val) = @atomic p.run = val

"""
Increments the loop index of a process
"""
@inline inc!(p::Process) = p.loopidx += 1

function changeargs!(p::Process; args...)
    p.taskdata = editargs(p.taskdata; args...)
end

export changeargs!


### LINKING

link_process!(p1::Process, p2::Process) = push!(p1.linked_processes, p2)
unlink_process!(p1::Process, p2::Process) = filter!(x -> x != p2, p1.linked_processes)
