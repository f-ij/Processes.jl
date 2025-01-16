define_processdebug_task(@specialize(p), @specialize(func), @specialize(args), @specialize(runtime)) = @task mainloop_warntype(p, func, args, runtime)

function process_warntype(p)
    func = getfunc(p)
    args = getinputargs(p)
    runtime = getruntime(p)
    mainloop_warntype(p, func, args, runtime)
end
export process_warntype
import InteractiveUtils: @code_warntype

function mainloop_warntype(@specialize(p), @specialize(func), @specialize(args), ::Runtime)
    Base.code_typed(func, Tuple{typeof(args)}; optimize=true)
end