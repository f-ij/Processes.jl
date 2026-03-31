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
    initcontext = replace(context, (;key => identified_algo))
    c = init(identified_algo, initcontext)
    return merge_into_subcontexts(context, (;key => c))
end