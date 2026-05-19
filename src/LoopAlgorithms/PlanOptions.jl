@inline function _root_loop_options(options::Options) where {Options<:Tuple}
    if isempty(options)
        return ()
    end

    tail = _root_loop_options(Base.tail(options))
    option = getfield(options, 1)
    Option = fieldtype(Options, 1)
    if Option <: Union{LocalPlanOption, Route, Share}
        return tail
    end
    return (option, tail...)
end

@inline function _plan_wiring(options::Options) where {Options<:Tuple}
    if isempty(options)
        return ()
    end

    tail = _plan_wiring(Base.tail(options))
    option = getfield(options, 1)
    Option = fieldtype(Options, 1)
    if Option <: Union{Route, Share}
        return (option, tail...)
    end
    return tail
end

function _local_option_matches_child_type(::Type{Child}, ::Type{Owner}, ::Type{Option}) where {Child, Owner, Option}
    if Option <: Route
        return match(Child, Option.parameters[7])
    end
    if Owner === Any || Owner === DataType || Owner === UnionAll
        return false
    end
    return match(Child, Owner)
end

@generated function _local_option_matches_child(::Val{I}, funcs::Funcs, ::LocalPlanOption{Owner, Option}) where {I, Funcs<:Tuple, Owner, Option}
    I > fieldcount(Funcs) && return :(Val(false))
    _local_option_matches_child_type(fieldtype(Funcs, I), Owner, Option) && return :(Val(true))
    if !(Option <: Route)
        return :(Val(:runtime))
    end
    return :(Val(false))
end

@inline _push_local_option(::Val{true}, idx, funcs, option::LocalPlanOption, tail::Tail) where {Tail<:Tuple} =
    (getfield(option, :option), tail...)

@inline _push_local_option(::Val{false}, idx, funcs, option::LocalPlanOption, tail::Tail) where {Tail<:Tuple} = tail

@inline function _push_local_option(::Val{:runtime}, idx::Val{I}, funcs::Funcs, option::LocalPlanOption, tail::Tail) where {I, Funcs<:Tuple, Tail<:Tuple}
    child = getfield(funcs, I)
    owner = getfield(option, :owner)
    if match(child, owner)
        return (getfield(option, :option), tail...)
    end

    local_option = getfield(option, :option)
    if local_option isa Share
        first_algo = get_firstalgo(local_option)
        second_algo = get_secondalgo(local_option)
        if match(child, first_algo) || match(child, second_algo)
            return (local_option, tail...)
        end
    end
    return tail
end

@inline function _local_options_for_child(idx::Val{I}, funcs::Funcs, options::Options) where {I, Funcs<:Tuple, Options<:Tuple}
    if isempty(options)
        return ()
    end

    tail = _local_options_for_child(idx, funcs, Base.tail(options))
    option = getfield(options, 1)
    return _local_options_for_child(idx, funcs, option, tail)
end

@inline _local_options_for_child(idx, funcs, option::LocalPlanOption, tail::Tail) where {Tail<:Tuple} =
    _push_local_option(_local_option_matches_child(idx, funcs, option), idx, funcs, option, tail)

@inline _local_options_for_child(idx, funcs, option, tail::Tail) where {Tail<:Tuple} = tail

@inline @generated function _local_plan_wiring(funcs::Funcs, options::Options) where {Funcs<:Tuple, Options<:Tuple}
    runtime_checks = Any[]
    for option_idx in 1:fieldcount(Options)
        option_type = fieldtype(Options, option_idx)
        option_type <: LocalPlanOption || continue
        owner = option_type.parameters[1]
        option = option_type.parameters[2]
        assigned = any(i -> _local_option_matches_child_type(fieldtype(Funcs, i), owner, option), 1:fieldcount(Funcs))
        runtime_assigned = !(option <: Route)
        if !assigned
            if runtime_assigned
                push!(runtime_checks, quote
                    local _local_option = getfield(getfield(options, $option_idx), :option)
                    local _assigned = false
                    for _bucket in _wiring
                        _assigned |= any(==(_local_option), _bucket)
                    end
                    _assigned || error("Local plan option $(getfield(options, $option_idx)) could not be assigned to any child in plan funcs $(funcs).")
                end)
                continue
            end
            return :(error("Local plan option $(getfield(options, $option_idx)) could not be assigned to any child in plan funcs $(funcs)."))
        end
    end
    tuple_expr = Expr(:tuple, (:(@inline _local_options_for_child(Val($i), funcs, options)) for i in 1:fieldcount(Funcs))...)
    isempty(runtime_checks) && return tuple_expr
    return quote
        local _wiring = $tuple_expr
        $(runtime_checks...)
        _wiring
    end
end

@inline function _all_plan_wiring(plan_wiring::PlanWiring, local_wiring::LocalWiring) where {PlanWiring<:Tuple, LocalWiring<:Tuple}
    if isempty(local_wiring)
        return plan_wiring
    end
    return (plan_wiring..., getfield(local_wiring, 1)..., _all_plan_wiring((), Base.tail(local_wiring))...)
end
