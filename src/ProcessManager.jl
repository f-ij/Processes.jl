export ManagedProcessResult, ProcessManager, manageprocesses

"""
    ManagedProcessResult

Result record returned for each property handled by [`manageprocesses`](@ref).

Fields:

- `idx`: original index in the property list.
- `property`: the property value used to create the process.
- `process`: the process that was launched, or `nothing` if creation failed early.
- `context`: final context if retained in memory, otherwise `nothing`.
- `savefile`: saved `.jld2` path when persistence was requested.
- `error`: captured exception, or `nothing` on success.
"""
struct ManagedProcessResult{Prop, Proc, Ctx, Save, Err}
    idx::Int
    property::Prop
    process::Proc
    context::Ctx
    savefile::Save
    error::Err
end

"""
    ProcessManager(makeprocess, properties; max_running = Threads.nthreads(),
                   poll_interval = 0.01, savefolder = nothing,
                   filename = default_manager_filename, onfinish = nothing,
                   throw = true)

Bounded launcher for a collection of processes.

`makeprocess` is called with `(property)` or `(property, idx)` and must return either:

- a `Process`, or
- a named tuple containing at least `process = ...` and optionally `savefile = ...`.

The manager launches at most `max_running` processes at a time, waits for finished ones,
optionally saves their final contexts, and then continues launching the remaining jobs.
"""
struct ProcessManager{F, P, NameF, FinishF}
    makeprocess::F
    properties::P
    max_running::Int
    poll_interval::Float64
    savefolder::Union{Nothing, String}
    filename::NameF
    onfinish::FinishF
    throw::Bool
end

"""
Default filename scheme used by `ProcessManager` when `savefolder` is set.
"""
@inline default_manager_filename(property, idx, process) = "context_$(lpad(idx, 4, '0'))_$(process.id).jld2"

function ProcessManager(makeprocess, properties; max_running = Threads.nthreads(), poll_interval = 0.01, savefolder = nothing, filename = default_manager_filename, onfinish = nothing, throw = true)
    max_running > 0 || error("`max_running` must be larger than zero.")
    return ProcessManager(makeprocess, collect(properties), max_running, Float64(poll_interval), isnothing(savefolder) ? nothing : String(savefolder), filename, onfinish, throw)
end

"""
Call a process builder with `(property, idx)` when available, otherwise `(property)`.
"""
@inline _call_process_builder(makeprocess, property, idx) = applicable(makeprocess, property, idx) ? makeprocess(property, idx) : makeprocess(property)

"""
Resolve a save filename from either a fixed string or a filename callback.
"""
@inline _call_filename_builder(filename::AbstractString, property, idx, process) = filename
@inline _call_filename_builder(filename, property, idx, process) = applicable(filename, property, idx, process) ? filename(property, idx, process) : applicable(filename, property, idx) ? filename(property, idx) : filename(idx)

"""
Run an optional finish hook with supported signatures `(result)` or `(result, manager)`.
"""
function _call_onfinish(onfinish, result, manager)
    isnothing(onfinish) && return nothing

    if applicable(onfinish, result, manager)
        return onfinish(result, manager)
    elseif applicable(onfinish, result)
        return onfinish(result)
    else
        error("`onfinish` must accept `(result)` or `(result, manager)`.")
    end
end

"""
    savecontext(context, filename)

Save a final context directly to a JLD2 file.

This method complements the package-level `savecontext(::Process, ...)` helper by working on
already-materialized contexts, which is what `ProcessManager` has after finalization.
"""
function savecontext(context, filename::AbstractString)
    folder = dirname(filename)
    if !isempty(folder) && folder != "."
        mkpath(folder)
    end
    jldsave(filename; context)
    return filename
end

"""
Strip runtime-only globals from a finished context before returning or saving it.
"""
function _materialize_context(context::ProcessContext)
    subcontexts = getfield(context, :subcontexts)
    globals = getproperty(subcontexts, :globals)

    # The runtime `:process` reference is useful while running, but it should not be kept in
    # persisted results because it introduces unnecessary object graphs.
    if haskey(globals, :process)
        globals = deletekeys(globals, :process)
        subcontexts = (; subcontexts..., globals)
        return ProcessContext(subcontexts, getfield(context, :registry))
    end

    return context
end

@inline _materialize_context(context) = context

"""
Normalize builder output to the manager's internal `(process, savefile)` form.
"""
@inline _normalize_managed_entry(process::Process) = (; process, savefile = nothing)
@inline function _normalize_managed_entry(entry::NamedTuple)
    haskey(entry, :process) || error("Managed process builders must return a `Process` or a named tuple with a `:process` key.")
    return (; process = entry.process, savefile = get(entry, :savefile, nothing))
end

"""
Build and start one managed process, capturing constructor/startup errors into a result.
"""
function _launch_managed_process(manager::ProcessManager, property, idx)
    try
        entry = _normalize_managed_entry(_call_process_builder(manager.makeprocess, property, idx))
        run(entry.process)
        return (; idx, property, process = entry.process, savefile = entry.savefile)
    catch err
        return ManagedProcessResult(idx, property, nothing, nothing, nothing, err)
    end
end

"""
Check whether a managed process task has completed.
"""
@inline _is_finished(entry) = !isnothing(task(entry.process)) && istaskdone(task(entry.process))

