export ProcessManager, WorkerSlot
export FlushPolicy, FlushAtEnd, NoFlush, FlushEvery
export dispatch!, poll!, drain!, run!, resetworker!, reinitworker!, slots, workers

"""
Policy trait controlling when a `ProcessManager` invokes a recipe `flush!` callback.
"""
abstract type FlushPolicy end

"""
    FlushAtEnd()

Flush worker-local buffers once, after all dispatched work has drained.
"""
struct FlushAtEnd <: FlushPolicy end

"""
    NoFlush()

Never invoke the recipe `flush!` callback automatically.
"""
struct NoFlush <: FlushPolicy end

"""
    FlushEvery(n; drain = true)

Invoke the recipe `flush!` callback after every `n` completed worker runs.
When `drain` is true, all active workers are finalized before flushing.
"""
struct FlushEvery <: FlushPolicy
    n::Int
    drain::Bool
    function FlushEvery(n::Integer; drain::Bool = true)
        n > 0 || throw(ArgumentError("`n` must be positive."))
        return new(Int(n), drain)
    end
end

_normalize_flush_policy(policy::FlushPolicy) = policy
_normalize_flush_policy(policy) = throw(ArgumentError("`flush_policy` must be a FlushPolicy, got $(typeof(policy))."))

"""
    WorkerSlot

Transparent manager-owned slot around a reusable worker.

The `worker` field is intentionally public so recipes can inspect and mutate the
underlying worker context directly.
"""
mutable struct WorkerSlot{W}
    idx::Int
    worker::W
    job::Any
    scratch::Any
    result::Any
    error::Any
    active::Bool
    runs::Int
end

WorkerSlot(idx::Integer, worker; scratch = nothing) =
    WorkerSlot(Int(idx), worker, nothing, scratch, nothing, nothing, false, 0)

context(slot::WorkerSlot) = context(slot.worker)

"""
    resetworker!(slot)

Reset the worker stored in `slot` and return the slot. The manager never calls
this automatically; recipes opt into reset timing explicitly.
"""
resetworker!(slot::WorkerSlot) = (reset!(slot.worker); slot)

"""
    reinitworker!(slot, inputs_overrides...; kwargs...)

Rebuild the worker context through the normal process init pipeline and return
the slot. For `Process` workers this delegates to `makecontext!`.
"""
function _resolve_reinit_input(worker::Process, input::Union{Input, Override})
    reg = getregistry(getcontext(taskdata(worker)))
    return resolve(reg, input)
end

_resolve_reinit_input(::Process, input::Union{NamedInput, NamedOverride}) = (input,)

function _resolve_reinit_inputs(worker::Process, inputs_overrides...)
    resolved = ()
    for input in inputs_overrides
        resolved = (resolved..., _resolve_reinit_input(worker, input)...)
    end
    return resolved
end

function reinitworker!(slot::WorkerSlot{<:Process}, inputs_overrides...; kwargs...)
    resolved = _resolve_reinit_inputs(slot.worker, inputs_overrides...)
    makecontext!(slot.worker, resolved...; kwargs...)
    return slot
end

"""
    ProcessManager(recipe; nworkers = Threads.nthreads(), workers = nothing,
                   config = nothing, state = nothing, flush_policy = FlushAtEnd(),
                   throw = true, poll_interval = 0.0)

Flexible worker orchestrator.

Recipes may be named tuples containing callbacks, or concrete objects that
overload the callback functions below. The default worker protocol supports
`Process` workers.
"""
mutable struct ProcessManager{Recipe, State, Policy <: FlushPolicy}
    recipe::Recipe
    slots::Vector{WorkerSlot}
    config::Any
    state::State
    flush_policy::Policy
    throw::Bool
    poll_interval::Float64
    completions::Int
    completions_since_flush::Int
    dispatched::Int
    errors::Vector{Any}
    closed::Bool
    owns_workers::Bool
end

function ProcessManager(recipe; nworkers::Integer = Threads.nthreads(), workers = nothing, config = nothing, state = nothing, flush_policy = FlushAtEnd(), throw::Bool = true, poll_interval::Real = 0.0)
    nworkers > 0 || throw(ArgumentError("`nworkers` must be positive."))
    normalized_policy = _normalize_flush_policy(flush_policy)
    prepared_state = if isnothing(state)
        initstate(recipe, config, nothing)
    else
        state
    end
    manager = ProcessManager(recipe, WorkerSlot[], config, prepared_state, normalized_policy, throw, Float64(poll_interval), 0, 0, 0, Any[], false, isnothing(workers))

    worker_values = if isnothing(workers)
        [makeworker(recipe, idx, manager) for idx in 1:Int(nworkers)]
    else
        collected = collect(workers)
        isempty(collected) && throw(ArgumentError("`workers` must not be empty."))
        collected
    end

    for (idx, worker) in enumerate(worker_values)
        push!(manager.slots, WorkerSlot(idx, worker))
    end

    return manager
