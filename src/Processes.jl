module Processes
    const modulefolder = @__DIR__

    export getcontext, Process, start, quit

    using UUIDs, Preferences, JLD2, MacroTools, StaticArrays

    import Base: Threads.SpinLock, lock, unlock
    const wait_timeout = .5

    import DataStructures: Queue, dequeue!, enqueue!

    export ProcessAlgorithm, ProcessState

    const DEBUG_MODE = @load_preference("debug", false)
    debug_mode() = @load_preference("debug", false)
    function debug_mode(bool)
        @set_preferences!("debug" => bool)
    end

    include("AbstractTypeDefs.jl")

    include("Functions.jl")
    include("Unroll.jl")
    include("Printing.jl")
    include("ExpressionTools.jl")

    include("Arena.jl")


    

    include("AbstractProcesses.jl")

    include("Matching.jl")
    include("Identifiable/Identifiable.jl")

    include("Registry/Registry.jl")
    include("Context/Context.jl")

    include("Lifetime.jl")
    include("TaskDatas.jl")
    include("InputInterface/InputInterface.jl")
    include("Prepare.jl")
    include("Running.jl")
    include("TriggerList.jl")
    include("Benchmark.jl")
    include("Debugging.jl")
    include("Listeners.jl")
    include("Process.jl")

    include("ProcessList.jl")

    include("InlineProcess.jl")

    include("ProcessStatus.jl")
    include("Interface.jl")
    
    include("ProcessEntities/ProcessEntities.jl")
    # include("ProcessStates/ProcessStates.jl")
    # include("ProcessAlgorithms.jl")

    include("LoopAlgorithms/LoopAlgorithms.jl")
    include("Packaging/Packaging.jl")
    include("Loops.jl")
    include("Trackers/Trackers.jl")
    include("TotalInc.jl")
    include("Tools.jl")
    include("Saving.jl")

    include("GeneratedCode/GeneratedCode.jl")


end
