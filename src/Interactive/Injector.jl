export ContextInjector, Injector, InteractiveVar, interact!, isinteractive

"""
Buffered update for one concrete context variable.

The target is already resolved to a `(subcontext, variable)` pair before it is
stored, so `ContextInjector` does not perform registry or view lookup while it is
stepping.
"""
struct BufferedContextUpdate{Subcontext, Varname, T}
    value::T
end

BufferedContextUpdate(subcontext::Symbol, varname::Symbol, value) =
    BufferedContextUpdate{subcontext, varname, typeof(value)}(value)

@inline _update_subcontext(::BufferedContextUpdate{Subcontext}) where {Subcontext} = Subcontext
@inline _update_varname(::BufferedContextUpdate{Subcontext, Varname}) where {Subcontext, Varname} = Varname
@inline _update_value(update::BufferedContextUpdate) = getfield(update, :value)

"""
Apply queued, externally supplied context updates when scheduled by the enclosing
loop algorithm.

Use `interact!(context, input)` to enqueue values programmatically, or
`view(context, Var(...))` to obtain a ref-like `InteractiveVar`.
"""
const context_injector_key = :_injector
const context_injector_id = ValMatcher(:ContextInjector)
const context_injector_aliases = VarAliases()

struct ContextInjector <: AbstractIdentifiableAlgo{
    ContextInjector,
    context_injector_id,
    context_injector_aliases,
    Symbol(),
    context_injector_key,
} end

@inline Base.getkey(::Union{ContextInjector, Type{<:ContextInjector}}) = context_injector_key
@inline getalgo(inj::ContextInjector) = inj
@inline getalgos(inj::ContextInjector) = (inj,)
@inline setcontextkey(inj::ContextInjector, ::Symbol) = inj
@inline setid(inj::ContextInjector, newid) = inj
@inline setvaraliases(inj::ContextInjector, newaliases) = inj
@inline match_by(::Union{ContextInjector, Type{<:ContextInjector}}) = context_injector_id
@inline registry_entrytype(::Type{<:ContextInjector}) = ContextInjector
@inline isstaticallyfindable(::ContextInjector) = true

# Compatibility name for the old scratch widget and for user-facing terminology.
const Injector = ContextInjector

@inline _context_injector_state(::ContextInjector) = (; buffer = Any[])

Processes.init(inj::ContextInjector, ::NamedTuple = (;)) = _context_injector_state(inj)

function Processes.init(inj::ContextInjector, context::ProcessContext)
    return replace(context, NamedTuple{(context_injector_key,)}((_context_injector_state(inj),)))
end

@inline Processes.cleanup(::ContextInjector, context::ProcessContext) = context

@inline Processes.step!(inj::ContextInjector, context::C) where {C<:ProcessContext} =
    Processes.step!(inj, context, Stable())

@inline Processes.step!(inj::ContextInjector, context::C, ::Stable) where {C<:ProcessContext} =
    _step_context_injector(inj, context)

# Buffered updates are converted before they enter the queue, so the unstable
# pass can use the same exact-type-preserving merge path as the stable pass.
@inline Processes.step!(inj::ContextInjector, context::C, ::Unstable) where {C<:ProcessContext} =
    _step_context_injector(inj, context)

@inline function _step_context_injector(::ContextInjector, context::C) where {C<:ProcessContext}
    updates = _context_injector_buffer(context)
    isempty(updates) && return context

    @inbounds for i in eachindex(updates)
        context = @inline _apply_buffered_update(context, updates[i])
    end
    empty!(updates)
    return context::C
end

@inline function _context_injector_buffer(context::ProcessContext)
    getfield(getdata(getfield(get_subcontexts(context), context_injector_key)), :buffer)
end

@inline context_injector_buffer_isempty(context) = false
@inline context_injector_buffer_isempty(context::ProcessContext) = isempty(_context_injector_buffer(context))

