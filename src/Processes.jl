module Processes
    const modulefolder = @__DIR__

    export getcontext, Process, start, quit

    using UUIDs, Preferences, JLD2, MacroTools, StaticArrays
    import Base: Threads.SpinLock, lock, unlock
    const wait_timeout = .5

    import DataStructures: Queue, dequeue!, enqueue!

    abstract type ProcessAlgorithm end
    abstract type ProcessLoopAlgorithm <: ProcessAlgorithm end # Algorithms that can be inlined in processloop
    abstract type ComplexLoopAlgorithm <: ProcessLoopAlgorithm end # Algorithms that have multiple functions and intervals

    abstract type AbstractOption end
    abstract type ProcessState <: AbstractOption end

    abstract type AbstractContext end
    abstract type AbstractSubContext end

    export ProcessAlgorithm, ProcessState

    const DEBUG_MODE = @load_preference("debug", false)
    debug_mode() = @load_preference("debug", false)
    function debug_mode(bool)
        @set_preferences!("debug" => bool)
    end

    include("Functions.jl")
    include("Unroll.jl")
    include("Printing.jl")
    include("ExpressionTools.jl")

    # @ForwardDeclare AVec ""
    abstract type AbstractAVec{T} <: AbstractVector{T} end
    include("Arena.jl")
    # @ForwardDeclare Process ""
    # struct Process end

    

    include("AbstractProcesses.jl")
    include("Scoped/Scoped.jl")
    include("Registry/Registry.jl")
    include("Context/Context.jl")

    include("Lifetime.jl")
    include("TaskDatas.jl")
    include("InputInterface.jl")
    include("Prepare.jl")
    include("Running.jl")
    include("TriggerList.jl")
    include("Benchmark.jl")
    include("Debugging.jl")
    include("Listeners.jl")
    include("Process.jl")

    include("InlineProcess.jl")

    include("ProcessStatus.jl")
    include("Interface.jl")
    include("Loops.jl")
    include("ProcessStates/ProcessStates.jl")
    include("ProcessAlgorithms/ProcessAlgorithms.jl")
    include("Trackers/Trackers.jl")
    include("TotalInc.jl")
    include("Tools.jl")
    include("Saving.jl")


end
