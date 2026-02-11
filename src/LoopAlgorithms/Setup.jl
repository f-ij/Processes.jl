"""
Call a LoopAlgorithm as:

LoopAlgorithm(  func1, func2, func3, ..., 
                tuple(interval1, interval2, interval3, ...),
                processstate1, processstate2, ..., 
                options1, option2, ...)
"""
function parse_la_input(laType::Type{<:LoopAlgorithm}, args...)
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
    # @assert all(x -> x isa ProcessAlgorithm, processalgos) "All arguments before the first non-ProcessAlgorithm must be ProcessAlgorithms, but got: $(processalgos)"

    # Now we should have intervals/repeats if theres more than one function
    intervals_or_repeats = nothing

    if length(args) > after_last_algo_idx
        after_algo = args[after_last_algo_idx + 1]

        if after_algo isa Tuple
            @assert length(after_algo) == length(processalgos) "If passing intervals as a tuple, there must be one interval per function, but got $(after_algo) for functions $(processalgos)"
            intervals_or_repeats = after_algo
        elseif laType <: CompositeAlgorithm
            intervals_or_repeats = RepeatOne()
        else
            error("For routines, please pass the number of repeats after all ProcessAlgorithms as a tuple, even if it's just one repeat, e.g. (10,). Got: $after_algo")
        end
    end

    first_process_states = findfirst(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), args)
    last_process_state = nothing
    pstates = tuple()
    if !isnothing(first_process_states)
        last_process_state = findlast(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), args)
        pstates = args[first_process_states:last_process_state]
        @assert all(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), pstates) "All arguments between the first and last ProcessState must be ProcessStates, but got: $(pstates)"
        pstates = tuple(IdentifiableAlgo.(pstates)...)
    end


    options = tuple()
    if !isnothing(last_process_state) && length(args) > last_process_state
        options = tuple(args[last_process_state + 1:end]...)
    end
    return LoopAlgorithm(laType, processalgos, pstates, options, intervals_or_repeats)
end

get_loopalgorithm_registry(la::LoopAlgorithm) = getregistry(la)
get_loopalgorithm_registry(::Any) = NameSpaceRegistry()
function setup(cla_target_type::Type{<:LoopAlgorithm},funcs::NTuple{N, ProcessAlgorithm}, 
                            specification_num::NTuple{N, Real} = ntuple(_ -> 1, N), 
                            options::Union{AbstractOption, Type{<:AbstractOption}}...) where {N}

    allfuncs = Any[]
    registry = NameSpaceRegistry()
    multipliers = getmultipliers_from_specification_num(cla_target_type, specification_num)
    options_all = options

    # @assert all(map(x -> (x isa ProcessEntity || x <: ProcessEntity || x isa LoopAlgorithm), funcs)) "All functions must be ProcessEntities or LoopAlgorithms, but got: $(funcs)"

    # for (func_idx, func) in enumerate(funcs)
    #     if func isa LoopAlgorithm # Deepcopy to make multiple instances independent
    #         func = deepcopy(func)
    #     else
    #         registry, func = add(registry, func, multipliers[func_idx])
    #     end
    #     push!(allfuncs, func)
    # end

    # registry = inherit(registry, get_loopalgorithm_registry.(allfuncs)...; multipliers)
    # @DebugMode "Combined registry: $registry, after inheriting: $(get_loopalgorithm_registry.(allfuncs))"


    # process_state = filter(x -> (x isa ProcessState) || (x isa Type{<:ProcessState}), options_all)
    # registry = addall(registry, process_state)
    # @DebugMode "Adding process state options: $process_state"
    # @DebugMode "Final registry: $registry"

    # # allfuncs = recursive_update_cla_names.(allfuncs, Ref(registry))
    # allfuncs = update_keys.(allfuncs, Ref(registry))
    # @show allfuncs


    functuple = IdentifiableAlgo(funcs...)
    specification_num = tuple(floor.(Int, specification_num)...)

    # routes = filter(x -> x isa Route, options_all)
    # shares = filter(x -> x isa Share, options_all)
    # resolved_options = resolve_options(registry, options_all...)

    # shared_contexts = resolve_options(registry, shares...)
    # shared_vars = resolve_options(registry, routes...)
    (;functuple, registry, options)
end

function setup_registry(la::LA) where LA <: LoopAlgorithm
    registry = NameSpaceRegistry()
    all_funcs = @inline flat_funcs(la)
    multipliers = @inline flat_multipliers(la)
    registry = @inline addall(registry, all_funcs, multipliers)
    return registry
end