export Var
struct Var{Entity, name} end

Var(entity, name) = Var{entity, name}()

@inline function Base.getindex(c::ProcessContext, var::Var{Entity, name}) where {Entity, name}
    @inline getproperty(c[Entity], name)
end

@inline function Base.getindex(c::SubContext, vars::Var...)
    ntuple(Val(length(vars))) do i
        getindex(c, vars[i])
    end
end