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