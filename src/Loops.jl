
"""
Run a single function in a loop indefinitely
"""
function processloop(@specialize(p), @specialize(func), @specialize(args), ::Indefinite)
    # println("Running indefinitely on thread $(Threads.threadid())")
    set_starttime!(p)
    while run(p) 
        @inline func(args)
        inc!(p) 
        GC.safepoint()
    end
    set_endtime!(p)
end

"""
Run a single function in a loop for a given number of times
"""
function processloop(@specialize(p), @specialize(func), @specialize(args), ::Repeat{repeats}) where repeats
    # println("Running from $(loopidx(p)) to $repeats on thread $(Threads.threadid())")
    set_starttime!(p)
    for _ in loopidx(p):repeats
        if !run(p)
            break
        end
        @inline func(args)
        inc!(p)
        GC.safepoint()
    end
    set_endtime!(p)
end

# @inline function voidfuncmap(@specialize(args), @specialize(funcs), triggers)
#     @inline interval_dispatch(args, funcs[1], triggers[1])
#     @inline voidfuncmap(args, Base.tail(funcs), Base.tail(triggers))
# end

# """
# Execute function on every loop iteration
# """
# @inline function interval_dispatch(args, @specialize(func), trigger::Every)
#     func(args)
# end

# """
# Precomputed trigger based dispatch for a function
# """
# @inline function interval_dispatch(args, @specialize(func), trigger::TriggerList)
#     (;proc) = args
#     if loopidx(p) == next(trigger)
#         func(args)
#         inc!(trigger)
#     end
# end

# """
# Interval based dispatch for a function
# """
# @inline function interval_dispatch(args, @specialize(func), interval::Val{N}) where N

#     (;proc) = args
#     if N == 1
#         func(args)
#     else
#         if loopidx(p) % N == 0
#             func(args)
#         end
#     end
# end

# @inline voidfuncmap(::Nothing, ::Any) = nothing

# @inline function funchead(::Type{Tuple})

# end










