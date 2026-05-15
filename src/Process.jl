export Process, getallocator, getnewallocator, getcontext, getticks


mutable struct Process{F} <: AbstractProcess
    id::UUID
    algo::F
    runtime_context::Any
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
    lastresult::Any
    # linked_processes::Vector{Process} # Maybe do only with UUIDs for flexibility
    # allocator::Allocator
    rls::RuntimeListeners
    threadid::Int
end

const _LOOP_PRECOMPILE_LOCK = ReentrantLock()
const _LOOP_PRECOMPILE_TASKS = Dict{Any, Task}()

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
    return sprint(summary, getalgo(p))
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

function Process(func::Func, inputs_overrides::Vararg{Any,N}; context::C = nothing, repeats = nothing, lifetime = nothing, repeat = nothing, timeout = 1.0) where {Func,N,C}
    lifetime = _process_constructor_lifetime(repeats, lifetime, repeat)

    algo = normalize_process_algo(func)
    lifetime = normalize_process_lifetime(algo, lifetime)
    algo = _process_constructor_algo(algo, context, inputs_overrides, lifetime)
    runtime_context = isnothing(context) ? getstoredcontext(algo) : context
    runtime_context = merge_into_globals(runtime_context, (; lifetime,))

    # p = Process(uuid1(), context, td, timeout, nothing, UInt(1), UInt(1), Threads.ReentrantLock(), false, true, nothing, nothing, Arena(), RuntimeListeners(), 0)
    p = Process{typeof(algo)}(uuid1(), algo, runtime_context, timeout, nothing, UInt(1), UInt(1), Threads.ReentrantLock(), false, true, nothing, nothing, nothing, RuntimeListeners(), 0)

    register_process!(p)
    schedule_loop_precompile!(p, lifetime)
    @DebugMode "Created process with id $(p.id), now preparing data"
    
    finalizer(remove_process!, p)
    return p
end

function _process_constructor_algo(algo::LA, ::Nothing, inputs_overrides::Tuple{}, lifetime::LT) where {LA<:LoopAlgorithm, LT}
    isnothing(getstoredcontext(algo)) || return algo
    return init(algo; lifetime)
end

function _process_constructor_algo(algo::LA, ::Nothing, inputs_overrides::IO, lifetime::LT) where {LA<:LoopAlgorithm, IO<:Tuple, LT}
    return init(algo, inputs_overrides...; lifetime)
end

function _process_constructor_algo(algo::LA, context::C, inputs_overrides::IO, lifetime::LT) where {LA<:LoopAlgorithm, C, IO<:Tuple, LT}
    isempty(inputs_overrides) || error("Pass either an initialized `context` or init/override specs to `Process`, not both.")
    isnothing(getstoredcontext(algo)) || return algo
    return _with_lifecycle(resolve(algo), nothing, getstoredinits(algo), getstoredoverrides(algo))
end

function Process(func, repeats::Int; overrides = tuple(), timeout = 1.0, context = nothing)
    overrides_tuple = overrides isa Tuple ? overrides : (overrides,)
    return Process(func, overrides_tuple...; repeats = repeats, timeout, context)
end

Base.:(==)(p1::Process, p2::Process) = p1.id == p2.id

getalgo(p::P) where {P<:Process} = p.algo
context(p::P) where {P<:Process} = p.runtime_context
@inline _store_runtime_context!(p::P, c::C) where {P<:Process, C} = (p.runtime_context = c)
function context(p::P, c::C) where {P<:Process, C}
    p.runtime_context = c
end

function getcontext(p::Process)
    return merge_into_globals(context(p), (;process = p))
end

getcontext(p::Process, context) = getcontext(p)[context]
lifetime(p::Process) = get(getglobals(context(p)), :lifetime, Indefinite())

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
    loop
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
    p1.algo = p2.algo
    p1.runtime_context = context(p2)
    p1.timeout = p2.timeout
    reset!(p1)
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

_is_generating_package_output() = ccall(:jl_generating_output, Cint, ()) != 0

function _try_precompile(f, signature::Tuple)
    try
        Base.precompile(f, signature)
    catch
    end
    return nothing
end

@inline function precompile_loop!(loopfunc, p::Process, func, context, lt)
    precompile_loop!(typeof(loopfunc), typeof(p), typeof(func), typeof(context), typeof(lt))

    return nothing
end

@inline precompile_loop!(p::Process, func, context, lt) = precompile_loop!(loop, p, func, context, lt)

function _callable_instance(::Type{F}) where {F}
    return isdefined(F, :instance) ? getfield(F, :instance) : nothing
