module Processes
    const modulefolder = @__DIR__

    export getcontext, Process, start, quit

    using UUIDs, Preferences, JLD2, MacroTools, StaticArrays, PrecompileTools

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

    # include("Arena.jl")


    include("AbstractProcesses.jl")

    include("Matching.jl")
    include("Identifiable/Identifiable.jl")

    include("Registry/Registry.jl")
    include("Context/Context.jl")

    include("Lifetime.jl")
    include("TaskDatas.jl")
    include("InputInterface/InputInterface.jl")
    include("Init.jl")
    include("Running.jl")
    include("TriggerList.jl")
    include("Benchmark.jl")
    include("Debugging.jl")
    include("Listeners.jl")

    include("Process.jl")
    include("InlineProcess.jl")


    include("ProcessList.jl")

    include("Widgets/Widgets.jl")


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

    @setup_workload begin
        @compile_workload begin
            struct Fib <: ProcessAlgorithm end
            struct Luc <: ProcessAlgorithm end

            function Processes.step!(::Fib, context)
                fiblist = context.fiblist
                push!(fiblist, fiblist[end] + fiblist[end-1])
                return (;)
            end

            function Processes.init(::Fib, context)
                n_calls = num_calls(context)
                fiblist = Int[0, 1]
                processsizehint!(fiblist, context)
                return (;fiblist)
            end

            function Processes.step!(::Luc, context)
                luclist = context.luclist
                push!(luclist, luclist[end] + luclist[end-1])
                return (;)
            end

            function Processes.init(::Luc, context)
                luclist = Int[2, 1]
                processsizehint!(luclist,context)
                return (;luclist)
            end


            Fdup = Unique(Fib())
            Ldup = Unique(Luc)


            FibLuc = CompositeAlgorithm( (Fib(), Fib, Luc), (1,1,2), Route(Fib(), Luc, :fiblist))

            C = Routine((Fib, Fib(), FibLuc), (10,20,30))

            FFluc = CompositeAlgorithm( (FibLuc, Fdup, Fib, Ldup), (10,5,2,1), Route(Fdup, Ldup, :fiblist), Share(Fib, Ldup))

            pfu = Process(FFluc)
            pcu = Process(C)
            run(pfu)
            close(pfu)
            run(pcu)
            close(pcu)

            pfr = Process(FFluc, lifetime = 1)
            pcr = Process(C, lifetime = 1)

            pack = package(FibLuc)
            p = Process(pack)
            run(p)
            close(p)
            pr = Process(pack, lifetime = 1)
            run(pr)
            
        end

    end

end
