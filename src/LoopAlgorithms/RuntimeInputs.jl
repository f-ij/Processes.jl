export RuntimeInput, RuntimeInputState, RuntimeInputs, partialinit

"""
Lightweight process handle used by `run(::LoopAlgorithm; ...)`.

Direct loop-algorithm runs need the same loop counter, timing, and lifetime
interface as a normal `Process`, but they should not allocate or store an
interactive task handle. `LoopRunProcess` is that minimal runtime object.
"""
mutable struct LoopRunProcess{LT} <: AbstractProcess
    loopidx::UInt
    tickidx::UInt
    lifetime::LT
    @atomic shouldrun::Bool
    starttime::Union{Nothing, Float64, UInt64}
    endtime::Union{Nothing, Float64, UInt64}
    threadid::Int
end

LoopRunProcess(lifetime::LT) where {LT} = LoopRunProcess{LT}(UInt(1), UInt(1), lifetime, true, nothing, nothing, 0)
@inline lifetime(p::LoopRunProcess) = p.lifetime
@inline shouldrun(p::LoopRunProcess) = p.shouldrun
@inline tick!(p::LoopRunProcess) = (p.tickidx += UInt(1))
@inline set_starttime!(p::LoopRunProcess) = (p.starttime = time_ns())
@inline set_endtime!(p::LoopRunProcess) = (p.endtime = time_ns())
@inline context(::LoopRunProcess, ::Any) = nothing

"""
Runtime input declaration produced by DSL `@input`.

`Name`, `T`, and `Required` live in the type so validation specializes on the
declared input contract. `default` is stored only for optional inputs.
"""
struct RuntimeInput{Name, T, Required, Default}
    default::Default
end

RuntimeInput(name::Symbol, ::Type{T}; required::Bool = true, default = nothing) where {T} =
    RuntimeInput{name, T, required, typeof(default)}(default)

"""
Loop option carrying all runtime input declarations for a composed algorithm.

The DSL stores this as an option so `run(...; kwargs...)` can validate keyword
arguments without inspecting the generated step code.
"""
struct RuntimeInputs{Specs} <: AbstractOption
    specs::Specs
end

RuntimeInputs(specs::Tuple = ()) = RuntimeInputs{typeof(specs)}(specs)

"""
Registry-visible marker state for runtime input names.

Runtime inputs are not persistent state. This marker exists so the composition
registry can route DSL references such as `temperature` to the runtime input
owner while initialization still produces an empty persistent subcontext.
"""
struct RuntimeInputState{Specs} <: ProcessState
    specs::Specs
end

RuntimeInputState(specs::Tuple = ()) = RuntimeInputState{typeof(specs)}(specs)

Processes.registry_allowmerge(::Union{RuntimeInputState, Type{<:RuntimeInputState}}) = true
match_by(ia::Union{IdentifiableAlgo{<:RuntimeInputState}, Type{<:IdentifiableAlgo{<:RuntimeInputState}}}) = ValMatcher(getkey(ia))

Processes.init(::RuntimeInputState, context) = (;)

Base.merge(a::RuntimeInputState, b::RuntimeInputState) = RuntimeInputState((a.specs..., b.specs...))

"""
Return the runtime input declaration bundle attached to `la`.

Runtime input declarations may be stored either as explicit `RuntimeInputs`
options or as `RuntimeInputState` process states. The latter is used by the DSL
so inputs can participate in routing through the registry.
"""
function runtimeinputs(la::LA) where {LA<:AbstractLoopAlgorithm}
    opts = getoptions(la)
    inputs = filter_by_type(RuntimeInputs, opts)
    if !isempty(inputs)
        specs = mapreduce(x -> x.specs, (a, b) -> (a..., b...), inputs; init = ())
        return RuntimeInputs(specs)
    end

    specs = ()
    for state in getstates(la)
        input_state = state isa IdentifiableAlgo ? getalgo(state) : state
        input_state isa RuntimeInputState && (specs = (specs..., input_state.specs...))
    end
    return RuntimeInputs(specs)
