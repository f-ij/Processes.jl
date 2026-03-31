"""
Re-initialize one registered subcontext inside an existing `ProcessContext`.

The target can be provided either as its symbol key or as the registered algorithm
reference. `inputs` are merged into that subcontext before `init`, and `overrides`
are merged afterwards.
"""
Base.@constprop :aggressive function initcontext(context::ProcessContext, s::Symbol; inputs = (;), overrides = (;))
    reg = @inline getregistry(context)
    identified_algo = reg[s]
    return initcontext(context, identified_algo; inputs, overrides)
end

Base.@constprop :aggressive function initcontext(context::ProcessContext, algo; inputs = (;), overrides = (;))
    reg = getregistry(context)
    identified_algo = reg[algo]
    return initcontext(context, identified_algo; inputs, overrides)
end

function initcontext(context::ProcessContext, identified_algo::IdentifiableAlgo; inputs = (;), overrides = (;))
    key = getkey(identified_algo)
    inputcontext = isempty(inputs) ? context : merge_into_subcontexts(context, (;key => inputs))
    prepared_context = init(identified_algo, inputcontext)
    return isempty(overrides) ? prepared_context : merge_into_subcontexts(prepared_context, (;key => overrides))
end
