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