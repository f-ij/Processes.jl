"""
Struct to define the lifetime of a process
Is a struct so that dispatch can be used to choose the appropriate loop during compile time
"""
abstract type Lifetime end
struct Indefinite <: Lifetime end
struct Repeat{Num} <: Lifetime 
    function Repeat{Num}() where Num 
        @assert Num isa Real "Repeats must be an integer" 
        new{Num}()
    end
end

repeats(r::Repeat{N}) where N = N
repeats(p::AbstractProcess) = repeats(lifetime(p))
export repeats

import Base./
(/)(::Repeat{N}, r) where N = N/r

# Get the lifetime within a prepare step of a process
mutable struct LifetimeTracker
    lt::Lifetime
end


function lifetime(args)
    if args.lifetime isa Indefinite
        return args.lifetime
    end

    if haskey(args, :lifetimetracker)
        return args.lifetimetracker.lt
    else 
        return args.lifetime
    end
end