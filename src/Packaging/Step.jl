function init(pack::PackagedAlgo, context)
    all_algos = getalgos(pack)
    # contextview = view(context, pack, inject = (;))
    context = unrollreplace(context, all_algos...) do context, algo
        init(algo, context)
    end
end

"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(pa::PackagedAlgo{T, Is}, context::C) where {T,Is,C<:AbstractContext}
    algoidx = 1
    this_inc = inc(pa)
    allfuncs = getalgos(pa)
    return @inline _comp_dispatch(pa, context::C, algoidx, this_inc, gethead(allfuncs), gettail(allfuncs))
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
Base.@constprop :aggressive @inline function _comp_dispatch(pa::PackagedAlgo{T,Is}, context::C, algoidx::Int, this_inc::Int, thisfunc::TF, funcs) where {T, Is, TF,C<:AbstractContext}
    if isnothing(thisfunc)
        inc!(pa)
        # GC.safepoint()
        return context
    end
    if interval(pa, algoidx) == 1
        context = step!(thisfunc, context)
    else
        if this_inc % interval(pa, algoidx) == 0
            context = step!(thisfunc, context)
        end
    end
    return @inline _comp_dispatch(pa, context, algoidx + 1, this_inc, gethead(funcs), gettail(funcs))
end

function cleanup(pa::PackagedAlgo, context::AbstractContext)
    all_algos = getalgos(pa)
    context = unrollreplace(context, all_algos...) do context, algo
        @inline cleanup(algo, context)
    end
    return context
end