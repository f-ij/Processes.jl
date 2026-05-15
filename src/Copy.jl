export copyinputs, copyoverrides, copyprocess

@inline copyinputs(la::LoopAlgorithm) = getstoredinits(la)
@inline copyoverrides(la::LoopAlgorithm) = getstoredoverrides(la)
@inline copyinputs(p::Process) = copyinputs(getalgo(p))
@inline copyoverrides(p::Process) = copyoverrides(getalgo(p))

"""
    copyprocess(p::Process, Init(...), Override(...); kwargs...)

Build a new process from the stored initialized loop algorithm recipe. Extra
init/override specs are merged by `init`.
"""
function copyprocess(p::Process, specs...; lifetime = Processes.lifetime(p), timeout = p.timeout, context = nothing, func = getalgo(p), kwargs...)
    algo = isnothing(context) ? init(func, specs...) : _with_lifecycle(resolve(func), context, copyinputs(func), copyoverrides(func))
    return Process(algo; lifetime, timeout)
end

copyprocess(la::LoopAlgorithm, specs...; lifetime = Indefinite(), timeout = 1.0, context = nothing, kwargs...) =
    Process(isnothing(context) ? init(la, specs...) : _with_lifecycle(resolve(la), context, copyinputs(la), copyoverrides(la)); lifetime, timeout)
