# function init(pack::PackagedAlgo, context::C) where C <: AbstractContext
#     all_entities = get_processentities(pack)
#     context = @inline unrollreplace(context, all_entities...) do context, entity
#         init(entity, context)
#     end
# end


function init(pack::PackagedAlgo, context::C) where C <: AbstractContext
    all_entities = get_processentities(pack)
    context = @inline unrollreplace(context, all_entities...) do context, entity
        init(entity, context)
    end
    viewed = @inline view(context, pack)
    subcontext = getsubcontext(viewed)
    allfields = (;subcontext...)
    # Filter out to_all
    filtered = @inline filter_nt(allfields, :algo, :lifetime)
    # @show context
    # @show viewed

    context = replace(viewed, (;getkey(pack) => filtered))
    return context
end

"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""
Base.@constprop :aggressive @inline function step!(ca::PackagedAlgo{T, Is}, context::C, typestable::S = Stable()) where {T,Is,C<:AbstractContext, S}
    this_inc = inc(ca)
    algos_and_intervals = @inline algo_and_interval_iterator(ca)
    
    return @inline unrollreplace_withcallback(context, context -> begin
            @inline inc!(ca)
            context
        end , algos_and_intervals... ) do context, (func, interval)

        if @inline divides(this_inc, interval)
            context = @inline step!(func, context, typestable)
        end
        return context
    end
end


function cleanup(pa::PackagedAlgo, context::C) where C <: AbstractContext
    all_algos = @inline getalgos(pa)
    context = unrollreplace(context, all_algos...) do context, algo
        @inline cleanup(algo, context)
    end
    return context
end
