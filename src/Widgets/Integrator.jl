struct Integrator{T, id} <: ProcessAlgorithm end

Integrator(T = Float64; name::Union{Symbol, UUID} = uuid4()) = Integrator{T, uuid4()}()

function init(::Integrator{T, id}, context::C) where {T, id, C}
    total = get(context, :initialvalue, 0.0)
    (;total)
end

function step!(::Integrator{T, id}, context::C) where {T, id, C}
    (;total, Δvalue) = context
    stepsize = get(context, :stepsize, one(T))
    total += Δvalue * stepsize
    return (;total)
end