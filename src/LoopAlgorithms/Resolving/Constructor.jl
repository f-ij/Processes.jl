"""
Resolve multiple loop algorithms onto one shared registry.

Each loop algorithm is updated separately against that registry and returned in the
same order.
"""
function resolve(la1::LA1, la2::LA2, las::Vararg{AbstractLoopAlgorithm}) where {LA1<:AbstractLoopAlgorithm, LA2<:AbstractLoopAlgorithm}
    loopalgorithms = (la1, la2, las...)
    registry = setup_registry(loopalgorithms...)
    return map(loopalgorithms) do la
        resolved = la isa LoopAlgorithm ? la : LoopAlgorithm(la)
        resolved = attach_registry_to_tree(resolved, registry)
        options = _unresolved_options(resolved)
        options isa Tuple || error("Resolving multiple loop algorithms together requires unresolved loop algorithms, but got $(typeof(resolved)) with options of type $(typeof(options)).")
        resolved = resolve_step_wiring(resolved, registry)
        setoptions(resolved, _root_loop_options(options))
    end
end

@inline resolve(loopalgorithms::Tuple{Vararg{AbstractLoopAlgorithm}}) = resolve(loopalgorithms...)
