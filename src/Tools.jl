export processsizehint!, recommendsize, newallocator

"""
For a proess with a limited lifetime,
give the array a size hint based on the lifetime and the number of updates per step.
"""
@inline function processsizehint!(args, array, updates_per_step = 1)
    p = args.proc
    this_func = getfunc(p)
    startsize = length(array)

    if this_func isa CompositeAlgorithm
        this_interval = get_this_interval(args)
        rpts = ceil(Int,lifetime(p)/this_interval)
        sizehint!(array, startsize + rpts * updates_per_step)
    else 
        rpts = lifetime(p)
        sizehint!(array, startsize + rpts * updates_per_step)
    end
end

"""
Recommend a size for an array based on the lifetime of the process and the number of updates per step.
"""
@inline function recommendsize(args, updates_per_step = 1) 
    p = args.proc
    this_func = getfunc(p)

    if this_func isa CompositeAlgorithm
        this_interval = get_this_interval(args)
        rpts = ceil(Int,lifetime(p)/this_interval)
        return rpts * updates_per_step
    else 
        rpts = lifetime(p)
        return rpts * updates_per_step
    end
end


"""
Get the allocator directly from the args
"""
getallocator(args) = getallocator(args.proc)
function newallocator(args)
    if haskey(args, :algotracker)
        if algoidx(args.algotracker) == 1
            return args.proc.allocator = Arena()
        else
            return getallocator(args)
        end
    end
end

####
export TimeTracker, wait, add_timetracker
"""
A time tracker for waiting in loops
"""
mutable struct TimeTracker
    lasttime::UInt64
end
TimeTracker() = TimeTracker(0)
function Base.wait(timetracker::TimeTracker, seconds)
    while time_ns() - timetracker.lasttime < seconds*1e9
    end
    timetracker.lasttime = time_ns()
end

Base.wait(args::NamedTuple, seconds) = Base.wait(args.timetracker, seconds)
add_timetracker(args::NamedTuple) = (;args..., timetracker = TimeTracker())






