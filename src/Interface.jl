
export start, restart, quit, pause, close, syncclose, refresh

"""
Start a process that is not running or unpause a paused process
"""
function start(p::Process; prevent_hanging = true)
    
    @assert isidle(p) "Process is already in use"

    if ispaused(p) # If paused, then just unpause
        unpause(p)
    else # If not paused, then start from scratch
        reset!(p)
        preparedata!(p)
        spawntask!(p)
    end


    ## Only run one start at a time to prevent hanging
    if prevent_hanging
        while !start_finished[]
            yield()
        end
    end
    start_finished[] = false

    return true
end   

"""
Close a process, stopping it from running
"""
function Base.close(p::Process)
    @atomic p.run = false
    @atomic p.paused = false
    p.loopidx = 1
    return true
end

"""
Close and wait for a process to finish
"""
function syncclose(p::Process)
    close(p)
    timedwait(p)
end

"""
Close and remove a process from the process list
"""
function quit(p::Process)
    close(p)
    delete!(processlist, p.id)
    return true
end


"""
Pause a process, allowing it to be unpaused later
"""
function pause(p::Process)
    @atomic p.run = false
    @atomic p.paused = true
    return true
end

"""
Redefine task without preparing again
"""
function unpause(p::Process)
    p.task = spawntask(p, getfunc(p), getargs(p), lifetime(p))
end

"""
Pause, re-prepare and unpause a process
This is useful mostly for processes that run indefinitely,
where the args prepared are computed properties of the args.

This will cause the computed properties to re-compute. 
This may be used also to levarge the dispatch system, if the types of the data change
so that the new loop function is newly compiled
"""
function refresh(p::Process)
    @assert !isnothing(p.taskfunc) "No task to run"
    pause(p)
    prepare_args!(p)
    unpause(p)
    return true
end

function restart(p::Process, sticky = false)
    @assert !isnothing(p.taskfunc) "No task to run"
    #Acquire spinlock so that process can not be started twice
    return lock(p.lock) do 
        close(p)
        
        if timedwait(p, p.taskfunc.timeout)
            preparedata!(p)
            spawntask!(p)
            return true
        else
            println("Task timed out")
            return false
        end
    end    
end

"""
Wait for a process to finish
"""
@inline Base.wait(p::Process) = if !isnothing(p.task) wait(p.task) else nothing end

"""
Fetch the return value of a process
"""
@inline Base.fetch(p::Process) = if !isnothing(p.task) fetch(p.task) else nothing end