@inline function _apply_buffered_update(context::C, update::BufferedContextUpdate{Subcontext, Varname}) where {C<:ProcessContext, Subcontext, Varname}
    value = _update_value(update)
    return (@inline merge_into_subcontexts(context, NamedTuple{(Subcontext,)}((NamedTuple{(Varname,)}((value,)),))))::C
end

function _context_injectors(context::ProcessContext)
    reg = getregistry(context)
    injector = haskey(reg, context_injector_key) ? reg[context_injector_key] : nothing
    isnothing(injector) ? () : (injector,)
end

@inline isinteractive(context::ProcessContext) = !isempty(_context_injectors(context))
@inline isinteractive(process::AbstractProcess) = isinteractive(context(process))

function _resolve_scoped_target(context::ProcessContext, target)
    reg = getregistry(context)
    if target isa Symbol
        return reg[target]
    elseif target isa Type
        matches = findall(target, reg)
        if isempty(matches)
            error("No algorithm matching $(target) was found in the registry.")
        elseif length(matches) > 1
            error("Context has multiple algorithms matching $(target): $(getkey.(matches)). Pass a specific key or algorithm instance.")
        end
        return only(matches)
    end
    return reg[target]
end

function _resolve_injector(context::ProcessContext, injector = nothing)
    reg = getregistry(context)
    if isnothing(injector)
        resolved = haskey(reg, context_injector_key) ? reg[context_injector_key] : nothing
        isnothing(resolved) && error("Cannot create an interactive variable view because this context has no ContextInjector in its registry.")
        return resolved
    elseif injector isa Symbol
        resolved = reg[injector]
    else
        resolved = reg[injector]
    end
    getalgo(resolved) isa ContextInjector || error("Requested injector $(injector) resolved to $(resolved), not a ContextInjector.")
    return resolved
end

@inline function _resolve_target_key(context::ProcessContext, target)
    if target isa Symbol
        isasubcontext(context, target) || error("Target subcontext $(target) not found in context.")
        return target
    end
    scoped = _resolve_scoped_target(context, target)
    return getkey(scoped)
end

function _convert_for_context_variable(context::ProcessContext, subcontext::Symbol, varname::Symbol, value)
    # Resolve against the concrete context layout instead of the Val-based helper,
    # which is intended for compile-time keys.
    subcontext in get_subcontexts_fieldnames(typeof(context)) || error("Target subcontext $(subcontext) not found in context.")
    subctx = getproperty(context, subcontext)
    haskey(getdata(subctx), varname) || error("Target variable $(subcontext).$(varname) not found. Interactive updates can only modify existing variables.")
    current = getproperty(subctx, varname)
    target_type = typeof(current)
    try
        return convert(target_type, value)
    catch err
        error("Cannot buffer interactive update for $(subcontext).$(varname): value $(repr(value)) of type $(typeof(value)) is not convertible to existing type $(target_type). Original error: $(err)")
    end
end

function _resolved_update(context::ProcessContext, subcontext::Symbol, varname::Symbol, value)
    typed = _convert_for_context_variable(context, subcontext, varname, value)
    return BufferedContextUpdate(subcontext, varname, typed)
end

function _resolved_target_from_view(context::ProcessContext, target, varname::Symbol)
    scoped = _resolve_scoped_target(context, target)
    scv = view(context, scoped)
    subcontext_varname = algo_to_subcontext_names(scv, varname)
    locations = get_all_locations(scv)
    haskey(locations, subcontext_varname) || error("Variable $(varname) is not available in view $(getkey(scoped)). Available variables are $(keys(locations)).")

    location = getproperty(locations, subcontext_varname)
    location isa VarLocation{:injected} && error("Cannot interactively update injected variable $(varname); it is not stored in the context.")
    target_subcontext = get_subcontextname(location)
    target_varname = get_originalname(location)
    target_varname isa Tuple && error("Cannot interactively update $(varname) because it maps to multiple context variables $(target_varname).")
    return target_subcontext, target_varname
end