end

function precompile_loop!(loopfunc_type::Type, process_type::Type, func_type::Type, context_type::Type, lifetime_type::Type)
    loopfunc = _callable_instance(loopfunc_type)
    isnothing(loopfunc) && return nothing
    Base.precompile(loopfunc, (process_type, func_type, context_type, lifetime_type, NonGenerated))
    return nothing
end

function _global_context_type(p::Process)
    return typeof(merge_into_globals(context(p), (; process = p)))
end

function _loop_precompile_signature(loopfunc_type::Type, process_type::Type, func_type::Type, context_type::Type, lifetime_type::Type)
    return (loopfunc_type, process_type, func_type, context_type, lifetime_type)
end

function _loop_precompile_task!(loopfunc_type::Type, process_type::Type, func_type::Type, context_type::Type, lifetime_type::Type)
    if _is_generating_package_output()
        precompile_loop!(loopfunc_type, process_type, func_type, context_type, lifetime_type)
        return nothing
    end

    signature = _loop_precompile_signature(loopfunc_type, process_type, func_type, context_type, lifetime_type)
    lock(_LOOP_PRECOMPILE_LOCK) do
        task = get(_LOOP_PRECOMPILE_TASKS, signature, nothing)
        if isnothing(task)
            task = Threads.@spawn precompile_loop!(loopfunc_type, process_type, func_type, context_type, lifetime_type)
            _LOOP_PRECOMPILE_TASKS[signature] = task
        end
        return task
    end
end

function schedule_loop_precompile!(p::Process, lt = lifetime(p); loopfunc = loop)
    _loop_precompile_task!(typeof(loopfunc), typeof(p), typeof(getalgo(p)), _global_context_type(p), typeof(lt))
    return p
end

function wait_loop_precompile!(p::Process, func, context, lt; loopfunc = loop)
    task = _loop_precompile_task!(typeof(loopfunc), typeof(p), typeof(func), typeof(context), typeof(lt))
    isnothing(task) || wait(task)
    return nothing
end


"""
Runs the prepared task of a process on a thread
"""
function makeloop!(p::Process, inputs::NamedTuple = (;), lt = lifetime(p); threaded = true, loopfunc::LF = loop) where LF 
    @atomic p.paused = false
    @atomic p.shouldrun = true
    p.lastresult = nothing

    func = getalgo(p)
    inputs = _validate_runtime_inputs(func, inputs)
    runtime_context = merge_into_globals(Processes.context(p), (;process = p))
    return _makeloop_prepared!(p, func, runtime_context, lt, inputs; threaded, loopfunc)
end

function _makeloop_prepared!(p::P, func::F, runtime_context::C, lt::LT, inputs::I; threaded::Bool = true, loopfunc::LF = loop, resume::R = Resuming{false}()) where {P<:Process, F, C, LT, I<:NamedTuple, LF, R<:Resuming}
    wait_loop_precompile!(p, func, runtime_context, lt; loopfunc)
    if threaded
        p.task = Threads.@spawn loopfunc(p, func, runtime_context, lt, inputs, resume)
    else
        p.task = @async loopfunc(p, func, runtime_context, lt, inputs, resume)
    end
    return p
end

function _resume_paused_loop!(p::Process; threaded = true)
    wait(p)
    @atomic p.shouldrun = true
    p.lastresult = nothing

    func = getalgo(p)
    runtime_context = Processes.context(p)
    lt = lifetime(p)
    return _makeloop_prepared!(p, func, runtime_context, lt, (;); threaded, resume = Resuming{true}())
end

makeloop!(p::Process, lt::Lifetime; threaded = true, loopfunc::LF = loop) where {LF} =
    makeloop!(p, (;), lt; threaded, loopfunc)

"""
Reset process to initial state
"""
function reset!(p::Process)
    reset_loopidx!(p)
    reset_ticks!(p)
    @atomic p.paused = false
    @atomic p.shouldrun = true
    reset_times!(p)
    algo = getalgo(p)
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

    algo_lines = split(sprint(show, getalgo(p)), '\n')
    print(io, "├── algo = ", algo_lines[1])
    for line in Iterators.drop(algo_lines, 1)
        print(io, "\n", "│   ", line)
    end

    context_lines = split(
        sprint(show, context(p); context = IOContext(io, :printcontextglobals => false, :limit => get(io, :limit, false), :color => get(io, :color, false))),
        '\n',
    )
    print(io, "\n", "└── context = ", context_lines[1])
    for line in Iterators.drop(context_lines, 1)
        print(io, "\n", "    ", line)
    end

    return nothing
end
