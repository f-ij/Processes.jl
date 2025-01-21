
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

"""
Wait for a process to finish
"""
@inline Base.wait(p::Process) = if !isnothing(p.task) wait(p.task) else nothing end

"""
Fetch the return value of a process
"""
@inline Base.fetch(p::Process) = if !isnothing(p.task) fetch(p.task) else nothing end