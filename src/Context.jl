abstract type AbstractContext end
abstract type AbstractSubContext end



"""
For every type register possible names and last updated name
"""
struct UpdateRegistry{Types, T}
    entries::T
end

"""
Defines static routes between different subcontexts
"""
struct Route{From, To, Varnames} end

struct SharedState{name} end
contextname(st::Type{SharedState{name}}) where {name} = name
contextname(st::SharedState{name}) where {name} = name

struct SubContext{Name,T<:NamedTuple, S, R, Reg} <: AbstractSubContext
    data::T
    shared::S #Can write to
    routes::R #Cant write to, just read
    registry::Reg
end

@inline get_datatype(sc::Type{<:SubContext}) = sc.parameters[2]
@inline getshared_types(sct::Type{<:SubContext}) where {T} = T.parameters[3]
@inline getroute_types(sct::Type{<:SubContext}) where {T} = T.parameters[4]

@inline Base.pairs(sc::SubContext) = pairs(sc.data)
@inline Base.getproperty(sc::SubContext, name::Symbol) = getproperty(sc.data, name)
@inline function Base.merge(sc::SubContext{Name}, args::NamedTuple) where Name
    merged = merge(sc.data, args)
    SubContext{Name,typeof(merged)}(merged)
end
@inline function Base.merge(args::NamedTuple, sc::SubContext{Name}) where Name
    merged = merge(args, sc.data)
    SubContext{Name,typeof(merged)}(merged)
end

"""
Previously args system
This stores the context of a process
"""
struct ProcessContext{D} <: AbstractContext
    data::D
end

# @inline subcontext_keys(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldnames(fieldtype(pc.data, name).data)
# @inline function subcontext_keys(c_type::Type{ProcessContext{D}}, v::Val{Name}) where {D, Name}
#     subcontext_type = fieldtype(c_type.data, Name)
#     return fieldnames(subcontext_type.parameters[2])
# end
@inline subcontext_keys(pc::ProcessContext{D}, name::Symbol) where {D} = @inline fieldnames(fieldtype(pc.data, name).data)
@inline subcontext_type(pc::ProcessContext{D}, name::Symbol) where {D} = fieldtype(pc.data, name)


@inline function isasubcontext(pc::Type{<:ProcessContext}, v::Val{s}) where {s<:Symbol}
    return fieldtype(pc.data, s) <: SubContext
end
@inline isasubcontext(pc::ProcessContext, s::Symbol) = isasubcontext(typeof(pc), Val(s))
@inline isasubcontext(pc::Type{<:ProcessContext}, s::Symbol) = isasubcontext(pc, Val(s))

### BASE EXTENSIONS
@inline function Base.merge(pc::ProcessContext, args::NamedTuple)
    merged = merge(pc.data, args)
    ProcessContext{typeof(merged), typeof(pc.reg), typeof(pc.routes)}(merged, pc.reg, pc.routes)
end

@inline function Base.merge(args::NamedTuple, pc::ProcessContext)
    merged = merge(args, pc.data)
    ProcessContext{typeof(merged), typeof(pc.reg), typeof(pc.routes)}(merged, pc.reg, pc.routes)
end

@inline Base.pairs(pc::ProcessContext) = pairs(pc.data)
@inline Base.getproperty(pc::ProcessContext, name::Symbol) = getproperty(pc.data, name)
###

#### Subcontext views ####
struct SubContextView{CType, SubName}
    context::CType
end

@inline subcontext_type(scv::SubContextView{CType, SubName}) where {CType<:ProcessContext, SubName} = fieldtype(CType, SubName)
@inline subcontext_type(scvt::Type{<:SubContextView{CType, SubName}}) where {CType<:ProcessContext, SubName} = fieldtype(CType, SubName)

@inline function these_keys(::Type{<:SubContextView{CType, SubName}}) where {CType<:ProcessContext, SubName}
    subcontext_type = fieldtype(CType, SubName)
    return fieldnames(get_datatype(subcontext_type))
end

@inline function get_keys(::Type{<:SubContextView{CType, SubName}}, v::Val{Name}) where {Name, CType, Name}
    context_type = fieldtype(CType, data)
    subcontext_type = fieldtype(context_type, Name)
    return fieldnames(get_datatype(subcontext_type))
end

@inline function pairset(namedtuples::NamedTuple...)
    merged = @inline merge(namedtuples...)
    return @inline pairs(merged)
end

@generated function merge(scv::SubContextView{CType, SubName}, args::NamedTuple) where {CType<:ProcessContext, SubName}
    this_subcontext = context_type(scv)
    _these_keys = these_keys(typeof(scv))
    keys_to_merge = fieldnames(args)
    shared_names = getname.(getshared_types(this_subcontext).parameters)


end

getcontext()








