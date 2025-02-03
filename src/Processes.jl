module Processes
    const modulefolder = @__DIR__

    export getargs, Process, start, quit

    using UUIDs, Preferences
    import Base: Threads.SpinLock, lock, unlock
    const wait_timeout = .5

    abstract type ProcessAlgorithm end
    export ProcessAlgorithm

    const DEBUG_MODE = @load_preference("debug", false)

    include("Functions.jl")
    include("ExpressionTools.jl")

    @ForwardDeclare AVec ""
    include("Arena.jl")
    @ForwardDeclare Process ""

 
    include("TaskFuncs.jl")
    include("TriggerList.jl")
    include("Benchmark.jl")
    include("Debugging.jl")
    include("Process.jl")
    include("ProcessStatus.jl")
    include("Interface.jl")
    include("Loops.jl")
    include("CompositeAlgorithms.jl")
    include("Tools.jl")

end