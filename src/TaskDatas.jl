"""
Struct with all information to create the function within a process
"""
struct TaskData{F}
    func::F
    args::Union{NamedTuple, Base.Pairs} # Args that are given as the process is created
    prepared_args::Union{NamedTuple, Base.Pairs} # Args after prepare
    overrides::Any # Given as kwargs
    lifetime::Lifetime
    consumed::Ref{Bool} # Check wether a task has already been spawned for this taskdata
    timeout::Float64 # Timeout in seconds
end

TaskData(func; overrides::NamedTuple = (;), lifetime = Indefinite(), args...) = 
    TaskData(func, args, (;), overrides, lifetime, Ref(true), 1.0)

function newargs(tf::TaskData; args...)
    TaskData(tf.func, args, tf.prepared_args, tf.overrides, tf.lifetime, tf.consumed, tf.timeout)
end

function newfunc(tf::TaskData, func)
    TaskData(func, tf.args, tf.prepared_args, tf.overrides, tf.lifetime, tf.consumed, tf.timeout)
end

"""
Overwrite the old args with the new args
"""
function editargs(tf::TaskData; args...)
    TaskData(tf.func, (;tf.args..., args...), tf.prepared_args, tf.overrides, tf.lifetime, tf.consumed, tf.timeout)
end

function preparedargs(tf::TaskData, args)
    TaskData(tf.func, tf.args, args, tf.overrides, tf.lifetime, tf.consumed, tf.timeout)
end

getfunc(p::AbstractProcess) = p.taskdata.func
# getprepare(p::AbstractProcess) = p.taskdata.prepare
# getcleanup(p::AbstractProcess) = p.taskdata.cleanup
args(p::AbstractProcess) = p.taskdata.args
overrides(p::AbstractProcess) = p.taskdata.overrides
tasklifetime(p::AbstractProcess) = p.taskdata.lifetime
timeout(p::AbstractProcess) = p.taskdata.timeout
loopdispatch(p::AbstractProcess) = loopdispatch(p.taskdata)
loopdispatch(tf::TaskData) = tf.lifetime
consumed(tf::TaskData) = tf.consumed[]
function consume!(tf::TaskData)
    old_status = tf.consumed[]
    tf.consumed[] = true
    return old_status
end
consumed(p::AbstractProcess) = consumed(p.taskdata)
consume!(p::AbstractProcess) = consumed(p.taskdata)

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
newargs!(p::AbstractProcess; args...) = p.taskdata = newargs(p.taskdata, args...)
export newargs!

prepare_args(p::AbstractProcess) = prepare_args(p, p.taskdata.func; lifetime = tasklifetime(p), overrides = overrides(p), args(p)...)
prepare_args!(p::AbstractProcess) = p.taskdata = preparedargs(p.taskdata, prepare_args(p))

"""
Fallback prepare
"""
const warnset = Set{Any}()
function prepare(::T, ::Any) where T
    if !in(T, warnset)
        @warn "No prepare function defined for $T, returning empty args"
        push!(warnset, T)
    end
    (;)
end

prepare(p::AbstractProcess; args...) = prepare_args(p, getfunc(p); args...)

function prepare_args(process, @specialize(func); lifetime = Indefinite(), overrides = (;), skip_prepare = false, args...)

    @static if DEBUG_MODE
        println("Preparing args for process $(process.id)")
    end
    algo = func
   
    if func isa Type
        algo = func()
        process.taskdata = newfunc(process.taskdata, algo)
    end


    # If prepare is skipped, then the prepared arguments are already stored in the process
    prepared_args = nothing
    if skip_prepare
        prepared_args = process.taskdata.prepared_args
    else
        if isnothing(get(overrides, :prepare, nothing)) # If prepare is nothing, then the user didn't specify a prepare function
            @static if DEBUG_MODE
                println("No prepare function override for process $(process.id)")
            end

            prepared_args = prepare(algo, (;proc = process, lifetime, args...))

        else
            prepared_args = overrides.prepare(algo, (;proc = process, lifetime, args...))
        end
        if isnothing(prepared_args)
            prepared_args = (;)
        end
    end
    @static if DEBUG_MODE
        println("Just prepared args for process $(process.id)")
    end

    algo_args = (;proc = process, lifetime, prepared_args...)
        
    algo_args = deletevalues(algo_args, nothing)

    return algo_args
end

# TODO: Add a loopfunction to taskdata?
function spawntask(p, func::F, args, runtimelisteners, loopdispatch; loopfunction = processloop) where F
    Threads.@spawn loopfunction(p, func, args, runtimelisteners, loopdispatch)
end

function runloop(p, func::F, args, runtimelisteners, loopdispatch; loopfunction = processloop) where F
    loopfunction(p, func, args, runtimelisteners, loopdispatch)
end

preparedata!(p::AbstractProcess) = preparedata!(p, p.taskdata.func; lifetime = tasklifetime(p), overrides = overrides(p), args(p)...)


function preparedata!(process, @specialize(func); lifetime = Indefinite(), overrides = (;), skip_prepare = false, inputargs...)   
    @static if DEBUG_MODE
        println("Creating task for process $(process.id)")
    end

    reset!(func) # Reset the loop counters for Routines and CompositeAlgorithms

    timeouttime = get(overrides, :timeout, 1.0)

    # if haskey(overrides, :loopfunction)
    #     loopfunction = overrides[:loopfunction]
    # else
    #     loopfunction = getloopfunc(process)
    # end

    # @static if DEBUG_MODE
    #     println("Loopfunction is $loopfunction for process $(process.id)")
    # end

    # prepared_args = prepare_args(process, func; lifetime, overrides, skip_prepare, inputargs...)
    prepared_args = prepare(process; lifetime, overrides, skip_prepare, inputargs...)

    @static if DEBUG_MODE
        display("Prepared args are $prepared_args")
    end

    # Create new taskdata
    process.taskdata = TaskData(func, inputargs, prepared_args, overrides, lifetime, Ref(true) ,timeouttime)
end

function cleanup(p::AbstractProcess)
    returnargs = cleanup(getfunc(p), getargs(p))
    return deletekeys(returnargs, :proc, :lifetime)
end

export preparedata!

