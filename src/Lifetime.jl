"""
Struct to define the lifetime of a process
Is a struct so that dispatch can be used to choose the appropriate loop during compile time
"""
abstract type Lifetime end
struct Indefinite <: Lifetime end
struct Repeat <: Lifetime 
    repeats::Int
end


repeats(r::Repeat) = r.repeats
repeats(::Indefinite) = Inf
repeats(p::AbstractProcess) = repeats(lifetime(p))
export repeats

import Base./
(/)(r::Repeat, n) = r.repeats / n

# Get the lifetime within a prepare step of a process
mutable struct LifetimeTracker
    lt::Lifetime
end


function lifetime(args::NamedTuple)
    if args.lifetime isa Indefinite
        return args.lifetime
    end

    if haskey(args, :lifetimetracker)
        return args.lifetimetracker.lt
    else 
        return args.lifetime
    end
end