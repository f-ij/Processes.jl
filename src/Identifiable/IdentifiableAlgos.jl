function changecontextname(sa::IdentifiableAlgo{F}, newname::Symbol) where {F}
    IdentifiableAlgo{F, id(sa), varaliases(sa), algoname(sa), newname}(sa.func)
end

function changecontextname(a::Any, newname)
    return a
end

########################################
############### Traits #################
########################################
match_by(sa::IdentifiableAlgo) = id(sa)
staticmatch_by(::Union{T,Type{T}}) where {T<:IdentifiableAlgo} = id(T)

id(sa::IdentifiableAlgo{F, Id}) where {F, Id} = Id
id(sat::Type{<:IdentifiableAlgo{F, Id}}) where {F, Id} = Id
id(obj::Any) = nothing

setid(sa::SA, newid) where {SA<:IdentifiableAlgo} = setparameter(sa, 2, newid)

hasid(::Any) = false
hasid(sa::IdentifiableAlgo) = !isnothing(id(sa))

hasname(::IdentifiableAlgo) = true
hasname(obj::Any) = !isnothing(getname(obj))

algoname(sa::IdentifiableAlgo{F, Id, Aliases, AlgoName}) where {F, Id, Aliases, AlgoName} = AlgoName == Symbol() ? nothing : AlgoName

varaliases(sa::Union{IdentifiableAlgo{F, Id, Aliases}, Type{<:IdentifiableAlgo{F, Id, Aliases}}}) where {F, Id, Aliases} = Aliases

algotype(::Union{IdentifiableAlgo{F}, Type{<:IdentifiableAlgo{F}}}) where {F} = F
algotype(f::Any) = typeof(f)


@inline getfunc(sa::IdentifiableAlgo{F}) where {F} = sa.func
@inline getname(sa::IdentifiableAlgo) = getname(typeof(sa))
@inline function getname(sat::Type{<:IdentifiableAlgo{F, Id, Aliases, AlgoName, ScopeName}}) where {F, Id, Aliases, AlgoName, ScopeName}
    ScopeName
end
getalgorithm(sa::IdentifiableAlgo{F}) where {F} = sa.func

# ##### MATCHING INSTANCES #####

# isinstance(obj, sa::IdentifiableAlgo) = isinstance(sa, obj)
# function isinstance(sa::IdentifiableAlgo, obj)
#     if hasid(sa)
#         # if id(sa) == :default
#         #     return sa.func === obj
#         # end
#         return false
#     end
#     sa.func === obj
# end

# """
# Default instances can match with a type
# """
# function isinstance(sa::IdentifiableAlgo, obj::Type)
#     # if id(sa) == :default
#     #     return typeof(sa.func) <: obj
#     # end
#     return false
# end 

# """
# Check for id and instance
# """
# function isinstance(sa::IdentifiableAlgo, sa2::IdentifiableAlgo)
#     # Non-nothing ids MUST match
#     if hasid(sa) || hasid(sa2)
#         return id(sa) == id(sa2)
#     end
#     return sa.func === sa2.func
# end
# # isinstance(o1::Any, o2::Any) = o1 === o2



function mergereturn(sa::IdentifiableAlgo{F, Id, Aliases, AlgoName, ScopeName}, args, returnval) where {F, Id, Aliases, AlgoName, ScopeName}
    (;args..., (ScopeName => (;getproperty(returnval, ScopeName)..., returnval...)))
end

# function update_auto(sa::IdentifiableAlgo{F, Name}, newname::Symbol) where {F, Name}
#     if has_generated_name(sa)
#         return changename(sa, newname)
#     end
#     return sa
# end

"""
For bulk replacement of names
"""
function replacecontextname(a::IdentifiableAlgo{F, Id, Aliases, AlgoName, OldName}, name_replacement::Pair) where {F, Id, Aliases, AlgoName, OldName}
    if OldName == name_replacement[1]
        return changecontextname(a, name_replacement[2])
    end
    return a
end

function replacecontextname(a::IdentifiableAlgo{F, Id, Aliases, AlgoName, OldName}, name_replacements::AbstractArray{<:Pair}) where {F, Id, Aliases, AlgoName, OldName}
    for nr in name_replacements
        if OldName == nr[1]
            return changecontextname(a, nr[2])
        end
    end
    return a
end

"""
Not named entities are not changed
"""
function replacecontextname(a::Any, name_replacements)
    return a
end

IdentifiableAlgo_label(sa::IdentifiableAlgo) = string((isnothing(algoname(sa)) ? summary(getalgorithm(sa)) : algoname(sa)),"@",getname(sa))


# ### CONTAINER TRAIT ###
# thincontainer(::Type{<:IdentifiableAlgo}) = true
# function (sa::IdentifiableAlgo)(newobj::O) where {O} # Composition rule
#     return IdentifiableAlgo(newobj, getname(sa), id(sa))
# end
# _contained_type(::Type{<:IdentifiableAlgo{F}}) where {F} = F
# _unwrap_container(sa::IdentifiableAlgo) = getalgorithm(sa)


function Base.show(io::IO, sa::IdentifiableAlgo)
    algo_repr = sprint(show, getalgorithm(sa))
    print(io, IdentifiableAlgo_label(sa), ": ", algo_repr)
    @static if debug_mode()
        print(io, " [staticmatch_by=", staticmatch_by(sa), "]")
    end
end
