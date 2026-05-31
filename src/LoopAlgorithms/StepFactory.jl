export get_step, get_child_step

@inline Base.getindex(wiring::PlanWiring, idx::Int) = getfield(child_wiring(wiring), idx)

"""Return `items` with duplicate symbols removed while preserving first-seen order."""
function _unique_symbols(items::Tuple)
    result = Symbol[]
    for item in items
        item isa Symbol || continue
        item in result || push!(result, item)
    end
    return Tuple(result)
end

"""Return source subcontext names needed by one resolved route."""
function _route_source_names(route::R) where {R<:Route}
    source = get_fromname(route)
    source == :_runtime && return ()
    return source isa Symbol ? (source,) : ()
end

"""Return source subcontext names needed by one resolved share."""
function _share_source_names(share::S) where {S<:Share}
    source = contextname(share)
    return source isa Symbol ? (source,) : ()
end

"""Return all subcontext names required by one concrete child wiring bucket."""
function get_available_subcontext_names(wiring::W, namespace::N = Namespace{nothing}()) where {W<:Wiring, N<:Namespace}
    route_sources = mapreduce(_route_source_names, (left, right) -> (left..., right...), routes(wiring); init = ())
    share_sources = mapreduce(_share_source_names, (left, right) -> (left..., right...), shares(wiring); init = ())
    return _unique_symbols((_namespace_names(namespace)..., route_sources..., share_sources...))
end

"""Return all subcontext names required by a child-indexed `PlanWiring`."""
function get_available_subcontext_names(wiring::W, namespaces::N) where {W<:PlanWiring, N<:Tuple}
    child_wirings = child_wiring(wiring)
    names = ()
    for i in eachindex(child_wirings)
        names = (names..., get_available_subcontext_names(getfield(child_wirings, i), getfield(namespaces, i))...)
    end
    return _unique_symbols(names)
end

"""Return all subcontext names required by a concrete child step."""
function get_child_available_subcontext_names(child::A, wiring::W, namespace::N) where {A, W<:Wiring, N<:Namespace}
    return get_available_subcontext_names(wiring, namespace)
end

function get_child_available_subcontext_names(child::LA, wiring::W, namespace::N) where {LA<:AbstractLoopAlgorithm, W<:PlanWiring, N<:Namespace}
    return step_available_names(child)
end

"""Return all subcontext names required by a resolved plan node."""
function get_available_subcontext_names(plan::P, wiring::W, namespaces::N) where {P<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Tuple}
    funcs = getalgos(plan)
    child_wirings = child_wiring(wiring)
    names = ()
    for i in eachindex(child_wirings)
        names = (names..., get_child_available_subcontext_names(getfield(funcs, i), getfield(child_wirings, i), getfield(namespaces, i))...)
    end
    return _unique_symbols(names)
end

"""Clear resolved step functions after unresolved plan edits."""
@inline function clear_steps(plan::P) where {P<:Union{CompositeAlgorithm, Routine}}
    return setfield(plan, :child_steps, ())
end

@inline clear_steps(x) = x

"""Return the typed tuple of resolved child-step functions."""
@inline get_child_steps(plan::Union{CompositeAlgorithm, Routine}) = getfield(plan, :child_steps)
@inline get_child_steps(la::LoopAlgorithm) = get_child_steps(getplan(la))

"""Return one resolved child-step function."""
@inline get_child_step(plan::Union{CompositeAlgorithm, Routine}, idx::Int) = getfield(get_child_steps(plan), idx)
@inline get_child_step(la::LoopAlgorithm, idx::Int) = get_child_step(getplan(la), idx)

"""Return the root step function owned by a resolved loop wrapper."""
@inline function get_step(la::LoopAlgorithm)
    step = getfield(la, :step)
    isnothing(step) && error("Root plan step has not been generated. Resolve the loop algorithm before running it.")
    return step
end

@inline get_step(fa::FinalizedAlgorithm) = get_step(inneralgorithm(fa))

"""Return all subcontext names expected by a resolved plan step."""
@inline step_available_names(plan::Union{CompositeAlgorithm, Routine}) =
    get_available_subcontext_names(plan, getwiring(plan), getfield(plan, :namespaces))
@inline step_available_names(la::LoopAlgorithm) = step_available_names(getplan(la))
@inline step_available_names(fa::FinalizedAlgorithm) = step_available_names(inneralgorithm(fa))

"""Return the root-step subcontext names as a concrete `Val` when the step is typed."""
@inline @generated function step_available_names_val(la::LA) where {LA<:LoopAlgorithm}
    RootStep = LA.parameters[2]
    if RootStep <: RuntimeGeneratedFunction && length(RootStep.parameters) >= 1
        argnames = RootStep.parameters[1]
        subcontext_names = argnames[6:end]
        return :(Val{$subcontext_names}())
    end
    return :(Val(step_available_names(la)))
end

