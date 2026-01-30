"""
Struct with all information to create the function within a process
"""
struct TaskData{F, As, Or, C, Lt}
    func::F
    inputs::As # Input context as the process is created
    overrides::Or # Given as kwargs
    empty_context::C # Gives the structure of the context for this task
    lifetime::Lt
end

function TaskData(algo; overrides = tuple(), inputs = tuple(), lifetime = Indefinite())
    @DebugMode "Algo: $algo"
    if algo isa Type # For convenience, allow passing types
        algo = algo()
    end
    c = ProcessContext(algo; globals = (;lifetime, algo))
    # TaskData(algo, args, (;), overrides, lifetime, Ref(true))
    if !(inputs isa Tuple)
        # println("Making inputs a tuple")
        inputs = (inputs,)
    end
    if !(overrides isa Tuple)
        # println("Making overrides a tuple")
        overrides = (overrides,)
    end
    TaskData(algo, inputs, overrides, c, lifetime)
end

getfunc(td::TaskData) = td.func
getinputs(td::TaskData) = td.inputs
getoverrides(td::TaskData) = td.overrides
getlifetime(td::TaskData) = td.lifetime
getcontext(td::TaskData) = td.empty_context


function newfunc(tf::TaskData, func)
    TaskData(func, tf.inputs, tf.overrides, tf.empty_context, tf.lifetime)
end

# """
# Overwrite the old input context with the new context
# """
# function editcontext(tf::TaskData; context...)
#     TaskData(tf.func, (;tf.inputs..., context...), tf.overrides, tf.lifetime)
# end

function preparedcontext(tf::TaskData, context)
    TaskData(tf.func, context, tf.overrides, tf.empty_context, tf.lifetime)
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
