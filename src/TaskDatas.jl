"""
Struct with all information to create the function within a process
"""
struct TaskData{F, As, Or, Lt}
    func::F
    inputs::As # Input context as the process is created
    overrides::Or # Given as kwargs
    lifetime::Lt
end

function TaskData(algo; overrides = tuple(), inputs = tuple(), lifetime = Indefinite())
    @static if DEBUG_MODE
        println("Algo: $algo")
    end
    if algo isa Type # For convenience, allow passing types
        algo = algo()
    end
    # TaskData(algo, args, (;), overrides, lifetime, Ref(true))
    TaskData(algo, inputs, overrides, lifetime)
end

getfunc(td::TaskData) = td.func
getinputs(td::TaskData) = td.inputs
getoverrides(td::TaskData) = td.overrides
getlifetime(td::TaskData) = td.lifetime


function newfunc(tf::TaskData, func)
    TaskData(func, tf.inputs, tf.overrides, tf.lifetime)
end

# """
# Overwrite the old input context with the new context
# """
# function editcontext(tf::TaskData; context...)
#     TaskData(tf.func, (;tf.inputs..., context...), tf.overrides, tf.lifetime)
# end

function preparedcontext(tf::TaskData, context)
    TaskData(tf.func, context, tf.overrides, tf.lifetime)
end

# TODO: ???
loopdispatch(p::AbstractProcess) = loopdispatch(p.taskdata)
loopdispatch(tf::TaskData) = tf.lifetime

function sametask(t1,t2)
    checks = (t1.func == t2.func,
    # t1.prepare == t2.prepare,
    # t1.cleanup == t2.cleanup,
    t1.inputs == t2.inputs,
    t1.overrides == t2.overrides,
    t1.lifetime == t2.lifetime)
    return all(checks)
end
export sametask

# #TODO: This should be somewhere visible
# newcontext!(p::AbstractProcess; context...) = p.taskdata = editcontext(p.taskdata; context...)
# export newcontext!
