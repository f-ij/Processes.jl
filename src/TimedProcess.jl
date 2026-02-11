struct TimedProcess{TD, C} <: AbstractProcess
    timer::Base.RefValue{Timer, Nothing}
    taskdata::TD
    context::C
    paused::Base.RefValue{Bool}
end

function TimedProcess(func::F, interval::Real; lifetime = Indefinite(), interval::Real = 0., context = nothing) where F
    tf = TaskData(func; lifetime = Repeat(1), context...)
    prepared_context = init_context(tf)
    timer = Ref{Timer, Nothing}(Timer(identity, delay; interval))
    paused = Ref(false)
    return TimedProcess(timer, tf, prepared_context, paused)
end

