export FuncWrapper

struct ValueRef{index} end

to_expr(::ValueRef{index}, varname) where {index} = :(getindex(getproperty($varname, :values), $index))

"""
Wrap a plain function so it behaves like a `ProcessAlgorithm`.

`InputSymbols` are routed positionally, `OutputSymbols` are written back by name,
and `Kwargs` can point either to context symbols or inline literal values.
"""
mutable struct FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs, T} <: ProcessAlgorithm
    func::F
    values::T
end

function _funcwrapper_encode_inputs(inputs)
    literal_values = Any[]
    literal_idx = 0
    encoded = ntuple(length(inputs)) do i
        input = inputs[i]
        if input isa Symbol
            input
        else
            literal_idx += 1
            push!(literal_values, input isa QuoteNode ? input.value : input)
            ValueRef{literal_idx}()
        end
    end
    return encoded, tuple(literal_values...)
end

inputsymbols_to_exprs(inputs, varname) = (inputs[i] isa Symbol ? :($(inputs[i])) : to_expr(inputs[i], varname) for i in 1:length(inputs))
context_input_symbols(inputs) = tuple((x for x in inputs if x isa Symbol)...)

@generated function step!(fw::FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs, T}, context::C) where {F, InputSymbols, OutputSymbols, Kwargs, T, C}
    positional_names = context_input_symbols(InputSymbols)
    kwargnames = keys(Kwargs)
    kwargvals = values(Kwargs)
    kwargvalnames = tuple((x for x in kwargvals if x isa Symbol)...)
    kwexprs = (Expr(:kw, kwargnames[i], kwargvals[i]) for i in 1:length(kwargnames))
    call_expr = :(fw.func($(inputsymbols_to_exprs(InputSymbols, :fw)...); $(kwexprs...)))
    output_assignment = isempty(OutputSymbols) ? call_expr : :($(OutputSymbols...) = $call_expr)
    return_expr = isempty(OutputSymbols) ? :(return (;)) : :(return (;$(OutputSymbols...)))
    return quote
        (;$(positional_names...), $(kwargvalnames...)) = context
        $output_assignment
        $return_expr
    end
end

@inline init(::FuncWrapper, context) = (;)

function FuncWrapper(f::F, inputs, outputsyms::NTuple{M, Symbol}) where {F, M}
    newinputs, values = _funcwrapper_encode_inputs(inputs)
    FuncWrapper{F, newinputs, outputsyms, NamedTuple(), typeof(values)}(f, values)
end

function FuncWrapper(f::F, inputs::Tuple, outputsyms::NTuple{M, Symbol}, kwargs::NamedTuple) where {F, M}
    newinputs, values = _funcwrapper_encode_inputs(inputs)
    FuncWrapper{F, newinputs, outputsyms, kwargs, typeof(values)}(f, values)
end

function FuncWrapper(f::F, inputs, outputsyms::NTuple{M, Symbol}, kwargs::NTuple{K, Symbol}) where {F, M, K}
    newinputs, values = _funcwrapper_encode_inputs(inputs)
    same_name_kwargs = NamedTuple{kwargs}(kwargs)
    FuncWrapper{F, newinputs, outputsyms, same_name_kwargs, typeof(values)}(f, values)
end
