export initcontext
"""
So that warnings are only printed once per type per session
"""
const warnset = Set{Any}()
"""
Fallback init
"""
function init(t::T, c::Any) where T
    if !in(T, warnset)
        @warn "No init function defined for var $t with type $T, returning empty context"
        push!(warnset, T)
    end
    (;)
end

"""
Make a context from an algo and empty context
"""
function initcontext(algo::F, c::ProcessContext; lifetime = Indefinite()) where {F <: AbstractLoopAlgorithm}
    input_context = _merge_into_globals(c, (;algo, lifetime))

    @DebugMode "Preparing context for algo $(algo) with input context $input_context"
    @DebugMode "Overrides are ()"

    prepared_context = init(algo, input_context)
    @DebugMode "Prepared in initcontext context is $prepared_context"

    return @inline without_runtime_subcontexts(prepared_context)
end

function initcontext(algo::F, c::ProcessContext = ProcessContext(algo), overrides_and_inputs::Union{Input, Override}...; lifetime = Indefinite()) where {F <: AbstractLoopAlgorithm}
    input_context = _merge_into_globals(c, (;algo, lifetime))
    resolved = _resolve_lifecycle_specs(getregistry(input_context), overrides_and_inputs)
    inputs, overrides = _split_init_override(resolved)
    input_context = merge_resolved_inputs(input_context, inputs)

    @DebugMode "Preparing context for algo $(algo) with input context $input_context"
    @DebugMode "Overrides are $overrides"

    prepared_context = init(algo, input_context)
    @DebugMode "Prepared in initcontext context is $prepared_context"

    overridden_context = merge_resolved_inputs(prepared_context, overrides)

    return @inline without_runtime_subcontexts(overridden_context)
end

function makecontext(p::AbstractProcess, inputs_overrides...; lifetime=nothing)
    lt = isnothing(lifetime) ? Processes.lifetime(p) : lifetime
    context(init(getalgo(p), inputs_overrides...; lifetime = lt))
end
"""Build a fresh context for a process by replaying lifecycle init on its LA."""
function makecontext!(p::AbstractProcess, inputs_overrides...; lifetime=nothing)
    c = makecontext(p, inputs_overrides...; lifetime)
    context(p,c)
end

function cleanup(p::AbstractProcess)
    lifetime = tasklifetime(p)
    returncontext = cleanup(getalgo(p), (;process = p, lifetime, getcontext(p)...))
    return deletekeys(returncontext, :process, :lifetime)
end

export preparedata!, cleanup
