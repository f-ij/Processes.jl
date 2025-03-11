

export UniqueAlgoTracker, add_algorithm!, unique_algorithms

"""
Tracks the number of unique algorithms, and how many times they will be
repeated
"""
mutable struct UniqueAlgoTracker{PA}
    const pa::PA
    const counts::Dict{Any, Int}
    const repeats::Dict{Any, Float64}
    current::Int
end

function UniqueAlgoTracker(pa::ProcessLoopAlgorithm)
    ua = UniqueAlgoTracker(pa, Dict{Any, Int}(), Dict{Any, Float64}(), 1)
    for i in 1:num_leafs(pa)
        add_algorithm!(ua, getleaf(pa, i), getrepeats(pa, i))
    end
    ua
end

function UniqueAlgoTracker(pa::SimpleAlgo)
    ua = UniqueAlgoTracker(pa, Dict{Any, Int}(), Dict{Any, Int}(), 1)
    add_algorithm!(ua, pa, 1)
    ua
end

function add_algorithm!(ua::UniqueAlgoTracker, algo, repeats)
    if !haskey(ua.counts, algo)
        ua.counts[algo] = 1
        ua.repeats[algo] = repeats
    else
        ua.counts[algo] += 1
        ua.repeats[algo] += repeats
    end
end
Base.getindex(ua::UniqueAlgoTracker, idx) = collect(keys(ua.counts))[idx]
unique_algorithms(ua::UniqueAlgoTracker) = keys(ua.counts)
total_repeats(ua::UniqueAlgoTracker) = ua.repeats
getalgo(ua::UniqueAlgoTracker, idx) = getindex(ua, idx)
this_algo(args) = getalgo(args.ua, args.ua.current)

function next!(ua::UniqueAlgoTracker)
    ua.current += 1
end

currentalgo(ua::UniqueAlgoTracker) = getalgo(ua, ua.current)
current_repeats(ua::UniqueAlgoTracker) = ua.repeats[currentalgo(ua)]
current_counts(ua::UniqueAlgoTracker) = ua.counts[currentalgo(ua)]


iterate(ua::UniqueAlgoTracker, state = 1) = state > length(unique_algorithms(ua)) ? nothing : (next!(ua), state + 1)


function prepare(ua::UniqueAlgoTracker, args)
    returnargs = (;)
    for a in unique_algorithms(ua)
        newargs = prepare(a, (;args..., ua))            # Add algo tracker to args
        overlap = intersect(keys(returnargs), keys(newargs))  # Find wether there are overlapping keys between the algorithms
        @static if DEBUG_MODE
            println("Preparing arguments using the UniqueAlgoTracker for algorithm $a")
            println("Keys of args are: $(keys(args))")
            println("Keys of new args are: $(keys(newargs))")
        end
        if !isempty(overlap)
            @warn "Multiple algorithms define the same arguments: $overlap. \n Only one of them will be used with a random order."
        end
        returnargs = (;returnargs..., newargs...)                  # Add the new arguments to the existing ones
        next!(ua)                                      # Move to the next algorithm  
    end
    inputoverlap = intersect(keys(args), keys(returnargs))
    if !isempty(inputoverlap)
        @warn "An algorithm is providing arguments that are already defined in the input arguments: $inputoverlap. \n The algorithm arguments will be used."
    end
    returnargs = (;args..., returnargs...)
    return deletekeys(returnargs, :ua)
end

function cleanup(ua::UniqueAlgoTracker, args)
    for a in unique_algorithms(ua)
        newargs = cleanup(a, (;args..., ua))
        overlap = intersect(keys(args), keys(newargs))
        filter!(x -> getproperty(newargs, x) != getproperty(args, x), overlap)
        if !isempty(overlap)
            @warn "Multiple algorithms clean up providing unique arguments with the same name: $overlap. \n Returning all of them with a unique name."
            algomap = (overlap[i] => Symbol(overlap[i], "_", currentalgo(ua)) for i in 1:length(overlap))
            newargs = renamekeys(newargs, algomap...)
        end
        args = (;args..., newargs...)
        next!(ua)
    end
    returnargs = deletekeys(args, :ua)
    return returnargs
end