end

@inline _runtime_input_name(::RuntimeInput{Name}) where {Name} = Name
@inline _runtime_input_type(::RuntimeInput{Name, T}) where {Name, T} = T
@inline _runtime_input_required(::RuntimeInput{Name, T, Required}) where {Name, T, Required} = Required

"""
Build default keyword values for optional runtime inputs.

Required inputs are intentionally omitted here so validation can report a
missing input instead of silently supplying `nothing`.
"""
function _runtime_input_defaults(specs::Tuple)
    pairs = Pair{Symbol, Any}[] 
    for spec in specs
        _runtime_input_required(spec) || push!(pairs, _runtime_input_name(spec) => spec.default)
    end
    return (; pairs...)
end

"""
Validate one run's keyword arguments against `la`'s runtime input declarations.

This rejects unknown names, checks required inputs, validates typed inputs with
`isa`, and merges optional defaults into the returned `NamedTuple`.
"""
function _validate_runtime_inputs(la::LA, inputs::I) where {LA<:AbstractLoopAlgorithm, I<:NamedTuple}
    specs = runtimeinputs(la).specs
    if isempty(specs)
        isempty(inputs) || error("Runtime inputs were passed, but this LoopAlgorithm declares no @input values.")
        return inputs
    end

    allowed = Tuple(_runtime_input_name(spec) for spec in specs)
    for name in keys(inputs)
        name in allowed || error("Unknown runtime input `$name`. Declared inputs are $(allowed).")
    end

    for spec in specs
        name = _runtime_input_name(spec)
        if haskey(inputs, name)
            T = _runtime_input_type(spec)
            value = getproperty(inputs, name)
            value isa T || error("Runtime input `$name` has type $(typeof(value)), expected `$T`.")
        elseif _runtime_input_required(spec)
            error("Missing required runtime input `$name`.")
        end
    end

    return merge(_runtime_input_defaults(specs), inputs)
end

"""
Merge runtime inputs into a transient context field for one loop execution.

The empty `NamedTuple` method preserves the original context object and type.
Non-empty inputs are stored in `ProcessContext._input`, not in persistent
subcontexts, so finished contexts can be stripped back to their original shape.
"""
@inline _merge_runtime_inputs(context, ::NamedTuple{()}) = context
@inline _merge_runtime_inputs(context, inputs::I) where {I<:NamedTuple} =
    ProcessContext(get_subcontexts(context), getregistry(context), getglobals(context), inputs)

@inline _strip_runtime_inputs(context) = context

"""
Remove runtime-only data from a finished context.

This is the single-context fallback used by direct runs or callers that do not
have an original persistent context to restore from. It removes loop handles
from `_runtime`, clears `_input`, and drops the legacy `:_input` subcontext if a
context was created before the runtime/input field split.
"""
function _strip_runtime_inputs(context::C) where {C<:ProcessContext}
    runtime = getglobals(context)
    subcontexts = get_subcontexts(context)
    if !haskey(runtime, :process) &&
        !haskey(runtime, :lifetime) &&
        !haskey(subcontexts, :_input) &&
        isempty(getruntimeinput(context))
        return context
    end

    stripped_runtime = haskey(runtime, :process) ? deletekeys(runtime, :process) : runtime
    stripped_runtime = haskey(stripped_runtime, :lifetime) ? deletekeys(stripped_runtime, :lifetime) : stripped_runtime
    persistent_subcontexts = haskey(subcontexts, :_input) ? deletekeys(subcontexts, :_input) : subcontexts
    return ProcessContext(persistent_subcontexts, getregistry(context), stripped_runtime, (;))
end

"""
    _strip_runtime_inputs(runtime_context, stored_context)

Keep the updated persistent subcontexts from `runtime_context`, but restore the
runtime and input fields from `stored_context`.
"""
@inline _strip_runtime_inputs(runtime_context, stored_context) = _strip_runtime_inputs(runtime_context)

