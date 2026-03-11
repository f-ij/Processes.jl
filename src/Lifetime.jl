export repeats

"""
Struct to define the lifetime of a process
Is a struct so that dispatch can be used to choose the appropriate loop during compile time
"""
abstract type Lifetime end
struct Indefinite <: Lifetime end
struct Repeat <: Lifetime 
    repeats::Int
end

Base.:(/)(r::Repeat, n) = r.repeats / n

repeats(r::Repeat) = r.repeats
repeats(::Indefinite) = Inf
repeats(p::AbstractProcess) = repeats(lifetime(p))

struct Until{Vars, F}
    cond::F
end

function breakcondition(lt::Union{Repeat, Indefinite}, process::P, context::C) where {P <: AbstractProcess, C}
    if !shouldrun(process)
        return true
    else
        return false
    end
end

function breakcondition(u::Until{Vars},process::P, context::C) where {Vars, P <: AbstractProcess, C}
    if !shouldrun(process)
        return true
    else
        return !(u.cond(getindex(context, u.Vars...)))
    end
end



