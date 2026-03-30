struct ThreadedIndex{idx} end
struct ThreadedLayer{Idxs} end

"""
Return threaded execution layers from the resolved shared-variable dependencies stored on
the concrete `ProcessContext` subtype.
"""
@generated function _threaded_layers(::TCA, ::C) where {TCA<:ThreadedCompositeAlgorithm, C<:ProcessContext}
    n = numalgos(TCA)

    child_names = ntuple(i -> getkey(getalgotype(TCA, i)), n)
    parents = [Int[] for _ in 1:n]

    for idx in 1:n
        child_name = child_names[idx]
        child_name isa Symbol || continue

        subcontext_t = subcontext_type(C, child_name)
        for sharedvar_t in getsharedvars_types(subcontext_t)
            parent_name = get_fromname(sharedvar_t)
            parent_name isa Symbol || continue

            parent_idx = findfirst(==(parent_name), child_names)
            if !isnothing(parent_idx) && parent_idx != idx && !(parent_idx in parents[idx])
                push!(parents[idx], parent_idx)
            end
        end
    end

    remaining = collect(1:n)
    done = Int[]
    layers = Any[]

    while !isempty(remaining)
        layer = Int[]
        for idx in remaining
            if all(parent -> parent in done, parents[idx])
                push!(layer, idx)
            end
        end

        if isempty(layer)
            layer_exprs = [:(ThreadedLayer{$(Expr(:tuple, i))}()) for i in 1:n]
            return Expr(:tuple, layer_exprs...)
        end

        push!(layers, Tuple(layer))
        append!(done, layer)
        filter!(idx -> !(idx in layer), remaining)
    end

    layer_exprs = [:(ThreadedLayer{$(Expr(:tuple, layer...))}()) for layer in layers]
    return Expr(:tuple, layer_exprs...)
end

@inline function _threaded_should_run(tca::ThreadedCompositeAlgorithm, this_inc::Int, idx::Int)
    this_interval = interval(tca, idx)
    return this_interval == 1 || this_inc % this_interval == 0
end

Base.@constprop :aggressive function threaded_step(sa::SA, base_context::C) where {SA<:AbstractIdentifiableAlgo, C<:ProcessContext}
    contextview = @inline view(base_context, sa)
    task = Threads.@spawn step!(getalgo(sa), contextview)
    return (sa, contextview, task)
end

Base.@constprop :aggressive function _threaded_run_child(base_context::C, tca::TCA, ::ThreadedIndex{idx}, this_inc::Int) where {C<:ProcessContext, TCA<:ThreadedCompositeAlgorithm, idx}
    if !(@inline _threaded_should_run(tca, this_inc, idx))
        return nothing
    end

    sa = @inline getalgo(tca, idx)
    contextview = @inline view(base_context, sa)
    retval = @inline step!(getalgo(sa), contextview)
    merged_context = @inline merge(contextview, retval)
    local_payload = @inline get_data(getproperty(merged_context, getkey(sa)))
    child_name = getkey(getalgotype(TCA, idx))
    return NamedTuple{(child_name,), Tuple{get_datatype(subcontext_type(C, child_name))}}((local_payload,))
end

Base.@constprop :aggressive function _threaded_spawn_child(base_context::C, tca::TCA, ::ThreadedIndex{idx}, this_inc::Int) where {C<:ProcessContext, TCA<:ThreadedCompositeAlgorithm, idx}
    if !(@inline _threaded_should_run(tca, this_inc, idx))
        return nothing
    end
    sa = @inline getalgo(tca, idx)
    return @inline threaded_step(sa, base_context)
end

Base.@constprop :aggressive function _threaded_merge_child_payload(merged::NamedTuple, future, ::Type{C}, ::Type{TCA}, idx::ThreadedIndex{idx_val}) where {C<:ProcessContext, TCA<:ThreadedCompositeAlgorithm, idx_val}
    if future === nothing
        return merged
    end
    sa, contextview, task = future
    retval = @inline fetch(task)
    merged_context = @inline merge(contextview, retval)
    local_payload = @inline get_data(getproperty(merged_context, getkey(sa)))
    child_name = getkey(getalgotype(TCA, idx_val))
    payload = NamedTuple{(child_name,), Tuple{get_datatype(subcontext_type(C, child_name))}}((local_payload,))
    return @inline merge(merged, payload)
end

Base.@constprop :aggressive function _threaded_run_layer(base_context::C, tca::TCA, ::ThreadedLayer{Idxs}, this_inc::Int, s::S) where {C<:ProcessContext, TCA<:ThreadedCompositeAlgorithm, Idxs, S}
    children = ntuple(i -> ThreadedIndex{Idxs[i]}(), length(Idxs))
    isempty(children) && return base_context

    if length(children) == 1
        merged_children = @inline _threaded_run_child(base_context, tca, getfield(children, 1), this_inc)
        isnothing(merged_children) && return base_context
        if s isa Unstable
            return @inline merge_into_subcontexts(base_context, merged_children)
        else
            return @inline merge_into_subcontexts(base_context, merged_children)::C
        end
    end

    futures = ntuple(Val(length(children))) do i
        @inline _threaded_spawn_child(base_context, tca, getfield(children, i), this_inc)
    end

    child_futures = ntuple(Val(length(children))) do i
        (getfield(children, i), getfield(futures, i))
    end

    merged_children = unrollreplace((;), child_futures...) do merged, child_future
        child, future = child_future
        @inline _threaded_merge_child_payload(merged, future, C, TCA, child)
    end

    isempty(merged_children) && return base_context
    if s isa Unstable
        return @inline merge_into_subcontexts(base_context, merged_children)
    else
        return (@inline merge_into_subcontexts(base_context, merged_children))::C
    end
end

Base.@constprop :aggressive function step!(tca::ThreadedCompositeAlgorithm, context::C, s::S) where {C<:ProcessContext, S}
    this_inc = inc(tca)
    layers = @inline _threaded_layers(tca, context)

    if s isa Unstable
        current = @inline unrollreplace(context, layers...) do current, layer
        @inline _threaded_run_layer(current, tca, layer, this_inc, s)
        end
    else

        current = @inline unrollreplace(context, layers...) do current, layer
            @inline _threaded_run_layer(current, tca, layer, this_inc, s)::C
        end
    end
    inc!(tca)
    return current
end
