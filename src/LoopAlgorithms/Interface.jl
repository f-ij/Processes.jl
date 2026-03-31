export SimpleAlgo, CompositeAlgorithm, Routine
export getkey, step!, init, getmultiplier, getoptions, setoptions, get_shares, get_routes

getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(getregistry(cla), obj)
getkey(cla::LoopAlgorithm, obj) = getkey(getregistry(cla), obj)
getoptions(cla::LoopAlgorithm) = getfield(cla, :options)
get_shares(cla::LoopAlgorithm) = @inline filter_by_type(Share, getoptions(cla))
get_routes(cla::LoopAlgorithm) = @inline filter_by_type(Route, getoptions(cla))
get_states(cla::LoopAlgorithm) = getfield(cla, :states)

getoptions(la::LoopAlgorithm, T::Type{O}) where O = @inline filter_by_type(O, getoptions(la))
setoptions(la::LoopAlgorithm, options) = error("setoptions not implemented for $(typeof(la))")

"""
Trait for setup
"""
iscomposite(::Any) = false
iscomposite(::Type{<:LoopAlgorithm}) = false
iscomposite(::Type{<:CompositeAlgorithm}) = true
iscomposite(la::LoopAlgorithm) = iscomposite(typeof(la))

statetypes(::Type{LoopAlgorithm}) = error("statetypes not implemented for LoopAlgorithm, got $(la)")
algotypes(::Type{LoopAlgorithm}) = error("algotypes not implemented for LoopAlgorithm, got $(la)")

# Reset needs to be implemented
reset!(a::Any) = a

"""
Get the numbers Val(1), Val(2), ... Val(N) for the N algorithms in a composite or routine, as a tuple.
"""
@generated function algonvalumbers(ca::LoopAlgorithm)  
    nums = ntuple(i -> Val(i), numalgos(ca))
    return :($nums)
end

"""
Index a resolved loop algorithm by its registered symbol key.

This is equivalent to property access like `algo.some_key`, but works for keys that
are only available at runtime.
"""
Base.@constprop :aggressive @inline function Base.getindex(cla::LoopAlgorithm, name::Symbol)
    getproperty(cla, Val(name))
end

@inline function Base.getindex(cla::LoopAlgorithm, idx)
    getalgos(cla)[idx]
end

@inline @generated function Base.keys(ca::LA) where LA <: LoopAlgorithm
    Fs = algotypes(ca)
    States = statetypes(ca)
    f_names = getkey.(Fs)
    f_names = filter(s -> s != Symbol(""), f_names)
    f_names = QuoteNode.(f_names)

    s_names = getkey.(States)
    s_names = filter(s -> s != Symbol(""), s_names)
    s_names = QuoteNode.(s_names)
    return quote
        $(LineNumberNode(@__LINE__, @__FILE__))
        ($(f_names...), $(s_names...))
    end
end

Base.@constprop :aggressive @inline Base.getproperty(ca::LoopAlgorithm, name::Symbol) = getproperty(ca, Val(name))
"""
Get an algo by name
"""
@inline @generated function Base.getproperty(ca::LoopAlgorithm, ::Val{name}) where {name}
    Fs = algotypes(ca)
    States = statetypes(ca)
    fidx = findfirst(==(name), getkey.(Fs))
    if !isnothing(fidx)
        return :(getindex(getalgos(ca), $fidx))
    end
    sidx = findfirst(==(name), getkey.(States))
    if !isnothing(sidx)
        return :(getindex(get_states(ca), $sidx))
    end
    return :(error("No algorithm or state with name $(name) found in LoopAlgorithm $(ca)"))
end
