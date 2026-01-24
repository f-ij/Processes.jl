#=
Container trait
Non containers return themselves as contained type

Containers return the type they contain as contained type
=#
##########################
# Recursive thin containers
##########################
thincontainer(a::Type{<:Any}) = false

##
# Fallback for non-containers
# Implement _unwrap_container(v::Value)
#           _contained_type(::Type{<:A})
##
contained_type(a::T) where {T} = contained_type(T)
function contained_type(a::Type{<:Any})
    if thincontainer(a)
        return contained_type(_contained_type(a))
    else
        return a
    end
end

"""
Recursive unwrapping of containers
"""
function unwrap_container(a::A) where {A}
    if thincontainer(A)
        return unwrap_container(_unwrap_container(a))
    else
        return a
    end
end

function full_unwrap_container(a::A, returntup = ()) where {A}
    if thincontainer(A)
        returntup = (returntup..., a) # Store current level
        return full_unwrap_container(_unwrap_container(a), returntup)
    else
        return (returntup..., a)
    end
end

function isinstance(a::A, b::B) where {A, B}
    if thincontainer(A)
        return isinstance(_unwrap_container(a), b)
    elseif thincontainer(B)
        return isinstance(a, _unwrap_container(b))
    else
        return a === b
    end
end