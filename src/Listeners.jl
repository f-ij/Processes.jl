struct StartCloseListener{F}
    f::F
    proc::Process
    weak::Bool
    type::Symbol
    function StartCloseListener(f, proc, type, weak = false)
        sl = new{typeof(f)}(f, proc, weak)
        weak && finalizer(off, sl)
        return sl
    end
end

StartListener(f, proc) = StartCloseListener(f, proc, :start)
CloseListener(f, proc) = StartCloseListener(f, proc, :close)

function _exec_listeners(head, fs)
    if isnothing(fs)
        return
    end
    head()
    _exec_listeners(gethead(fs), gettail(fs))
end


struct RuntimeListeners{ST, CT}
    start::ST
    close::CT
end

start(rl::RuntimeListeners) = _exec_listeners(gethead(rl.start), gettail(rl.start))
Base.close(rl::RuntimeListeners) = _exec_listeners(gethead(rl.close), gettail(rl.close))


RuntimeListeners() = RuntimeListeners((), ())

function on(f, ::typeof(start), proc::Process)
    sl = StartListener(f, proc)
    runtimelisteners = proc.rl
    newstart = (f, runtimelisteners.start...)
    proc.rl = RuntimeListeners(newstart, runtimelisteners.close)
    return sl
end

function on(f, ::typeof(close), proc::Process)
    sl = CloseListener(f, proc)
    runtimelisteners = proc.rl
    newclose = (f, runtimelisteners.close...)
    proc.rl = RuntimeListeners(runtimelisteners.start, newclose)
    return sl
end

function off(sl::StartCloseListener)
    proc = sl.proc
    runtimelisteners = proc.rl
    type = sl.type
    newstarts = runtimelisteners.start
    newcloses = runtimelisteners.close
    if type == :start
        newstarts = filter(x -> x != sl, newstarts)
    else
        newcloses = filter(x -> x != sl, newcloses)
    end

    proc.rl = RuntimeListeners(newstarts, newcloses)
end