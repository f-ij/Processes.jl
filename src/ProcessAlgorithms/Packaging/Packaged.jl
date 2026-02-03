#=
Mirrors
  struct CompositeAlgorithm{T, Intervals, NSR, O, id, CustomName} <: LoopAlgorithm
    funcs::T
    inc::Base.RefValue{Int} # To track the intervals
    registry::NSR
    options::O
  end

But works like a ProcessAlgorithm, options wont work since SubContext is fully shared
=#
struct PackagedAlgo{T, Intervals, NSR, id, CustomName}
    funcs::T
    inc::Base.RefValue{Int} # To track the intervals
    registry::NSR
end

function PackagedAlgo(funcs::NTuple{N, Any}, 
                            intervals::NTuple{N, Real} = ntuple(_ -> 1, N);
                            id = uuid4(), customname = Symbol()
                            ) where {N}
    (;functuple, registry) = setup(CompositeAlgorithm, funcs, intervals)
    if all(x -> x == 1, intervals)
        intervals = RepeatOne() # Set to simpleAlgo
    end
    PackagedAlgo{typeof(functuple), intervals, typeof(registry), id, customname}(functuple, Ref(1), registry)
end

function PackagedAlgo(comp::CompositeAlgorithm, name = "")
    flatfuncs, flatintervals = flatten(comp)

    # Translate routes to VarAliases
    ###
    ###

    ## If shares are used, error and suggest using varaliases
    ## TODO: Support autoalias (e.g. all variables get a postfix)


    PackagedAlgo(flatfuncs, flatintervals, customname = name)
end
