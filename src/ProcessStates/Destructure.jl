export Destructure, DynamicStore, destructure, release!, getdestructure_id, getdynamicstore_id

"""
Thin container that stores a non-isbits value in a dynamic store.
"""
struct DynamicStore{id,T}
end

getid(d::Union{Type{<:DynamicStore{id,T}}, DynamicStore{id,T}}) where {id,T} = id

const DYNAMIC_STORE = Dict{UInt64, WeakRef}()
const DYNAMIC_REVERSE = WeakKeyDict{Any, UInt64}()
const _dynamic_counter = Ref{UInt64}(0)

function DynamicStore(x::T, id = (_dynamic_counter[] += 1)) where {T}
    DYNAMIC_STORE[id] = WeakRef(x)
    DYNAMIC_REVERSE[x] = id
    if !isbitstype(T)
        finalizer(x) do _
            delete!(DYNAMIC_STORE, id)
            delete!(DYNAMIC_REVERSE, x)
        end
    end
    return DynamicStore{id, T}()
end

function getvalue(d::DynamicStore)
    wref = get(DYNAMIC_STORE, getid(d), nothing)
    if wref === nothing || wref.value === nothing
        error("DynamicStore value not found in store for id $(getid(d))")
    end
    return wref.value
end

function release!(d::DynamicStore)
    wref = get(DYNAMIC_STORE, getid(d), nothing)
    if wref !== nothing
        x = wref.value
        if x !== nothing
            delete!(DYNAMIC_REVERSE, x)
        end
    end
    delete!(DYNAMIC_STORE, getid(d))
    return nothing
end

function getdynamicstore_id(x)
    return get(DYNAMIC_REVERSE, x, nothing)
end

#####
# Can be set later during processing
#####
function DelayedStore(x::Type{T}) where {T}
    id = (_dynamic_counter[] += 1)
    DYNAMIC_STORE[id] = WeakRef(nothing)
    return DynamicStore{id, T}()
end

function setreference(d::DynamicStore{id,T}, x::DT) where {id,T, DT <: T}
    DYNAMIC_STORE[id] = WeakRef(x)
    DYNAMIC_REVERSE[x] = id
    if !isbitstype(T)
        finalizer(x) do _
            delete!(DYNAMIC_STORE, id)
            delete!(DYNAMIC_REVERSE, x)
        end
    end
    return nothing
end

## THINCONTAINER
thincontainer(::Type{<:DynamicStore}) = true
function (ds::DynamicStore{id,T})(newobj::O) where {id,T,O<:T} # Composition
    release!(ds)
    return DynamicStore(newobj, id)
end
_contained_type(::Type{<:DynamicStore{id, T}}) where {id, T} = typeof(DYNAMIC_STORE[id].value)
_unwrap_container(d::DynamicStore) = getvalue(d)



"""
ProcessState wrapper for an arbitrary value that is destructured into its fields
during prepare.
"""
struct Destructure{T,F} <: ProcessState
    obj::T
    func::F
end

hasfunc(d::Union{Destructure{T,F}, Type{<:Destructure{T,F}}}) where {T,F} = !(F <: Nothing)

function Destructure(x::T, func::F = nothing) where {T, F<:Union{Nothing, Function}}
    wrapped = isbitstype(T) ? x : DynamicStore(x)
    return Destructure{typeof(wrapped), F}(wrapped, func)
end

"""
For do syntax
"""
Destructure(f::Function, x::T) where {T} = Destructure(x, f)

function getdestructure_id(x)
    return getdynamicstore_id(x)
end

function getvalue(d::Destructure)
    return unwrap_container(d)
end

destructure(x::NamedTuple) = x

@generated function destructure(x::T) where {T}
    names = fieldnames(T)
    if isempty(names)
        return :(NamedTuple{()}(()))
    end
    vals = [:(getfield(x, $(QuoteNode(n)))) for n in names]
    return :(NamedTuple{$(names)}(($(vals...),)))
end

function prepare(d::Destructure, context::AbstractContext)
    value = getvalue(d)
    valuename = Symbol(lowercase(string(nameof(typeof(value)))))
    fields = destructure(value)
    fields = (;valuename => value, fields...)
    if hasfunc(d)
        fields = d.func(fields, context)
    end
    return fields
end

## CONTAINER
thincontainer(::Type{<:Destructure}) = true
function (d::Destructure{T,F})(newobj::O) where {T,F,O<:T} # Composition rule
    return Destructure(newobj, d.func)
end
_contained_type(::Type{<:Destructure{T, F}}) where {T, F} = contained_type(T)
_unwrap_container(d::Destructure{T, F}) where {T, F} = getvalue(d)
