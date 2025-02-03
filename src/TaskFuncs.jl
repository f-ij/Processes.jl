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
    args::Union{NamedTuple, Base.Pairs} # Args that are given as the process is created
    prepared_args::Union{NamedTuple, Base.Pairs} # Args after prepare
    overrides::Any # Given as kwargs
    lifetime::Lifetime
    timeout::Float64 # Timeout in seconds
end

TaskFunc(func; overrides::NamedTuple = (;), lifetime = Indefinite(), args...) = 
    TaskFunc(func, args, (;), overrides, lifetime, 1.0)

function newargs(tf::TaskFunc; args...)
    TaskFunc(tf.func, args, tf.prepared_args, tf.overrides, tf.lifetime, tf.timeout)
end

"""
Overwrite the old args with the new args
"""
function editargs(tf::TaskFunc; args...)
    TaskFunc(tf.func, (;tf.args..., args...), tf.prepared_args, tf.overrides, tf.lifetime, tf.timeout)
end

function preparedargs(tf::TaskFunc, args)
    TaskFunc(tf.func, tf.args, args, tf.overrides, tf.lifetime, tf.timeout)
end

getfunc(p::Process) = p.taskfunc.func
# getprepare(p::Process) = p.taskfunc.prepare
# getcleanup(p::Process) = p.taskfunc.cleanup
args(p::Process) = p.taskfunc.args
overrides(p::Process) = p.taskfunc.overrides
tasklifetime(p::Process) = p.taskfunc.lifetime
timeout(p::Process) = p.taskfunc.timeout

function sametask(t1,t2)
    checks = (t1.func == t2.func,
    # t1.prepare == t2.prepare,
    # t1.cleanup == t2.cleanup,
    t1.args == t2.args,
    t1.overrides == t2.overrides,
    t1.lifetime == t2.lifetime,
    t1.timeout == t2.timeout)
    return all(checks)
end
export sametask

#TODO: This should be somewhere visible
newargs!(p::Process; args...) = p.taskfunc = newargs(p.taskfunc, args...)
export newargs!

prepare_args(p::Process) = prepare_args(p, p.taskfunc.func; lifetime = tasklifetime(p), overrides = overrides(p), args(p)...)
prepare_args!(p::Process) = p.taskfunc = preparedargs(p.taskfunc, prepare_args(p))

function prepare_args(process, @specialize(func); lifetime = Indefinite(), overrides = (;), skip_prepare = false, args...)

    @static if DEBUG_MODE
        println("Preparing args for process $(process.id)")
    end
    # If prepare is skipped, then the prepared arguments are already stored in the process
    prepared_args = nothing
    if skip_prepare
        prepared_args = process.taskfunc.prepared_args
    else

        # So that prepare can be defined as
        # prepare(::Typeofdata, args)
        # instead of prepare(::Type{Typeofdata}, args)
        # But this falls back to the old way if the new way doesn't work
        calledobject = func
        try 
            calledobject = func()
        catch
        end

        # Prepare always has access to process and lifetime
        if isnothing(get(overrides, :prepare, nothing)) # If prepare is nothing, then the user didn't specify a prepare function
            try
                prepared_args = prepare(calledobject, (;proc = process, lifetime, args...))
            catch(err)
                # println("No prepare function defined for:")
                @warn "No prepare function defined for $func, or prepare failed no args are prepared"
                # display(err)
                prepared_args = (;args...)
            end
        else
            prepared_args = overrides.prepare(calledobject, (;proc = process, lifetime, args...))
        end
        if isnothing(prepared_args)
            prepared_args = (;)
        end
    end
        
    # Add the process and lifetime
    return algo_args = (;proc = process, lifetime, prepared_args...)
end

# Function barrier to create task from taskfunc so that the task is properly precompiled
function define_task(p, @specialize(func), args, loopdispatch; loopfunction = processloop)
    @task loopfunction(p, func, args, loopdispatch)
end

createtask!(p::Process; loopfunction = nothing) = createtask!(p, p.taskfunc.func; lifetime = tasklifetime(p), overrides = overrides(p), loopfunction, args(p)...)

# function createtask!(process, @specialize(func); lifetime = Indefinite(), prepare = nothing, cleanup = nothing, overrides = (;), skip_prepare = false, define_task = define_processloop_task, args...)  
function createtask!(process, @specialize(func); lifetime = Indefinite(), overrides = (;), skip_prepare = false, inputargs...)   
    @static if DEBUG_MODE
        println("Creating task for process $(process.id)")
    end

    timeouttime = get(overrides, :timeout, 1.0)

    loopfunction = getloopfunc(process)

    @static if DEBUG_MODE
        println("Loopfunction is $loopfunction")
    end

    prepared_args = prepare_args(process, func; lifetime, prepare, cleanup, overrides, skip_prepare, inputargs...)

    @static if DEBUG_MODE
        println("Prepared args are $prepared_args")
    end

    # Create new taskfunc
    process.taskfunc = TaskFunc(func, inputargs, prepared_args, overrides, lifetime, timeouttime)

    # Add the overrides
    # They are not stored in the args of the taskfunc but separately
    # They are mostly for debugging or testing, so that the user can pass in the arguments to the function
    # These overrides should be removed at a restart, but not a refresh or pause
    task_args = (;prepared_args..., overrides...)
    
    # Make the task
    # process.task = define_task(process, func, task_args, lifetime)
    if haskey(overrides, :loopfunction)
        loopfunction = overrides[:loopfunction]
    end
    process.task = define_task(process, func, task_args, lifetime; loopfunction)

    @static if DEBUG_MODE
        println("Task created: $(process.task)")
    end

end

export createtask!

