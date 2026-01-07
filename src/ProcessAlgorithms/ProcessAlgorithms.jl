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
getname(::Any) = nothing

function needsname(a::Any)
    isnothing(getname(a))
end

needsname(::CompositeAlgorithm) = false
needsname(::Routine) = false
needsname(::SimpleAlgo) = false

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

            function Processes.step!(f::$FFunction, args::NT) where NT <: NamedTuple
                (;$(splatnames...)) = args
                @inline $FSymbol($(args...))
            end

            $ex
        end
    println(q)
    esc(q)
end


macro NamedProcessAlgorithm(name, ex)
    # Expand the ProcessAlgorithm macro in the calling module's context
    newex = macroexpand(__module__, :(@ProcessAlgorithm($ex)))
    push!(newex.args, quote 
        getname(::$FFunction) = $name
    end)
    println(newex)
    return esc(newex)
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
#                 return NamedAlgorithm($name, $FFunction())
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

function _prepare(inputargs, named_algohead::NamedAlgorithm, tail::Any...)
    temp_prepare_args = (;_instance = getalgorithm(named_algohead), inputargs...)
    prepared_args_algo = prepare(getalgorithm(named_algohead), temp_prepare_args)

    runtimeargs = (;inputargs..., getname(named_algohead) => (;_instance = named_algohead, prepared_args_algo...))
    (;runtimeargs..., _prepare(inputargs, tail...)...)
end

function _prepare(inputargs, na::NamedAlgorithm)
    temp_prepare_args = (;_instance = getalgorithm(na), inputargs...)
    prepared_args_algo = prepare(getalgorithm(na), temp_prepare_args)

    (;inputargs..., getname(na) => (;_instance = na, prepared_args_algo...))
end
# function cleanup(pa::Union{CompositeAlgorithm, Routine}, args)
#     prepare_helper = PrepereHelper(pa, args)
#     cleanup(prepare_helper, args)
# end

