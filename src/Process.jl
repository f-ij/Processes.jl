export Process, getallocator, getnewallocator, getcontext, getticks


mutable struct Process{F} <: AbstractProcess
    id::UUID
    context::AbstractContext
    taskdata::TaskData{F}
    timeout::Float64
    task::Union{Nothing, Task}
    loopidx::UInt # To track the current loop index for resuming
    tickidx::UInt # To track ticks for performance monitoring
    # To make sure other processes don't interfere
    lock::ReentrantLock 
    @atomic shouldrun::Bool
    @atomic paused::Bool
    starttime ::Union{Nothing, Float64, UInt64}
    endtime::Union{Nothing, Float64, UInt64}
    # linked_processes::Vector{Process} # Maybe do only with UUIDs for flexibility
    # allocator::Allocator
    rls::RuntimeListeners
    threadid::Int
end

@setterGetter Process lock shouldrun
"""
Get value of run of a process, denoting wether it should run or not
"""
shouldrun(p::Process) = p.shouldrun
"""
Set value of run of a process, denoting wether it should run or not
"""
shouldrun(p::Process, val) = @atomic p.shouldrun = val

# Loop counting
@inline looptick!(p::Process) = (p.tickidx = p.tickidx + UInt(1))
@inline tick!(p::Process) = (p.tickidx = p.tickidx + UInt(1))
@inline getticks(p::Process) = p.tickidx
@inline reset_ticks!(p::Process) = (p.tickidx = UInt(1))

@inline function _process_state_label(p::Process)
    if ispaused(p)
        return "Paused"
    elseif isrunning(p)
        return "Running"
    elseif isdone(p)
        return "Finished"
    else
        return "Idle"
    end
end

@inline function _process_algo_summary(p::Process)
    return sprint(summary, getalgo(taskdata(p)))
end

@inline function _process_constructor_lifetime(repeats, lifetime, repeat)
    if !isnothing(repeat)
        isnothing(repeats) || error("Pass either `repeats = ...` or `repeat = ...`, not both.")
        repeats = repeat
    end

    if !isnothing(repeats)
        isnothing(lifetime) || error("Pass either `repeats = ...` or `lifetime = ...`, not both.")
        if repeats isa AbstractFloat && isinf(repeats)
            return Indefinite()
        else
            return repeats
        end
    end

    if isnothing(lifetime)
        return nothing
    elseif lifetime isa Lifetime
        return lifetime
    else
        error("Pass `repeats = ...` for repeat counts. The `lifetime` keyword is reserved for Lifetime objects.")
    end
end

function Process(func, inputs_overrides...; context = nothing, repeats = nothing, lifetime = nothing, repeat = nothing, timeout = 1.0)
    lifetime = _process_constructor_lifetime(repeats, lifetime, repeat)

    prepared = prepare_process_constructor(func, inputs_overrides...; lifetime, context)
    td = prepared.taskdata
    context = prepared.context

    # p = Process(uuid1(), context, td, timeout, nothing, UInt(1), UInt(1), Threads.ReentrantLock(), false, true, nothing, nothing, Arena(), RuntimeListeners(), 0)
    p = Process(uuid1(), context, td, timeout, nothing, UInt(1), UInt(1), Threads.ReentrantLock(), false, true, nothing, nothing, RuntimeListeners(), 0)

    register_process!(p)
    @DebugMode "Created process with id $(p.id), now preparing data"
    
    finalizer(remove_process!, p)
    return p
end

function Process(func, repeats::Int; overrides = tuple(), timeout = 1.0, context = nothing)
    overrides_tuple = overrides isa Tuple ? overrides : (overrides,)
    return Process(func, overrides_tuple...; repeats = repeats, timeout, context)
end

Base.:(==)(p1::Process, p2::Process) = p1.id == p2.id

function getcontext(p::Process)
    if !isdone(p)   
        return merge_into_globals(p.context, (;process = p))
    else
        try
            return fetch(p)
        catch # if error state, just return context
            return merge_into_globals(p.context, (;process = p))
        end
    end
end

getcontext(p::Process, context) = getcontext(p)[context]
lifetime(p::Process) = p.taskdata.lifetime

set_starttime!(p::Process) = p.starttime = time_ns()
set_endtime!(p::Process) = p.endtime = time_ns()
reset_times!(p::Process) = (p.starttime = nothing; p.endtime = nothing)

