@inline normalize_process_algo(func::F) where {F<:LoopAlgorithm} = func
@inline normalize_process_algo(func::Type{F}) where {F<:LoopAlgorithm} = func
@inline normalize_process_algo(func::F) where {F} = SimpleAlgo(func)

@inline normalize_process_lifetime(func, lifetime::Integer) = Repeat(lifetime)
@inline function normalize_process_lifetime(@nospecialize(func), ::Nothing)
    if func isa Routine || func isa Type{<:Routine}
        return Repeat(1)
    else
        return Indefinite()
    end
end
@inline normalize_process_lifetime(func, lifetime::LT) where {LT<:Lifetime} = lifetime
normalize_process_lifetime(func, lifetime) =
    error("Unsupported process lifetime `$lifetime` for `$func`.")

@inline instantiate_process_algo(func::F) where {F<:LoopAlgorithm} = func
@inline instantiate_process_algo(func::Type{F}) where {F<:LoopAlgorithm} = func()

@inline resolve_process_inputs_overrides(func::F) where {F<:LoopAlgorithm} = (), ()

@inline function resolve_process_inputs_overrides(
    func::F,
    inputs_overrides::Vararg{Union{Input, Override},N},
) where {F<:LoopAlgorithm,N}
    isresolved(func) || throw(ArgumentError("`resolve_process_inputs_overrides` requires a resolved loop algorithm when inputs or overrides are present. Call `resolve` before resolving inputs."))
    reg = getregistry(func)

    inputs = @inline filter_by_type(Input, inputs_overrides)
    overrides = @inline filter_by_type(Override, inputs_overrides)

    named_inputs = resolve(reg, inputs...)
    named_overrides = resolve(reg, overrides...)

    return named_inputs, named_overrides
end

function resolve_process_inputs_overrides(func::F, inputs_overrides::Vararg{Any,N}) where {F<:LoopAlgorithm,N}
    isempty(inputs_overrides) && return (), ()

    isresolved(func) || throw(ArgumentError("`resolve_process_inputs_overrides` requires a resolved loop algorithm when inputs or overrides are present. Call `resolve` before resolving inputs."))
    reg = getregistry(func)

    inputs = @inline filter_by_type(Input, inputs_overrides)
    overrides = @inline filter_by_type(Override, inputs_overrides)

    named_inputs = resolve(reg, inputs...)
    named_overrides = resolve(reg, overrides...)

    return named_inputs, named_overrides
end

function resolve_process_inputs_overrides(func::Type{F}, inputs_overrides::Vararg{Any,N}) where {F<:LoopAlgorithm,N}
    isempty(inputs_overrides) && return (), ()
    throw(ArgumentError("`resolve_process_inputs_overrides` requires an instantiated, resolved loop algorithm when inputs or overrides are present."))
end

function resolve_process_inputs_overrides(func::F, inputs_overrides::Vararg{Any,N}) where {F,N}
    isempty(inputs_overrides) && return (), ()
    throw(ArgumentError("`resolve_process_inputs_overrides` requires a resolved loop algorithm when inputs or overrides are present."))
end
