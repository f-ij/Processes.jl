abstract type Tracker end

is_decomposable(::Any) = false
is_decomposable(r::Routine) = true
is_decomposable(ca::CompositeAlgorithm) = true
# is_decomposable(sr::SubRoutine) = is_decomposable(sr.func)

# getbranch(::Any, idx) = nothing
getbranch(r::Routine, idx) = r.funcs[idx]
getbranch(ca::CompositeAlgorithm, idx) = ca.funcs[idx]
# getbranch(sr::SubRoutine, idx) = getbranch(sr.func, idx)

nbranches(::Any) = 0
nbranches(r::Routine) = length(r.funcs)
nbranches(ca::CompositeAlgorithm) = numfuncs(ca)

"""
Give the number of total leafs in the algorithm
"""
function num_leafs(pa)
    if !is_decomposable(pa)
        return 1
    end
    return sum(num_leafs(getbranch(pa,i)) for i in 1:nbranches(pa))
end

"""
Get the number of leafs in this branch
"""
function branch_leafs(pa, i)
    num_leafs(getbranch(pa, i))
end

"""
Given a linear index, find the branch that contains it
"""
function upper_branch(r, linearidx)
    branchidx = 1
    while branch_leafs(r, branchidx) < linearidx
        linearidx -= branch_leafs(r, branchidx)
        branchidx += 1
    end
    return branchidx
end

"""
Given a branch, count the number of leafs in preceding branches at the same level
"""
function sum_previous_leafs(r, branchidx)
    if branchidx == 1
        return 0
    end
    sum(branch_leafs(r, i) for i in 1:branchidx-1)
end

function getleaf(r::ProcessAlgorithm, linearidx)
    _getleaf(r, linearidx)
end

function _getleaf(r, linearidx)
    # if r isa Routine || r isa CompositeAlgorithm
    if is_decomposable(r)
        branchidx = upper_branch(r, linearidx)
        linearidx -= sum_previous_leafs(r, branchidx)
        _getleaf(getbranch(r, branchidx), linearidx)
    else
        return r
    end
end

"""
Walk through the tree sequentially
"""
getbranch(tree, idx) = tree[idx+1]

enterbranches(tree, pathidxs...) = enterbranches(getbranch(tree, gethead(pathidxs)), gettail(pathidxs)...)
enterbranches(tree) = tree

function branchpath(f, linearidx)
    if !is_decomposable(f)
        return ()
    end
    @assert linearidx <= num_leafs(f) "Index given exceeds the number of algorithms"
    branchidx = upper_branch(f, linearidx)
    return (branchidx, branchpath(getbranch(f, branchidx), linearidx - sum_previous_leafs(f,branchidx))...)
end

mutable struct AlgoBranch
    const f::ProcessAlgorithm
    const linearidx::Int
    const branchpath
    stepidx::Int
    repeat_accum::Int
end

AlgoBranch(f::ProcessAlgorithm, linearidx) = AlgoBranch(f, linearidx, branchpath(f, linearidx), 1, 1)
export AlgoBranch, walk!, branchpath

branchpath(a::AlgoBranch) = a.branchpath


repeats(::Any) = 1
repeats(::Any, idx) = 1

function thisnode(a::AlgoBranch)
    if a.stepidx == 1
        return a.f
    end
    enterbranches(a.f, branchpath(a)[1:a.stepidx-1]...)
end

branchidx(a::AlgoBranch) = branchpath(a)[a.stepidx]

function getrepeat(a::AlgoBranch)
    if a.stepidx == length(branchpath(a)) + 1
        return 1
    end
    repeats(thisnode(a), branchidx(a))
end

function walk!(ab::AlgoBranch)
    if ab.stepidx == length(branchpath(ab)) + 1
        return nothing
    end
    node = thisnode(ab)
    ab.stepidx += 1
    return node
end


function algo_num_executions(pa::ProcessAlgorithm, linearidx)
    ab = AlgoBranch(pa, linearidx)
    # println("AlgoBranch: ", ab)
    rpts = getrepeat(ab)
    walk!(ab)
     
    return rpts * _algo_num_executions(ab)
end

function _algo_num_executions(ab::AlgoBranch)
    if !is_decomposable(thisnode(ab))
        return 1
    end
    rpts = getrepeat(ab)
    walk!(ab)
    
    return rpts * _algo_num_executions(ab)
end

"""
Get the number of times an algorithm will be repeated
"""
getrepeats(f::ProcessAlgorithm, linearidx) = algo_num_executions(f, linearidx)

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
this_algo(args) = getalgo(args.ua, algoidx(args))

function next!(ua::UniqueAlgoTracker)
    ua.current += 1
end

currentalgo(ua::UniqueAlgoTracker) = getalgo(ua, ua.current)
current_repeats(ua::UniqueAlgoTracker) = ua.repeats[currentalgo(ua)]
current_counts(ua::UniqueAlgoTracker) = ua.counts[currentalgo(ua)]


iterate(ua::UniqueAlgoTracker, state = 1) = state > length(unique_algorithms(ua)) ? nothing : (next!(ua), state + 1)


function prepare(ua::UniqueAlgoTracker, args)
    for a in unique_algorithms(ua)
        newargs = prepare(a, (;args..., ua))            # Add algo tracker to args
        overlap = intersect(keys(args), keys(newargs))  # Find wether there are overlapping keys between the algorithms
        if !isempty(overlap)
            @warn "Multiple algorithms define the same arguments: $overlap. \n Only one of them will be used with a random order."
        end
        args = (;args..., newargs...)                  # Add the new arguments to the existing ones
        next!(ua)                                      # Move to the next algorithm  
    end
    return deletekeys(args, :ua)
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

