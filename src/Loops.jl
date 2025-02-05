const start_finished = Ref(false)

function before_while(p::Process)
    start_finished[] = true
    p.threadid = Threads.threadid()
    @atomic p.paused = false
    set_starttime!(p)
    start.(get_linked_processes(p))
end

function after_while(p::Process, args)
    set_endtime!(p)
    close.(get_linked_processes(p))
    if run(p) || lifetime(p) isa Indefinite
        return cleanup(p, args)
    else
        return args
    end
end

cleanup(::Any, args) = args


"""
Run a single function in a loop indefinitely
"""
function processloop(@specialize(p::Process), @specialize(func), @specialize(args), ::Indefinite)
    @static if DEBUG_MODE
        println("Running process loop indefinitely from thread $(Threads.threadid())")
    end

    before_while(p)
    while run(p) 
        @inline func(args)
        inc!(p) 
        GC.safepoint()
    end
    return after_while(p, args)
end

"""
Run a single function in a loop for a given number of times
"""
function processloop(@specialize(p::Process), @specialize(func), @specialize(args), ::Repeat{repeats}) where repeats
    @static if DEBUG_MODE
        println("Running process loop for $repeats times from thread $(Threads.threadid())")
    end
    before_while(p)
    for _ in loopidx(p):repeats
        if !run(p)
            break
        end
        @inline func(args)
        inc!(p)
        GC.safepoint()
    end
    return after_while(p, args)
end


