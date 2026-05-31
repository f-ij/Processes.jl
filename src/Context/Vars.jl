export Var
struct Var{Entity, name} end

Var(entity, name) = Var{entity, name}()
Var(name) = Var{:globals, name}()

@inline function Base.getindex(c::AbstractScopedContext, var::Var{Entity, name}) where {Entity, name}
    @inline getproperty(c[Entity], name)
end

@inline function Base.getindex(c::SubContext, vars::Var...)
    ntuple(Val(length(vars))) do i
        getindex(c, vars[i])
    end
end

@inline function Base.getindex(c::AbstractScopedContext, var::Var{:globals, name}) where {name}
    getglobals(c)[name]
end

"""
Read a DSL runtime variable selector from scoped runtime globals.
"""
@inline function Base.getindex(c::AbstractScopedContext, var::Var{:_runtime, name}) where {name}
    getglobals(c)[name]
end
