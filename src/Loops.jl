const start_finished = Ref(false)

function before_while(p::Process, runtimelisteners)
    start_finished[] = true
    p.threadid = Threads.threadid()
    @atomic p.paused = false
    start(runtimelisteners)
    start.(get_linked_processes(p)) # TODO OBSOLETE?
    set_starttime!(p)
end

function after_while(p::Process, runtimelisteners, args)
    set_endtime!(p)
    close(runtimelisteners)
    close.(get_linked_processes(p)) # TODO OBSOLETE?
    if !run(p) || lifetime(p) isa Indefinite # If user interrupted, or lifetime is indefinite
        return args
    else
        # return cleanup(getfunc(p), args)
        return cleanup(p)
    end
end

cleanup(::Any, args) = args


"""
Run a single function in a loop indefinitely
"""
function processloop(@specialize(p::Process), @specialize(func), @specialize(args), runtimelisteners, ::Indefinite)
    @static if DEBUG_MODE
        println("Running process loop indefinitely from thread $(Threads.threadid())")
    end

    before_while(p, runtimelisteners)
    while run(p) 
        @inline func(args)
        inc!(p) 
        GC.safepoint()
    end
    return after_while(p, runtimelisteners, args)
end

"""
Run a single function in a loop for a given number of times
"""
function processloop(@specialize(p::Process), @specialize(func), @specialize(args), runtimelisteners, ::Repeat{repeats}) where repeats
    @static if DEBUG_MODE
        println("Running process loop for $repeats times from thread $(Threads.threadid())")
    end
    before_while(p, runtimelisteners)
    for _ in loopidx(p):repeats
        if !run(p)
            break
        end
        @inline func(args)
        # inc!(p)
        # GC.safepoint()
    end
    return after_while(p, runtimelisteners, args)
end


