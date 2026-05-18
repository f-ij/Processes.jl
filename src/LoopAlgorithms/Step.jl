"""
Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
    recursive calls
"""

@inline _plan_step_wiring(::Any) = ()
@inline _plan_step_wiring(la::Union{CompositeAlgorithm, Routine}) = getfield(la, :step_wiring)
@inline _plan_step_wiring(la::LoopAlgorithm) = _plan_step_wiring(getplan(la))
@inline _plan_step_wiring(fa::FinalizedAlgorithm) = _plan_step_wiring(inneralgorithm(fa))

@inline _empty_step_routing_type(::Type{StepRouting{Tuple{}, Tuple{}, Tuple{}}}) = true
@inline _empty_step_routing_type(::Type{<:StepRouting}) = false

@inline step!(child::LA, context::C, typestable::S, routing::StepRouting) where {LA<:AbstractLoopAlgorithm, C<:AbstractContext, S} =
    @inline step!(child, context, typestable, routing_childwiring(routing))

# Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm{T, Is}, context::C, typestable::S = Stable()) where {T,Is,C<:AbstractContext, S}
#     this_inc = inc(ca)
#     algos_and_intervals = @inline algo_and_interval_iterator(ca)
#
#     context = @inline unrollreplace(context, algos_and_intervals...) do context, (func, interval)
#         if @inline divides(this_inc, interval)
#             context = @inline step!(func, context, S())
#         end
#         return context
#     end
#     @inline inc!(ca)
#     return context
# end

Base.@constprop :aggressive @inline function step!(ca::CompositeAlgorithm, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    return @inline step!(ca, context, typestable, getfield(ca, :step_wiring))
end

Base.@constprop :aggressive @inline @generated function step!(ca::CompositeAlgorithm{T, Is, W, G, SW}, context::C, typestable::S, step_wiring::StepWiring) where {T, Is, W, G, SW, C<:AbstractContext, S, StepWiring<:Tuple}
    intervals = Is 
    exprs = Any[]
    this_inc = gensym(:this_inc)

    push!(exprs, :($this_inc = @inline inc(ca)))

    for i in 1:length(T.parameters)
        algo_name = gensym(:algo)
        interval = intervals[i]
        routing_type = StepWiring.parameters[i]
        step_expr = _empty_step_routing_type(routing_type) ?
            :(context = @inline step!($algo_name, context, typestable)) :
            :(context = @inline step!($algo_name, context, typestable, getfield(step_wiring, $i)))

        push!(exprs, :(local $algo_name = @inline getalgo(ca, $i)))

        if T.parameters[i] <: ContextInjector
            if interval isa Interval{1}
                push!(exprs, quote
                    if !(@inline context_injector_buffer_isempty(context))
                        $step_expr
                    end
                end)
            else
                push!(exprs, quote
                    if !(@inline context_injector_buffer_isempty(context)) && @inline divides($this_inc, $interval)
                        $step_expr
                    end
                end)
            end
        elseif interval isa Interval{1}
            push!(exprs, step_expr)
        else
            push!(exprs, quote
                if @inline divides($this_inc, $interval)
                    $step_expr
                end
            end)
        end
    end

    push!(exprs, :(@inline inc!(ca)))
    push!(exprs, :(context))

    return Expr(:block, exprs...)
end

"""
Routines unroll their subroutines and execute them in order.
"""
Base.@constprop :aggressive @inline function step!(r::Routine, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    return @inline step!(r, context, typestable, getfield(r, :step_wiring))
end

Base.@constprop :aggressive @inline @generated function step!(r::Routine{T, Repeats, MV, W, G, SW}, context::C, typestable::S, step_wiring::StepWiring) where {T, Repeats, MV, W, G, SW, C<:AbstractContext, S, StepWiring<:Tuple}
    exprs = Any[]
    globals = gensym(:globals)
    process = gensym(:process)
    lifetime = gensym(:lifetime)

    push!(exprs, :($globals = @inline getglobals(context)))
    push!(exprs, :($process = $globals.process))
    push!(exprs, :($lifetime = $globals.lifetime))

    for i in 1:length(T.parameters)
        func = gensym(:func)
        start_idx = gensym(:start_idx)
        this_repeat = Repeats[i]
        routing_type = StepWiring.parameters[i]
        unstable_step = _empty_step_routing_type(routing_type) ?
            :(context = @inline step!($func, context, Unstable())) :
            :(context = @inline step!($func, context, Unstable(), getfield(step_wiring, $i)))
        stable_step = _empty_step_routing_type(routing_type) ?
            :(context = @inline step!($func, context, typestable)) :
            :(context = @inline step!($func, context, typestable, getfield(step_wiring, $i)))

        push!(exprs, quote
            local $func = @inline getalgo(r, $i)
            local $start_idx = @inline get_resume_point(r, $i)
            if $start_idx <= $this_repeat
                $unstable_step
                @inline tick!($process)

                for lidx in ($start_idx + 1):$this_repeat
                    if @inline breakcondition($lifetime, $process, context)
                        @inline set_resume_point!(r, $i, lidx)
                        return context
                    end
                    $stable_step
                    @inline tick!($process)
                end
            end
        end)
    end

    push!(exprs, :context)
    return Expr(:block, exprs...)
end

@inline function resume_step!(a::A, context::C, typestable::S = Stable()) where {A, C<:AbstractContext, S}
    @inline step!(a, context, typestable)
end

@inline function resume_step!(r::Routine, context::C, typestable::S = Stable()) where {C<:AbstractContext, S}
    @inline step!(r, context, typestable)
end
