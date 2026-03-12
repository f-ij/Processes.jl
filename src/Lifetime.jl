export repeats

abstract type Lifetime end

abstract type RepeatLifetime <: Lifetime end
abstract type IndefiniteLifetime <: Lifetime end

Base.:(/)(r::Repeat, n) = r.repeats / n
repeats(r::Repeat) = r.repeats

repeats(::Indefinite) = Inf
repeats(p::AbstractProcess) = repeats(lifetime(p))


"""
Struct to define the lifetime of a process
Is a struct so that dispatch can be used to choose the appropriate loop during compile time
"""
struct Indefinite <: IndefiniteLifetime end
struct Repeat <: RepeatLifetime
    repeats::Int
end



function breakcondition(lt::Union{Repeat, Indefinite}, process::P, context::C) where {P <: AbstractProcess, C}
    if !shouldrun(process)
        return true
    else
        return false
    end
end
struct Until{Vars, F} <: IndefiniteLifetime
    cond::F
end

Until(cond::Function, Vars...) = Until{Vars, typeof(cond)}(cond)


function breakcondition(u::Until{Vars}, process::P, context::C) where {Vars, P <: AbstractProcess, C}
    if !shouldrun(process)
        return true
    else
        return u.cond(getindex(context, Vars...))
    end
end

struct RepeatOrUntil{Vars, F} <: RepeatLifetime
    repeats::Int
    cond::F
end
repeats(rou::RepeatOrUntil) = rou.repeats


RepeatOrUntil(cond::Function, repeats::Int, Vars...) = RepeatOrUntil{Vars, typeof(cond)}(repeats, cond)

function breakcondition(ru::RepeatOrUntil{Vars}, process::P, context::C) where {Vars, P <: AbstractProcess, C}
    if !shouldrun(process)
        return true
    else
        return ru.cond(getindex(context, Vars...))
    end
end





