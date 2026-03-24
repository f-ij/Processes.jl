"""
So that warnings are only printed once per type per session
"""
const warnset = Set{Any}()
"""
Fallback init
"""
function init(t::T, c::Any) where T
    # @show T
    # @show c
    if !in(T, warnset)
        @warn "No init function defined for var $t with type $T, returning empty context"
        push!(warnset, T)
    end
    (;)
end

"""
Make a context from an algo
"""
function initcontext(algo::F, c::ProcessContext = ProcessContext(algo), overrides_and_inputs::Union{NamedInput, NamedOverride}...; lifetime = Indefinite()) where {F}
    inputs = filter(x -> x isa NamedInput, overrides_and_inputs)
    overrides = filter(x -> x isa NamedOverride, overrides_and_inputs)
    
    input_context = merge(c, inputs...; to_all = (;algo, lifetime))

    @DebugMode "Preparing context for algo $(algo) with input context $input_context"
    @DebugMode "Overrides are $overrides"

    prepared_context = init(algo, input_context)
    @DebugMode "Prepared in initcontext context is $prepared_context"

    overridden_context = merge(prepared_context, overrides...)

    return overridden_context
end

@inline function initcontext(p::AbstractProcess)
    td = taskdata(p)
    c = initcontext(td)
    @DebugMode "Prepared context is $c"
    return c
end

"""
Init context from TaskData
"""
function initcontext(td::TD) where {TD<:TaskData}
    lifetime = getlifetime(td)
    overrides = getoverrides(td)
    inputs = getinputs(td)
    empty_c = getcontext(td)
    
    return initcontext(td.func, empty_c, overrides..., inputs...; lifetime = lifetime)
end

function makecontext(p::AbstractProcess)
    initcontext(taskdata(p))
end

function makecontext!(p::AbstractProcess)
    c = makecontext(p)
    context(p,c)
end

function cleanup(p::AbstractProcess)
    lifetime = tasklifetime(p)
    returncontext = cleanup(getalgo(p), (;process = p, lifetime, getcontext(p)...))
    return deletekeys(returncontext, :process, :lifetime)
end

export preparedata!, cleanup
