using UUIDs
"""
Algorithm assigned to a namespace in a context
    Ids can be used te separate two algorithms with the same name and function
"""
struct ScopedAlgorithm{F, Name, Id} <: ProcessAlgorithm
    func::F
end

"""
Set an explicit name for an algorithm
"""
ScopedAlgorithm(f, name, id = nothing) = ScopedAlgorithm{typeof(f), name, id}(f)
Autoname(f, i, prefix = "_", id = nothing) = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)), string(i)), id}(f)

"""
Scoped Algorithms don't wrap other ScopedAlgorithms
    We just change the name of the algorithm
"""
ScopedAlgorithm(na::ScopedAlgorithm, name) = changename(na, name)

hasname(::ScopedAlgorithm) = true
hasname(obj::Any) = !isnothing(getname(obj))

id(na::ScopedAlgorithm{F, Name, Id}) where {F, Name, Id} = Id
id(obj::Any) = nothing

getname(na::ScopedAlgorithm{F, Name}) where {F, Name} = Name
getalgorithm(na::ScopedAlgorithm{F, Name}) where {F, Name} = na.func

@generated function has_generated_name(na::ScopedAlgorithm{F, Name}) where {F, Name}
    is_auto = string(Name)[1] == '_'
    return :($is_auto)
end

isinstance(na::ScopedAlgorithm, obj) = na.func === obj
isinstance(obj, na::ScopedAlgorithm) = na.func === obj
"""
Check for id and instance
"""
function isinstance(na::ScopedAlgorithm, na2::ScopedAlgorithm)
    return id(na) === id(na2) && na.func === na2.func
end
isinstance(o1::Any, o2::Any) = o1 === o2

@inline function namedstep!(na::ScopedAlgorithm{F, Name}, args) where {F, Name}
    args = (;getproperty(args, Name)..., globalargs = args)
    @inline step!(na.func, args)
end

@inline function step!(na::ScopedAlgorithm{F, Name}, args) where {F, Name}
    # args = (;getproperty(args, Name)..., args)
    @inline step!(na.func, args)
end

function mergereturn(na::ScopedAlgorithm{F, Name}, args, returnval) where {F, Name}
    (;args..., (Name => (;getproperty(returnval, Name)..., returnval...)))
end

function changename(na::ScopedAlgorithm{F}, newname) where {F}
    ScopedAlgorithm{F, typeof(newname)}(na.func)
end

function changename(a::Any, newname)
    return a
end

function update_auto(na::ScopedAlgorithm{F, Name}, newname) where {F, Name}
    if has_generated_name(na)
        return changename(na, newname)
    end
    return na
end

function replacename(a::ScopedAlgorithm{F, OldName}, name_replacement::Pair) where {F, OldName}
    if OldName == name_replacement[1]
        return changename(a, name_replacement[2])
    end
    return a
end

function replacename(a::ScopedAlgorithm{F, OldName}, name_replacements::AbstractArray{<:Pair}) where {F, OldName}
    for nr in name_replacements
        if OldName == nr[1]
            return changename(a, nr[2])
        end
    end
    return a
end

function replacename(a::Any, name_replacements)
    return a
end

algotype(::ScopedAlgorithm{F, Name}) where {F, Name} = F

scopedalgorithm_label(na::ScopedAlgorithm) = string(summary(getalgorithm(na)),"@",getname(na))

function Base.show(io::IO, na::ScopedAlgorithm)
    algo_repr = sprint(show, getalgorithm(na))
    print(io, scopedalgorithm_label(na), ": ", algo_repr)
end
