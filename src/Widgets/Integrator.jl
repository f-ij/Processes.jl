struct Integrator{T, id} <: ProcessAlgorithm end

Integrator(T = Float64; name::Union{Symbol, UUID} = uuid4()) = Integrator{T, uuid4()}()

function init(::Integrator{T}, context::C) where {T, C}
    total = @inline get(context, :initialvalue, zero(T))::T
    stepsize = @inline get(context, :stepsize, one(T))::T
    (;total, stepsize)
end

function step!(::Integrator{T}, context::C) where {T, C}
    (;total, Δvalue, stepsize) = context
    total += Δvalue * stepsize
    return (;total)
end