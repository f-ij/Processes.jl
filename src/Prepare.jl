"""
So that warnings are only printed once per type per session
"""
const warnset = Set{Any}()
"""
Fallback prepare
"""
function prepare(t::T, c::Any) where T
    # @show T
    # @show c
    if !in(T, warnset)
        @warn "No prepare function defined for var $t with type $T, returning empty context"
        push!(warnset, T)
    end
    (;)
end


"""
previously prepare_args
"""
function prepare_context(algo::F, c::ProcessContext, overrides_and_inputs::Union{NamedInput, NamedOverride}...; lifetime = Indefinite()) where {F}
    inputs = filter(x -> x isa NamedInput, overrides_and_inputs)
    overrides = filter(x -> x isa NamedOverride, overrides_and_inputs)
    
    input_context = merge(c, inputs...; to_all = (;algo, lifetime))

    @DebugMode "Preparing context for algo $(algo) with input context $input_context"
    @DebugMode "Overrides are $overrides"

    prepared_context = prepare(algo, input_context)

    overridden_context = merge(prepared_context, overrides...)

    return overridden_context
end

@inline function init_context(td::TaskData)
    func = getfunc(td)
    ProcessContext(func, globals = (;lifetime = getlifetime(td), algo = func))
end

"""
Prepare context from TaskData
"""
function prepare_context(td::TD) where {TD<:TaskData}
    lifetime = getlifetime(td)
    overrides = getoverrides(td)
    inputs = getinputs(td)
    empty_c = getcontext(td)
    
    return prepare_context(td.func, empty_c, overrides..., inputs...; lifetime = lifetime)
end

@inline function init_context(p::AbstractProcess)
    td = taskdata(p)
    c = init_context(td)
    @DebugMode "Prepared context is $c"
    return c
end

function prepare_context(process::AbstractProcess, c::ProcessContext) 
    @DebugMode "Creating task for process $(process.id)"

    td = taskdata(process)
    return prepare_context(td, c)
end


function makecontext(p::AbstractProcess)
    c = init_context(p)
    prepare_context(p, c)
end
function makecontext!(p::AbstractProcess)
    c = makecontext(p)
    @show c
    context(p,c)
end

function cleanup(p::AbstractProcess)
    lifetime = tasklifetime(p)
    returncontext = cleanup(getfunc(p), (;process = p, lifetime, getcontext(p)...))
    return deletekeys(returncontext, :process, :lifetime)
end

export preparedata!, cleanup
