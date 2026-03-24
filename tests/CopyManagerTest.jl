using Test
using JLD2
using Processes

module CopyManagerExt
using UUIDs
using JLD2
using Processes

import ..Processes: Process, TaskData, Input, Override, NamedInput, NamedOverride,
    ProcessContext, normalize_process_algo, getregistry, to_named, get_target_name,
    getinputs, getoverrides, getlifetime, getalgo, taskdata, initcontext,
    processlist, remove_process!, RuntimeListeners, context, task, deletekeys

include(joinpath(@__DIR__, "..", "src", "Copy.jl"))
include(joinpath(@__DIR__, "..", "src", "ProcessManager.jl"))
end

struct CopyManagedAccumulator <: Processes.ProcessAlgorithm end

function Processes.init(::CopyManagedAccumulator, context)
    (; start, sink) = context
    return (; value = start, sink)
end

function Processes.step!(::CopyManagedAccumulator, context)
    push!(context.sink, context.value)
    return (; value = context.value + context.delta)
end

@testset "copyprocess rebuilds from task description" begin
    template_sink = Int[]
    template = Process(
        CopyManagedAccumulator,
        Input(CopyManagedAccumulator, :start => 1, :sink => template_sink),
        Override(CopyManagedAccumulator, :delta => 2);
        lifetime = 3,
    )

    sink_a = Int[]
    sink_b = Int[]

    p_a = CopyManagerExt.copyprocess(
        template,
        Input(CopyManagedAccumulator, :start => 10, :sink => sink_a),
    )
    p_b = CopyManagerExt.copyprocess(
        template,
        Input(CopyManagedAccumulator, :start => 20, :sink => sink_b),
    )

    run(p_a)
    run(p_b)

    wait(p_a)
    wait(p_b)

    close(p_a)
    close(p_b)

    ctx_a = context(p_a)
    ctx_b = context(p_b)

    @test sink_a == [10, 12, 14]
    @test sink_b == [20, 22, 24]
    @test isempty(template_sink)
    @test ctx_a[CopyManagedAccumulator].value == 16
    @test ctx_b[CopyManagedAccumulator].value == 26
end

@testset "manageprocesses runs bounded copies and saves contexts" begin
    template = Process(
        CopyManagedAccumulator,
        Input(CopyManagedAccumulator, :start => 0, :sink => Int[]),
        Override(CopyManagedAccumulator, :delta => 3);
        lifetime = 4,
    )

    jobs = [
        (; start = 1, sink = Int[]),
        (; start = 10, sink = Int[]),
        (; start = 100, sink = Int[]),
    ]

    mktempdir() do folder
        results = CopyManagerExt.manageprocesses(template, jobs,
            (job, idx) -> (;
                inputs = Input(CopyManagedAccumulator, :start => job.start, :sink => job.sink),
                savefile = "copy_manager_$idx.jld2",
            );
            max_running = 2,
            savefolder = folder,
            throw = true,
        )

        @test length(results) == length(jobs)
        @test all(isnothing(result.error) for result in results)
        @test all(isnothing(result.context) for result in results)
        @test all(!isnothing(result.savefile) for result in results)
        @test all(isfile(result.savefile) for result in results)

        @test jobs[1].sink == [1, 4, 7, 10]
        @test jobs[2].sink == [10, 13, 16, 19]
        @test jobs[3].sink == [100, 103, 106, 109]

        saved_context = JLD2.load(results[2].savefile, "context")
        @test saved_context[CopyManagedAccumulator].value == 22
        @test !haskey(getfield(saved_context, :subcontexts).globals, :process)
    end
end
