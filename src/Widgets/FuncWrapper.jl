export FuncWrapper

struct ValueRef{index, T} end

to_expr(::ValueRef{index, T}, varname) where {index, T} = :((getindex(getproperty($varname, :values), $index))::$T)
@inline _valueref_index(::ValueRef{index, T}) where {index, T} = index

"""
Wrap a plain function so it behaves like a `ProcessAlgorithm`.

`InputSymbols` are routed positionally, `OutputSymbols` are written back by name,
and `Kwargs` can point either to context symbols or inline literal values.
"""
mutable struct FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs, T} <: ProcessAlgorithm
    func::F
    values::T
    display::Any
end

@inline _funcwrapper_render_value(value; io::IO = stdout) = sprint(show, value; context = io)

@inline function _funcwrapper_render_display(value; io::IO = stdout)
    if value isa Symbol
        return string(value)
    elseif value isa QuoteNode
        return _funcwrapper_render_value(value.value; io)
    elseif value isa Expr
        rendered = sprint(show, value)
        if startswith(rendered, ":(") && endswith(rendered, ")")
            first_idx = nextind(rendered, 2)
            last_idx = prevind(rendered, lastindex(rendered))
            return first_idx > last_idx ? "" : String(SubString(rendered, first_idx, last_idx))
        end
        return rendered
    else
        return _funcwrapper_render_value(value; io)
    end
end

@inline function _funcwrapper_render_input(input, values; io::IO = stdout)
    if input isa Symbol
        return string(input)
    else
        return _funcwrapper_render_value(values[_valueref_index(input)]; io)
    end
end

@inline function _funcwrapper_signature_parts(
    ::Type{<:FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs}},
    display;
    io::IO = stdout,
) where {F, InputSymbols, OutputSymbols, Kwargs}
    positional = [_funcwrapper_render_display(input; io) for input in display.positional]
    kwargs_rendered = [string(name, " = ", _funcwrapper_render_display(value; io)) for (name, value) in pairs(display.kwargs)]
    outputs = isempty(OutputSymbols) ? "nothing" : "(; " * join(string.(OutputSymbols), ", ") * ")"
    return positional, kwargs_rendered, outputs
end

@inline function _funcwrapper_signature_string(fw::FuncWrapper; io::IO = stdout)
    positional, kwargs_rendered, outputs = _funcwrapper_signature_parts(typeof(fw), getfield(fw, :display); io)
    args = if isempty(kwargs_rendered)
        join(positional, ", ")
    elseif isempty(positional)
        "; " * join(kwargs_rendered, ", ")
    else
        join(positional, ", ") * "; " * join(kwargs_rendered, ", ")
    end
    return "(" * args * ") -> " * outputs
end

@inline _funcwrapper_callable_label(f) = sprint(show, f)
@inline _identifiable_funcwrapper_label(sa::IdentifiableAlgo{F}) where {F<:FuncWrapper} = isnothing(algoname(sa)) ? string(getkey(sa)) : string(algoname(sa), "@", getkey(sa))

@inline _funcwrapper_display_bundle(inputs::Tuple, kwargs::NamedTuple) = (; positional = inputs, kwargs)
@inline _funcwrapper_default_display_inputs(inputs) = tuple(inputs...)

function _funcwrapper_encode_inputs(inputs)
    literal_values = Any[]
    literal_idx = 0
    encoded = ntuple(length(inputs)) do i
        input = inputs[i]
        if input isa Symbol
            input
        else
            value = input isa QuoteNode ? input.value : input
            literal_idx += 1
            push!(literal_values, value)
            ValueRef{literal_idx, typeof(value)}()
        end
    end
    return encoded, tuple(literal_values...)
end

inputsymbols_to_exprs(inputs, varname) = (inputs[i] isa Symbol ? :($(inputs[i])) : to_expr(inputs[i], varname) for i in 1:length(inputs))
context_input_symbols(inputs) = tuple((x for x in inputs if x isa Symbol)...)

