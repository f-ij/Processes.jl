export Process, getallocator, getnewallocator, getcontext

mutable struct Process{F} <: AbstractProcess
    id::UUID
    context::AbstractContext
    taskdata::TaskData{F}
    timeout::Float64
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
    threadid::Int
end

export Process

function Process(func, inputs_overrides...; lifetime = Indefinite(), timeout = 1.0)

    # Wrap in a LoopAlgorithm to get all
    # features
    if !(func isa LoopAlgorithm)
        func = SimpleAlgo(tuple(func))
    end
    
    if lifetime isa Integer
        lifetime = Repeat(lifetime)
    elseif isnothing(lifetime)
        if func isa Routine # Standard lifetime for routines is 1
            lifetime = Repeat(1)
        else
            lifetime = Indefinite()
        end
    end

    inputs = filter(x -> x isa Input, inputs_overrides)
    overrides = filter(x -> x isa Override, inputs_overrides)

    named_inputs = to_named(func, inputs...)
    named_overrides = to_named(func, overrides...)

    # if !(func isa ProcessLoopAlgorithm)
    #     func = SimpleAlgo(func)
    # end

    # tf = TaskData(func, (func, args) -> args, (func, args) -> nothing, args, (;), (), rt)
    td = TaskData(func; lifetime, overrides = named_overrides, inputs = named_inputs)

    # context = init_context(td)

    context = prepare_context(td)
    p = Process(uuid1(), context, td, timeout, nothing, UInt(1), Threads.ReentrantLock(), false, false, nothing, nothing, Process[], Arena(), RuntimeListeners(), 0)
    register_process!(p)
    @DebugMode "Created process with id $(p.id), now preparing data"
    
    finalizer(remove_process!, p)
    return p
end

function Process(func, repeats::Int; overrides = (;), timeout = 1.0, context...) 
    lifetime = repeats == 0 ? Indefinite() : Repeat(repeats)
    return Process(func; lifetime, overrides, timeout, context...)
end

import Base: ==
==(p1::Process, p2::Process) = p1.id == p2.id

getallocator(p::Process) = p.allocator

getinputcontext(p::Process) = p.taskdata.inputargs
function getcontext(p::Process)
    if !isdone(p)   
        return merge_into_globals(p.context, (;process = p))
    else
        try
            return fetch(p)
        catch # if error state, just return context
            return merge_into_globals(p.context, (;process = p))
        end
    end
end
getcontext(p::Process, context) = getcontext(p)[context]
setcontext!(p::Process, context::NamedTuple) = (p.context = context)
lifetime(p::Process) = p.taskdata.lifetime

set_starttime!(p::Process) = p.starttime = time_ns()
set_endtime!(p::Process) = p.endtime = time_ns()
reset_times!(p::Process) = (p.starttime = nothing; p.endtime = nothing)

runtimelisteners(::Any) = nothing
runtimelisteners(p::Process) = p.rls

isthreaded(p::Process) = true

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
    p1.timeout = p2.timeout
    p1.context = p2.context
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

# timeout(p::Process) = p.timeout

export newprocess

"""
Runs the prepared task of a process on a thread
"""
function spawntask!(p::Process; threaded = true) 
    @atomic p.paused = false
    @atomic p.run = true

    context = merge_into_globals(p.context, (;process = p))

    if threaded
        p.task = spawntask(p, p.taskdata.func, context, lifetime(p))
    else
        p.task = @async runloop(p, p.taskdata.func, context, lifetime(p))
    end
    return p
end

@inline lock(p::Process) = lock(p.lock)
@inline lock(f, p::Process) = lock(f, p.lock)
@inline unlock(p::Process) =  unlock(p.lock)

function reset!(p::Process)
    reset_loopidx!(p)
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

export changecontext!

## Running

# Run the loop without preparing data
function (p::Process)(threaded = true)
    spawntask!(p; threaded)
end


### LINKING

link_process!(p1::Process, p2::Process) = push!(p1.linked_processes, p2)
unlink_process!(p1::Process, p2::Process) = filter!(x -> x != p2, p1.linked_processes)
