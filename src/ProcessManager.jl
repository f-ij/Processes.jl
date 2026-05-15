export ProcessManager, WorkerSlot
export FlushPolicy, FlushAtEnd, NoFlush, FlushEvery
export dispatch!, poll!, drain!, run!, resetworker!, reinitworker!, slots, workers, copyworker

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
mutable struct WorkerSlot{W, Job, Scratch, Result, Err}
    idx::Int
    worker::W
    job::Union{Nothing, Job}
    scratch::Union{Nothing, Scratch}
    result::Union{Nothing, Result}
    error::Union{Nothing, Err}
    active::Bool
    runs::Int
end

WorkerSlot(idx::Integer, worker; scratch = nothing) =
    WorkerSlot{typeof(worker), Any, Any, Any, Any}(Int(idx), worker, nothing, scratch, nothing, nothing, false, 0)

context(slot::WorkerSlot) = context(slot.worker)

"""
    resetworker!(slot)

Reset the worker stored in `slot` and return the slot. The manager never calls
this automatically; recipes opt into reset timing explicitly.
"""
resetworker!(slot::WorkerSlot) = (reset!(slot.worker); slot)

function _resolve_reinit_input(worker::Process, input::Union{Input, Override})
    _is_resolved_input(input) && return (input,)
    reg = getregistry(context(worker))
    return resolve(reg, input)
end

function _resolve_reinit_inputs(worker::Process, inputs_overrides...)
    resolved = ()
    for input in inputs_overrides
        resolved = (resolved..., _resolve_reinit_input(worker, input)...)
    end
    return resolved
end

"""
    reinitworker!(slot, inputs_overrides...; kwargs...)

Rebuild the worker context through the normal process init pipeline and return
the slot. For `Process` workers this delegates to `makecontext!`.
"""
function reinitworker!(slot::WorkerSlot{<:Process}, inputs_overrides...; kwargs...)
    context(slot.worker, context(init(getalgo(slot.worker), inputs_overrides...; lifetime = lifetime(slot.worker))))
    return slot
end

"""
    ProcessManager(recipe; nworkers = Threads.nthreads(), workers = nothing,
                   config = nothing, state = nothing, flush_policy = FlushAtEnd(),
                   throw = true, poll_interval = 0.0,
                   job_type = Any, scratch_type = Any,
                   result_type = Any, error_type = Any)

Flexible worker orchestrator.

Recipes may be named tuples containing callbacks, or concrete objects that
overload the callback functions below. The default worker protocol supports
`Process` workers.

When `workers` is omitted, the recipe must define `makeworker`. The manager calls
`makeworker` once to create a template worker, then copies that template for the
remaining slots. The default `Process` copy reuses the template task description
and deep-copies the runtime context. Recipes can define
`makecontext(idx, manager, template)` to build a separate `Process` context for
each slot while keeping the template task description, or
`copyworker(template, idx, manager)` when the whole worker copy must be custom. When
`workers` is passed, the manager wraps those existing workers in slots and does
not create new worker contexts.

The `job_type`, `scratch_type`, `result_type`, and `error_type` keywords let
latency-sensitive code make worker slot fields concrete. Leaving them as `Any`
keeps the manager fully flexible.
"""
mutable struct ProcessManager{Recipe, W, Config, State, Policy <: FlushPolicy}
    recipe::Recipe
    slots::W
    config::Config
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

const _PROCESSMANAGER_PRECOMPILE_LOCK = ReentrantLock()
const _PROCESSMANAGER_PRECOMPILE_TYPES = Set{Any}()

_slot_job_type(::WorkerSlot{W, Job}) where {W, Job} = Job

function _first_slot_type(slots::Tuple)
    return typeof(first(slots))
end

function _precompile_processmanager!(::Type{M}, ::Type{Slot}, ::Type{Job}) where {M<:ProcessManager, Slot<:WorkerSlot, Job}
    _try_precompile(dispatch!, (M, Job))
    _try_precompile(poll!, (M,))
    _try_precompile(drain!, (M,))
    _try_precompile(run!, (M, Vector{Job}))
    _try_precompile(_wait_for_free_slot!, (M,))
    _try_precompile(_finish_done_slots!, (M,))
    _try_precompile(_finish_slot!, (M, Slot))
    _try_precompile(_start_slot!, (M, Slot, Job))
    _try_precompile(_slot_isdone, (M, Slot))
    return nothing
end

