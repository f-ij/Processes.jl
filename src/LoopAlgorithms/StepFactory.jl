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

"""Run every child step factory for a resolved plan."""
function generate_child_steps(plan::P, this_plan_wiring::W, namespaces::N) where {P<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Tuple}
    funcs = getalgos(plan)
    child_wirings = child_wiring(this_plan_wiring)
    return ntuple(length(funcs)) do i
        child = getfield(funcs, i)
        child_wiring = getfield(child_wirings, i)
        namespace = getfield(namespaces, i)

        # Resolve-time step factory choice. Plan children use their own stored
        # generated step; process children compile wiring and namespace into a
        # direct view/step/merge boundary.
        if child isa FuncWrapper
            generate_funcwrapper_context_step(child, child_wiring, namespace)
        elseif child isa AbstractLoopAlgorithm
            generate_plan_context_step(child, child_wiring, getfield(child, :namespaces))
        elseif child isa ProcessAlgorithm
            generate_process_algorithm_context_step(child, child_wiring, namespace)
        else
            error("Cannot generate a child step for $(typeof(child)). Expected a plan child or ProcessAlgorithm.")
        end
    end
end

"""Generate context-threaded child call expressions for a composite plan step."""
function _composite_context_child_exprs(child_wirings::Tuple)
    exprs = Any[]
    for i in eachindex(child_wirings)
        push!(exprs, quote
                _this_interval = @inline interval(_plan, $i)
                if @inline divides(_this_inc, _this_interval)
                    _child_algo = @inline getalgo(_plan, $i)
                    _child_step = @inline getfield((@inline get_child_steps(_plan)), $i)
                    _context = @inline _child_step(_child_algo, _context, _process, _lifetime)
                end
            end)
    end
    return exprs
end

