include("Utils.jl")
include("LoopAlgorithms.jl")
include("GetFirst.jl")
include("CompositeAlgorithms.jl")
include("SimpleAlgo.jl")
include("Routines.jl")
include("Setup.jl")
include("Prepare.jl")
# include("Step.jl")
include("GeneratedStep.jl")
include("Fusing/Fusing.jl")
include("IsBitsStorage.jl")
include("Widgets.jl")

include("Showing.jl")



export SimpleAlgo, CompositeAlgorithm, Routine
export getname, step!, @ProcessAlgorithm, @NamedProcessAlgorithm, prepare

"""
Macro to define a ProcessAlgorithm from a function definition.
    This creates a struct of the function name subtype of ProcessAlgorithm,
    with an implicit step! method that calls the function with the provided arguments.    
"""
macro ProcessAlgorithm(ex)
    F, args, body = nothing, nothing, nothing
    @capture(ex, function F_(args__) body_ end )
    if isnothing(F)
        @capture(ex, function F_(args__) where W_ body_ end )
    end
    if isnothing(F)
       @capture(ex, function F_(args__) where {W__} body_ end )
    end

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

    splatnames = args
    splatnames = map(name -> name isa Expr && name.head == :(::) ? name.args[1] : name, splatnames)
    splatnames = filter(x -> x != :context, splatnames) # These are the splat args


    typeless_args = map(arg -> arg isa Expr && arg.head == :(::) ? arg.args[1] : arg, args)

    q = quote
            struct $FFunction <: ProcessAlgorithm end

            @inline function Processes.step!(f::$FFunction, context::C) where C <: Processes.AbstractContext
                $(LineNumberNode(__source__.line, __source__.file))
                (;$(splatnames...)) = context
                @inline $FSymbol($(typeless_args...))
            end

            $ex
        end
    # println(q)
    esc(q)
end

export @ProcessAlgorithm, @NamedProcessAlgorithm


# function prepare(pa::Union{CompositeAlgorithm, Routine}, args)
#     prepare_helper = PrepereHelper(pa, args)
#     prepare(prepare_helper, args)
# end
