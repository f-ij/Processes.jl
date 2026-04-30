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
Apply queued, externally supplied context updates every `check_every` steps.

Use `interact!(context, input)` to enqueue values programmatically, or
`view(context, Var(...))` to obtain a ref-like `InteractiveVar`.
"""
struct ContextInjector <: ProcessAlgorithm
    check_every::Int

    function ContextInjector(check_every::Integer)
        check_every > 0 || error("ContextInjector check_every must be positive, got $check_every")
        new(Int(check_every))
    end
end

ContextInjector(; check_every::Integer = 1) = ContextInjector(check_every)

# Compatibility name for the old scratch widget and for user-facing terminology.
const Injector = ContextInjector

function Processes.init(::ContextInjector, context)
    return (; buffer = Any[], buffer_lock = ReentrantLock(), step_counter = 0)
end

@inline Processes.step!(sa::IdentifiableAlgo{ContextInjector}, context::C) where {C<:ProcessContext} =
    Processes.step!(sa, context, Stable())

@inline Processes.step!(sa::IdentifiableAlgo{ContextInjector}, context::C, ::Stable) where {C<:ProcessContext} =
    _step_context_injector(sa, context)

# Buffered updates are converted before they enter the queue, so the unstable
# pass can use the same exact-type-preserving merge path as the stable pass.
@inline Processes.step!(sa::IdentifiableAlgo{ContextInjector}, context::C, ::Unstable) where {C<:ProcessContext} =
    _step_context_injector(sa, context)

@inline function _step_context_injector(sa::IdentifiableAlgo{ContextInjector}, context::C) where {C<:ProcessContext}
    injector = getalgo(sa)
    key = getkey(sa)
    state = getproperty(context, key)
    counter = getproperty(state, :step_counter) + 1

    context = @inline merge_into_subcontext(context, key, (; step_counter = counter))
    if counter % injector.check_every != 0
        return context
    end

    updates = _take_buffered_updates!(getproperty(state, :buffer), getproperty(state, :buffer_lock))
    before = typeof(context)
    for update in updates
        context = @inline _apply_buffered_update(context, update)
    end
    @assert typeof(context) == before "ContextInjector changed the context type while applying buffered updates.\n$(sprint(show, ContextTypeDiff(before, typeof(context))))"
    return context
end

function _take_buffered_updates!(buffer::Vector, buffer_lock)
    lock(buffer_lock)
    try
        updates = copy(buffer)
        empty!(buffer)
        return updates
    finally
        unlock(buffer_lock)
    end
end

@inline function _buffer_target_exists(context::ProcessContext, ::BufferedContextUpdate{Subcontext, Varname}) where {Subcontext, Varname}
    if !(Subcontext in get_subcontexts_fieldnames(typeof(context)))
        @warn "Skipping interactive update for $(Subcontext).$(Varname) because the target subcontext is not present in the current context."
        return false
    end

    subctx = getproperty(context, Subcontext)
    if !haskey(getdata(subctx), Varname)
        @warn "Skipping interactive update for $(Subcontext).$(Varname) because the target variable is not present in the current context."
        return false
    end

    return true
end

@inline function _apply_buffered_update(context::ProcessContext, update::BufferedContextUpdate{Subcontext, Varname}) where {Subcontext, Varname}
    _buffer_target_exists(context, update) || return context
    value = _update_value(update)
    return @inline merge_into_subcontexts(context, NamedTuple{(Subcontext,)}((NamedTuple{(Varname,)}((value,)),)))
end

function _context_injectors(context::ProcessContext)
    algos = all_algos(getregistry(context))
    return tuple((algo for algo in algos if getalgo(algo) isa ContextInjector)...)
end

@inline isinteractive(context::ProcessContext) = !isempty(_context_injectors(context))
@inline isinteractive(process::AbstractProcess) = isinteractive(getfield(process, :context))

function _resolve_scoped_target(context::ProcessContext, target)
    reg = getregistry(context)
    if target isa Symbol
        return reg[target]
    elseif target isa Type
        matches = tuple((algo for algo in all_algos(reg) if getalgo(algo) isa target)...)
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
        injectors = _context_injectors(context)
        if isempty(injectors)
            error("Cannot create an interactive variable view because this context has no ContextInjector in its registry.")
        elseif length(injectors) > 1
            keys = getkey.(injectors)
            error("Context has multiple ContextInjectors $(keys). Pass `injector = :name` to choose one.")
        end
        return only(injectors)
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

function _resolved_updates(context::ProcessContext, input::NamedInput)
    target = get_target_name(input)
    # get_vars(input) is a NamedTuple, so iterate its pairs directly instead of
    # calling map on the Pairs wrapper.
    return tuple((_resolved_update_from_view(context, target, first(pair), last(pair)) for pair in pairs(get_vars(input)))...)
end

function _resolved_updates(context::ProcessContext, input::NamedOverride)
    target = get_target_name(input)
    return tuple((_resolved_update_from_view(context, target, first(pair), last(pair)) for pair in pairs(get_vars(input)))...)
end

function _resolved_updates(context::ProcessContext, input::Union{Input, Override})
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
    # Injector state is stored in a SubContext, so inspect its data payload.
    haskey(getdata(state), :buffer) && haskey(getdata(state), :buffer_lock) || error("Subcontext $(injector_key) does not look like a ContextInjector state.")
    return getproperty(state, :buffer), getproperty(state, :buffer_lock)
end

function _push_buffered_update!(context::ProcessContext, injector_key::Symbol, update::BufferedContextUpdate)
    buffer, buffer_lock = _buffer_storage(context, injector_key)
    lock(buffer_lock)
    try
        push!(buffer, update)
    finally
        unlock(buffer_lock)
    end
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
    interact!(getfield(process, :context), input; injector)

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