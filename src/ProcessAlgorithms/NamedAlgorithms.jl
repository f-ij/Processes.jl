"""
Algorithm with a static namespace
"""
struct NamedAlgorithm{F, Name} <: ProcessAlgorithm
    func::F
end

NamedAlgorithm(f, name) = NamedAlgorithm{typeof(f), name}(f)

hasname(::NamedAlgorithm) = true
hasname(obj::Any) = !isnothing(getname(obj))

getname(na::NamedAlgorithm{F, Name}) where {F, Name} = Name
getalgorithm(na::NamedAlgorithm{F, Name}) where {F, Name} = na.func

@generated function has_generated_name(na::NamedAlgorithm{F, Name}) where {F, Name}
    is_auto = string(Name)[1] == '_'
    return :($is_auto)
end

isinstance(na::NamedAlgorithm, obj) = na.func === obj
isinstance(obj, na::NamedAlgorithm) = na.func === obj

@inline function namedstep!(na::NamedAlgorithm{F, Name}, args) where {F, Name}
    args = (;getproperty(args, Name)..., globalargs = args)
    @inline step!(na.func, args)
end

@inline function step!(na::NamedAlgorithm{F, Name}, args) where {F, Name}
    # args = (;getproperty(args, Name)..., args)
    @inline step!(na.func, args)
end

function mergereturn(na::NamedAlgorithm{F, Name}, args, returnval) where {F, Name}
    (;args..., (Name => (;getproperty(returnval, Name)..., returnval...)))
end

function changename(na::NamedAlgorithm{F}, newname) where {F}
    NamedAlgorithm{F, typeof(newname)}(na.func)
end

function changename(a::Any, newname)
    a
end

function replacename(a::NamedAlgorithm{F, OldName}, name_replacement::Pair) where {F, OldName}
    if OldName == name_replacement[1]
        return changename(a, name_replacement[2])
    end
    return a
end

function replacename(a::NamedAlgorithm{F, OldName}, name_replacements::AbstractArray{<:Pair}) where {F, OldName}
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

algotype(::NamedAlgorithm{F, Name}) where {F, Name} = F

namedalgorithm_label(na::NamedAlgorithm) = string(summary(getalgorithm(na)),"@",getname(na))

function Base.show(io::IO, na::NamedAlgorithm)
    algo_repr = sprint(show, getalgorithm(na))
    print(io, namedalgorithm_label(na), ": ", algo_repr)
end