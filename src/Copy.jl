export copyinputs, copyoverrides, copytaskdata, copyprocess

"""
Normalize a value to tuple form.
"""
@inline _tupleize(x::Tuple) = x
@inline _tupleize(x) = (x,)

"""
Rebuild an input-like object without sharing the wrapper instance.
"""
@inline _copy_inputlike(input::Input) = Input(input.target_algo, pairs(input.vars)...)
@inline _copy_inputlike(override::Override) = Override(override.target_algo, pairs(override.vars)...)
@inline _copy_inputlike(ni::NamedInput{Name}) where {Name} = NamedInput{Name}(ni.vars)
@inline _copy_inputlike(no::NamedOverride{Name}) where {Name} = NamedOverride{Name}(no.vars)

"""
    copyinputs(td::TaskData)
    copyinputs(p::Process)

Return the input description stored on a task or process as fresh wrapper objects.

This copies the input descriptors, not the runtime context. It is meant for rebuilding
new processes from the same process description while allowing new per-copy inputs to be
merged in later.
"""
@inline copyinputs(td::TaskData) = Tuple(_copy_inputlike(input) for input in getinputs(td))

"""
    copyoverrides(td::TaskData)
    copyoverrides(p::Process)

Return the override description stored on a task or process as fresh wrapper objects.

As with [`copyinputs`](@ref), this copies the constructor-time description rather than the
materialized runtime context.
"""
@inline copyoverrides(td::TaskData) = Tuple(_copy_inputlike(override) for override in getoverrides(td))

@inline copyinputs(p::Process) = copyinputs(taskdata(p))
@inline copyoverrides(p::Process) = copyoverrides(taskdata(p))

@inline _is_inputlike(x) = x isa Input || x isa NamedInput
@inline _is_overridelike(x) = x isa Override || x isa NamedOverride

@inline _resolve_copy(::Any, input::NamedInput) = (_copy_inputlike(input),)
@inline _resolve_copy(::Any, override::NamedOverride) = (_copy_inputlike(override),)
@inline _resolve_copy(reg, input::Input) = resolve(reg, input)
@inline _resolve_copy(reg, override::Override) = resolve(reg, override)

"""
Convert any mix of `Input`/`Override` and already-named variants to named copies.
"""
function _resolve_copy(reg, inputs_overrides...)
    named = ()
    for input_or_override in inputs_overrides
        named = (named..., _resolve_copy(reg, input_or_override)...)
    end
    return named
end

"""
Resolve copy-time input and override updates against the registry of `func`.
"""
function _resolve_copy_inputs_overrides(func, inputs_overrides...)
    inputs = Tuple(x for x in inputs_overrides if _is_inputlike(x))
    overrides = Tuple(x for x in inputs_overrides if _is_overridelike(x))

    # Resolve through a fresh empty context so copied inputs follow the same registry mapping
    # as a normal constructor call.
    empty_context = ProcessContext(normalize_process_algo(func))
    reg = getregistry(empty_context)

    named_inputs = _resolve_copy(reg, inputs...)
    named_overrides = _resolve_copy(reg, overrides...)

    return named_inputs, named_overrides
end

"""
Merge named inputs or overrides by target algorithm key.

Later entries replace earlier ones with the same target, matching normal "last value wins"
constructor behavior.
"""
function _merge_named_by_target(base::Tuple, replacements::Tuple)
    isempty(replacements) && return base

    merged = base
    for replacement in replacements
        target = get_target_name(replacement)
        found = false
        newitems = Any[]

        for item in merged
            if get_target_name(item) == target
                push!(newitems, replacement)
                found = true
            else
                push!(newitems, item)
            end
        end

        found || push!(newitems, replacement)
        merged = Tuple(newitems)
    end

    return merged
end