"""
Compute the output file for a finished managed process, if any.
"""
function _resolve_savefile(manager::ProcessManager, entry)
    filename = isnothing(entry.savefile) ? (isnothing(manager.savefolder) ? nothing : _call_filename_builder(manager.filename, entry.property, entry.idx, entry.process)) : entry.savefile
    isnothing(filename) && return nothing

    filename = String(filename)
    if !isnothing(manager.savefolder) && !isabspath(filename)
        filename = joinpath(manager.savefolder, filename)
    end
    endswith(filename, ".jld2") || (filename *= ".jld2")

    return filename
end

"""
Wait for one launched process, close it, materialize the final context, and save if needed.
"""
function _finalize_managed_process(manager::ProcessManager, entry)
    err = nothing
    final_context = nothing
    savefile = nothing

    try
        wait(entry.process)
        close(entry.process)
        final_context = _materialize_context(context(entry.process))

        # Large contexts can be moved to disk immediately to keep the result vector light.
        savefile = _resolve_savefile(manager, entry)
        if !isnothing(savefile)
            savecontext(final_context, savefile)
            final_context = nothing
        end
    catch caught
        err = caught
        try
            close(entry.process)
        catch
        end
    end

    result = ManagedProcessResult(entry.idx, entry.property, entry.process, final_context, savefile, err)
    _call_onfinish(manager.onfinish, result, manager)
    return result
end

"""
    run(manager::ProcessManager)

Execute the manager and return one [`ManagedProcessResult`](@ref) per input property.

The result vector preserves the original property ordering even though processes may finish
out of order.
"""
function Base.run(manager::ProcessManager)
    total = length(manager.properties)
    results = Vector{Any}(undef, total)
    active = Any[]

    for (idx, property) in enumerate(manager.properties)
        # Backpressure: only launch a new process once at least one active process has finished.
        while length(active) >= manager.max_running
            finished = findall(_is_finished, active)
            if isempty(finished)
                sleep(manager.poll_interval)
                continue
            end

            for active_idx in reverse(finished)
                entry = active[active_idx]
                results[entry.idx] = _finalize_managed_process(manager, entry)
                deleteat!(active, active_idx)
            end
        end

        launched = _launch_managed_process(manager, property, idx)
        if launched isa ManagedProcessResult
            results[idx] = launched
        else
            push!(active, launched)
        end
    end

    # Drain the remaining active processes after no new launches are left.
    while !isempty(active)
        finished = findall(_is_finished, active)
        if isempty(finished)
            sleep(manager.poll_interval)
            continue
        end

        for active_idx in reverse(finished)
            entry = active[active_idx]
            results[entry.idx] = _finalize_managed_process(manager, entry)
            deleteat!(active, active_idx)
        end
    end

    if manager.throw
        errors = Any[]
        for result in results
            isnothing(result.error) || push!(errors, result.error)
        end
        isempty(errors) || throw(CompositeException(errors))
    end

    return results
end

"""
    manageprocesses(makeprocess, properties; kwargs...)

Run a bounded set of processes produced from `properties`.

This is a convenience wrapper around `run(ProcessManager(...))`.
"""
@inline manageprocesses(makeprocess, properties; kwargs...) = run(ProcessManager(makeprocess, properties; kwargs...))

"""
Extract mapped inputs and overrides from a mapper result named tuple.
"""
@inline _mapped_inputs_overrides(mapped::NamedTuple) = begin
    inputs = haskey(mapped, :inputs) ? _tupleize(mapped.inputs) : ()
    overrides = haskey(mapped, :overrides) ? _tupleize(mapped.overrides) : ()
    inputs_overrides = haskey(mapped, :inputs_overrides) ? _tupleize(mapped.inputs_overrides) : ()
    return (inputs..., overrides..., inputs_overrides...)
end

"""
Turn a mapper return value into a copied process or managed process entry.
"""
function _mapped_copyprocess(template::Process, mapped)
    if isnothing(mapped)
        return copyprocess(template)
    elseif mapped isa Process
        return mapped
    elseif mapped isa NamedTuple
        inputs_overrides = _mapped_inputs_overrides(mapped)
        kwargs = deletekeys(mapped, :inputs, :overrides, :inputs_overrides, :savefile)
        process = copyprocess(template, inputs_overrides...; kwargs...)
        return (; process, savefile = get(mapped, :savefile, nothing))
    else
        return copyprocess(template, _tupleize(mapped)...)
    end
end

"""
    manageprocesses(template::Process, properties, mapper = nothing; kwargs...)

Run a bounded set of copied processes starting from a template process.

`mapper` may return:

- `nothing`: copy the template as-is,
- a `Process`: use that process directly,
- a named tuple with `inputs`, `overrides`, `inputs_overrides`, copy keywords, and optional `savefile`,
- any other value, which is treated as positional input/override data for `copyprocess`.
"""
function manageprocesses(template::Process, properties, mapper = nothing; kwargs...)
    makeprocess = let template = template, mapper = mapper
        function (property, idx)
            mapped = isnothing(mapper) ? nothing : _call_process_builder(mapper, property, idx)
            return _mapped_copyprocess(template, mapped)
        end
    end

    return manageprocesses(makeprocess, properties; kwargs...)
end