@inline @generated function step!(fw::FuncWrapper{F, InputSymbols, OutputSymbols, Kwargs, T}, context::C) where {F, InputSymbols, OutputSymbols, Kwargs, T, C}
    positional_names = context_input_symbols(InputSymbols)
    kwargnames = keys(Kwargs)
    kwargvals = values(Kwargs)
    kwargvalnames = tuple((x for x in kwargvals if x isa Symbol)...)
    kwexprs = (Expr(:kw, kwargnames[i], kwargvals[i]) for i in 1:length(kwargnames))
    call_expr = :(@inline fw.func($(inputsymbols_to_exprs(InputSymbols, :fw)...); $(kwexprs...)))
    output_assignment = isempty(OutputSymbols) ? call_expr : :($(OutputSymbols...) = $call_expr)
    return_expr = isempty(OutputSymbols) ? :(return (;)) : :(return (;$(OutputSymbols...)))
    quote
        (;$(positional_names...), $(kwargvalnames...)) = context
        $output_assignment
        $return_expr
    end
end

@inline init(::FuncWrapper, context) = (;)

function _funcwrapper_construct(f::F, inputs, outputsyms::NTuple{M, Symbol}, kwargs::NamedTuple, display_inputs::Tuple, display_kwargs::NamedTuple) where {F, M}
    newinputs, values = _funcwrapper_encode_inputs(inputs)
    display = _funcwrapper_display_bundle(display_inputs, display_kwargs)
    FuncWrapper{F, newinputs, outputsyms, kwargs, typeof(values)}(f, values, display)
end

function FuncWrapper(f::F, inputs, outputsyms::NTuple{M, Symbol}) where {F, M}
    _funcwrapper_construct(f, inputs, outputsyms, NamedTuple(), _funcwrapper_default_display_inputs(inputs), NamedTuple())
end

function FuncWrapper(f::F, inputs::Tuple, outputsyms::NTuple{M, Symbol}, kwargs::NamedTuple) where {F, M}
    _funcwrapper_construct(f, inputs, outputsyms, kwargs, _funcwrapper_default_display_inputs(inputs), kwargs)
end

function FuncWrapper(f::F, inputs::Tuple, outputsyms::NTuple{M, Symbol}, kwargs::NamedTuple, display_inputs::Tuple, display_kwargs::NamedTuple) where {F, M}
    _funcwrapper_construct(f, inputs, outputsyms, kwargs, display_inputs, display_kwargs)
end

function FuncWrapper(f::F, inputs, outputsyms::NTuple{M, Symbol}, kwargs::NTuple{K, Symbol}) where {F, M, K}
    same_name_kwargs = NamedTuple{kwargs}(kwargs)
    _funcwrapper_construct(f, inputs, outputsyms, same_name_kwargs, _funcwrapper_default_display_inputs(inputs), same_name_kwargs)
end

function Base.summary(io::IO, fw::FuncWrapper)
    print(io, "FuncWrapper(", _funcwrapper_signature_string(fw; io), ")")
end

function Base.show(io::IO, fw::FuncWrapper)
    print(
        io,
        "FuncWrapper(",
        _funcwrapper_signature_string(fw; io),
        ", ",
        _funcwrapper_callable_label(getfield(fw, :func)),
        ")",
    )
end

function Base.show(io::IO, ::MIME"text/plain", fw::FuncWrapper)
    println(io, "FuncWrapper")
    println(io, "├── signature = ", _funcwrapper_signature_string(fw; io))
    print(io, "└── function = ", _funcwrapper_callable_label(getfield(fw, :func)))
    return nothing
end

function Base.show(io::IO, sa::IdentifiableAlgo{F}) where {F<:FuncWrapper}
    fw = getalgo(sa)
    print(
        io,
        _identifiable_funcwrapper_label(sa),
        ": ",
        _funcwrapper_callable_label(getfield(fw, :func)),
        " :: ",
        _funcwrapper_signature_string(fw; io),
    )
    @static if debug_mode()
        print(io, " [match_by=", match_by(sa), "]")
    end
end
