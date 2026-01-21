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

struct Input{T,NT<:NamedTuple}
    target_algo::T
    vars::NT
end
"""
Override an internal prepared arg in the context of a target algorithm
"""
struct Override{T,NT<:NamedTuple}
    target_algo::T
    vars::NT
end

get_target_algo(ov::Union{Override, Input}) = ov.target_algo
get_vars(ov::Union{Override, Input}) = ov.vars

"""
Construct named tuples from overrides and inputs, optionally adding common variables to all
"""
@inline function construct_context_merge_tuples(registry::NameSpaceRegistry, overrides_inputs::Union{Override, Input}...; to_all = (;)) 
    names = map(o -> static_lookup(registry, get_target_algo(o)), overrides_inputs) # Get the names from the registry
    vars = get_vars.(overrides_inputs) # Get the input variables
    if !isempty(to_all) # Add common variables to all named tuples
        for algo in registry # Add to_all to each named tuple
            name = getname(algo)
            vars = (;vars..., name => (;get(vars, name, (;))..., to_all...))
        end
    end
    return NamedTuple{(names...)}(vars)
end

@inline function Base.merge(context::ProcessContext, overrides_or_inputs::Union{Override, Input}...; to_all = (;))
    if isempty(overrides_or_inputs)
        return context
    end
    override_nt = construct_context_merge_tuples(context.registry, overrides_or_inputs...; to_all = to_all)
    merge_into_subcontexts(context.subcontexts, override_nt)
end


"""
previously prepare_args
"""
function prepare_context(algo::F, c::ProcessContext, overrides_and_inputs::Union{Override, Input}...; lifetime = Indefinite()) where {F}
    inputs = filter(x -> x isa Input, overrides_and_inputs)
    overrides = filter(x -> x isa Override, overrides_and_inputs)

    input_context = merge(c, inputs...; to_all = (;algo, lifetime))

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
function prepare_context(td::TD, c::ProcessContext) where {TD<:TaskData}
    lifetime = getlifetime(td)
    overrides = getoverrides(td)
    inputs = getinputargs(td)
    
    return prepare_context(td.func, c, overrides..., inputs...; lifetime = lifetime)
end

@inline function init_context(p::AbstractProcess)
    td = taskdata(p)
    c = init_context(td)
    @static if DEBUG_MODE
        display("Prepared context is $prepared_context")
    end
    return c
end

function prepare_context(process::AbstractProcess, c::ProcessContext) 
    @static if DEBUG_MODE
        println("Creating task for process $(process.id)")
    end

    td = taskdata(process)
    return prepare_context(td, c)
end


function makecontext(p::AbstractProcess)
    c = init_context(p)
    prepared_context = prepare_context(p, c)
end
function makecontext!(p::AbstractProcess)
    c = makecontext(p)
    context(p,c)
end



function cleanup(p::AbstractProcess)
    lifetime = tasklifetime(p)
    returncontext = cleanup(getfunc(p), (;proc = p, lifetime, getcontext(p)...))
    return deletekeys(returncontext, :proc, :lifetime)
end

export preparedata!, cleanup
