#=
Container trait
Non containers return themselves as contained type

Containers return the type they contain as contained type
=#
##########################
# Recursive thin containers
##########################
thincontainer(a::Type{<:Any}) = false
thincontainer(a::Any) = thincontainer(typeof(a))

##
# Implement _unwrap_container(v::Value)
#           _contained_type(::Type{<:A})
# optional: (val::A)(inner::B) to rebuild
##
contained_type(a::T) where {T} = contained_type(T)

"""

"""
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

"""
Findfirst, but unwraps thin containers and returns the first matching inner value
"""
function getfirst(matching_f, a::A) where {A}
    if thincontainer(A)
        if matching_f(a)
            return a
        else
            return getfirst(matching_f, _unwrap_container(a))
        end
    else
        if matching_f(a)
            return a
        else
            return nothing
        end
    end
end

"""
Replace the wrappers at each level according to matching and replacement functions
    Then rebuild to the left
"""
function rebuild_from(matching_f, replacement_f, a::A) where {A}
    if !thincontainer(A)
        return a
    end
    levels = full_unwrap_container(a)
    level = 0
    replaced = nothing
    for l in levels
        if matching_f(l)
            replaced = replacement_f(l)
            break
        else
            level += 1
        end
    end
    if isnothing(replaced)
        return a
    end

    for l in level:-1:1 # Rebuild
        replaced = levels[l](replaced)
    end

    return replaced
end