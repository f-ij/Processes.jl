define_processdebug_task(@specialize(p), @specialize(func), @specialize(args), @specialize(lifetime)) = @task mainloop_warntype(p, func, args, lifetime)

function process_warntype(p)
    func = getfunc(p)
    args = getinputargs(p)
    lifetime = getlifetime(p)
    mainloop_warntype(p, func, args, lifetime)
end
export process_warntype
# import InteractiveUtils: @code_warntype

function mainloop_warntype(@specialize(p), @specialize(func), @specialize(args), ::Lifetime)
    Base.code_typed(func, Tuple{typeof(args)}; optimize=true)
end

function get_example_process(func, rt; loopfunction = nothing)
    p = Process(func; lifetime = rt)
    preparedata!(p)
    return p
end

function ex_p_and_args(func, rt; loopfunction = nothing)
    p = get_example_process(func, rt; loopfunction)
    args = getargs(p)
    return p, args
end
export get_example_process, ex_p_and_args