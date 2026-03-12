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


function breakcondition(lt::Union{Repeat, Indefinite}, process::P, context::C) where {P <: AbstractProcess, C}
    if !shouldrun(process)
        return true
    else
        return false
    end
end
struct Until{Vars, F}
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

struct RepeatOrUntil{Vars, F}
    repeats::Int
    cond::F
end

RepeatOrUntil(cond::Function, repeats::Int, Vars...) = RepeatOrUntil{Vars, typeof(cond)}(repeats, cond)

function 





