include("_env.jl")

struct DebugSource <: Processes.ProcessAlgorithm end
struct DebugLeft <: Processes.ProcessAlgorithm end
struct DebugRight <: Processes.ProcessAlgorithm end
struct DebugJoin <: Processes.ProcessAlgorithm end

Processes.init(::DebugSource, context) = (; signal = copy(context.start_signal))
Processes.step!(::DebugSource, _context) = (;)

Processes.init(::DebugLeft, context) = (; left = similar(context.input_signal))
Processes.step!(::DebugLeft, _context) = (;)

Processes.init(::DebugRight, context) = (; right = similar(context.input_signal))
Processes.step!(::DebugRight, _context) = (;)

Processes.init(::DebugJoin, _context) = (; total = 0.0)
Processes.step!(::DebugJoin, _context) = (;)

routes = (
    Route(DebugSource => DebugLeft, :signal => :input_signal),
    Route(DebugSource => DebugRight, :signal => :input_signal),
    Route(DebugLeft => DebugJoin, :left => :left_input),
    Route(DebugRight => DebugJoin, :right => :right_input),
)

dag = DaggerCompositeAlgorithm(
    DebugSource, DebugLeft, DebugRight, DebugJoin,
    (1, 1, 2, 1),
    routes...,
)

p = Process(
    dag,
    Input(DebugSource, :start_signal => randn(8));
    lifetime = 1,
)

showdaggergraph(stdout, p)
println()
