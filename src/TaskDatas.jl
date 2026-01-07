"""
Struct with all information to create the function within a process
"""
struct TaskData{F, As, Or, Lt}
    func::F
    inputargs::As # Args that are giv en as the process is created
    # prepared_args::PAs # Args after prepare
    overrides::Or # Given as kwargs
    lifetime::Lt
    timeout::Float64 # Timeout in seconds
end

function TaskData(algo; overrides::NamedTuple = (;), lifetime = Indefinite(), args...)
    @static if DEBUG_MODE
        println("Algo: $algo")
    end
    if algo isa Type # For convenience, allow passing types
        algo = algo()
    end
    # TaskData(algo, args, (;), overrides, lifetime, Ref(true), 1.0)
    TaskData(algo, args, overrides, lifetime, 1.0)
end

# function PreparedData(algo; overrides::NamedTuple = (;), lifetime = Indefinite(), args...)
#     @static if DEBUG_MODE
#         println("Algo: $algo")
#     end
#     if algo isa Type # For convenience, allow passing types
#         algo = algo()
#     end
#     _prepared_args = prepare_args(algo; lifetime = lifetime, overrides = overrides, args...)
#     TaskData(algo, args, _prepared_args, overrides, lifetime, Ref(true), 1.0)
# end

# function newargs(tf::TaskData; args...)
#     TaskData(tf.func, args, tf.prepared_args, tf.overrides, tf.lifetime, tf.consumed, tf.timeout)
# end

function newfunc(tf::TaskData, func)
    TaskData(func, tf.args, tf.prepared_args, tf.overrides, tf.lifetime, tf.timeout)
end

"""
Overwrite the old args with the new args
"""
function editargs(tf::TaskData; args...)
    TaskData(tf.func, (;tf.args..., args...), tf.prepared_args, tf.overrides, tf.lifetime, tf.timeout)
end

function preparedargs(tf::TaskData, args)
    TaskData(tf.func, tf.args, args, tf.overrides, tf.lifetime, tf.timeout)
end

getfunc(p::AbstractProcess) = p.taskdata.func
# getprepare(p::AbstractProcess) = p.taskdata.prepare
# getcleanup(p::AbstractProcess) = p.taskdata.cleanup
# args(p::AbstractProcess) = p.taskdata.args
overrides(p::AbstractProcess) = p.taskdata.overrides
tasklifetime(p::AbstractProcess) = p.taskdata.lifetime
timeout(p::AbstractProcess) = p.taskdata.timeout
loopdispatch(p::AbstractProcess) = loopdispatch(p.taskdata)
loopdispatch(tf::TaskData) = tf.lifetime

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