@inline step_available_names_val(fa::FinalizedAlgorithm) = step_available_names_val(inneralgorithm(fa))
@inline step_available_names_val(plan::Union{CompositeAlgorithm, Routine}) = Val(step_available_names(plan))

"""Generate a child step for either a concrete child or a nested plan child."""
function generate_child_step(child::A, thiswiring::W, namespace::N) where {A, W<:Wiring, N<:Namespace}
    return generate_process_algorithm_step(thiswiring, namespace)
end

function generate_child_step(child::LA, thiswiring::W, namespace::N) where {LA<:AbstractLoopAlgorithm, W<:PlanWiring, N<:Namespace}
    return generate_plan_step(child, thiswiring, getfield(child, :namespaces))
end

"""Run every child step factory for a resolved plan."""
function generate_child_steps(plan::P, this_plan_wiring::W, namespaces::N) where {P<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Tuple}
    funcs = getalgos(plan)
    child_wirings = child_wiring(this_plan_wiring)
    return ntuple(i -> generate_child_step(getfield(funcs, i), getfield(child_wirings, i), getfield(namespaces, i)), length(funcs))
end

"""Return the generated function argument expressions for named subcontexts."""
function _subcontext_arg_exprs(names::Tuple)
    return Any[Expr(:(::), name, Symbol(:T, i)) for (i, name) in enumerate(names)]
end

"""Return the `where` type variables for named subcontext arguments."""
function _subcontext_typevars(names::Tuple)
    return Any[Symbol(:T, i) for i in eachindex(names)]
end

"""Return a named-tuple expression from current subcontext argument variables."""
function _subcontexts_tuple_expr(names::Tuple)
    return Expr(:tuple, Expr(:parameters, (Expr(:(=), name, name) for name in names)...))
end

"""Return the generated step result with globals first and subcontexts splatted."""
function _step_return_expr(names::Tuple)
    fields = Any[Expr(:(=), :globals, :_globals)]
    append!(fields, (Expr(:(=), name, name) for name in names))
    return Expr(:tuple, Expr(:parameters, fields...))
end

"""Generate child call expressions for a composite plan step."""
function _composite_child_exprs(funcs::Tuple, parent_names::Tuple, child_wirings::Tuple, namespaces::Tuple)
    exprs = Any[]
    for i in eachindex(child_wirings)
        child_subcontext_names = get_child_available_subcontext_names(getfield(funcs, i), getfield(child_wirings, i), getfield(namespaces, i))
        child_args = Any[child_subcontext_name for child_subcontext_name in child_subcontext_names]
        update_exprs = Any[]
        for child_subcontext_name in child_subcontext_names
            child_subcontext_name in parent_names || continue
            push!(update_exprs, :($child_subcontext_name = @inline getproperty(_returned, $(QuoteNode(child_subcontext_name)))))
        end
        push!(exprs, quote
            _this_interval = @inline interval(_plan, $i)
            if @inline divides(_this_inc, _this_interval)
                _child_algo = @inline getalgo(_plan, $i)
                _child_step = @inline get_child_step(_plan, $i)
                _returned = @inline RuntimeGeneratedFunctions.generated_callfunc(_child_step, _child_algo, _process, _lifetime, _globals, _inputs, $(child_args...))
                _globals = @inline getproperty(_returned, :globals)
                $(update_exprs...)
            end
        end)
    end
    return exprs
end

"""Generate child call expressions for a routine plan step."""
function _routine_child_exprs(funcs::Tuple, parent_names::Tuple, child_wirings::Tuple, namespaces::Tuple, lifetime_values::Tuple)
    exprs = Any[]
    break_context_expr = _subcontexts_tuple_expr(parent_names)
    for i in eachindex(child_wirings)
        child_subcontext_names = get_child_available_subcontext_names(getfield(funcs, i), getfield(child_wirings, i), getfield(namespaces, i))
        child_args = Any[child_subcontext_name for child_subcontext_name in child_subcontext_names]
        update_exprs = Any[]
        for child_subcontext_name in child_subcontext_names
            child_subcontext_name in parent_names || continue
            push!(update_exprs, :($child_subcontext_name = @inline getproperty(_returned, $(QuoteNode(child_subcontext_name)))))
        end
        push!(exprs, quote
            # Wiring should have a getindex method that returns the appropriate wiring for the child algorithm, 
            _this_child_idx = $i
            _this_lifetime = $(lifetime_values[i])
            _this_repeat_count = @inline routine_repeat_count(_this_lifetime)
            _resume_point = @inline get_resume_point(_plan, _this_child_idx)
            if _resume_point <= _this_repeat_count
                for _lidx in _resume_point:_this_repeat_count
                    _break_context = @inline break_context_from_subcontexts($break_context_expr, _inputs)
                    if @inline routine_breakcondition(_this_lifetime, _lifetime, _process, _break_context, _lidx)
                        if !(@inline _routine_local_breakcondition(_this_lifetime, _process, _break_context, _lidx))
                            @inline set_resume_point!(_plan, _this_child_idx, _lidx)
                        end
                        break
                    end
                    # get the pregenerated step for the child algorithm, which should be a _step!-like function 
                    # that takes the normal arguments plus all the available subcontexts for this child step
                    _child_algo = @inline getalgo(_plan, _this_child_idx)
                    _child_step = @inline get_child_step(_plan, _this_child_idx)

                    # call the child step with the appropriate arguments, including the available subcontexts for this child
                    _returned = @inline RuntimeGeneratedFunctions.generated_callfunc(_child_step, _child_algo, _process, _lifetime, _globals, _inputs, $(child_args...))
                    _globals = @inline getproperty(_returned, :globals)
                    $(update_exprs...)
                    @inline tick!(_process)
                end
            end
            @inline set_resume_point!(_plan, _this_child_idx, 1)
        end)
    end
    return exprs
