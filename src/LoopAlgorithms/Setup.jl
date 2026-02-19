"""
Call a LoopAlgorithm as:

LoopAlgorithm(  func1, func2, func3, ..., 
                tuple(interval1, interval2, interval3, ...),
                processstate1, processstate2, ..., 
                options1, option2, ...)
"""
function parse_la_input(laType::Type{<:LoopAlgorithm}, args...)
    collected_options = tuple()

    ######### ALGORITHMS #########
    if args[1] isa Tuple
        @warn "Passing algorithms as a tuple will be deprecated, please pass intervals as a separate argument after all ProcessAlgorithms, e.g. LoopAlgorithm(func1, func2, (10, 20), option1, option2). Got: $(args[1])"
        args = (args[1]..., args[2:end]...)
    end
    # First ProcessAlgorithms
    after_last_algo_idx = findlast(args) do x
        if x isa Type
            return x <: SteppableAlgorithm
        else
            return x isa SteppableAlgorithm
        end
    end
    @assert !isnothing(after_last_algo_idx) "At least one argument must be a non-ProcessAlgorithm to separate the functions from the options, but got: $(args)"
    processalgos = tuple(args[1:after_last_algo_idx]...)
    processalgos = ntuple(i -> (processalgos[i] isa ProcessEntity || processalgos[i] isa Type{<:ProcessEntity}) ? IdentifiableAlgo(processalgos[i]) : processalgos[i], length(processalgos))
    
    # Collect options from all LoopAlgorithms
    for algo in processalgos
        if algo isa LoopAlgorithm
            collected_options = (unique(collected_options)..., getoptions(algo)...)
        end
    end

    args = args[after_last_algo_idx + 1:end] # Remove the ProcessAlgorithms from the arguments list for further processing


    ######### INTERVALS #########
    # Now we should have intervals/repeats if theres more than one function
    intervals_or_repeats = nothing
    if !isempty(args)
        firstargs = args[1]

        if firstargs isa Tuple
            @assert length(firstargs) == length(processalgos) "If passing intervals as a tuple, there must be one interval per function, but got $(firstargs) for functions $(processalgos)"
            intervals_or_repeats = firstargs
            args = args[2:end] # Remove the intervals from the arguments list for further processing
        elseif laType <: CompositeAlgorithm
            intervals_or_repeats = RepeatOne{length(processalgos)}
        end

    elseif laType <: CompositeAlgorithm
        intervals_or_repeats = RepeatOne{length(processalgos)}
    else
        error("For routines, please pass the number of repeats after all ProcessAlgorithms as a tuple, even if it's just one repeat, e.g. (10,). Got: $firstargs")
    end


    ### FLATTEN ###
    if laType <: CompositeAlgorithm

        processalgos, intervals_or_repeats = flatten_comp_funcs(processalgos, tuple(intervals_or_repeats...))
        if all(x -> x == 1, intervals_or_repeats)
            intervals_or_repeats = RepeatOne{length(processalgos)}
        end
    end

    ######### PROCESS STATES #########
    first_process_states = findfirst(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), args)
    last_process_state = nothing
    pstates = tuple()
    if !isnothing(first_process_states)
        last_process_state = findlast(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), args)
        pstates = args[first_process_states:last_process_state]
        @assert all(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), pstates) "All arguments between the first and last ProcessState must be ProcessStates, but got: $(pstates)"
        pstates = tuple(IdentifiableAlgo.(pstates)...)
        args = args[last_process_state + 1:end]
    end

    options = tuple()
    if !isempty(args)
        options = tuple(args[1:end]...)
        @assert all(x -> x isa AbstractOption || x isa Type{<:AbstractOption}, options) "All arguments after the ProcessStates must be options, but got: $(options)"
    end
    options = tuple(collected_options..., options...)
    return LoopAlgorithm(laType, processalgos, pstates, options, intervals_or_repeats)
end

function setup_registry(la::LA) where LA <: LoopAlgorithm
    registry = NameSpaceRegistry()
    #add states
    states = get_states(la)
    multipliers = ntuple(i -> 1, length(states))
    registry = addall(registry, states, multipliers)

    all_funcs = @inline flat_funcs(la)
    multipliers = @inline flat_multipliers(la)
    registry = @inline addall(registry, all_funcs, multipliers)

    return registry
end