end

"""
    slots(manager)

Return the manager's mutable worker slots.
"""
slots(manager::ProcessManager) = manager.slots

"""
    workers(manager)

Return the workers stored in each manager slot.
"""
workers(manager::ProcessManager) = map(slot -> slot.worker, manager.slots)

struct NoRecipeCallback end
const _NO_RECIPE_CALLBACK = NoRecipeCallback()

_has_recipe_field(recipe, name::Symbol) = hasproperty(recipe, name) && !isnothing(getproperty(recipe, name))

function _call_with_supported_arity(f, args...)
    for n in length(args):-1:0
        callargs = n == 0 ? () : args[1:n]
        applicable(f, callargs...) && return f(callargs...)
    end
    throw(MethodError(f, args))
end

function _call_recipe_field(recipe, name::Symbol, args...)
    _has_recipe_field(recipe, name) || throw(ArgumentError("Recipe does not define callback `$name`."))
    return _call_with_supported_arity(getproperty(recipe, name), args...)
end

function _call_optional_recipe_field(recipe, name::Symbol, args...)
    _has_recipe_field(recipe, name) || return _NO_RECIPE_CALLBACK
    return _call_with_supported_arity(getproperty(recipe, name), args...)
end

makeworker(recipe, idx, manager) = _call_recipe_field(recipe, :makeworker, idx, manager)
function initstate(recipe, config, manager)
    result = _call_optional_recipe_field(recipe, :initstate, config, manager)
    return result === _NO_RECIPE_CALLBACK ? nothing : result
end
prepare!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, :prepare!, slot, job, manager)
start!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, :start!, slot, job, manager)
isdone(recipe, slot, manager) = _call_optional_recipe_field(recipe, :isdone, slot, manager)
finalize!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, :finalize!, slot, job, manager)
afterrun!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, :afterrun!, slot, job, manager)
consume!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, :consume!, slot, job, manager)
release!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, :release!, slot, job, manager)
flush!(recipe, manager) = _call_optional_recipe_field(recipe, :flush!, manager)
close!(recipe, slot, manager) = _call_optional_recipe_field(recipe, :close!, slot, manager)
onerror!(recipe, slot, err, manager) = _call_optional_recipe_field(recipe, :onerror!, slot, err, manager)

function _start_worker!(worker::Process)
    run(worker)
    return worker
end

_worker_isdone(worker::Process) = isdone(worker)

function _finalize_worker!(worker::Process)
    wait(worker)
    close(worker)
    return worker
end

function _close_worker!(worker::Process)
    close(worker)
    return worker
end

function _start_slot!(manager::ProcessManager, slot::WorkerSlot, job)
    result = start!(manager.recipe, slot, job, manager)
    return result === _NO_RECIPE_CALLBACK ? _start_worker!(slot.worker) : result
end

function _slot_isdone(manager::ProcessManager, slot::WorkerSlot)
    result = isdone(manager.recipe, slot, manager)
    return result === _NO_RECIPE_CALLBACK ? _worker_isdone(slot.worker) : Bool(result)
end

function _finalize_slot_worker!(manager::ProcessManager, slot::WorkerSlot, job)
    result = finalize!(manager.recipe, slot, job, manager)
    return result === _NO_RECIPE_CALLBACK ? _finalize_worker!(slot.worker) : result
end

function _safe_close_slot!(manager::ProcessManager, slot::WorkerSlot)
    try
        result = close!(manager.recipe, slot, manager)
        result === _NO_RECIPE_CALLBACK && _close_worker!(slot.worker)
    catch err
        push!(manager.errors, err)
    end
    return slot
end

function _handle_slot_error!(manager::ProcessManager, slot::WorkerSlot, err)
    slot.error = err
    push!(manager.errors, err)
    try
        onerror!(manager.recipe, slot, err, manager)
    catch hook_err
        push!(manager.errors, hook_err)
        manager.throw && throw(hook_err)
    end
    manager.throw && throw(err)
    return slot
end

