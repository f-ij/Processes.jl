export Process, getallocator, getnewallocator, threadid, getlidx

mutable struct Process
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
    threadid::Union{Nothing,Int64}
end
export Process

function Process(func; lifetime = Indefinite(), overrides = (;), args...)
    if lifetime isa Integer
        lifetime = Repeat{lifetime}()
    elseif isnothing(lifetime)
        lifetime = Indefinite()
    end

    if !(func isa ProcessLoopAlgorithm)
        func = SimpleAlgo(func)
    end

    # tf = TaskData(func, (func, args) -> args, (func, args) -> nothing, args, (;), (), rt, 1.)
    tf = TaskData(func; lifetime, overrides, args...)
    p = Process(uuid1(), tf, nothing, 1, Threads.ReentrantLock(), false, false, nothing, nothing, Process[], Arena(), nothing)
    register_process!(p)
    preparedata!(p)
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
        return fetch(p)
    end
end
getargs(p::Process, args) = getargs(p)[args]
lifetime(p::Process) = p.taskdata.lifetime

set_starttime!(p::Process) = p.starttime = time_ns()
set_endtime!(p::Process) = p.endtime = time_ns()
reset_times!(p::Process) = (p.starttime = nothing; p.endtime = nothing)
loopint(p::Process) = Int(p.loopidx)
export loopint

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

function Base.finalizer(p::Process)
    quit(p)
    delete!(processlist, p.id)
end

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

    p.task = spawntask(p, p.taskdata.func, p.taskdata.prepared_args, lifetime(p))

    return p
end
export runtask!

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

## Prepare
function prepare(p::Process)
    p.taskdata = preparedargs(p.taskdata, prepare(p.taskdata.func, p.taskdata.args))
    return p
end

function changeargs!(p::Process; args...)
    p.taskdata = editargs(p.taskdata; args...)
end

export changeargs!


### LINKING

link_process!(p1::Process, p2::Process) = push!(p1.linked_processes, p2)
unlink_process!(p1::Process, p2::Process) = filter!(x -> x != p2, p1.linked_processes)
