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
function initcontext(algo::F, c::ProcessContext = ProcessContext(algo), overrides_and_inputs::Union{NamedInput, NamedOverride}...; lifetime = Indefinite()) where {F <: LoopAlgorithm}
    inputs = filter(x -> x isa NamedInput, overrides_and_inputs)
    overrides = filter(x -> x isa NamedOverride, overrides_and_inputs)
    
    input_context = merge_into_globals(c, (;algo, lifetime))
    input_context = merge(input_context, inputs...)

    @DebugMode "Preparing context for algo $(algo) with input context $input_context"
    @DebugMode "Overrides are $overrides"

    prepared_context = init(algo, input_context)
    @DebugMode "Prepared in initcontext context is $prepared_context"

    overridden_context = merge(prepared_context, overrides...)

    return overridden_context
end

"""
Init context from TaskData
"""
function initcontext(td::TD, new_inputs_overrides::Union{NamedInput, NamedOverride}...; lifetime=nothing) where {TD<:TaskData}
    lifetime = getlifetime(td)
    overrides = getoverrides(td)
    inputs = getinputs(td)
    empty_c = getcontext(td)

    if isempty(new_inputs_overrides)
        return initcontext(getalgo(td), empty_c, overrides..., inputs...; lifetime = lifetime)
    else # Override inputs and overrides with new ones 
        # TODO: Do we set the new inputs and overrides to the TaskData? Or do we just use them for this context? 
        # For now, just use them for this context
        return initcontext(getalgo(td), empty_c, new_inputs_overrides...; lifetime = lifetime)
    end

end

function makecontext(p::AbstractProcess, inputs_overrides...; lifetime=nothing)
    initcontext(taskdata(p), inputs_overrides...; lifetime=lifetime)
end
"""
From a process and its taskdata, make a context and set it to the process
"""
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