function _finish_slot!(manager::ProcessManager, slot::WorkerSlot)
    slot.active || return slot
    job = slot.job
    try
        slot.result = _finalize_slot_worker!(manager, slot, job)
        afterrun!(manager.recipe, slot, job, manager)
        consume!(manager.recipe, slot, job, manager)
        release!(manager.recipe, slot, job, manager)
        slot.runs += 1
        manager.completions += 1
        manager.completions_since_flush += 1
    catch err
        _safe_close_slot!(manager, slot)
        _handle_slot_error!(manager, slot, err)
    finally
        slot.active = false
        slot.job = nothing
    end
    return slot
end

function _finish_done_slots!(manager::ProcessManager)
    finished = 0
    for slot in manager.slots
        if slot.active && _slot_isdone(manager, slot)
            _finish_slot!(manager, slot)
            finished += 1
        end
    end
    return finished
end

function _drain_active!(manager::ProcessManager)
    for slot in manager.slots
        slot.active && _finish_slot!(manager, slot)
    end
    return manager
end

function _flush!(manager::ProcessManager)
    manager.completions_since_flush == 0 && return manager
    flush!(manager.recipe, manager)
    manager.completions_since_flush = 0
    return manager
end

_apply_flush_policy!(manager::ProcessManager, ::NoFlush; final::Bool = false) = manager

function _apply_flush_policy!(manager::ProcessManager, ::FlushAtEnd; final::Bool = false)
    final && _flush!(manager)
    return manager
end

function _apply_flush_policy!(manager::ProcessManager, policy::FlushEvery; final::Bool = false)
    if manager.completions_since_flush >= policy.n || (final && manager.completions_since_flush > 0)
        policy.drain && _drain_active!(manager)
        _flush!(manager)
    end
    return manager
end

_next_free_slot(manager::ProcessManager) = findfirst(slot -> !slot.active, manager.slots)
_has_active_slots(manager::ProcessManager) = any(slot -> slot.active, manager.slots)

"""
    poll!(manager)

Finalize completed workers, make their slots reusable, and apply the configured
flush policy if it is due.
"""
function poll!(manager::ProcessManager)
    manager.closed && throw(ArgumentError("Cannot poll a closed ProcessManager."))
    _finish_done_slots!(manager)
    _apply_flush_policy!(manager, manager.flush_policy; final = false)
    return manager
end

function _wait_for_free_slot!(manager::ProcessManager)
    while true
        free_idx = _next_free_slot(manager)
        isnothing(free_idx) || return manager.slots[free_idx]
        poll!(manager)
        if isnothing(_next_free_slot(manager))
            manager.poll_interval > 0 ? sleep(manager.poll_interval) : yield()
        end
    end
end

"""
    dispatch!(manager, job)

Schedule `job` on the next available worker slot, waiting for a slot to become
free when all workers are active.
"""
function dispatch!(manager::ProcessManager, job)
    manager.closed && throw(ArgumentError("Cannot dispatch to a closed ProcessManager."))
    slot = _wait_for_free_slot!(manager)
    slot.job = job
    slot.result = nothing
    slot.error = nothing
    try
        prepare!(manager.recipe, slot, job, manager)
        _start_slot!(manager, slot, job)
        slot.active = true
        manager.dispatched += 1
    catch err
        slot.active = false
        slot.job = nothing
        _handle_slot_error!(manager, slot, err)
    end
    return slot
end

"""
    drain!(manager)

Wait for all active workers to finish, then apply the configured final flush
policy.
"""
function drain!(manager::ProcessManager)
    manager.closed && throw(ArgumentError("Cannot drain a closed ProcessManager."))
    while _has_active_slots(manager)
        _finish_done_slots!(manager)
        if _has_active_slots(manager)
            manager.poll_interval > 0 ? sleep(manager.poll_interval) : yield()
        end
    end
    _apply_flush_policy!(manager, manager.flush_policy; final = true)
    return manager
end

"""
    run!(manager, jobs)

Dispatch all `jobs`, keep workers busy according to the manager's slot limit,
and drain at the end.
"""
function run!(manager::ProcessManager, jobs)
    for job in jobs
        dispatch!(manager, job)
        poll!(manager)
    end
    drain!(manager)
    return manager
end

function Base.close(manager::ProcessManager)
    manager.closed && return true
    for slot in manager.slots
        slot.active && _safe_close_slot!(manager, slot)
        slot.active = false
        slot.job = nothing
    end
    manager.closed = true
    return true
end
