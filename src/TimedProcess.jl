struct TimedProcess{TD, C} <: AbstractProcess
    timer::Base.RefValue{Timer, Nothing}
    taskdata::TD
    context::C
    paused::Base.RefValue{Bool}
end

