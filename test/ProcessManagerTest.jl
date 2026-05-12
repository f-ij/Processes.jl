using Test
using Processes

mutable struct ManagerFakeWorker
    idx::Int
    buffer::Vector{Int}
    done::Bool
end

function immediate_fake_recipe(external, flush_count)
    return (;
        makeworker = (idx, manager) -> ManagerFakeWorker(idx, Int[], false),
        prepare! = (slot, job, manager) -> push!(slot.worker.buffer, job),
        start! = (slot, job, manager) -> (slot.worker.done = true),
        isdone = (slot, manager) -> slot.worker.done,
        finalize! = (slot, job, manager) -> (slot.worker.done = false),
        flush! = manager -> begin
            flush_count[] += 1
            for slot in slots(manager)
                append!(external, slot.worker.buffer)
                empty!(slot.worker.buffer)
            end
            return external
        end,
    )
end

@testset "ProcessManager stores flush policy traits" begin
    manager = ProcessManager(immediate_fake_recipe(Int[], Ref(0)); nworkers = 1)
    @test manager.flush_policy isa FlushAtEnd
    @test_throws ArgumentError ProcessManager(immediate_fake_recipe(Int[], Ref(0)); nworkers = 1, flush_policy = :end)
end

@testset "ProcessManager can keep slot fields concrete" begin
    manager = ProcessManager(
        immediate_fake_recipe(Int[], Ref(0));
        nworkers = 1,
        job_type = Int,
        result_type = Nothing,
    )

    @test manager.config === nothing
    @test eltype(slots(manager)) <: WorkerSlot{ManagerFakeWorker, Int, Any, Nothing, Any}
end

@testset "ProcessManager stores slots as a typed tuple" begin
    recipe = (;
        prepare! = (slot, job, manager) -> (slot.worker.done = true; push!(slot.worker.buffer, job)),
        isdone = (slot, manager) -> slot.worker.done,
    )
    manager = ProcessManager(
        recipe;
        workers = (ManagerFakeWorker(1, Int[], false), (; done = false, buffer = Int[])),
        job_type = Int,
    )

    @test slots(manager) isa Tuple
    @test workers(manager) isa Tuple
    @test typeof(slots(manager)) <: Tuple{
        WorkerSlot{ManagerFakeWorker, Int, Any, Any, Any},
        WorkerSlot{@NamedTuple{done::Bool, buffer::Vector{Int}}, Int, Any, Any, Any},
    }
end

@testset "ProcessManager initializes owned state from config" begin
    recipe = (;
        initstate = config -> (; scale = config.scale, count = Ref(0)),
        makeworker = (idx, manager) -> ManagerFakeWorker(idx, Int[], false),
    )

    manager = ProcessManager(recipe; nworkers = 1, config = (; scale = 3))
    @test manager.config == (; scale = 3)
    @test manager.state.scale == 3
    @test manager.state.count[] == 0

    override_state = (; scale = 9)
    override_manager = ProcessManager(recipe; nworkers = 1, config = (; scale = 3), state = override_state)
    @test override_manager.state === override_state
end

@testset "ProcessManager keeps scheduling bounded by worker slots" begin
    active = Ref(0)
    max_active = Ref(0)
    recipe = (;
        makeworker = (idx, manager) -> ManagerFakeWorker(idx, Int[], false),
        prepare! = (slot, job, manager) -> push!(slot.worker.buffer, job),
        start! = (slot, job, manager) -> begin
            active[] += 1
            max_active[] = max(max_active[], active[])
            slot.worker.done = false
        end,
        isdone = (slot, manager) -> slot.worker.done,
        finalize! = (slot, job, manager) -> begin
            slot.worker.done = false
            active[] -= 1
        end,
    )

    manager = ProcessManager(recipe; nworkers = 2, flush_policy = NoFlush())
    dispatch!(manager, 1)
    dispatch!(manager, 2)
    @test max_active[] == 2

    slots(manager)[1].worker.done = true
    dispatch!(manager, 3)
    @test max_active[] == 2
    @test manager.dispatched == 3

    for slot in slots(manager)
        slot.worker.done = true
    end
    drain!(manager)
    @test active[] == 0
end

