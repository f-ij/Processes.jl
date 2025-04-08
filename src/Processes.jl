module Processes
    const modulefolder = @__DIR__

    export getargs, Process, start, quit

    using UUIDs, Preferences, JLD2, MacroTools
    import Base: Threads.SpinLock, lock, unlock
    const wait_timeout = .5

    import DataStructures: Queue, dequeue!, enqueue!

    abstract type ProcessAlgorithm end
    abstract type ProcessLoopAlgorithm <: ProcessAlgorithm end # Algorithms that can be inlined in processloop

    export ProcessAlgorithm

    const DEBUG_MODE = @load_preference("debug", false)
    function debug_mode(bool)
        @set_preferences!("debug" => bool)
    end

    include("Functions.jl")
    include("Printing.jl")
    include("ExpressionTools.jl")

    @ForwardDeclare AVec ""
    include("Arena.jl")
    @ForwardDeclare Process ""

    
    include("Lifetime.jl")
    include("TaskDatas.jl")
    include("TriggerList.jl")
    include("Benchmark.jl")
    include("Debugging.jl")
    include("Listeners.jl")
    include("Process.jl")
    include("ProcessStatus.jl")
    include("Interface.jl")
    include("Loops.jl")
    include("ProcessAlgorithms/ProcessAlgorithms.jl")
    include("Trackers/Trackers.jl")
    include("TotalInc.jl")
    include("Tools.jl")
    include("Saving.jl")


end