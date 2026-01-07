const start_finished = Ref(false)

function before_while(p::AbstractProcess)
    start_finished[] = true
    p.threadid = Threads.threadid()
    @atomic p.paused = false
    _runtimelisteners = runtimelisteners(p)
    start(_runtimelisteners)
    start.(get_linked_processes(p)) # TODO OBSOLETE?
    set_starttime!(p)
end

function before_while(ip::InlineProcess)
    set_starttime!(ip)
end

function after_while(p::AbstractProcess, args)
    set_endtime!(p)
    _runtimelisteners = runtimelisteners(p)
    close(_runtimelisteners)
    close.(get_linked_processes(p)) # TODO OBSOLETE?
    if !run(p) || lifetime(p) isa Indefinite # If user interrupted, or lifetime is indefinite
        return args
    else
        # return cleanup(getfunc(p), args)
        return cleanup(p)
    end
end

function after_while(ip::InlineProcess, args)
    set_endtime!(ip)
    return cleanup(ip)
end

cleanup(::Any, args) = args


"""
Run a single function in a loop indefinitely
"""
function processloop(p::AbstractProcess, func::F, args::As, ::Indefinite) where {F, As}
    @static if DEBUG_MODE
        println("Running process loop indefinitely from thread $(Threads.threadid())")
    end

    before_while(p)
    while run(p) 
        # returnval = @inline step!(func, args)
        # args = mergeargs(args, returnval)
        @inline step!(func, args)
        inc!(p) 
        GC.safepoint()
    end
    return after_while(p, args)
end

"""
Run a single function in a loop for a given number of times
"""
function processloop(p::AbstractProcess, func::F, args::As, r::Repeat) where {F, As}
    @static if DEBUG_MODE
        println("Running process loop for $repeats times from thread $(Threads.threadid())")
    end
    before_while(p)
    for _ in loopidx(p):repeats(r)
        if !run(p)
            break
        end
        # returnval = @inline step!(func, args)
        # args = mergeargs(args, returnval)
        @inline step!(func, args)
        inc!(p)
        GC.safepoint()
    end
    return after_while(p, args)
end


