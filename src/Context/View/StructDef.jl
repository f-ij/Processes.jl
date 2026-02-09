
"""
A location of a variable in subcontext: subcontextname and which has the local name there: originalname
the type parameter indicates whether its a local, shared or routed variable
TODO: is type really neccesary anywhere?
"""
struct VarLocation{Type, subcontextname, originalname, func} end
VarLocation{Type}(subcontextname::Symbol, originalname::Union{Tuple, Symbol}, func = nothing) where {Type} = VarLocation{Type, subcontextname, originalname, func}()
VarLocation(type, subcontextname::Symbol, originalname::Union{Tuple, Symbol}, func = nothing) = VarLocation{type, subcontextname, originalname, func}()

@inline getfunc(vl::Union{VarLocation{T, subcontextname, originalname, func}, Type{<:VarLocation{T, subcontextname, originalname, func}}}) where {T, subcontextname, originalname, func} = func
@inline get_subcontextname(vl::Union{VarLocation{T, SCN, ON}, Type{<:VarLocation{T, SCN, ON}}}) where {T, SCN, ON} = SCN
@inline get_originalname(vl::Union{VarLocation{T, SCN, ON}, Type{<:VarLocation{T, SCN, ON}}}) where {T, SCN, ON} = ON

"""
For variable names :a, :b, :c
    create the expression :(func(:a, :b, :c)) where func is the function to apply to the variable names
"""
@inline function funcexpr(vl::Union{VL, Type{<:VL}}, 
        varnames...) where VL <: VarLocation
            func = getfunc(vl) 
            if isnothing(func)
                if length(varnames) == 1 # If no func, can only have one var
                    return :($(varnames[1]))
                else 
                    error("Error: VarLocation: $vl with a function must have exactly one variable name, got $(varnames)")
                end
            end
            return Expr(:call, func, varnames...)
end

struct SubContextView{CType, SubName, T, NT, VarAliases} <: AbstractContext
    context::CType
    instance::T # ScopedInstance for which the view is created
    injected::NT

    function SubContextView{CType, SubName, T, NT}(context::CType, instance::T; inject::NT = (;)) where {CType, SubName, T, NT}
        new{CType, SubName, T, typeof(inject), varaliases(instance)}(context, instance, inject)
    end

    function SubContextView{CType, SubName, T, NT, VarAliases}(context::CType, instance::T, inject::NT = (;)) where {CType, SubName, T, NT, VarAliases}
        new{CType, SubName, T, typeof(inject), varaliases(instance)}(context, instance, inject)
    end
end
