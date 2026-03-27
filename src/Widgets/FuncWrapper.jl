export FuncWrapper

"""
Wrap a plain function so it behaves like a `ProcessAlgorithm`.

`InputSymbols` are routed positionally, `OutputSymbols` are written back by name,
and `Kwargs` can point either to context symbols or inline literal values.
"""
struct FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs} <: ProcessAlgorithm
    func::F
end

@generated function step!(fw::FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs}, context::C) where {F, InputSymbols, OutputSymbols, Kwargs, C}
    kwargnames = keys(Kwargs)
    kwargvals = values(Kwargs)
    kwargvalnames = filter(x -> x isa Symbol, kwargvals)
    kwexprs = (Expr(:kw, kwargnames[i], kwargvals[i]) for i in 1:length(kwargnames))
    return quote
        (;$(InputSymbols...), $(kwargvalnames...)) = context
        $(OutputSymbols...) = fw.func($(InputSymbols...); $(kwexprs...))
        return (;$(OutputSymbols...))
    end
    # error( quote
    #     (;$(InputSymbols...), $(kwargvalnames...)) = context
    #     $(OutputSymbols...) = fw.func($(InputSymbols...); $(kwexprs...))
    #     return (;$(OutputSymbols...))
    # end)
end

@generated function init(fw::FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs}, context::C) where {F, InputSymbols, OutputSymbols, Kwargs, C}
    kwargnames = keys(Kwargs)
    kwargvals = values(Kwargs)
    kwargvalnames = filter(x -> x isa Symbol, kwargvals)
    kwexprs = (Expr(:kw, kwargnames[i], kwargvals[i]) for i in 1:length(kwargnames))
    return quote
        try
            # During init the routed inputs may not exist yet. In that case we just
            # skip seeding this wrapper and let step! populate it later.
            (;$(InputSymbols...), $(kwargvalnames...)) = context
            $(OutputSymbols...) = fw.func($(InputSymbols...); $(kwexprs...))
            return (;$(OutputSymbols...))
        catch
            return (;)
        end
    end
end

function FuncWrapper(f::F, inputsyms::NTuple{N, Symbol}, outputsyms::NTuple{M, Symbol}) where {F, N, M}
    FuncWrapper{F, inputsyms, outputsyms, NamedTuple()}(f)
end

function FuncWrapper(f::F, inputsyms::NTuple{N, Symbol}, outputsyms::NTuple{M, Symbol}, kwargs::NamedTuple) where {F, N, M}
    FuncWrapper{F, inputsyms, outputsyms, kwargs}(f)
end

function FuncWrapper(f::F, inputsyms::NTuple{N, Symbol}, outputsyms::NTuple{M, Symbol}, kwargs::NTuple{K, Symbol}) where {F, N, M, K}
    same_name_kwargs = NamedTuple{kwargs}(kwargs)
    FuncWrapper{F, inputsyms, outputsyms, same_name_kwargs}(f)
end