function schedule_processmanager_precompile!(manager::ProcessManager)
    _is_generating_package_output() && return nothing
    isempty(slots(manager)) && return nothing

    manager_type = typeof(manager)
    slot_type = _first_slot_type(slots(manager))
    job_type = _slot_job_type(first(slots(manager)))
    signature = (manager_type, slot_type, job_type)

    should_schedule = lock(_PROCESSMANAGER_PRECOMPILE_LOCK) do
        if !(signature in _PROCESSMANAGER_PRECOMPILE_TYPES)
            push!(_PROCESSMANAGER_PRECOMPILE_TYPES, signature)
            return true
        end
        return false
    end
    should_schedule && Threads.@spawn _precompile_processmanager!(manager_type, slot_type, job_type)
    return nothing
end

function _slot_container(workers, ::Type{Job}, ::Type{Scratch}, ::Type{Result}, ::Type{Err}) where {Job, Scratch, Result, Err}
    return Tuple(
        WorkerSlot{typeof(worker), Job, Scratch, Result, Err}(
            Int(idx),
            worker,
            nothing,
            nothing,
            nothing,
            nothing,
            false,
            0,
        )
        for (idx, worker) in enumerate(workers)
    )
end

_has_recipe_callback(recipe, name::Val) = !_is_no_recipe_callback(_recipe_field(recipe, name))

function _worker_context(recipe, idx, manager, template)
    return _call_optional_recipe_field(recipe, Val(:makecontext), idx, manager, template)
end

function _process_with_context(template::Process, idx::Integer, prepared_context)
    return Process(getalgo(template); context = prepared_context, lifetime = lifetime(template), timeout = template.timeout)
end

function _process_with_context(template, idx::Integer, prepared_context)
    throw(ArgumentError("Recipe callback `makecontext` is only supported by default for `Process` workers. Define `copyworker` to customize non-Process worker construction."))
end

function _owned_worker_values(recipe, nworkers::Integer, build_manager)
    template = makeworker(recipe, 1, build_manager)

    if _has_recipe_callback(recipe, Val(:makecontext))
        return ntuple(Int(nworkers)) do idx
            prepared_context = _worker_context(recipe, idx, build_manager, template)
            _process_with_context(template, idx, prepared_context)
        end
    end

    return ntuple(Int(nworkers)) do idx
        idx == 1 ? template : copyworker(recipe, template, idx, build_manager)
    end
end

function ProcessManager(recipe; nworkers::Integer = Threads.nthreads(), workers = nothing, config = nothing, state = nothing, flush_policy = FlushAtEnd(), throw::Bool = true, poll_interval::Real = 0.0, job_type::Type{Job} = Any, scratch_type::Type{Scratch} = Any, result_type::Type{Result} = Any, error_type::Type{Err} = Any) where {Job, Scratch, Result, Err}
    nworkers > 0 || throw(ArgumentError("`nworkers` must be positive."))
    normalized_policy = _normalize_flush_policy(flush_policy)
    prepared_state = if isnothing(state)
        initstate(recipe, config, nothing)
    else
        state
    end
    build_manager = ProcessManager(recipe, (), config, prepared_state, normalized_policy, throw, Float64(poll_interval), 0, 0, 0, Any[], false, isnothing(workers))

    worker_values = if isnothing(workers)
        _owned_worker_values(recipe, nworkers, build_manager)
    else
        collected = collect(workers)
        isempty(collected) && throw(ArgumentError("`workers` must not be empty."))
        Tuple(collected)
    end

    slot_values = _slot_container(worker_values, job_type, scratch_type, result_type, error_type)
    manager = ProcessManager(recipe, slot_values, config, prepared_state, normalized_policy, throw, Float64(poll_interval), 0, 0, 0, Any[], false, isnothing(workers))
    schedule_processmanager_precompile!(manager)
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
_slot_worker(slot::WorkerSlot) = slot.worker
workers(manager::ProcessManager) = map(_slot_worker, manager.slots)

struct NoRecipeCallback end
_is_no_recipe_callback(::NoRecipeCallback) = true
_is_no_recipe_callback(_) = false

@inline function _recipe_field(recipe, ::Val{name}) where {name}
    hasfield(typeof(recipe), name) || return NoRecipeCallback()
    callback = getfield(recipe, name)
    return isnothing(callback) ? NoRecipeCallback() : callback
end

@inline _call_with_supported_arity(f) = f()
_valname(::Val{name}) where {name} = name

@inline function _call_with_supported_arity(f, a)
    applicable(f, a) && return f(a)
    applicable(f) && return f()
    throw(MethodError(f, (a,)))
