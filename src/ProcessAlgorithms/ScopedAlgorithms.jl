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
ScopedAlgorithm(f, name::Symbol, id::Union{Nothing, UUID} = nothing) = ScopedAlgorithm{typeof(f), name, id}(f)
Autoname(f, i::Int, prefix = "_", id = nothing) = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)),"_",string(i)), id}(f)
DefaultScope(f, prefix = "_") = ScopedAlgorithm{typeof(f), Symbol(prefix, nameof(typeof(f)),"_", 0), :default}(f) 

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

hasid(sa::ScopedAlgorithm) = !isnothing(id(sa))


getname(sa::ScopedAlgorithm{F, Name}) where {F, Name} = Name
getname(sat::Type{<:ScopedAlgorithm{F, Name}}) where {F, Name} = Name
getalgorithm(sa::ScopedAlgorithm{F, Name}) where {F, Name} = sa.func

# """
# Scope cannot be stripped fomr id'ed functions
# """
# function strip_scope(sa::ScopedAlgorithm)
#     if isnothing(id(sa))
#         return getalgorithm(sa)
#     end
#     return sa
# end
# strip_scope(a::Any) = a

# function strip_scope(sat::Type{<:ScopedAlgorithm{F}}) where {F}
#     if isnothing(id(sat))
#         return F
#     end
#     return sat
# end
# strip_scope(t::Type{<:Any}) = t


isinstance(obj, sa::ScopedAlgorithm) = isinstance(sa, obj)
function isinstance(sa::ScopedAlgorithm, obj)
    if hasid(sa)
        return false
    end
    sa.func === obj
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

@inline function namedstep!(sa::ScopedAlgorithm{F, Name}, args) where {F, Name}
    args = (;getproperty(args, Name)..., globalargs = args)
    @inline step!(sa.func, args)
end

@inline function step!(sa::ScopedAlgorithm{F, Name}, args) where {F, Name}
    # args = (;getproperty(args, Name)..., args)
    @inline step!(sa.func, args)
end

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

scopedalgorithm_label(sa::ScopedAlgorithm) = string(summary(getalgorithm(sa)),"@",getname(sa))

function Base.show(io::IO, sa::ScopedAlgorithm)
    algo_repr = sprint(show, getalgorithm(sa))
    print(io, scopedalgorithm_label(sa), ": ", algo_repr)
end

# function Base.show(io::IO, nat::Type{<:ScopedAlgorithm})
#     if nat isa DataType
#         Base.show_type_name(io, nat)
#         Base.show_type_parameters(io, nat)
#         print(io, "@", getname(nat))
#     else
#         base_type = Base.unwrap_unionall(nat)
#         mod = parentmodule(base_type)
#         if mod === Main || mod === Core || mod === Base
#             print(io, nameof(base_type))
#         else
#             print(io, nameof(mod), ".", nameof(base_type))
#         end
#     end
# end
