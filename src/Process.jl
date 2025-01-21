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
    objectref::Any
    retval::Any
    errorlog::Any
    algorithm::Any #Ref to the algorithm being run TODO:: Remove this one?
end

getinputargs(p::Process) = p.taskfunc.args
getargs(p::Process) = p.taskfunc.prepared_args
getargs(p::Process, args) = p.taskfunc.prepared_args[args]
getruntime(p::Process) = p.taskfunc.runtime

set_starttime!(p::Process) = p.starttime = time_ns()
set_endtime!(p::Process) = p.endtime = time_ns()
reset_times!(p::Process) = (p.starttime = nothing; p.endtime = nothing)

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
export runtime_ns

function createfrom!(p1::Process, p2::Process)
    p1.taskfunc = p2.taskfunc
    createtask!(p1)
end

export runtime


# Process() = Process(nothing, 0, Threads.SpinLock(), (true, :Nothing))
function Process(func, repeats::Int; overrides = (;), args...) 
    runtime = repeats == 0 ? Indefinite() : Repeat{repeats}()
    return Process(func; runtime, overrides, args...)
end

function Process(func = nothing; runtime = Indefinite(), overrides = (;), args...)
    if runtime isa Integer
        runtime = Repeat{runtime}()
    end
    # tf = TaskFunc(func, (func, args) -> args, (func, args) -> nothing, args, (;), (), rt, 1.)
    tf = TaskFunc(func; args, runtime, overrides...)
    p = Process(uuid1(), tf, nothing, 1, Threads.ReentrantLock(), false, false, nothing, nothing, nothing, nothing, nothing, nothing)
    register_process!(p)
    return p
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

"""
Chooses the right combination of arguments to use for a process
    1. Algorithm prepares arguments
    2. If the process was previously paused, also use earlier specified kwargs
    3. If the user gives new args through kwargs, also use those
"""
function choose_args(p::Process, prepared_args, specified_args = nothing)
    masked_args = prepared_args
    if ispaused(p) # If paused, use the old kwargs
        #TODO: Is the if here neccesary?
        # Shouldn't it be decided by wether there is a retval
        masked_args = replacekwargs(prepared_args, p.retval)
    end
    if !isnothing(specified_args)
        masked_args = replacekwargs(prepared_args, specified_args)
    end

    return masked_args
end

function choose_argsNEW(p::Process, prepared_args, specified_args = nothing)
    masked_args = prepared_args
    if ispaused(p) # If paused, use the old kwargs
        #TODO: Is the if here neccesary?
        # Shouldn't it be decided by wether there is a retval
        masked_args = replacekwargs(prepared_args, fetch(p))
    end
    if !isnothing(specified_args)
        masked_args = replacekwargs(prepared_args, specified_args)
    end

    return masked_args
end

function timedwait(p, timeout = wait_timeout)
    t = time()
    
    while !isdone(p) && time() - t < timeout
    end

    return isdone(p)
end


status(p::Process) = isrunning(p) ? :Running : :Quit
message(p::Process) = run(p) ? :Run : :Quit

isstarted(p::Process) = !isnothing(p.task) && istaskstarted(p.task)

isrunning(p::Process) = isstarted(p) && !istaskdone(p.task)

ispaused(p::Process) = !isnothing(p.task) && p.paused

isdone(p::Process) = !isnothing(p.task) && istaskdone(p.task)

isidle(p::Process) = isdone(p.task) || ispaused(p)

"""
Can be used for a new process
"""
isfree(p::Process) = !isrunning(p) && !ispaused(p)
"""
Is currently used for running,
    can be paused
"""
isused(p::Process) = isrunning(p) || ispaused(p)

export start, restart, quit, pause, close
function start(p::Process, sticky = false)
    # @assert isfree(p) "Process is already in use"
    @assert !isnothing(p.taskfunc) "No task to run"
    if isdone(p)
        reset!(p)
    end


    reset_times!(p)

    createtask!(p)
    runtask!(p)
    return true
end   

function Base.close(p::Process)
    @atomic p.run = false
    # p.endtime = time()
    @atomic p.paused = false
    p.loopidx = 1
    return true
end

function syncclose(p::Process)
    close(p)
    timedwait(p)
end

function quit(p::Process)
    close(p)
    delete!(processlist, p.id)
    return true
end

