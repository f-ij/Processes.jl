"""
Generated process loop that inlines the step! expression when available.
"""
@inline @generated function generated_processloop(process::AbstractProcess, algo::F, context::C, r::Repeat) where {F, C}
    # step_expr = try
    #     step!_expr(F, C)
    # catch
    #     :(context = @inline step!(algo, context); context)
    # end
    # step_expr = step!_expr(F, C, :algo)
    algo_name = gensym(:algo)
    step_expr = step!_expr(F, C, algo_name)

    return quote
        # println("Running generated process loop for $repeats times from thread $(Threads.threadid())")
        @inline before_while(process)
        start_idx = loopidx(process)
        
        # if @inline resuming(process)
        #     context = @inline resume_step!(algo, context)
        #     start_idx += 1
        # end

        for _ in start_idx:repeats(r)
            if !shouldrun(process)
                break
            end
            $(algo_name) = algo
            $(step_expr)
            @inline inc!(process)
            @inline tick!(process)
        end
        return @inline after_while(process, algo, context)
    end
end



"""
Generated process loop that inlines the step! expression when available.
"""
@generated function generated_processloop(process::AbstractProcess, func::F, context::C, ::Indefinite) where {F, C}
    step_expr = step!_expr(F, C, :func)
    return quote
        # println("Running generated process loop indefinitely from thread $(Threads.threadid())")
        @inline before_while(process)
        # if resuming(process)
        #     context = @inline resume_step!(func, context)
        # end

        while shouldrun(process)
            $(step_expr)
            @inline inc!(process)
            @inline tick!(process)
        end
        return @inline after_while(process, func, context)
    end
end
