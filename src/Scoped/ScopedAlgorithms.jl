using UUIDs

abstract type AbstractScopedAlgorithm end
export ScopedAlgorithm, Unique

"""
Algorithm assigned to a namespace in a context
    Ids can be used te separate two algorithms with the same name and function
"""
struct ScopedAlgorithm{F, Name, Id} <: AbstractScopedAlgorithm
    func::F
end

"""
Set an explicit name for an algorithm
"""
ScopedAlgorithm(f, name::Symbol, id::Union{Nothing, UUID} = nothing) = ScopedAlgorithm{typeof(f), name, id}(f)
Autoname(f, i::Int, prefix = "", id = nothing) = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)),"_",string(i)), id}(f)
Autoname(f::ScopedAlgorithm, i::Int, prefix = "") = ScopedAlgorithm{typeof(f.func), Symbol(prefix, nameof(typeof(f.func)),"_",string(i)), id(f)}(f.func)
DefaultScope(f, prefix = "") = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)),"_", 0), :default}(f) 

function Unique(f)
    f = instantiate(f)
    ScopedAlgorithm{typeof(f),nothing, uuid4()}(f)
end

"""
Scoped Algorithms don't wrap other ScopedAlgorithms
    We just change the name of the algorithm
"""
ScopedAlgorithm(na::ScopedAlgorithm, name::Symbol) = changename(na, name)

hasname(::ScopedAlgorithm) = true
hasname(obj::Any) = !isnothing(getname(obj))

id(sa::ScopedAlgorithm{F, Name, Id}) where {F, Name, Id} = Id
id(sat::Type{<:ScopedAlgorithm{F, Name, Id}}) where {F, Name, Id} = Id
id(obj::Any) = nothing

isdefault(sa::ScopedAlgorithm) = id(sa) == :default
isdefault(sat::Type{<:ScopedAlgorithm}) = id(sat) == :default
isdefault(obj::Any) = false

hasid(sa::ScopedAlgorithm) = !isnothing(id(sa))


@inline getfunc(sa::ScopedAlgorithm{F, Name}) where {F, Name} = sa.func
@inline getname(sa::ScopedAlgorithm{F, Name}) where {F, Name} = getname(typeof(sa))
@inline function getname(sat::Type{<:ScopedAlgorithm{F, Name}}) where {F, Name}
    Name
end
getalgorithm(sa::ScopedAlgorithm{F, Name}) where {F, Name} = sa.func



"""
Remove the scope from the type
"""
strip_scope(a::Any) = a
function strip_scope(sat::Type{<:ScopedAlgorithm{F}}) where {F}
        return F
end


isinstance(obj, sa::ScopedAlgorithm) = isinstance(sa, obj)
function isinstance(sa::ScopedAlgorithm, obj)
    if hasid(sa)
        # if id(sa) == :default
        #     return sa.func === obj
        # end
        return false
    end
    sa.func === obj
end

"""
Default instances can match with a type
"""
function isinstance(sa::ScopedAlgorithm, obj::Type)
    # if id(sa) == :default
    #     return typeof(sa.func) <: obj
    # end
    return false
end 

"""
Check for id and instance
"""
function isinstance(sa::ScopedAlgorithm, sa2::ScopedAlgorithm)
    # Non-nothing ids MUST match
    if hasid(sa) || hasid(sa2)
        return id(sa) == id(sa2)
    end
    return sa.func === sa2.func
end
isinstance(o1::Any, o2::Any) = o1 === o2



function mergereturn(sa::ScopedAlgorithm{F, Name}, args, returnval) where {F, Name}
    (;args..., (Name => (;getproperty(returnval, Name)..., returnval...)))
end

function changename(sa::ScopedAlgorithm{F}, newname::Symbol) where {F}
    ScopedAlgorithm{F, typeof(newname), id(sa)}(sa.func)
end

function changename(a::Any, newname)
    return a
end

# function update_auto(sa::ScopedAlgorithm{F, Name}, newname::Symbol) where {F, Name}
#     if has_generated_name(sa)
#         return changename(sa, newname)
#     end
#     return sa
# end

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
algotype(f::Any) = typeof(f)

scopedalgorithm_label(sa::ScopedAlgorithm) = string(summary(getalgorithm(sa)),"@",getname(sa))

function Base.show(io::IO, sa::ScopedAlgorithm)
    algo_repr = sprint(show, getalgorithm(sa))
    print(io, scopedalgorithm_label(sa), ": ", algo_repr)
end