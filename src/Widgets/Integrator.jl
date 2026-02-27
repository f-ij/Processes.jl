struct Integrator{T, id} <: ProcessAlgorithm end

Integrator(T = Float64; name::Union{Symbol, UUID} = uuid4()) = Integrator{T, uuid4()}()

function init(::Integrator{T}, context::C) where {T, C}
    total = @inline get(context, :initialvalue, 0.0)
    (;total)
end

function step!(::Integrator{T}, context::C) where {T, C}
    (;total, Δvalue) = context
    stepsize = @inline get(context, :stepsize, one(T))
    total += Δvalue * stepsize
    return (;total)
end