runtimelisteners(::Any) = nothing
runtimelisteners(p::Process) = p.rls

isthreaded(p::Process) = true

"""
different loopfunction can be passed to the process through overrides
"""
function getloopfunc(p::Process)
    get(p.taskdata.overrides, :loopfunc, processloop)
end




# function Base.finalizer(p::Process)
#     quit(p)
#     delete!(processlist, p.id)
# end

function runtime(p::Process)
    @assert !isnothing(p.starttime) "Process has not started"
    return runtime_ns(p) / 1e9
end

function runtime_ns(p::Process)
    @assert !isnothing(p.starttime) "Process has not started"
    timens = isnothing(p.endtime) ? time_ns() - p.starttime : p.endtime - p.starttime
    return Int(timens)
end
export runtime_ns, runtime

# Exact time the process stopped in hh:mm:ss
function stop_time(p::Process)
    if isdone(p)
        return Dates.format(Dates.DateTime(p.endtime), "HH:MM:SS")
    else
        return nothing
    end
end

function createfrom!(p1::Process, p2::Process)
    p1.taskdata = p2.taskdata
    p1.timeout = p2.timeout
    p1.context = p2.context
    preparedata!(p1)
end



function timedwait(p, timeout = wait_timeout)
    t = time()
    
    while !isdone(p) && time() - t < timeout
    end

    return isdone(p)
end

@inline lock(p::Process) = lock(p.lock)
@inline lock(f, p::Process) = lock(f, p.lock)
@inline unlock(p::Process) =  unlock(p.lock)

@inline function precompile_loop!(p::Process, func, context, lt)
    Base.precompile(loop, (typeof(p), typeof(func), typeof(context), typeof(lt), NonGenerated))
    Base.precompile(loop, (typeof(p), typeof(func), typeof(context), typeof(lt), Generated))

    return nothing
end


"""
Runs the prepared task of a process on a thread
"""
function makeloop!(p::Process, lt = lifetime(p); threaded = true, loopfunc::LF = loop) where LF 
    @atomic p.paused = false
    @atomic p.shouldrun = true

    func = p.taskdata.func
    context = merge_into_globals(p.context, (;process = p))
    @inline precompile_loop!(p, func, context, lt)
    if threaded
        p.task = Threads.@spawn loopfunc(p, func, context, lt)
    else
        p.task = @async loopfunc(p, func, context, lt)
    end
    return p
end

"""
Reset process to initial state
"""
function reset!(p::Process)
    reset_loopidx!(p)
    reset_ticks!(p)
    @atomic p.paused = false
    @atomic p.shouldrun = true
    reset_times!(p)
    algo = getalgo(p.taskdata)
    reset!(algo)
    return p
end

### LINKING

link_process!(p1::Process, p2::Process) = push!(p1.linked_processes, p2)
unlink_process!(p1::Process, p2::Process) = filter!(x -> x != p2, p1.linked_processes)

function Base.show(io::IO, p::Process)
    if !isnothing(p.task) && p.task._isexception
        print(io, "Error in process")
        return display(p.task)
    end
    print(io, _process_state_label(p), " Process(", _process_algo_summary(p), ", lifetime=", lifetime(p), ", loopidx=", loopint(p), ")")

    return nothing
end

function Base.summary(io::IO, p::Process)
    print(io, "Process(", _process_algo_summary(p), ")")
end

function Base.show(io::IO, ::MIME"text/plain", p::Process)
    if !isnothing(p.task) && p.task._isexception
        print(io, "Error in process")
        return display(p.task)
    end

    println(io, "Process")
    println(io, "├── state = ", _process_state_label(p))
    println(io, "├── lifetime = ", lifetime(p))
    println(io, "├── loopidx = ", loopint(p))
    println(io, "├── timeout = ", p.timeout)

    algo_lines = split(sprint(show, getalgo(taskdata(p))), '\n')
    print(io, "├── algo = ", algo_lines[1])
    for line in Iterators.drop(algo_lines, 1)
        print(io, "\n", "│   ", line)
    end

    context_lines = split(
        sprint(show, p.context; context = IOContext(io, :printcontextglobals => false, :limit => get(io, :limit, false), :color => get(io, :color, false))),
        '\n',
    )
    print(io, "\n", "└── context = ", context_lines[1])
    for line in Iterators.drop(context_lines, 1)
        print(io, "\n", "    ", line)
    end

    return nothing
end
