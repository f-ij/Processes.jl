include("_env.jl")
using Random

struct SourceStepAlloc <: Processes.ProcessAlgorithm end
struct BranchAStepAlloc <: Processes.ProcessAlgorithm end
struct BranchBStepAlloc <: Processes.ProcessAlgorithm end
struct BranchCStepAlloc <: Processes.ProcessAlgorithm end
struct BranchDStepAlloc <: Processes.ProcessAlgorithm end
struct ReducerStepAlloc <: Processes.ProcessAlgorithm end

function Processes.init(::SourceStepAlloc, context)
    return (; signal = copy(context.start_signal), phase = 0.01)
end

function Processes.step!(::SourceStepAlloc, context)
    signal = context.signal
    phase = context.phase

    @inbounds for i in eachindex(signal)
        x = signal[i]
        signal[i] = sin(x + phase) + cos(0.5 * x - phase) + 0.0000005 * i
    end

    return (; phase = phase + 0.01)
end

Processes.init(::BranchAStepAlloc, context) = (; output_a = zeros(context.n))
Processes.init(::BranchBStepAlloc, context) = (; output_b = zeros(context.n))
Processes.init(::BranchCStepAlloc, context) = (; output_c = zeros(context.n))
Processes.init(::BranchDStepAlloc, context) = (; output_d = zeros(context.n))

function Processes.step!(::BranchAStepAlloc, context)
    x = context.input_signal
    y = context.output_a

    @inbounds for i in eachindex(y)
        y[i] = sin(x[i]) + sqrt(abs(x[i]) + 1)
    end

    return (;)
end

function Processes.step!(::BranchBStepAlloc, context)
    x = context.input_signal
    y = context.output_b

    @inbounds for i in eachindex(y)
        y[i] = cos(x[i]) + abs(x[i])
    end

    return (;)
end

function Processes.step!(::BranchCStepAlloc, context)
    x = context.input_signal
    y = context.output_c

    @inbounds for i in eachindex(y)
        y[i] = exp(-abs(x[i])) + x[i]^2 * 0.001
    end

    return (;)
end

function Processes.step!(::BranchDStepAlloc, context)
    x = context.input_signal
    y = context.output_d

    @inbounds for i in eachindex(y)
        y[i] = tanh(x[i]) + 0.25 * x[i]
    end

    return (;)
end

Processes.init(::ReducerStepAlloc, _context) = (; checksum = 0.0)

function Processes.step!(::ReducerStepAlloc, context)
    a = context.a
    b = context.b
    c = context.c
    d = context.d
    checksum = 0.0

    @inbounds for i in eachindex(a)
        checksum += a[i] + b[i] + c[i] + d[i]
    end

    return (; checksum)
end

routes = (
    Route(SourceStepAlloc => BranchAStepAlloc, :signal => :input_signal),
    Route(SourceStepAlloc => BranchBStepAlloc, :signal => :input_signal),
    Route(SourceStepAlloc => BranchCStepAlloc, :signal => :input_signal),
    Route(SourceStepAlloc => BranchDStepAlloc, :signal => :input_signal),
    Route(BranchAStepAlloc => ReducerStepAlloc, :output_a => :a),
    Route(BranchBStepAlloc => ReducerStepAlloc, :output_b => :b),
    Route(BranchCStepAlloc => ReducerStepAlloc, :output_c => :c),
    Route(BranchDStepAlloc => ReducerStepAlloc, :output_d => :d),
)

dag = DaggerCompositeAlgorithm(
    SourceStepAlloc, BranchAStepAlloc, BranchBStepAlloc, BranchCStepAlloc, BranchDStepAlloc, ReducerStepAlloc,
    (1, 1, 1, 1, 1, 1),
    routes...,
)

n = 40_000
p = Process(
    dag,
    Input(SourceStepAlloc, :start_signal => randn(n)),
    Input(BranchAStepAlloc; n),
    Input(BranchBStepAlloc; n),
    Input(BranchCStepAlloc; n),
    Input(BranchDStepAlloc; n);
    lifetime = 1,
)

algo = getalgo(p.taskdata)
context = Processes.merge_into_globals(p.context, (; process = p))

step!(algo, context)
GC.gc()
alloc = @allocated step!(algo, context)

println("step_alloc=", alloc)