function _resolved_update_from_view(context::ProcessContext, target, varname::Symbol, value)
    target_subcontext, target_varname = _resolved_target_from_view(context, target, varname)
    return _resolved_update(context, target_subcontext, target_varname, value)
end

function _resolved_updates(context::ProcessContext, input::Union{Input, Override})
    if _is_resolved_input(input)
        target = get_target_name(input)
        return tuple((_resolved_update_from_view(context, target, first(pair), last(pair)) for pair in pairs(get_vars(input)))...)
    end

    resolved = resolve(getregistry(context), input)
    return Iterators.flatten(_resolved_updates(context, named) for named in resolved)
end

function _resolved_updates(context::ProcessContext, input::Pair{<:Var, <:Any})
    var, value = first(input), last(input)
    return (_resolved_update(context, var, value),)
end

function _resolved_update(context::ProcessContext, ::Var{Entity, Varname}, value) where {Entity, Varname}
    Entity == :globals && error("Interactive Var updates currently target subcontexts, not globals.")
    if Entity isa Symbol
        return _resolved_update(context, Entity, Varname, value)
    else
        return _resolved_update_from_view(context, Entity, Varname, value)
    end
end

function _resolved_target(context::ProcessContext, ::Var{Entity, Varname}) where {Entity, Varname}
    Entity == :globals && error("Interactive Var views currently target subcontexts, not globals.")
    if Entity isa Symbol
        _convert_for_context_variable(context, Entity, Varname, getproperty(getproperty(context, Entity), Varname))
        return Entity, Varname
    else
        return _resolved_target_from_view(context, Entity, Varname)
    end
end

function _buffer_storage(context::ProcessContext, injector_key::Symbol)
    state = getproperty(context, injector_key)
    return getproperty(state, :buffer)
end

function _push_buffered_update!(context::ProcessContext, injector_key::Symbol, update::BufferedContextUpdate)
    push!(_buffer_storage(context, injector_key), update)
    return update
end

"""
    interact!(context, input; injector = nothing)

Resolve `input`, convert each value to the existing context variable type, and
append the update to a `ContextInjector` buffer.
"""
function interact!(context::ProcessContext, input; injector = nothing)
    scoped_injector = _resolve_injector(context, injector)
    injector_key = getkey(scoped_injector)
    for update in _resolved_updates(context, input)
        _push_buffered_update!(context, injector_key, update)
    end
    return context
end

interact!(process::AbstractProcess, input; injector = nothing) =
    interact!(context(process), input; injector)

"""
Ref-like interactive view of one context variable.

`ref[]` reads the current value and `ref[] = value` enqueues an update in the
associated `ContextInjector`.
"""
struct InteractiveVar{InjectorKey, Subcontext, Varname, C}
    context::C
end

@inline _interactive_injector_key(::InteractiveVar{InjectorKey}) where {InjectorKey} = InjectorKey
@inline _interactive_subcontext(::InteractiveVar{InjectorKey, Subcontext}) where {InjectorKey, Subcontext} = Subcontext
@inline _interactive_varname(::InteractiveVar{InjectorKey, Subcontext, Varname}) where {InjectorKey, Subcontext, Varname} = Varname

function InteractiveVar(context::ProcessContext, var::Var; injector = nothing)
    scoped_injector = _resolve_injector(context, injector)
    subcontext, varname = _resolved_target(context, var)
    return InteractiveVar{getkey(scoped_injector), subcontext, varname, typeof(context)}(context)
end

function Base.view(context::ProcessContext, var::Var; injector = nothing)
    return InteractiveVar(context, var; injector)
end

function Base.getindex(ref::InteractiveVar)
    context = getfield(ref, :context)
    return getproperty(getproperty(context, _interactive_subcontext(ref)), _interactive_varname(ref))
end

function Base.setindex!(ref::InteractiveVar, value)
    context = getfield(ref, :context)
    update = _resolved_update(context, _interactive_subcontext(ref), _interactive_varname(ref), value)
    _push_buffered_update!(context, _interactive_injector_key(ref), update)
    return value
end
