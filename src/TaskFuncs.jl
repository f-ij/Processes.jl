"""
Struct to define the runtime of a process
Is a struct so that dispatch can be used to choose the appropriate loop during compile time
"""
abstract type Runtime end
struct Indefinite <: Runtime end
struct Repeat{Num} <: Runtime 
    function Repeat{Num}() where Num 
        @assert Num isa Real "Repeats must be an integer" 
        new{Num}()
    end
end

repeats(r::Repeat{N}) where N = N

"""
Struct with all information to create the function within a process
"""
struct TaskFunc
    func::Any
    prepare::Any # Appropriate function to prepare the arguments
    cleanup::Any
    args::Union{NamedTuple, Base.Pairs}
    prepared_args::Union{NamedTuple, Base.Pairs}
    overrides::Any # Given as kwargs
    runtime::Runtime
    timeout::Float64 # Timeout in seconds
end

TaskFunc(func; prepare = nothing, cleanup = nothing, overrides::NamedTuple = (;), runtime = Indefinite(), args...) = 
    TaskFunc(func, prepare, cleanup, args, (;), overrides, runtime, 1.0)

getfunc(p::Process) = p.taskfunc.func
getprepare(p::Process) = p.taskfunc.prepare
getcleanup(p::Process) = p.taskfunc.cleanup
args(p::Process) = p.taskfunc.args
overrides(p::Process) = p.taskfunc.overrides
taskruntime(p::Process) = p.taskfunc.runtime
timeout(p::Process) = p.taskfunc.timeout


define_processloop_task(@specialize(p), @specialize(func), @specialize(args), @specialize(runtime)) = @task processloop(p, func, args, runtime)

# Function barrier to create task from taskfunc so that the task is properly precompiled
function define_task_func(p, ploop, @specialize(func), args, runtime)
    @task ploop(p, func, args, runtime)
end


createtask!(p::Process; loopfunction = nothing) = createtask!(p, p.taskfunc.func; runtime = taskruntime(p), prepare = p.taskfunc.prepare, overrides = overrides(p), loopfunction, args(p)...)

# function createtask!(process, @specialize(func); runtime = Indefinite(), prepare = nothing, cleanup = nothing, overrides = (;), skip_prepare = false, define_task_func = define_processloop_task, args...)  
function createtask!(process, @specialize(func); runtime = Indefinite(), prepare = nothing, cleanup = nothing, overrides = (;), skip_prepare = false, loopfunction = nothing, args...)   
    timeouttime = get(overrides, :timeout, 1.0)

    if isnothing(loopfunction)
        loopfunction = processloop
    else
        overrides = (;overrides..., loopfunction = loopfunction)
    end

    # If prepare is skipped, then the prepared arguments are already stored in the process
    prepared_args = nothing
    if skip_prepare
        prepared_args = process.taskfunc.prepared_args
    else
        # Prepare always has access to process and runtime
        if isnothing(prepare) # If prepare is nothing, then the user didn't specify a prepare function
            prepared_args = InteractiveIsing.prepare(func, (;proc = process, runtime, args...))
        else
            prepared_args = prepare(func, (;proc = process, runtime, args...))
        end
        if isnothing(prepared_args)
            prepared_args = (;)
        end
    end
        
    # Add the process and runtime
    algo_args = (;proc = process, runtime, prepared_args...)

    # Create new taskfunc
    process.taskfunc = TaskFunc(func, prepare, cleanup, args, algo_args, overrides, runtime, timeouttime)

    # Add the overrides
    # They are not stored in the args of the taskfunc but separately
    # They are mostly for debugging or testing, so that the user can pass in the arguments to the function
    # These overrides should be removed at a restart, but not a refresh or pause
    task_args = (;algo_args..., overrides...)
    
    # Make the task
    # process.task = define_task_func(process, func, task_args, runtime)
    if haskey(overrides, :loopfunction)
        loopfunction = overrides[:loopfunction]
    end
    process.task = define_task_func(process, loopfunction, func, task_args, runtime)

end
export createtask!

