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
        println("Resizing to ", startsize + rpts * updates_per_step)
        sizehint!(array, startsize + rpts * updates_per_step)
    else 
        rpts = lifetime(p)
        sizehint!(array, startsize + rpts * updates_per_step)
    end
end

export processsizehint!