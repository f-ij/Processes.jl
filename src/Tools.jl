export processsizehint!, recommendsize, newallocator, progress, est_remaining

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
        rpts = ceil(Int,repeats(lifetime(p))/this_interval)
        sizehint!(array, startsize + rpts * updates_per_step)
    elseif haskey(args, :routinetracker)
        rpts = routinelifetime(args)
        sizehint!(array, startsize + rpts * updates_per_step)
    else 
        rpts = repeats(lifetime(p))
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


# Check Progress
function progress(p::Process)
    _loopidx = loopidx(p)
    _progress(p.taskfunc, _loopidx, lifetime(p))
end

function _progress(::Any, lidx, lifetime::Repeat{repeats}) where repeats
    lidx / repeats
end

function _progress(tf::TaskFunc{<:Routine}, lidx, lifetime::Repeat{repeats}) where repeats
    lidx / (total_routinesteps(tf.func)*repeats) 
end

function est_remaining(p::Process)
    prog = progress(p)
    rt = runtime(p)
    total_time = rt / prog
    remaining_sec = total_time - rt
    total_hours = floor(Int, total_time / 3600)
    total_minutes = floor(Int, mod(total_time, 3600) / 60)
    total_seconds = floor(Int, mod(total_time, 60))
    hours = floor(Int, remaining_sec / 3600)
    minutes = floor(Int, mod(remaining_sec, 3600) / 60)
    seconds = floor(Int, mod(remaining_sec, 60))
    println("Estimated time to completion: $total_hours:$total_minutes:$total_seconds hours")
    println("Of which remaining: $hours:$minutes:$seconds")
end







