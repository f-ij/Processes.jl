export RuntimeInput, RuntimeInputState, RuntimeInputs, partialinit

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

struct RuntimeInput{Name, T, Required, Default}
    default::Default
end

RuntimeInput(name::Symbol, ::Type{T}; required::Bool = true, default = nothing) where {T} =
    RuntimeInput{name, T, required, typeof(default)}(default)

struct RuntimeInputs{Specs} <: AbstractOption
    specs::Specs
end

RuntimeInputs(specs::Tuple = ()) = RuntimeInputs{typeof(specs)}(specs)

struct RuntimeInputState{Specs} <: ProcessState
    specs::Specs
end

RuntimeInputState(specs::Tuple = ()) = RuntimeInputState{typeof(specs)}(specs)

Processes.registry_allowmerge(::Union{RuntimeInputState, Type{<:RuntimeInputState}}) = true
match_by(ia::Union{IdentifiableAlgo{<:RuntimeInputState}, Type{<:IdentifiableAlgo{<:RuntimeInputState}}}) = ValMatcher(getkey(ia))

Processes.init(::RuntimeInputState, context) = (;)

Base.merge(a::RuntimeInputState, b::RuntimeInputState) = RuntimeInputState((a.specs..., b.specs...))

function runtimeinputs(la::LA) where {LA<:LoopAlgorithm}
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

function _runtime_input_defaults(specs::Tuple)
    pairs = Pair{Symbol, Any}[]
    for spec in specs
        _runtime_input_required(spec) || push!(pairs, _runtime_input_name(spec) => spec.default)
    end
    return (; pairs...)
end

function _validate_runtime_inputs(la::LoopAlgorithm, inputs::NamedTuple)
    specs = runtimeinputs(la).specs
    isempty(specs) && (isempty(inputs) || error("Runtime inputs were passed, but this LoopAlgorithm declares no @input values."))

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

@inline _merge_runtime_inputs(context, ::NamedTuple{()}) = context
@inline _merge_runtime_inputs(context, inputs::NamedTuple) =
    merge_into_subcontexts(context, (; _input = inputs))

@inline _strip_runtime_inputs(context) = context

function _strip_runtime_inputs(context::ProcessContext)
    subcontexts = get_subcontexts(context)
    haskey(subcontexts, :_input) || return context
    stripped = deletekeys(subcontexts, :_input)
    return ProcessContext(stripped, getregistry(context))
end

@inline getstoredinits(la::LoopAlgorithm) = hasfield(typeof(la), :inits) ? getfield(la, :inits) : ()
@inline getstoredoverrides(la::LoopAlgorithm) = hasfield(typeof(la), :overrides) ? getfield(la, :overrides) : ()
@inline getstoredcontext(la::LoopAlgorithm) = hasfield(typeof(la), :context) ? getfield(la, :context) : nothing
@inline context(la::LoopAlgorithm) = getstoredcontext(la)
@inline _without_lifecycle(la::LoopAlgorithm) = _with_lifecycle(la, nothing, (), ())

function _merge_specs_by_target(base::Tuple, updates::Tuple)
    merged = collect(Any, base)
    for update in updates
        target = get_target_name(update)
        idx = findfirst(spec -> get_target_name(spec) == target, merged)
        if isnothing(idx)
            push!(merged, update)
        else
            old = merged[idx]
            vars = merge(get_vars(old), get_vars(update))
            merged[idx] = update isa NamedInput ? NamedInput{target}(vars) : NamedOverride{target}(vars)
        end
    end
    return Tuple(merged)
end

function _split_init_override(specs...)
    inits = filter_by_type(NamedInput, specs)
    overrides = filter_by_type(NamedOverride, specs)
    return inits, overrides
end

function _resolve_lifecycle_specs(la::LoopAlgorithm, specs...)
    reg = getregistry(resolve(la))
    resolved = ()
    for spec in specs
        if spec isa Union{Init, Override}
            resolved = (resolved..., resolve(reg, spec)...)
        elseif spec isa Union{NamedInput, NamedOverride}
            resolved = (resolved..., spec)
        else
            error("Expected Init or Override, got $(spec).")
        end
    end
    return resolved
end

function _init_context_for(la::LoopAlgorithm, inits::Tuple, overrides::Tuple, lifetime)
    resolved = _without_lifecycle(resolve(la))
    sharedcontexts, sharedvars = _resolve_options(resolved)
    empty_context = _build_process_context(
        getregistry(resolved),
        sharedcontexts,
        sharedvars;
        globals = (; algo = resolved, lifetime),
    )
    input_context = isempty(inits) ? empty_context : merge_into_subcontexts(empty_context, (; (get_target_name(i) => get_vars(i) for i in inits)...))
    prepared = init(resolved, input_context)
    return isempty(overrides) ? prepared : merge_into_subcontexts(prepared, (; (get_target_name(o) => get_vars(o) for o in overrides)...))
end

"""
    init(la::LoopAlgorithm, Init(...), Override(...))

Fully initialize `la`, replaying stored init/override specs and letting passed
specs override stored specs per target.
"""
function init(la::LA, specs::Union{Init, Override, NamedInput, NamedOverride}...; lifetime = Indefinite()) where {LA<:LoopAlgorithm}
    resolved = _without_lifecycle(resolve(la))
    new_specs = _resolve_lifecycle_specs(resolved, specs...)
    new_inits, new_overrides = _split_init_override(new_specs...)
    inits = _merge_specs_by_target(getstoredinits(la), new_inits)
    overrides = _merge_specs_by_target(getstoredoverrides(la), new_overrides)
    context = _init_context_for(resolved, inits, overrides, lifetime)
    return _with_lifecycle(resolved, context, inits, overrides)
end

"""
    partialinit(la, Init(...), Override(...))

Re-initialize only the targets named by the passed specs.
"""
function partialinit(la::LA, specs::Union{Init, Override, NamedInput, NamedOverride}...) where {LA<:LoopAlgorithm}
    context = getstoredcontext(la)
    isnothing(context) && error("partialinit requires an initialized LoopAlgorithm.")
    resolved_specs = _resolve_lifecycle_specs(la, specs...)
    inits, overrides = _split_init_override(resolved_specs...)
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
validated, merged into a transient `:_input` context for the loop call, and
removed before the returned loop algorithm stores its next persistent context.
"""
function Base.run(la::LA; repeats = 1, lifetime = nothing, kwargs...) where {LA<:LoopAlgorithm}
    initialized = isnothing(getstoredcontext(la)) ? init(la) : la
    lt = isnothing(lifetime) ? normalize_process_lifetime(initialized, repeats) : normalize_process_lifetime(initialized, lifetime)
    inputs = _validate_runtime_inputs(initialized, (; kwargs...))
    process = LoopRunProcess(lt)
    runtime_context = merge_into_globals(getstoredcontext(initialized), (; process, lifetime = lt))
    result = loop(process, initialized, runtime_context, lt, inputs)
    stored = result isa AbstractContext ? result : getstoredcontext(initialized)
    return _with_lifecycle(initialized, _stored_loop_context(stored), getstoredinits(initialized), getstoredoverrides(initialized))
end