end

@inline function _call_with_supported_arity(f, a, b)
    applicable(f, a, b) && return f(a, b)
    applicable(f, a) && return f(a)
    applicable(f) && return f()
    throw(MethodError(f, (a, b)))
end

@inline function _call_with_supported_arity(f, a, b, c)
    applicable(f, a, b, c) && return f(a, b, c)
    applicable(f, a, b) && return f(a, b)
    applicable(f, a) && return f(a)
    applicable(f) && return f()
    throw(MethodError(f, (a, b, c)))
end

@inline function _call_with_supported_arity(f, a, b, c, d)
    applicable(f, a, b, c, d) && return f(a, b, c, d)
    applicable(f, a, b, c) && return f(a, b, c)
    applicable(f, a, b) && return f(a, b)
    applicable(f, a) && return f(a)
    applicable(f) && return f()
    throw(MethodError(f, (a, b, c, d)))
end

function _call_with_supported_arity(f, args...)
    throw(MethodError(f, args))
end

function _call_recipe_field(recipe, name::Val, args...)
    callback = _recipe_field(recipe, name)
    _is_no_recipe_callback(callback) && throw(ArgumentError("Recipe does not define callback `$(_valname(name))`."))
    return _call_with_supported_arity(callback, args...)
end

function _call_optional_recipe_field(recipe, name::Val, args...)
    callback = _recipe_field(recipe, name)
    _is_no_recipe_callback(callback) && return NoRecipeCallback()
    return _call_with_supported_arity(callback, args...)
end

makeworker(recipe, idx, manager) = _call_recipe_field(recipe, Val(:makeworker), idx, manager)
function _default_copyworker(template::Process, idx, manager)
    return Process(getalgo(template); context = deepcopy(context(template)), lifetime = lifetime(template), timeout = template.timeout)
end
_default_copyworker(template, idx, manager) = deepcopy(template)

function copyworker(recipe, template, idx, manager)
    result = _call_optional_recipe_field(recipe, Val(:copyworker), template, idx, manager)
    return _is_no_recipe_callback(result) ? _default_copyworker(template, idx, manager) : result
end

function initstate(recipe, config, manager)
    result = _call_optional_recipe_field(recipe, Val(:initstate), config, manager)
    return _is_no_recipe_callback(result) ? nothing : result
end
prepare!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, Val(:prepare!), slot, job, manager)
start!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, Val(:start!), slot, job, manager)
isdone(recipe, slot, manager) = _call_optional_recipe_field(recipe, Val(:isdone), slot, manager)
finalize!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, Val(:finalize!), slot, job, manager)
afterrun!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, Val(:afterrun!), slot, job, manager)
consume!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, Val(:consume!), slot, job, manager)
release!(recipe, slot, job, manager) = _call_optional_recipe_field(recipe, Val(:release!), slot, job, manager)
flush!(recipe, manager) = _call_optional_recipe_field(recipe, Val(:flush!), manager)
close!(recipe, slot, manager) = _call_optional_recipe_field(recipe, Val(:close!), slot, manager)
onerror!(recipe, slot, err, manager) = _call_optional_recipe_field(recipe, Val(:onerror!), slot, err, manager)

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
    return _is_no_recipe_callback(result) ? _start_worker!(slot.worker) : result
end

function _slot_isdone(manager::ProcessManager, slot::WorkerSlot)
    result = isdone(manager.recipe, slot, manager)
    return _is_no_recipe_callback(result) ? _worker_isdone(slot.worker) : Bool(result)
end

function _finalize_slot_worker!(manager::ProcessManager, slot::WorkerSlot, job)
    result = finalize!(manager.recipe, slot, job, manager)
    return _is_no_recipe_callback(result) ? _finalize_worker!(slot.worker) : result
end

function _safe_close_slot!(manager::ProcessManager, slot::WorkerSlot)
    try
        result = close!(manager.recipe, slot, manager)
        _is_no_recipe_callback(result) && _close_worker!(slot.worker)
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
    job = something(slot.job)
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

function _next_free_slot(manager::ProcessManager)
    for idx in eachindex(manager.slots)
        manager.slots[idx].active || return idx
    end
    return nothing
end

function _has_active_slots(manager::ProcessManager)
    for slot in manager.slots
        slot.active && return true
    end
    return false
end

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
        (slot.active || manager.owns_workers) && _safe_close_slot!(manager, slot)
        slot.active = false
        slot.job = nothing
    end
    manager.closed = true
    return true
end