@inline function _strip_runtime_inputs(runtime_context::C, stored_context::S) where {C<:ProcessContext, S<:ProcessContext}
    subcontexts = get_subcontexts(runtime_context)
    if !haskey(subcontexts, :_input) &&
        getglobals(runtime_context) == getglobals(stored_context) &&
        getruntimeinput(runtime_context) == getruntimeinput(stored_context)
        return runtime_context
    end

    persistent_subcontexts = haskey(subcontexts, :_input) ? deletekeys(subcontexts, :_input) : subcontexts
    # Previous implementation always rebuilt the context:
    # return ProcessContext(
    #     persistent_subcontexts,
    #     getregistry(runtime_context),
    #     getglobals(stored_context),
    #     getruntimeinput(stored_context),
    # )
    return ProcessContext(
        persistent_subcontexts,
        getregistry(runtime_context),
        getglobals(stored_context),
        getruntimeinput(stored_context),
    )
end

# Lifecycle accessors keep `LoopAlgorithm`, plain plan nodes, and wrappers on a
# shared path. Plain plans report no stored lifecycle data.
@inline getstoredinits(la::LA) where {LA<:AbstractLoopAlgorithm} = hasfield(LA, :inits) ? getfield(la, :inits) : ()
@inline getstoredoverrides(la::LA) where {LA<:AbstractLoopAlgorithm} = hasfield(LA, :overrides) ? getfield(la, :overrides) : ()
@inline getstoredcontext(la::LA) where {LA<:AbstractLoopAlgorithm} = hasfield(LA, :context) ? getfield(la, :context) : nothing
@inline context(la::LA) where {LA<:AbstractLoopAlgorithm} = getstoredcontext(la)
@inline _without_lifecycle(la::LA) where {LA<:AbstractLoopAlgorithm} = _with_lifecycle(la, nothing, (), ())

# Merge newly passed `Init`/`Override` specs over previously stored specs by
# target. This lets `init(initialized, Init(Target; ...))` replay the old
# lifecycle while replacing only the named target.
@inline _merge_specs_by_target(base::B, ::Tuple{}) where {B<:Tuple} = base
@inline _merge_specs_by_target(::Tuple{}, updates::Tuple{}) = ()
@inline _merge_specs_by_target(::Tuple{}, updates::Tuple{T}) where {T} = updates

@inline _resolve_lifecycle_specs(reg::R) where {R<:NameSpaceRegistry} = ()

"""
Merge two tuples of resolved lifecycle specs by target key.

When a target appears in both tuples, its named values are merged and the newer
values win. The result remains a tuple so callers can specialize on the concrete
set of lifecycle specs.
"""
function _merge_specs_by_target(base::B, updates::U) where {B<:Tuple, U<:Tuple}
    merged = collect(Any, base)
    for update in updates
        target = get_target_name(update)
        idx = findfirst(spec -> get_target_name(spec) == target, merged)
        if isnothing(idx)
            push!(merged, update)
        else
            old = merged[idx]
            vars = merge(get_vars(old), get_vars(update))
            merged[idx] = update isa Input ? Input{target,typeof(vars),typeof(get_ref(update))}(vars, get_ref(update)) : Override{target,typeof(vars),typeof(get_ref(update))}(vars, get_ref(update))
        end
    end
    return Tuple(merged)
end

"""
Split resolved lifecycle specs into initialization and override phases.

`Init` values must be available during `init(...)`; `Override` values are
applied afterwards to force persistent context fields.
"""
function _split_init_override(specs)
    inits = filter_by_type(Input, specs)
    overrides = filter_by_type(Override, specs)
    return inits, overrides
end

"""
Resolve `Init` and `Override` targets through a concrete registry.

The returned specs carry symbol targets, so later context merging does not need
to perform matcher lookup again.
"""
@inline function _resolve_lifecycle_specs(reg::R, specs) where {R<:NameSpaceRegistry}
    resolved = ()
    for spec in specs
        if spec isa Union{Init, Override}
            resolved = (resolved..., resolve(reg, spec)...)
        else
            error("Expected Init or Override, got $(spec).")
        end
    end
    return resolved
