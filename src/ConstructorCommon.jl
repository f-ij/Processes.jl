@inline function normalize_process_algo(func)
    if func isa LoopAlgorithm || func isa Type{<:LoopAlgorithm}
        return func
    else
        return SimpleAlgo(func)
    end
end

@inline function normalize_process_lifetime(func, lifetime)
    if lifetime isa Integer
        return lifetime == 0 ? Indefinite() : Repeat(lifetime)
    elseif isnothing(lifetime)
        if func isa Routine || func isa Type{<:Routine}
            return Repeat(1)
        else
            return Indefinite()
        end
    elseif lifetime isa Lifetime
        return lifetime
    else
        error("Unsupported process lifetime `$lifetime` for `$func`.")
    end
end

function resolve_process_inputs_overrides(func, inputs_overrides...)
    empty_context = ProcessContext(func)
    reg = getregistry(empty_context)

    inputs = @inline filter_by_type(Input, inputs_overrides)
    overrides = @inline filter_by_type(Override, inputs_overrides)

    named_inputs = to_named(reg, inputs...)
    named_overrides = to_named(reg, overrides...)

    return named_inputs, named_overrides
end

function prepare_process_constructor(func, inputs_overrides...; lifetime = Indefinite(), context = nothing)
    func = normalize_process_algo(func)
    lifetime = normalize_process_lifetime(func, lifetime)
    named_inputs, named_overrides = resolve_process_inputs_overrides(func, inputs_overrides...)

    @DebugMode "Named_inputs: $(named_inputs)"
    @DebugMode "Named overrides: $(named_overrides)"

    taskdata = TaskData(func; lifetime, overrides = named_overrides, inputs = named_inputs)
    prepared_context = isnothing(context) ? initcontext(taskdata) : context

    return (; func, lifetime, taskdata, context = prepared_context)
end
