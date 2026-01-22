include("Utils.jl")
include("ComplexLoopAlgorithms.jl")
include("SimpleAlgo.jl")
include("CompositeAlgorithms.jl")
include("Routines.jl")
include("Setup.jl")
include("Prepare.jl")
include("Showing.jl")


export getname, step!, @ProcessAlgorithm, @NamedProcessAlgorithm, prepare

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

    hasargs = :context in args
    splatnames = args
    if hasargs
        splatnames = filter(x -> x != :context, args) # These are the splat args
    end

    q = quote
            struct $FFunction <: ProcessAlgorithm end

            @inline function Processes.step!(f::$FFunction, context::C) where C <: Processes.AbstractContext
                (;$(splatnames...)) = context
                @inline $FSymbol($(args...))
            end

            $ex
        end
    # println(q)
    esc(q)
end


# macro NamedProcessAlgorithm(name, ex)
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

#     hasargs = :args in args
#     splatnames = args
#     if hasargs
#         splatnames = filter(x -> x != :args, args) # These are the splat args
#     end

#     q = quote
#             struct $FFunction <: ProcessAlgorithm end

#             @inline function Processes.step!(f::$FFunction, context::C) where C <: ProcessContext
#                 (;$(splatnames...)) = context
#                 @inline $FSymbol($(args...))
#             end

#             $ex
#         end
#     println(q)
#     esc(q)

# end

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