@testset "FlushAtEnd syncs worker-local buffers after drain" begin
    external = Int[]
    flush_count = Ref(0)
    manager = ProcessManager(immediate_fake_recipe(external, flush_count); nworkers = 2)

    for job in 1:5
        dispatch!(manager, job)
        poll!(manager)
    end

    @test isempty(external)
    @test manager.completions == 5
    drain!(manager)
    @test sort(external) == collect(1:5)
    @test flush_count[] == 1
end

@testset "NoFlush leaves worker-local buffers untouched" begin
    external = Int[]
    flush_count = Ref(0)
    manager = ProcessManager(immediate_fake_recipe(external, flush_count); nworkers = 2, flush_policy = NoFlush())

    run!(manager, 1:4)

    @test isempty(external)
    @test flush_count[] == 0
    @test sort(vcat((slot.worker.buffer for slot in slots(manager))...)) == collect(1:4)
end

@testset "FlushEvery flushes by completed worker runs" begin
    external = Int[]
    flush_count = Ref(0)
    manager = ProcessManager(immediate_fake_recipe(external, flush_count); nworkers = 2, flush_policy = FlushEvery(2; drain = false))

    run!(manager, 1:5)

    @test sort(external) == collect(1:5)
    @test flush_count[] == 3
end

@testset "release! runs after consume!" begin
    events = Symbol[]
    recipe = (;
        makeworker = (idx, manager) -> ManagerFakeWorker(idx, Int[], false),
        prepare! = (slot, job, manager) -> push!(slot.worker.buffer, job),
        start! = (slot, job, manager) -> (slot.worker.done = true),
        isdone = (slot, manager) -> slot.worker.done,
        finalize! = (slot, job, manager) -> (slot.worker.done = false),
        consume! = (slot, job, manager) -> push!(events, :consume),
        release! = (slot, job, manager) -> begin
            push!(events, :release)
            empty!(slot.worker.buffer)
        end,
    )

    manager = ProcessManager(recipe; nworkers = 1, flush_policy = NoFlush())
    run!(manager, [1])

    @test events == [:consume, :release]
    @test isempty(only(slots(manager)).worker.buffer)
end

struct ManagerProcessAccumulator <: Processes.ProcessAlgorithm end

function Processes.init(::ManagerProcessAccumulator, context)
    value = get(context, :start, 0)
    return (; value = Ref(value), buffer = Int[])
end

function Processes.step!(::ManagerProcessAccumulator, context)
    push!(context.buffer, context.value[])
    return (;)
end

function manager_process_context(worker)
    subcontexts = getfield(worker.context, :subcontexts)
    names = filter(!=(:globals), fieldnames(typeof(subcontexts)))
    return getproperty(subcontexts, only(names))
end

@testset "Process workers are transparent and reset is explicit" begin
    worker = Process(ManagerProcessAccumulator(); repeats = 1)
    external = Int[]
    reset_calls = Ref(0)
    recipe = (;
        prepare! = (slot, job, manager) -> begin
            local_context = manager_process_context(slot.worker)
            local_context.value[] = job
        end,
        flush! = manager -> begin
            for slot in slots(manager)
                local_context = manager_process_context(slot.worker)
                append!(external, local_context.buffer)
                empty!(local_context.buffer)
            end
        end,
    )

    manager = ProcessManager(recipe; workers = [worker])
    run!(manager, 1:3)

    @test external == [1, 2, 3]
    @test reset_calls[] == 0

    reset_recipe = (;
        prepare! = (slot, job, manager) -> begin
            reset_calls[] += 1
            resetworker!(slot)
            local_context = manager_process_context(slot.worker)
            local_context.value[] = job
        end,
        flush! = recipe.flush!,
    )

    reset_manager = ProcessManager(reset_recipe; workers = [worker])
    run!(reset_manager, 4:5)

    @test reset_calls[] == 2
end

@testset "reinitworker! rebuilds Process context through init pipeline" begin
    worker = Process(
        ManagerProcessAccumulator,
        Input(ManagerProcessAccumulator, :start => 0);
        repeats = 1,
    )
    external = Int[]
    recipe = (;
        prepare! = (slot, job, manager) -> reinitworker!(
            slot,
            Input(ManagerProcessAccumulator, :start => job),
        ),
        consume! = (slot, job, manager) -> begin
            local_context = manager_process_context(slot.worker)
            append!(external, local_context.buffer)
        end,
    )

    manager = ProcessManager(recipe; workers = [worker], flush_policy = NoFlush())
    run!(manager, [2, 5])

    @test external == [2, 5]
end