"""Generate context-threaded child call expressions for a routine plan step."""
function _routine_context_child_exprs(child_wirings::Tuple, lifetime_values::Tuple)
    exprs = Any[]
    for i in eachindex(child_wirings)
        push!(exprs, quote
            _this_child_idx = $i
            _this_lifetime = $(lifetime_values[i])
            _this_repeat_count = @inline routine_repeat_count(_this_lifetime)
            _resume_point = @inline get_resume_point(_plan, _this_child_idx)
            if _resume_point <= _this_repeat_count
                for _lidx in _resume_point:_this_repeat_count
                    if @inline routine_breakcondition(_this_lifetime, _lifetime, _process, _context, _lidx)
                        if !(@inline _routine_local_breakcondition(_this_lifetime, _process, _context, _lidx))
                            @inline set_resume_point!(_plan, _this_child_idx, _lidx)
                        end
                        break
                    end
                    _child_algo = @inline getalgo(_plan, _this_child_idx)
                    _child_step = @inline getfield((@inline get_child_steps(_plan)), _this_child_idx)
                    _context = @inline _child_step(_child_algo, _context, _process, _lifetime)
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
    # Resolve one pregenerated step function for every child.
    child_steps = generate_child_steps(ca, this_plan_wiring, namespaces)
    return nothing, child_steps
end

"""
Generate a step for routine with runtime wiring information
"""
@inline function generate_routine_steps(routine::R, this_plan_wiring::W, namespaces::N) where {R <: Routine, W <: PlanWiring, N<:Tuple}
    # Resolve one pregenerated step function for every child, recursively.
    child_steps = generate_child_steps(routine, this_plan_wiring, namespaces)
    return nothing, child_steps
end

"""Generate a context-threaded plan step with wiring and namespaces embedded."""
function generate_plan_context_step(plan::P, this_plan_wiring::W = getwiring(plan), namespaces::N = getfield(plan, :namespaces)) where {P<:Union{CompositeAlgorithm, Routine}, W<:PlanWiring, N<:Tuple}
    child_wirings = child_wiring(this_plan_wiring)
    if plan isa CompositeAlgorithm
        child_exprs = _composite_context_child_exprs(child_wirings)
        plan_prelude = Any[:(_this_inc = @inline inc(_plan))]
        plan_epilogue = Any[:(@inline inc!(_plan))]
    elseif plan isa Routine
        child_exprs = _routine_context_child_exprs(child_wirings, lifetimes(plan))
        plan_prelude = Any[]
        plan_epilogue = Any[]
    end

    funcbody = quote
        function (
            _plan::P,
            _context::C,
            _process::Proc,
            _lifetime::LT,
        ) where {P, C, Proc, LT}
            $(Expr(:meta, :inline))
            $(plan_prelude...)
            $(child_exprs...)
            $(plan_epilogue...)
            return _context
        end
    end

    return @RuntimeGeneratedFunction(funcbody.args[end])
end

"""Generate the root context-threaded step owned by a resolved loop algorithm."""
function generate_root_context_step(la::LA) where {LA<:LoopAlgorithm}
    plan = getplan(la)
    child_wirings = child_wiring(getwiring(plan))
    if plan isa CompositeAlgorithm
        child_exprs = _composite_context_child_exprs(child_wirings)
        plan_prelude = Any[:(_this_inc = @inline inc(_plan))]
        plan_epilogue = Any[:(@inline inc!(_plan))]
    elseif plan isa Routine
        child_exprs = _routine_context_child_exprs(child_wirings, lifetimes(plan))
        plan_prelude = Any[]
        plan_epilogue = Any[]
    end

    funcbody = quote
        function (
            _algo::A,
            _context::C,
            _process::Proc,
            _lifetime::LT,
        ) where {A, C, Proc, LT}
            $(Expr(:meta, :inline))
            _plan = @inline getplan(_algo)
            $(plan_prelude...)
            $(child_exprs...)
            $(plan_epilogue...)
            return _context
        end
    end

    return @RuntimeGeneratedFunction(funcbody.args[end])
end

"""Generate a context-threaded concrete child step with wiring and namespace embedded."""
function generate_process_algorithm_context_step(child::A, thiswiring::W, namespace::N = Namespace{nothing}()) where {A<:ProcessAlgorithm, W<:Wiring, N<:Namespace}
    funcbody = quote
        function (
            _algorithm::A,
            _context::C,
            _process::Proc,
            _lifetime::LT,
        ) where {A, C, Proc, LT}
            $(Expr(:meta, :inline))
            # Keep the generated child boundary explicit: view, public step!,
            # then merge. Do not call the normal _step! wrapper from here.
            _this_wiring = @inline $W()
            _this_namespace = @inline $N()
            _context_view = @inline view(
                _context,
                _algorithm,
                _this_namespace;
                sharedcontexts = (@inline shares(_this_wiring)),
                sharedvars = (@inline routes(_this_wiring)),
            )
            _retval = @inline step!(_algorithm, _context_view)
            return @inline merge(_context_view, _retval)
        end
    end

    return @RuntimeGeneratedFunction(funcbody.args[end])
end

"""Generate a context-threaded function-wrapper child step with wiring and namespace embedded."""
function generate_funcwrapper_context_step(child::FW, thiswiring::W, namespace::N = Namespace{nothing}()) where {FW<:FuncWrapper, W<:Wiring, N<:Namespace}
    funcbody = quote
        function (
            _algorithm::A,
            _context::C,
            _process::Proc,
            _lifetime::LT,
        ) where {A, C, Proc, LT}
            $(Expr(:meta, :inline))
            # FuncWrapper returns unresolved DSL outputs through runtime state,
            # so it needs its own generated merge boundary.
            _this_wiring = @inline $W()
            _this_namespace = @inline $N()
            _context_view = @inline view(
                _context,
                _algorithm,
                _this_namespace;
                sharedcontexts = (@inline shares(_this_wiring)),
                sharedvars = (@inline routes(_this_wiring)),
            )
            _retval = @inline step!(_algorithm, _context_view)
            return @inline merge_funcwrapper_return(_context_view, _context, _retval, Stable())
        end
    end

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
    return LoopAlgorithm(la; step = generate_root_context_step(la))
end

@inline attach_root_step(x) = x
