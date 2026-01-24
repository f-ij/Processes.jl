export PreferWeakKeyDict

"""
Dictionary that prefers strong keys for isbits types and weak keys otherwise.
"""
struct PreferWeakKeyDict{K,V} <: AbstractDict{K,V}
    strong::Dict{K,V}
    weak::WeakKeyDict{Any,V}
end

PreferWeakKeyDict{K,V}() where {K,V} = PreferWeakKeyDict(Dict{K,V}(), WeakKeyDict{Any,V}())
PreferWeakKeyDict() = PreferWeakKeyDict{Any,Any}()

@inline _use_strong(k) = isbitstype(typeof(k))

function Base.setindex!(d::PreferWeakKeyDict{K,V}, v::V, k) where {K,V}
    if _use_strong(k)
        d.strong[k] = v
    else
        d.weak[k] = v
    end
    return d
end

function Base.getindex(d::PreferWeakKeyDict, k)
    if _use_strong(k)
        return d.strong[k]
    end
    return d.weak[k]
end

function Base.get(d::PreferWeakKeyDict, k, default)
    if _use_strong(k)
        return get(d.strong, k, default)
    end
    return get(d.weak, k, default)
end

function Base.haskey(d::PreferWeakKeyDict, k)
    if _use_strong(k)
        return haskey(d.strong, k)
    end
    return haskey(d.weak, k)
end

function Base.delete!(d::PreferWeakKeyDict, k)
    if _use_strong(k)
        delete!(d.strong, k)
    else
        delete!(d.weak, k)
    end
    return d
end

function Base.empty!(d::PreferWeakKeyDict)
    empty!(d.strong)
    empty!(d.weak)
    return d
end

Base.length(d::PreferWeakKeyDict) = length(d.strong) + length(d.weak)

function Base.iterate(d::PreferWeakKeyDict, state = (1, nothing))
    which, sub = state
    if which == 1
        nxt = iterate(d.strong, sub)
        if nxt === nothing
            return iterate(d, (2, nothing))
        end
        return nxt, (1, nxt[2])
    end
    nxt = iterate(d.weak, sub)
    if nxt === nothing
        return nothing
    end
    return nxt, (2, nxt[2])
end
