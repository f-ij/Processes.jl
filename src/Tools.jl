export processsizehint!, recommendsize, newallocator, progress, est_remaining,
    num_calls

"""
Use within prepare function
For a process with a limited lifetime,
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
Get the number of times an algorithm will be called in a process
This is to be used in the prepare function
"""
function num_calls(args)
    _this_algo = this_algo(args)
    num_calls(args.proc, _this_algo)
end

"""
Routines will call inc! multuple times per loop
"""
function inc_multiplier(pa::ProcessAlgorithm)
    if pa isa Routine
        return sum(repeats(pa))
    else 
        return 1
    end
end

function maximum_loopidx(p::Process)
    return repeats(p)*inc_multiplier(getfunc(p))
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
    loopidx(p) / maximum_loopidx(p)
end

"""
Gives an estimate of the remaining time for the process
"""
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

function incs_per_sec(p::Process)
    loopidx(p) / runtime(p)
end

# CONDITIONAL PARTS
hasarg_exp = nothing
"""
Macro to easily do write conditional parts in algorithms to only execute
if a certain argument is present

This would commonly be used when an argument is passed in the creating of the process
This was a user can configure conditional parts in algorithms that only execute if a user passes
data with a certain name

Syntax is:

@hasarg if argname
    body
end

or

@hasarg if argname isa Type
    body
end
"""
macro hasarg(ex)
    argname = nothing
    body = nothing
    type = nothing
    condition = nothing 
    if @capture(ex, if argname_ isa type_ body_ end)
        condition = :(haskey(args, ($(QuoteNode(argname)))) && args.$argname isa $type)
    else @capture(ex, if argname_ body_ end)
        condition = :(haskey(args, ($(QuoteNode(argname)))))
    end

    
    body = MacroTools.postwalk(body) do x
        if x == argname
            return :(args.$argname)
        else
            return x
        end
    end
    global hasarg_exp = (quote
        Base.@assume_effects :foldable
        if $condition
            $(body)
        end
    end)
    return esc(hasarg_exp)
end
export @hasarg