function pause(p::Process)
    @atomic p.run = false
    @atomic p.paused = true
    @sync p.task
    try 
        p.retval = fetch(p)
    catch e
        p.errorlog = e
    end
    return true
end

function unpause(p::Process)
    # @atomic p.run = true
    # @atomic p.paused = false
    # runtask!(p)
    # return true
    start(p)
end

function refresh(p::Process)
    @assert !isnothing(p.taskfunc) "No task to run"
    pause(p)
    unpause(p)
    return true
end

function restart(p::Process, sticky = false)
    @assert !isnothing(p.taskfunc) "No task to run"
    #Acquire spinlock so that process can not be started twice
    return lock(p.lock) do 
        close(p)
        
        if timedwait(p, p.taskfunc.timeout)
            createtask!(p)
            runtask!(p)
            return true
        else
            println("Task timed out")
            return false
        end
    end    
end

function makeprocess(@specialize(func), runtime::RT = Indefinite(); prepare = nothing, overrides = (;), args...) where RT <: Runtime
    println("Making a new process with runtime $runtime")
    newp = Process(func; runtime, args...)
    register_process!(newp)
    args = (;proc = newp, args...)
    createtask!(newp, func; runtime, prepare, overrides, args...)
    
    return newp
end

makeprocess(func, repeats::Int; overrides...) = let rt = repeats == 0 ? Indefinite() : Repeat{repeats}(); makeprocess(func, rt; overrides...); end
export makeprocess

newprocess(func, repeats::Int = 0; overrides...) = let rt = repeats == 0 ? Indefinite() : Repeat{repeats}(); newprocess(func, rt; overrides...); end

export newprocess

function runtask!(p::Process) 
    @atomic p.run = true
    @atomic p.paused = false

    p.task.sticky = false
    Threads._spawn_set_thrpool(p.task, :default)
    # p.starttime = time()
    schedule(p.task)

    return p
end
export runtask!



"""
Give a function and then creates a task that is run by the process
The function needs to take an object as a reference
"""
function runtaskOLD(p, taskf::Function, repeats = 0; objectref = nothing, run = true)
    # p.starttime = time()
    p.objectref = objectref
    @atomic p.run = run
    @atomic p.paused = !run
    # t.taskfunc = TaskFunc(taskf, Repeat{repeats})
    # t = Task(t.taskfunc.func(p, objectref))
    t = taskf(p)
    p.task = t
    p.retval = nothing
    return t
end

####
# Dispatch Loops
include("Loops.jl")
#####




(p::Process)(taskf::Function, objectref = nothing) = runtask(p, taskf, objectref)
(p::Process)(task::Task, objectref = nothing) = runtask(p, task, objectref)

@inline lock(p::Process) = lock(p.lock)
@inline lock(f, p::Process) = lock(f, p.lock)
@inline unlock(p::Process) =  unlock(p.lock)

reset!(p::Process) = (p.loopidx = 1; p.retval = nothing; p.task = nothing; @atomic p.run = false; p.objectref = nothing)

"""
Get value of run of a process, denoting wether it should run or not
"""
run(p::Process) = p.run
"""
Set value of run of a process, denoting wether it should run or not
"""
run(p::Process, val) = @atomic p.run = val

"""
Wait for a process to finish
"""
@inline Base.wait(p::Process) = if !isnothing(p.task) wait(p.task) else nothing end

"""
Fetch the return value of a process
"""
@inline Base.fetch(p::Process) = if !isnothing(p.task) fetch(p.task) else nothing end

"""
Increments the loop index of a process
"""
@inline inc!(p::Process) = p.loopidx += 1

# mutable struct Processes <: AbstractVector{Process}
#     procs::Vector{Process}
# end

# lock(p::Processes) = lock.(p.procs)
# unlock(p::Processes) = unlock.(p.procs)

# Base.size(p::Processes) = (length(p.procs),)
# Processes(num::Integer) = Processes([Process() for _ in 1:num])

# Base.getindex(processes::Processes, num) = processes.procs[num]
# Base.setindex!(processes::Processes, val, idx) = setindex(processes.procs[num], val, idx)

# Base.length(processes::Processes) = length(processes.procs)

# Base.iterate(processes::Processes, s = 1) = iterate(processes.procs, s)

# function get_free_process(procs::Union{Processes, Vector{Process}})
#     for p in procs
#         if isfree(p)
#             return p
#         end
#     end
#     return nothing
# end
