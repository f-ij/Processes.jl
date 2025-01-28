export processsizehint!, recommendsize

"""
For a proess with a limited lifetime,
give the array a size hint based on the lifetime and the number of updates per step.
"""
@inline function processsizehint!(args, array, updates_per_step = 1)
    p = args.proc
    this_func = getfunc(p)
    startsize = length(array)

    if this_func isa CompositeAlgorithm
        this_interval = get_this_interval(args)
        rpts = ceil(Int,lifetime(p)/this_interval)
        sizehint!(array, startsize + rpts * updates_per_step)
    else 
        rpts = lifetime(p)
        sizehint!(array, startsize + rpts * updates_per_step)
    end
end

@inline function recommendsize(args, updates_per_step = 1) 
    p = args.proc
    this_func = getfunc(p)

    if this_func isa CompositeAlgorithm
        this_interval = get_this_interval(args)
        rpts = ceil(Int,lifetime(p)/this_interval)
        return rpts * updates_per_step
    else 
        rpts = lifetime(p)
        return rpts * updates_per_step
    end
end


"""
Get the allocator directly from the args
"""
getallocator(args) = getallocator(args.proc)