end

"""
Generate a step for composite with runtime wiring information
"""
@inline function generate_composite_steps(ca::CA, this_plan_wiring::W, namespaces::N) where {CA<:CompositeAlgorithm, W<:PlanWiring, N<:Tuple}
    # For every child, get a tuple of available subcontexts symbols from the wiring
    child_steps = generate_child_steps(ca, this_plan_wiring, namespaces)
    return generate_plan_step(ca, this_plan_wiring, namespaces), child_steps
end

"""
Generate a step for routine with runtime wiring information
    We drop the whole typestable machinery 

We thus need to be careful to keep the exact names of the standard arguments to be the same,
because these functions will be inlined with those names. We should use _argname with "_" prefixes
to avoid name clashes with subcontext names since now they are all passed as normal arguments.
I.e. all non-generated argument names should be prefixed with "_"
"""
@inline function generate_routine_steps(routine::R, this_plan_wiring::W, namespaces::N) where {R <: Routine, W <: PlanWiring, N<:Tuple}
    # For a child routine, get a tuple of available subcontexts symbols from the wiring, recursively
    child_steps = generate_child_steps(routine, this_plan_wiring, namespaces)
    return generate_plan_step(routine, this_plan_wiring, namespaces), child_steps
end

"""Generate a plan step function for a composite or routine."""
function generate_plan_step(plan::P, this_plan_wiring::W = getwiring(plan), namespaces::N = getfield(plan, :namespaces)) where {P<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Tuple}
    this_available_subcontexts_from_parent = get_available_subcontext_names(plan, this_plan_wiring, namespaces)
    subcontext_args = _subcontext_arg_exprs(this_available_subcontexts_from_parent)
    subcontext_typevars = _subcontext_typevars(this_available_subcontexts_from_parent)
    step_return_expr = _step_return_expr(this_available_subcontexts_from_parent)
    funcs = getalgos(plan)
    child_wirings = child_wiring(this_plan_wiring)
    if plan isa CompositeAlgorithm
        child_exprs = _composite_child_exprs(funcs, this_available_subcontexts_from_parent, child_wirings, namespaces)
        plan_prelude = Any[:(_this_inc = @inline inc(_plan))]
        plan_epilogue = Any[:(@inline inc!(_plan))]
    elseif plan isa Routine
        child_exprs = _routine_child_exprs(funcs, this_available_subcontexts_from_parent, child_wirings, namespaces, lifetimes(plan))
        plan_prelude = Any[]
        plan_epilogue = Any[]
    end

    funcbody = quote
        function (
            _plan::Plan,
            _process::Proc,
            _lifetime::LT,
            _globals::G,
            _inputs::I,
            $(subcontext_args...)
        ) where {Plan<:$(typeof(plan)), Proc<:AbstractProcess, LT<:Lifetime, G, I<:NamedTuple, $(subcontext_typevars...)}
            $(plan_prelude...)
            $(child_exprs...)
            $(plan_epilogue...)
            return $step_return_expr
        end
    end

    # RuntimeGeneratedFunctions turns the generated signature and body into the resolved plan step.
    return @RuntimeGeneratedFunction(funcbody.args[end])
end

"""Attach resolved child steps to one resolved plan node."""
function attach_steps_to_plan(plan::CA) where {CA<:CompositeAlgorithm}
    _, child_steps = generate_composite_steps(plan, getwiring(plan), getfield(plan, :namespaces))
    return setfield(plan, :child_steps, child_steps)
end

"""Attach resolved child steps to one resolved plan node."""
function attach_steps_to_plan(plan::R) where {R<:Routine}
    _, child_steps = generate_routine_steps(plan, getwiring(plan), getfield(plan, :namespaces))
    return setfield(plan, :child_steps, child_steps)
end

@inline attach_steps_to_plan(x) = x

"""Attach the root generated step to a resolved loop wrapper."""
@inline function attach_root_step(la::LA) where {LA<:LoopAlgorithm}
    return LoopAlgorithm(la; step = generate_plan_step(getplan(la)))
end

@inline attach_root_step(x) = x