end

@inline _resolve_lifecycle_specs(la::LA, specs) where {LA<:AbstractLoopAlgorithm} =
    _resolve_lifecycle_specs(getregistry(resolve(la)), specs)

"""
Build the persistent context for an initialized loop algorithm.

The initialization context includes `algo` and `lifetime` in `_runtime` because
init methods such as `processsizehint!` need them. Runtime `process` and
per-run `_input` values are intentionally absent here.
"""
@inline function _init_context_for(la::LA, inits::I, overrides::O, lifetime::LT) where {LA<:AbstractLoopAlgorithm, I<:Tuple, O<:Tuple, LT}
    empty_context = _build_process_context(
        getregistry(la);
        globals = (; algo = la, lifetime),
    )
    input_context = isempty(inits) ? empty_context : merge_into_subcontexts(empty_context, construct_context_merge_tuples(inits))
    prepared = init(la, input_context)
    return isempty(overrides) ? prepared : merge_into_subcontexts(prepared, construct_context_merge_tuples(overrides))
end

"""
    init(la::LoopAlgorithm, Init(...), Override(...))

Fully initialize `la`, replaying stored init/override specs and letting passed
specs override stored specs per target.
"""
@inline function init(la::LA, specs::Union{Init, Override}...; lifetime = Indefinite()) where {LA<:AbstractLoopAlgorithm}
    resolved = _without_lifecycle(resolve(la))
    new_specs = _resolve_lifecycle_specs(getregistry(resolved), specs)
    new_inits, new_overrides = _split_init_override(new_specs)
    inits = _merge_specs_by_target(getstoredinits(la), new_inits)
    overrides = _merge_specs_by_target(getstoredoverrides(la), new_overrides)
    context = _init_context_for(resolved, inits, overrides, lifetime)
    return _with_lifecycle(resolved, context, inits, overrides)
end

"""
    partialinit(la, Init(...), Override(...))

Re-initialize only the targets named by the passed specs.
"""
function partialinit(la::LA, specs::Union{Init, Override}...) where {LA<:AbstractLoopAlgorithm}
    context = getstoredcontext(la)
    isnothing(context) && error("partialinit requires an initialized LoopAlgorithm.")
    resolved_specs = _resolve_lifecycle_specs(la, specs)
    inits, overrides = _split_init_override(resolved_specs)
    new_context = context
    for input in inits
        key = get_target_name(input)
        ov = filter(o -> get_target_name(o) == key, overrides)
        new_context = initcontext(new_context, key; inputs = get_vars(input), overrides = isempty(ov) ? (;) : get_vars(first(ov)))
    end
    return _with_lifecycle(la, new_context, _merge_specs_by_target(getstoredinits(la), inits), _merge_specs_by_target(getstoredoverrides(la), overrides))
end

"""
    run(la::LoopAlgorithm; kwargs...)

Run an initialized loop algorithm with per-run runtime inputs. The inputs are
validated, merged into the transient `ProcessContext._input` field for the loop
call, and removed before the returned loop algorithm stores its next persistent
context.
"""
function Base.run(la::LA; repeats = 1, lifetime = nothing, kwargs...) where {LA<:AbstractLoopAlgorithm}
    initialized = isnothing(getstoredcontext(la)) ? init(la) : la
    stored_context = getstoredcontext(initialized)
    lt = isnothing(lifetime) ? normalize_process_lifetime(initialized, repeats) : normalize_process_lifetime(initialized, lifetime)
    inputs = _validate_runtime_inputs(initialized, (; kwargs...))
    process = LoopRunProcess(lt)
    result = loop(process, initialized, stored_context, lt, inputs)
    runtime_context = result isa AbstractContext ? result : stored_context
    persistent_context = _strip_runtime_inputs(runtime_context, stored_context)
    return _with_lifecycle(initialized, persistent_context, getstoredinits(initialized), getstoredoverrides(initialized))
end
