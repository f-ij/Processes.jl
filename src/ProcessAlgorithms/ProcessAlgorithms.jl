include("Utils.jl")
include("NamedAlgorithms.jl")
include("Registry.jl")
include("SimpleAlgo.jl")
include("CompositeAlgorithms.jl")
include("Routines.jl")

export getname, step!, @ProcessAlgorithm, @NamedProcessAlgorithm, prepare

"""
Can be used to set a name
"""
@inline function getname(a::Any)
    if !(a isa Type)
        a = typeof(a)
        return getname(a)
    end
    nothing
end

@inline function needsname(a::Any)
    isnothing(getname(a))
end

@inline needsname(::CompositeAlgorithm) = false
@inline needsname(::Routine) = false
@inline needsname(::SimpleAlgo) = false

@inline function getnamespace(args::NamedTuple, obj)
    thisname = @inline getname(obj)
    if isnothing(thisname)
        return args
    else
        return getproperty(args, thisname)
    end
end

@inline function mergenamespace(args::NamedTuple, newargs, name)
    namespaced_args = get(args, name, (;))
    (;args..., name => (;namespaced_args..., newargs...))
end


"""
Macro to define a ProcessAlgorithm from a function definition.
    This creates a struct of the function name subtype of ProcessAlgorithm,
    with an implicit step! method that calls the function with the provided arguments.    
"""
macro ProcessAlgorithm(ex)
    @capture(ex, function F_(args__) body_ end )
    # Get the function name from the expression
    Fname = F
    FFunction = F
    FSymbol = F

    

    ## Handle type annotated functions
    if F isa Expr && F.head == :(::)
        Fname = F.args[1]
        FFunction = Expr(:(::), :f, Fname)
        FSymbol = :f
    end

    hasargs = :args in args
    splatnames = args
    if hasargs
        splatnames = filter(x -> x != :args, args) # These are the splat args
    end

    q = quote
            struct $FFunction <: ProcessAlgorithm end

            @inline function Processes.step!(f::$FFunction, args::NT) where NT <: NamedTuple
                (;$(splatnames...)) = args
                @inline $FSymbol($(args...))
            end

            $ex
        end
    println(q)
    esc(q)
end


macro NamedProcessAlgorithm(name, ex)
    @capture(ex, function F_(args__) body_ end )
    # Get the function name from the expression
    Fname = F
    FFunction = F
    FSymbol = F

    

    ## Handle type annotated functions
    if F isa Expr && F.head == :(::)
        Fname = F.args[1]
        FFunction = Expr(:(::), :f, Fname)
        FSymbol = :f
    end

    hasargs = :args in args
    splatnames = args
    if hasargs
        splatnames = filter(x -> x != :args, args) # These are the splat args
    end

    q = quote
            struct $FFunction <: ProcessAlgorithm end

            @inline function Processes.step!(f::$FFunction, args::NT) where NT <: NamedTuple
                (;$(splatnames...)) = args
                @inline $FSymbol($(args...))
            end

            Processes.getname(::Type{$FFunction}) = $(QuoteNode(name))

            $ex
        end
    println(q)
    esc(q)

end

# macro ProcessAlgorithm(ex)
#     @capture(ex, function F_(args__) body_ end )
#     # Get the function name from the expression
#     Fname = F
#     FFunction = F
#     FSymbol = F

#     ## Handle type annotated functions
#     if F isa Expr && F.head == :(::)
#         Fname = F.args[1]
#         FFunction = Expr(:(::), :f, Fname)
#         FSymbol = :f
#     end

#     # Add args to the args__ in the expression using postwalk; every Processalgorithms also passes args explicitly
#     ex = MacroTools.postwalk(ex) do node
#         c = @capture(node, function cF_(cargs__) body_ end )
#         if c
#             return :(function $(cF)($(cargs...), args::NT = (;)) where NT <: NamedTuple; $(body) end)
#         else
#             return node
#         end
#     end
#     println("ex:",ex)
#     q = quote
#             struct $FFunction <: ProcessAlgorithm end

#             function (::$FFunction)(args::NT) where NT <: NamedTuple
#                 (;$(args...)) = args
#                 @inline $FSymbol($(args...), args)
#             end
            
#             $ex
#         end
#     println(q)
#     esc(q)
# end



# macro NamedProcessAlgorithm(name, ex)
#     # Reuse the ProcessAlgorithm macro to define the function
#     newex = @ProcessAlgorithm(ex)
#     push!(newex.args, quote function $FFunction() 
#                 return ScopedAlgorithm($name, $FFunction())
#             end
#         end)
#     println(newex)
#     return esc(newex)
# end

export @ProcessAlgorithm, @NamedProcessAlgorithm


# function prepare(pa::Union{CompositeAlgorithm, Routine}, args)
#     prepare_helper = PrepereHelper(pa, args)
#     prepare(prepare_helper, args)
# end

function prepare(cla::ComplexLoopAlgorithm, inputargs)
    namespace_registry = getregistry(cla)
    inputargs = (;inputargs..., algo = cla)
    runtimeargs = prepare(namespace_registry, inputargs)
end

function prepare(nsr::NameSpaceRegistry, inputargs)
    named_algos = Iterators.Flatten(nsr)
    runtimeargs = _prepare(inputargs, named_algos...)
end

function _prepare(inputargs::NamedTuple, named_algohead::ProcessAlgorithm, tail::Any...)
    @assert hasname(named_algohead)

    temp_prepare_args = (;_instance = getalgorithm(named_algohead), inputargs...)
    prepared_args_algo = prepare(getalgorithm(named_algohead), temp_prepare_args)

    namespace_name = getname(named_algohead)
    runtime_args = mergenamespace(inputargs, prepared_args_algo, namespace_name)

    _prepare(runtime_args, tail...)
end

function _prepare(args::NamedTuple, na::ProcessAlgorithm)
    @assert hasname(na)
    
    temp_prepare_args = (;_instance = getalgorithm(na), args...)
    prepared_args_algo = prepare(getalgorithm(na), temp_prepare_args)

    namespace_name = getname(na)
    runtime_args = mergenamespace(args, prepared_args_algo, namespace_name)

    return runtime_args
end
# function cleanup(pa::Union{CompositeAlgorithm, Routine}, args)
#     prepare_helper = PrepereHelper(pa, args)
#     cleanup(prepare_helper, args)
# end
