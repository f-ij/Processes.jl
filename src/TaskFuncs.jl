"""
Struct to define the lifetime of a process
Is a struct so that dispatch can be used to choose the appropriate loop during compile time
"""
abstract type Lifetime end
struct Indefinite <: Lifetime end
struct Repeat{Num} <: Lifetime 
    function Repeat{Num}() where Num 
        @assert Num isa Real "Repeats must be an integer" 
        new{Num}()
    end
end

repeats(r::Repeat{N}) where N = N
repeats(p::Process) = repeats(lifetime(p))
export repeats

import Base./
(/)(::Repeat{N}, r) where N = N/r

"""
Struct with all information to create the function within a process
"""
struct TaskFunc{F}
    func::F
    prepare::Any # Appropriate function to prepare the arguments
    cleanup::Any
    args::Union{NamedTuple, Base.Pairs} # Args that are given as the process is created
    prepared_args::Union{NamedTuple, Base.Pairs} # Args after prepare
    overrides::Any # Given as kwargs
    lifetime::Lifetime
    timeout::Float64 # Timeout in seconds
end

TaskFunc(func; prepare = nothing, cleanup = nothing, overrides::NamedTuple = (;), lifetime = Indefinite(), args...) = 
    TaskFunc(func, prepare, cleanup, args, (;), overrides, lifetime, 1.0)

function newargs(tf::TaskFunc; args...)
    TaskFunc(tf.func, tf.prepare, tf.cleanup, args, tf.prepared_args, tf.overrides, tf.lifetime, tf.timeout)
end

"""
Overwrite the old args with the new args
"""
function editargs(tf::TaskFunc; args...)
    TaskFunc(tf.func, tf.prepare, tf.cleanup, (;tf.args..., args...), tf.prepared_args, tf.overrides, tf.lifetime, tf.timeout)
end

function preparedargs(tf::TaskFunc, args)
    TaskFunc(tf.func, tf.prepare, tf.cleanup, tf.args, args, tf.overrides, tf.lifetime, tf.timeout)
end

getfunc(p::Process) = p.taskfunc.func
getprepare(p::Process) = p.taskfunc.prepare
getcleanup(p::Process) = p.taskfunc.cleanup
args(p::Process) = p.taskfunc.args
overrides(p::Process) = p.taskfunc.overrides
tasklifetime(p::Process) = p.taskfunc.lifetime
timeout(p::Process) = p.taskfunc.timeout

#TODO: This should be somewhere visible
newargs!(p::Process; args...) = p.taskfunc = newargs(p.taskfunc, args...)
export newargs!


define_processloop_task(@specialize(p), @specialize(func), @specialize(args), @specialize(lifetime)) = @task processloop(p, func, args, lifetime)

# Function barrier to create task from taskfunc so that the task is properly precompiled
function define_task_func(p, ploop, @specialize(func), args, lifetime)
    @task ploop(p, func, args, lifetime)
end


createtask!(p::Process; loopfunction = nothing) = createtask!(p, p.taskfunc.func; lifetime = tasklifetime(p), prepare = p.taskfunc.prepare, overrides = overrides(p), loopfunction, args(p)...)

# function createtask!(process, @specialize(func); lifetime = Indefinite(), prepare = nothing, cleanup = nothing, overrides = (;), skip_prepare = false, define_task_func = define_processloop_task, args...)  
function createtask!(process, @specialize(func); lifetime = Indefinite(), prepare = nothing, cleanup = nothing, overrides = (;), skip_prepare = false, loopfunction = nothing, args...)   
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
        calledobject = func
        try 
            calledobject = func()
        catch
        end
        # Prepare always has access to process and lifetime
        if isnothing(prepare) # If prepare is nothing, then the user didn't specify a prepare function
            try
                prepared_args = Processes.prepare(calledobject, (;proc = process, lifetime, args...))
            catch
                # println("No prepare function defined for:")
                @warn "No prepare function defined for $func, no args are prepared"
                prepared_args = (;)
            end
        else
            prepared_args = prepare(calledobject, (;proc = process, lifetime, args...))
        end
        if isnothing(prepared_args)
            prepared_args = (;)
        end
    end
        
    # Add the process and lifetime
    algo_args = (;proc = process, lifetime, prepared_args...)

    # Create new taskfunc
    process.taskfunc = TaskFunc(func, prepare, cleanup, args, algo_args, overrides, lifetime, timeouttime)

    # Add the overrides
    # They are not stored in the args of the taskfunc but separately
    # They are mostly for debugging or testing, so that the user can pass in the arguments to the function
    # These overrides should be removed at a restart, but not a refresh or pause
    task_args = (;algo_args..., overrides...)
    
    # Make the task
    # process.task = define_task_func(process, func, task_args, lifetime)
    if haskey(overrides, :loopfunction)
        loopfunction = overrides[:loopfunction]
    end
    process.task = define_task_func(process, loopfunction, func, task_args, lifetime)

end
export createtask!

