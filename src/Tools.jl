export processsizehint!, recommendsize, newallocator, progress, est_remaining,
    num_calls

"""
Use within prepare function
For a process with a limited lifetime,
give the array a size hint based on the lifetime and the number of updates per step.
"""
@inline function processsizehint!(args, array, updates_per_step = 1)
    if !haskey(args, :_instance) || !haskey(args, :lifetime)
        @warn("Cannot give a sizehint, prepare is not called from a process")
        return nothing
    end

    lifetime = args.lifetime
    if lifetime isa Indefinite
        return sizehint!(array, 2^16)
    end

    multiplier = getmultiplier(args.algo, args._instance)
    startsize = length(array)

    recommended_extra = ceil(Int, repeats(lifetime)*multiplier*updates_per_step)
    # @show recommended_extra
    # recommended_extra = recommendsize(args, updates_per_step)
    sizehint = startsize + recommended_extra
    # println("Recommended sizehint: $sizehint")
    @static if DEBUG_MODE
        println("Sizehint is $sizehint")
    end
    sizehint!(array, sizehint)
end
# """
# Given an algorithm, return the number of times it will be called per loop of the process
# """
# function call_ratio(ph::PrepereHelper, algo)
#     if algo isa Type
#         algo = algo()
#     end
#     if !haskey(ph.counts, algo)
#         return 0
#     end
#     ph.repeats[algo]
# end

"""
Get the number of times an algorithm will be called in a process
"""
function num_calls(algo, lifetime, instance)
    multiplier = getmultiplier(algo, instance)
    floor(Int, repeats(lifetime)*multiplier)
end

"""
Get the number of times an algorithm will be called in a process
This is to be used in the prepare function
"""
function num_calls(args)
    algo = args.algo
    lifetime = args.lifetime
    instance = args._instance
    num_calls(algo, lifetime, instance)
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

"""
Gives the maximum loop index for a process
"""
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

"""
Get the current loop index for a process
"""
loopidx(args::NamedTuple) = loopidx(args.proc)


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