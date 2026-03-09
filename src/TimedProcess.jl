mutable struct TimedProcess{TD, C} <: AbstractProcess
    timer::Union{Timer, Nothing}
    taskdata::TD
    callback::Function
    context::C
    paused::Bool
end

function TimedProcess(func::F; lifetime = Indefinite(), interval::Real = 0., context = nothing) where F
    tf = TaskData(func; lifetime = Repeat(1), context...)
    prepared_context = init_context(tf)

    callback = let context = prepared_context
        timer -> @inline step!(func, context)
    end

    return TimedProcess(nothing, tf, callback, prepared_context, true)
end

function init!(tp::TimedProcess)
    tp.context = init_context(tp.taskdata)
    tp.callback = let context = tp.context
        timer -> @inline step!(tp.taskdata.func, context)
    end
    return tp
end

function run(tp::TimedProcess)
    if !tp.paused
        init!(tp)
    end
    if tp.timer === nothing
        tp.timer = Timer(tp.callback, 0; interval = tp.timer.interval)
    end
    return tp
end

function pause(tp::TimedProcess)
    if tp.timer[] !== nothing
        close(tp.timer[])
        tp.timer[] = nothing
    end
    tp.paused = true
    return tp
end

function Base.close(tp::TimedProcess)
    if tp.timer[] !== nothing
        close(tp.timer[])
        tp.timer[] = nothing
    end
    return tp
end


