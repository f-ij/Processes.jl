"""
ProcessState wrapper for an arbitrary value that is destructured into its fields
during prepare.
"""
struct Destructure{T,F} <: ProcessState
    id::UInt64
    func::F
end

hasfunc(d::Union{Destructure{T,F}, Type{<:Destructure{T,F}}}) where {T,F} = !(F <: Nothing)

const DESTRUCTURE_STORE = Dict{UInt64, WeakRef}()
const _destructure_counter = Ref{UInt64}(0)
function Destructure(x::T, func::F = nothing) where {T, F<:Union{Nothing, Function}}
    id = (_destructure_counter[] += 1)
    DESTRUCTURE_STORE[id] = WeakRef(x)
    if !isbitstype(T)
        finalizer(x) do _
            delete!(DESTRUCTURE_STORE, id)
        end
    end
    return Destructure{T, F}(id, func)
end

"""
For do syntax
"""
Destructure(f::Function, x::T) where {T} = Destructure(x, f)

function getvalue(d::Destructure)
    wref = get(DESTRUCTURE_STORE, d.id, nothing)
    if wref === nothing || wref.value === nothing
        error("Destructure value not found in store for id $(d.id)")
    end
    return wref.value
end

function release!(d::Destructure)
    delete!(DESTRUCTURE_STORE, d.id)
    return nothing
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
    fields = destructure(getvalue(d))
    if hasfunc(d)
        fields = d.func(fields, context)
    end
    return fields
end

export Destructure, destructure, release!
