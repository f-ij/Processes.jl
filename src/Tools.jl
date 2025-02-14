export processsizehint!, recommendsize, newallocator, progress, est_remaining,
    num_calls

"""
For a proess with a limited lifetime,
give the array a size hint based on the lifetime and the number of updates per step.
"""
@inline function processsizehint!(args, array, updates_per_step = 1)
    startsize = length(array)
    recommended_extra = recommendsize(args, updates_per_step)
    sizehint = startsize + recommended_extra
    @static if DEBUG_MODE
        println("Sizehint is $sizehint")
    end
    sizehint!(array, sizehint)
end

"""
Recommend a size for an array based on the lifetime of the process and the number of updates per step.
"""
@inline function recommendsize(args, updates_per_step = 1) 
    p = args.proc

    if lifetime(p) isa Indefinite # If it just runs, allocate some amount of memory
        return 2^16
    end

    this_func = getfunc(p)

    if this_func isa SimpleAlgo
        return repeats(p) * updates_per_step
    else
        _currentalgo = currentalgo(args.ua)
        allrepeats = num_calls(p, _currentalgo)
        return allrepeats * updates_per_step
    end

end

"""
Given an algorithm, return the number of times it will be called per loop of the process
"""
function call_ratio(pa::ProcessAlgorithm, algo)
    ua = UniqueAlgoTracker(pa)
    if algo isa Type
        algo = algo()
    end
    if !haskey(ua.counts, algo)
        return 0
    end
    ua.repeats[algo]
end

"""
Get the number of times an algorithm will be called in a process
"""
function num_calls(p::Process, algo)
    pa = getfunc(p)
    if algo isa Type
        algo = algo()
    end
    floor(Int, repeats(p)*call_ratio(pa, algo))
end

"""
Routines will call inc! multuple times per loop
"""
function inc_multiplier(pa::ProcessAlgorithm)
    
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
    _progress(p.taskdata, _loopidx, lifetime(p))
end

function _progress(::Any, lidx, lifetime::Repeat{repeats}) where repeats
    lidx / repeats
end

function _progress(tf::TaskData{<:Routine}, lidx, lifetime::Repeat{repeats}) where repeats
    lidx / (repeats * call) 
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
    println("Estimated time to completion: $total_hours:$total_minutes:$total_seconds")
    println("Of which remaining: $hours:$minutes:$seconds")
end







