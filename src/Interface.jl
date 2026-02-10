
export start, restart, quit, pause, syncclose, reprepare

function Base.run(p::Process, lifetime = nothing)
    @assert isidle(p) "Process is already in use"
    @atomic p.shouldrun = true
    if !ispaused(p)
        makecontext!(p)
    end

    @atomic p.paused = false
    
    if !isnothing(lifetime)
        p.lifetime = lifetime
    end

     # ## Only run one start at a time to prevent hanging
    # ## Some processes may hang if the main thread continues executing
    # ## while the process is starting on a new thread
    # if prevent_hanging
    #     while !start_finished[]
    #         yield()
    #     end
    # end
    # start_finished[] = false

    makeloop!(p)
end

"""
Wait for a process to finish
"""
@inline Base.wait(p::Process) = if !isnothing(p.task) wait(p.task) else nothing end


"""
Close a process, stopping it from running
"""
function Base.close(p::Process)
    @atomic p.paused = false
    @atomic p.shouldrun = false

    fetched_context = nothing
    try
        wait(p)
        if !isnothing(p.task)
            fetched_context = fetch(p)
        end
    catch(err)
        println("Process with error closed:")
        Base.showerror(stderr, err)
        p.task = nothing
        makecontext!(p)

    end

    if fetched_context isa AbstractContext
        context(p, fetched_context)
    end
    p.task = nothing 

    p.loopidx = 1
    return true
end

function restart(p::Process)
    close(p)
    wait(p)
    @atomic p.paused = false # Force reprepare
    run!(p)
end

"""
Pause a process, allowing it to be unpaused later
"""
function pause(p::Process)
    @atomic p.paused = true
    @atomic p.shouldrun = false
    return true
end


"""
Start a process that is not running or unpause a paused process
"""
function start(p::Process; prevent_hanging = false, threaded = true)
    @warn "start is deprecated, use run instead"
    run(p)
end   

"""
Close and remove a process from the process list
"""
function quit(p::Process)
    close(p)
    delete!(processlist, p.id)
    return true
end


# """
# Redefine task without preparing again
# """
# function unpause(p::Process; threaded = true)
#     @atomic p.shouldrun = true
#     if threaded
#         p.task = spawnloop(p, getalgo(p), getcontext(p), runtimelisteners(p))
#     else
#         p.task = @async runtask(p, getalgo(p), getcontext(p), runtimelisteners(p))
#     end
#     return true
# end

"""
Pause, re-prepare and unpause a process
This is useful mostly for processes that run indefinitely,
where the prepared context is computed from the input context.

This will cause the computed properties to re-compute. 
This may be used also to levarge the dispatch system, if the types of the data change
so that the new loop function is newly compiled
"""
function reprepare(p::Process)
    # TODO: Allow for only preparing of subset of context
    @assert !isnothing(p.taskdata) "No task to run"
    pause(p)
    makecontext!(p)
    unpause(p)
    return true
end

# """
# Close and restart a process
# """
# function restart(p::Process; context...)
#     @assert !isnothing(p.taskdata) "No task to run"
    
#     if !isempty(context)
#         changecontext!(p, context...)
#     end

#     #Acquire spinlock so that process can not be started twice
#     return lock(p.lock) do 
#         close(p)
        
#         if timedwait(p, p.timeout)
#             start(p)
#             return true
#         else
#             println("Task timed out")
#             return false
#         end
#     end    
# end

"""
Fetch the return value of a process
"""
@inline Base.fetch(p::Process) = if !isnothing(p.task) fetch(p.task) else nothing end

"""
Quit all processes in the process list
Might be useful if user lost a reference to a process
"""
function quitall()
    for p in values(processlist)
        quit(p)
    end
end
export quitall
