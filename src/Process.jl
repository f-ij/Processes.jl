export Process, getallocator, getnewallocator, threadid

mutable struct Process
    id::UUID
    taskfunc::Union{Nothing,TaskFunc}
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

function Process(func = nothing; lifetime = Indefinite(), overrides = (;), args...)
    if lifetime isa Integer
        lifetime = Repeat{lifetime}()
    elseif isnothing(lifetime)
        lifetime = Indefinite()
    end

    # tf = TaskFunc(func, (func, args) -> args, (func, args) -> nothing, args, (;), (), rt, 1.)
    tf = TaskFunc(func; lifetime, overrides, args...)
    p = Process(uuid1(), tf, nothing, 1, Threads.ReentrantLock(), false, false, nothing, nothing, Process[], Arena(), nothing)
    register_process!(p)
    return p
end

import Base: ==
==(p1::Process, p2::Process) = p1.id == p2.id

getallocator(p::Process) = p.allocator

getinputargs(p::Process) = p.taskfunc.args
getargs(p::Process) = p.taskfunc.prepared_args
getargs(p::Process, args) = p.taskfunc.prepared_args[args]
lifetime(p::Process) = p.taskfunc.lifetime

set_starttime!(p::Process) = p.starttime = time_ns()
set_endtime!(p::Process) = p.endtime = time_ns()
reset_times!(p::Process) = (p.starttime = nothing; p.endtime = nothing)

"""
different loopfunction can be passed to the process through overrides
"""
function getloopfunc(p::Process)
    get(p.taskfunc.overrides, :loopfunc, processloop)
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
    timens = isnothing(p.endtime) ? time() - p.starttime : p.endtime - p.starttime
    times = timens / 1e9
    return times
end

function runtime_ns(p::Process)
    @assert !isnothing(p.starttime) "Process has not started"
    timens = isnothing(p.endtime) ? time_ns() - p.starttime : p.endtime - p.starttime
    return Int(timens)
end
export runtime_ns, runtime

function createfrom!(p1::Process, p2::Process)
    p1.taskfunc = p2.taskfunc
    createtask!(p1)
end

# Process() = Process(nothing, 0, Threads.SpinLock(), (true, :Nothing))
function Process(func, repeats::Int; overrides = (;), args...) 
    lifetime = repeats == 0 ? Indefinite() : Repeat{repeats}()
    return Process(func; lifetime, overrides, args...)
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

function makeprocess(@specialize(func), lifetime::RT = Indefinite(); prepare = nothing, overrides = (;), args...) where RT <: Lifetime
    println("Making a new process with lifetime $lifetime")
    newp = Process(func; lifetime, args...)
    register_process!(newp)
    args = (;proc = newp, args...)
    createtask!(newp, func; lifetime, prepare, overrides, args...)
    
    return newp
end

makeprocess(func, repeats::Int; overrides...) = let rt = repeats == 0 ? Indefinite() : Repeat{repeats}(); makeprocess(func, rt; overrides...); end
export makeprocess

newprocess(func, repeats::Int = 0; overrides...) = let rt = repeats == 0 ? Indefinite() : Repeat{repeats}(); newprocess(func, rt; overrides...); end

export newprocess

"""
Runs the prepared task of a process on a thread
"""
function runtask!(p::Process; threaded = true) 
    @atomic p.run = true
    @atomic p.paused = false

    p.task.sticky = false
    if threaded
        Threads._spawn_set_thrpool(p.task, :default)
    end
    schedule(p.task)

    while !istaskstarted(p.task)
        println("Waiting for task to start")
        sleep(0.1)
        #TODO: add timeout?
    end

    return p
end
export runtask!

@inline lock(p::Process) = lock(p.lock)
@inline lock(f, p::Process) = lock(f, p.lock)
@inline unlock(p::Process) =  unlock(p.lock)

function reset!(p::Process)
    p.loopidx = 1
    @atomic p.run = true
    @atomic p.paused = false
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
    p.taskfunc = preparedargs(p.taskfunc, prepare(p.taskfunc.func, p.taskfunc.args))
    return p
end

function changeargs!(p::Process; args...)
    p.taskfunc = editargs(p.taskfunc; args...)
end

export changeargs!


### LINKING

link_process!(p1::Process, p2::Process) = push!(p1.linked_processes, p2)
unlink_process!(p1::Process, p2::Process) = filter!(x -> x != p2, p1.linked_processes)