"""
    copytaskdata(td::TaskData, inputs_overrides...; keep_inputs = true, keep_overrides = true,
                 lifetime = getlifetime(td), func = getalgo(td))
    copytaskdata(p::Process, inputs_overrides...; kwargs...)

Create a fresh `TaskData` from an existing task or process description.

This is the safe copy primitive for process duplication. Instead of cloning a fully
materialized context, it reconstructs the constructor-time description and optionally
replaces inputs, overrides, lifetime, or the algorithm. This is useful when contexts
contain external buffers or other values that should be re-initialized per copy.
"""
function copytaskdata(td::TaskData, inputs_overrides...; keep_inputs = true, keep_overrides = true, lifetime = getlifetime(td), func = getalgo(td))
    extra_inputs, extra_overrides = _resolve_copy_inputs_overrides(func, inputs_overrides...)

    # Re-resolve the stored descriptors through the target registry so copied tasks stay
    # consistent even if `func` changes key layout.
    base_inputs, base_overrides = if keep_inputs || keep_overrides
        _resolve_copy_inputs_overrides(func, getinputs(td)..., getoverrides(td)...)
    else
        (), ()
    end
    keep_inputs || (base_inputs = ())
    keep_overrides || (base_overrides = ())

    merged_inputs = _merge_named_by_target(base_inputs, extra_inputs)
    merged_overrides = _merge_named_by_target(base_overrides, extra_overrides)

    return TaskData(func; inputs = merged_inputs, overrides = merged_overrides, lifetime = lifetime)
end

@inline copytaskdata(p::Process, inputs_overrides...; kwargs...) = copytaskdata(taskdata(p), inputs_overrides...; kwargs...)

"""
Evaluate a custom context builder with either `(taskdata)` or `(taskdata, process)`.
"""
function _copy_context(context_builder, td::TaskData, original_process)
    if applicable(context_builder, td, original_process)
        return context_builder(td, original_process)
    elseif applicable(context_builder, td)
        return context_builder(td)
    else
        error("`context_builder` must accept `(taskdata)` or `(taskdata, process)`.")
    end
end

"""
Register a copied process in the global weak-reference process list.
"""
function _register_copied_process!(p::Process)
    processlist[p.id] = WeakRef(p)
    finalizer(remove_process!, p)
    return p
end

"""
Create a new `Process` directly from already-prepared task data and context.
"""
function _makecopiedprocess(td::TaskData, prepared_context, timeout)
    p = Process(uuid1(), prepared_context, td, timeout, nothing, UInt(1), UInt(1), Threads.ReentrantLock(), false, true, nothing, nothing, RuntimeListeners(), 0)
    return _register_copied_process!(p)
end

"""
    copyprocess(td::TaskData, inputs_overrides...; keep_inputs = true, keep_overrides = true,
                lifetime = getlifetime(td), timeout = 1.0, context = nothing,
                context_builder = nothing, func = getalgo(td))
    copyprocess(p::Process, inputs_overrides...; keep_inputs = true, keep_overrides = true,
                lifetime = getlifetime(taskdata(p)), timeout = p.timeout, context = nothing,
                context_builder = nothing, func = getalgo(taskdata(p)))

Build a fresh `Process` from an existing task description or process.

`copyprocess` deliberately avoids `deepcopy` of the live runtime context. Instead it
reconstructs the process from `TaskData`, then initializes a fresh context unless you pass
either:

- `context`: an already-prepared context to install directly.
- `context_builder`: a function receiving `(taskdata)` or `(taskdata, original_process)`.

Additional `Input(...)` and `Override(...)` arguments are merged into the copied task
description before initialization.
"""
function copyprocess(td::TaskData, inputs_overrides...; keep_inputs = true, keep_overrides = true, lifetime = getlifetime(td), timeout = 1.0, context = nothing, context_builder = nothing, func = getalgo(td))
    copied_td = copytaskdata(td, inputs_overrides...; keep_inputs, keep_overrides, lifetime, func)

    # Default to the normal init pipeline so each copied process gets a fresh prepared context.
    prepared_context = if !isnothing(context)
        context
    elseif !isnothing(context_builder)
        _copy_context(context_builder, copied_td, nothing)
    else
        initcontext(copied_td)
    end

    return _makecopiedprocess(copied_td, prepared_context, timeout)
end

function copyprocess(p::Process, inputs_overrides...; keep_inputs = true, keep_overrides = true, lifetime = getlifetime(taskdata(p)), timeout = p.timeout, context = nothing, context_builder = nothing, func = getalgo(taskdata(p)))
    copied_td = copytaskdata(taskdata(p), inputs_overrides...; keep_inputs, keep_overrides, lifetime, func)

    # When copying from a live process, allow the builder to inspect the original process.
    prepared_context = if !isnothing(context)
        context
    elseif !isnothing(context_builder)
        _copy_context(context_builder, copied_td, p)
    else
        initcontext(copied_td)
    end

    return _makecopiedprocess(copied_td, prepared_context, timeout)
end
