function changename(sa::ScopedAlgorithm{F}, newname::Symbol) where {F}
    ScopedAlgorithm{F, newname, id(sa), varaliases(sa), algoname(sa)}(sa.func)
end

function changename(a::Any, newname)
    return a
end

"""
Scoped Algorithms don't wrap other ScopedAlgorithms
    We just change the name of the algorithm
"""
ScopedAlgorithm(na::ScopedAlgorithm, name::Symbol) = changename(na, name)


########################################
############### Traits #################
########################################
id(sa::ScopedAlgorithm{F, Name, Id}) where {F, Name, Id} = Id
id(sat::Type{<:ScopedAlgorithm{F, Name, Id}}) where {F, Name, Id} = Id
id(obj::Any) = nothing

setid(sa::SA, newid) where {SA<:ScopedAlgorithm} = setparameter(sa, 3, newid)

hasid(::Any) = false
hasid(sa::ScopedAlgorithm) = !isnothing(id(sa))

hasname(::ScopedAlgorithm) = true
hasname(obj::Any) = !isnothing(getname(obj))

algoname(sa::ScopedAlgorithm{F, Name, Id, Aliases, AlgoName}) where {F, Name, Id, Aliases, AlgoName} = AlgoName == Symbol() ? nothing : AlgoName

varaliases(sa::Union{ScopedAlgorithm{F, Name, Id, Aliases}, Type{<:ScopedAlgorithm{F, Name, Id, Aliases}}}) where {F, Name, Id, Aliases} = Aliases

isdefault(sa::ScopedAlgorithm) = id(sa) == :default
isdefault(sat::Type{<:ScopedAlgorithm}) = id(sat) == :default
isdefault(obj::Any) = false



@inline getfunc(sa::ScopedAlgorithm{F, Name}) where {F, Name} = sa.func
@inline getname(sa::ScopedAlgorithm{F, Name}) where {F, Name} = getname(typeof(sa))
@inline function getname(sat::Type{<:ScopedAlgorithm{F, Name}}) where {F, Name}
    Name
end
getalgorithm(sa::ScopedAlgorithm{F, Name}) where {F, Name} = sa.func

"""
Remove the scope from the type
"""
function contained_type(sat::Type{<:ScopedAlgorithm{F}}) where {F}
        return F
end


##### MATCHING INSTANCES #####

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
# isinstance(o1::Any, o2::Any) = o1 === o2



function mergereturn(sa::ScopedAlgorithm{F, Name}, args, returnval) where {F, Name}
    (;args..., (Name => (;getproperty(returnval, Name)..., returnval...)))
end

# function update_auto(sa::ScopedAlgorithm{F, Name}, newname::Symbol) where {F, Name}
#     if has_generated_name(sa)
#         return changename(sa, newname)
#     end
#     return sa
# end

"""
For bulk replacement of names
"""
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

scopedalgorithm_label(sa::ScopedAlgorithm) = string((isnothing(algoname(sa)) ? summary(getalgorithm(sa)) : algoname(sa)),"@",getname(sa))


### CONTAINER TRAIT ###
thincontainer(::Type{<:ScopedAlgorithm}) = true
function (sa::ScopedAlgorithm)(newobj::O) where {O} # Composition rule
    return ScopedAlgorithm(newobj, getname(sa), id(sa))
end
_contained_type(::Type{<:ScopedAlgorithm{F}}) where {F} = F
_unwrap_container(sa::ScopedAlgorithm) = getalgorithm(sa)


function Base.show(io::IO, sa::ScopedAlgorithm)
    algo_repr = sprint(show, getalgorithm(sa))
    print(io, scopedalgorithm_label(sa), ": ", algo_repr)
end

