module Processes
    const modulefolder = @__DIR__

    export getargs, Process, start, quit

    using UUIDs
    import Base: Threads.SpinLock, lock, unlock
    const wait_timeout = .5

    abstract type ProcessAlgorithm end
    export ProcessAlgorithm

    include("Functions.jl")
    include("ExpressionTools.jl")

    @ForwardDeclare ArenaVector ""
    include("Arena.jl")
    @ForwardDeclare Process ""

 
    include("TaskFuncs.jl")
    include("TriggerList.jl")
    include("CompositeAlgorithms.jl")
    include("Benchmark.jl")
    include("Debugging.jl")
    include("Process.jl")
    include("ProcessStatus.jl")
    include("Interface.jl")
    include("Loops.jl")
    include("Tools.jl")

end