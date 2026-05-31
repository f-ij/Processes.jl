"""
Generated top-level loop path that inlines `step!_expr`.

This path does not call the resolve-time RuntimeGeneratedFunction steps. The
resolved plan wiring is compile-time data for `step!_expr`, and concrete child
steps build `OnDemandContext` values inside the generated loop body.
"""

"""Return the persistent subcontext names carried by a typed process context."""
function _generated_loop_subcontext_names(::Type{C}) where {C<:ProcessContext}
    return fieldnames(C.parameters[1])
end

"""Return a named-tuple expression from the live subcontext variables."""
function _generated_loop_subcontexts_expr(names::Tuple)
    return _generated_step_subcontexts_expr(names)
end

"""Return assignments that bind each live subcontext variable from `subcontexts`."""
function _generated_loop_subcontext_bindings(names::Tuple)
    return Any[:(local $name = @inline getproperty(subcontexts, $(QuoteNode(name)))) for name in names]
end

"""Return whether one schedule value can use the context-free generated break path."""
@inline _generated_loop_simple_lifetime_supported(::Type{T}) where {T} =
    T <: Union{Repeat, Indefinite}
@inline _generated_loop_simple_lifetime_supported(value) =
    value isa Union{Repeat, Indefinite}

"""Return whether a plan tree only contains generated-loop-supported lifetimes."""
function _generated_loop_plan_supported(::Type{T}) where {T}
    return true
end

function _generated_loop_plan_supported(::Type{LA}) where {Plan, LA<:LoopAlgorithm{Plan}}
    return _generated_loop_plan_supported(Plan)
end

function _generated_loop_plan_supported(::Type{FA}) where {LA, FA<:FinalizedAlgorithm{LA}}
    return _generated_loop_plan_supported(LA)
end

function _generated_loop_plan_supported(::Type{CA}) where {CA<:CompositeAlgorithm}
    for child_type in tuple(algotypes(CA)...)
        child_type <: AbstractLoopAlgorithm || continue
        _generated_loop_plan_supported(child_type) || return false
    end
    return true
end

function _generated_loop_plan_supported(::Type{R}) where {R<:Routine}
    for lifetime_value in lifetimes(R)
        _generated_loop_simple_lifetime_supported(lifetime_value) || return false
    end
    for child_type in tuple(algotypes(R)...)
        child_type <: AbstractLoopAlgorithm || continue
        _generated_loop_plan_supported(child_type) || return false
    end
    return true
end

"""Generate the common setup used by repeat and indefinite generated loops."""
function _generated_loop_setup(::Type{F}, ::Type{C}) where {F<:AbstractLoopAlgorithm, C<:ProcessContext}
    top_names = _generated_loop_subcontext_names(C)
    bindings = _generated_loop_subcontext_bindings(top_names)
    state = GeneratedStepState(top_names, :runtime_globals, :runtime_inputs, :process, :lifetime)
    return top_names, bindings, state
end

"""Generated process loop for repeat lifetimes using block-expanded plan steps."""
@inline @generated function loop(
    process::P,
    algo::F,
    context::C,
    lifetime::RL,
    inputs::I,
    resume::Resuming{isresuming},
    ::Generated,
) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C<:ProcessContext, RL<:Repeat, I<:NamedTuple, isresuming}
    if !_generated_loop_plan_supported(F)
        return quote
            return @inline loop(process, algo, context, lifetime, inputs, resume, RuntimeGenerated())
        end
    end
    top_names, bindings, state = _generated_loop_setup(F, C)
    plan_body = step!_expr(F, C, :algo, nothing, nothing, state)
    subcontexts_expr = _generated_loop_subcontexts_expr(top_names)

    resume_expr = isresuming ? :(@atomic process.paused = false) : :(nothing)
    return quote
        @assert isresolved(algo) "Algo must be resolved before running the loop. Got algo $(algo) which is not resolved."
        @inline before_while(process)
        stored_context = context
        initial_context = @inline _merge_runtime_inputs(context, inputs)
        runtime_inputs = @inline getruntimeinput(initial_context)
        initial_globals = @inline getglobals(initial_context)
        runtime_globals = @inline deletekeys(initial_globals, :algo, :lifetime, :process)
        subcontexts = @inline get_subcontexts(initial_context)
        $(bindings...)
        $resume_expr

        start_idx = @inline loopidx(process)
        end_idx = @inline repeats(lifetime)
        for _ in start_idx:end_idx
            $plan_body
            @inline tick!(process)
            @inline inc!(process)
            if @inline breakcondition(lifetime, process, nothing)
                break
            end
        end

        final_globals = @inline merge(initial_globals, runtime_globals)
        final_context = @inline withruntime_if_changed(initial_context, final_globals)
        newcontext = @inline withsubcontexts(final_context, $subcontexts_expr)
        return @inline after_while(process, algo, newcontext, stored_context)
    end
end

"""Generated process loop for indefinite lifetimes using block-expanded plan steps."""
@inline @generated function loop(
    process::P,
    algo::F,
    context::C,
    lifetime::LT,
    inputs::I,
    resume::Resuming{isresuming},
    ::Generated,
) where {P<:AbstractProcess, F<:AbstractLoopAlgorithm, C<:ProcessContext, LT<:Indefinite, I<:NamedTuple, isresuming}
    if !_generated_loop_plan_supported(F)
        return quote
            return @inline loop(process, algo, context, lifetime, inputs, resume, RuntimeGenerated())
        end
    end
    top_names, bindings, state = _generated_loop_setup(F, C)
    plan_body = step!_expr(F, C, :algo, nothing, nothing, state)
    subcontexts_expr = _generated_loop_subcontexts_expr(top_names)

    resume_expr = isresuming ? :(@atomic process.paused = false) : :(nothing)
    return quote
        @inline before_while(process)
        stored_context = context
        initial_context = @inline _merge_runtime_inputs(context, inputs)
        runtime_inputs = @inline getruntimeinput(initial_context)
        initial_globals = @inline getglobals(initial_context)
        runtime_globals = @inline deletekeys(initial_globals, :algo, :lifetime, :process)
        subcontexts = @inline get_subcontexts(initial_context)
        $(bindings...)
        $resume_expr

        while true
            $plan_body
            @inline tick!(process)
            @inline inc!(process)
            if @inline breakcondition(lifetime, process, nothing)
                break
            end
        end

        final_globals = @inline merge(initial_globals, runtime_globals)
        final_context = @inline withruntime_if_changed(initial_context, final_globals)
        newcontext = @inline withsubcontexts(final_context, $subcontexts_expr)
        return @inline after_while(process, algo, newcontext, stored_context)
    end
end
