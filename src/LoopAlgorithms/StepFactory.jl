"""
Generate a step for composite with runtime wiring information
"""
@inline function generate_composite_steps(ca::CA, context::C, wiring::W, namespace::N)
    # For every child, get a tuple of available subcontexts symbols from the wiring
    # TODO IMPLEMENT similar to routine, but now just with the divides condition for the loop scheduling

end

"""
Generate a step for routine with runtime wiring information
    We drop the whole typestable machinery 

We thus need to be careful to keep the exact names of the standard arguments to be the same,
because these functions will be inlined with those names. We should use _argname with "_" prefixes
to avoid name clashes with subcontext names since now they are all passed as normal arguments.
I.e. all non-generated argument names should be prefixed with "_"
"""
@inline function generate_routine_steps(routine::R, this_plan_wiring::W, namespaces::N) where {R <: Routine, W <: PlanWiring, N}
    @assert isresolved(routine) "Can only generate steps for resolved routines"
    # For a child routine, get a tuple of available subcontexts symbols from the wiring, recursively
    # TODO IMPLEMENT this function
    this_routine_available_subcontexts_from_parent = get_available_subcontext_names.(this_plan_wiring)
    child_wirings = ntuple(i -> getindex(this_plan_wiring, i), numalgos(routine))

    routine_child_part_per_child = Any[]
    for i in 1:numalgos(routine)
        this_child_step_wiring = child_wirings[i]
        available_child_subcontext_names = get_available_subcontext_names(this_child_step_wiring)
        this_child_namespace = getindex(namespaces, i)
        child_available_subcontexts = get_available_subcontexts(this_child_step_wiring[i])

        # Below is the part of the generated routine step that corresponds to child i
        # This is just the for loop body that runs the child step repeatedly
        # But now i this branch we pass the subcontext names that actually can be accessed in this step branch
        # However, the child step itself is not generated here, it is generated separately 
        # Then gotten here as a getfield from the plan that calls this function
        # The reason we need to runtime generate this is because we need to know which arguments need to be passed on to a child step
        push!(routine_child_part_per_child, quote 
            # Wiring should have a getindex method that returns the appropriate wiring for the child algorithm, 
            _this_child_idx = $i
            _this_lifetime = _lifetime[_this_child_idx]
            if _lifetime isa RepeatLifetime
                _this_repeats = repeats(_this_lifetime)
                for _lidx in 1:_this_repeats
                    if @inline routine_breakcondition(_this_lifetime, _lifetime, _process, _context, _lidx)
                        break
                    end
                    # get the pregenerated step for the child algorithm, which should be a _step!-like function 
                    # that takes the normal arguments plus all the available subcontexts for this child step
                    child_step = get_child_step(_routine, _this_child_idx)
    
                    # call the child step with the appropriate arguments, including the available subcontexts for this child
                    return_subcontexts = @inline child_step(_routine, $this_child_step_wiring, $this_child_namespace, _process, _lifetime, $(child_available_subcontexts...))
                end
                # TODO generate a code block where all the available subcontexts passed by the parent that are also returned by the child
                # are overwritten, thus we need the intersection of the child_available_subcontexts and this_routine_available_subcontexts_from_parent
                # to know which subcontexts need to be overwritten 
            else # TODO Branch for other lifetime types like UntilLifetime
            end

         end)
    end
    # TODO generate ::T1, ::T2 ... where {..., T1, T2,...} for the child function type parameters so julia can specialize

    func_signature = quote function _generated_child_routine_step!(_routine:C, _process::P, _lifetime::LT, $(this_available_subcontexts[i]...))
                # Similar function body to the old _step!
                # but now something inserts the argument specific child steps
                # TODO Interpolate the child step code blocks generated above into the appropriate place 

            # Returns a namedtuple of all the names of the subcontexts from the parent
            # These are thuse overwritten by the child steps
            return (; $(this_available_subcontexts_from_parent...))
        end
    end

    # TODO use RUNTIMEGENERATEDFUNCTIONS machinery to generate a function with the above signature and body, and return that as the generated step for this routine
end

# """
# Running a composite algorithm allows for static unrolling and inlining of all sub-algorithms through 
#     recursive calls
# """

# """
# Step each scheduled child of a composite plan with explicit loop runtime.

# The `process` and `lifetime` values are forwarded so nested loop algorithms can
# run without storing those transient values in the context.
# """
# Base.@constprop :aggressive @inline @generated function _step!(ca::CA, context::C, wiring::W, namespace::N, process::P, lifetime::LT, typestable::S = Stable()) where {CA <: CompositeAlgorithm, C <: AbstractContext, W <: PlanWiring, N <: Namespace, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
#     algo_count = numalgos(CA)
#     child_wiring_type = W.parameters[2]
#     interval_values = CA.parameters[2]
#     child_namespace_tuple_type = CA.parameters[3]
#     # Generate the same child-indexed execution as the old unrollreplace path,
#     # but without the closure object on the hot non-generated loop path. The
#     # schedule is known from the plan type, so `divides` specializes away for
#     # interval-1 children.
#     exprs = Any[]
#     sizehint!(exprs, algo_count + 4)
#     push!(exprs, :(local algos = @inline getalgos(ca)))
#     push!(exprs, :(local this_inc = @inline inc(ca)))

#     for i in 1:algo_count
#         interval_value = interval_values[i]
#         child_step_wiring_type = fieldtype(child_wiring_type, i)
#         interval_type = typeof(interval_value)
#         child_namespace_type = fieldtype(child_namespace_tuple_type, i)
#         push!(exprs, quote
#             if @inline divides(this_inc, $interval_type())
#                 local algo = @inline getfield(algos, $i)
#                 local child_step_wiring = $child_step_wiring_type()
#                 local child_namespace = $child_namespace_type()
#                 context = @inline _step!(algo, context, child_step_wiring, child_namespace, process, lifetime, typestable)
#             end
#         end)
#     end

#     push!(exprs, :(@inline inc!(ca)))
#     push!(exprs, :(return context))
#     return Expr(:block, exprs...)
# end

# """Step one lifetime-scheduled child inside a `Routine`."""
# @inline function _subroutine_step!(
#     context::C,
#     func::F,
#     r::R,
#     process::P,
#     lifetime::LT,
#     typestable::S,
#     idx::Int,
#     subroutine_lifetime::SL,
#     child_step_wiring::W,
#     namespace::N,
# ) where {C,F,R<:Routine,P<:AbstractProcess,LT<:Lifetime,S<:Stability,SL<:Lifetime,W,N<:Namespace}
#     resume_point = @inline get_resume_point(r, idx)
#     this_repeat_count = @inline routine_repeat_count(subroutine_lifetime)
#     if resume_point <= this_repeat_count
#         context = @inline _step!(func, context, child_step_wiring, namespace, process, lifetime, typestable)
#         @inline tick!(process)

#         next_idx = resume_point + 1
#         if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, context, resume_point)
#             if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, context, resume_point))
#                 @inline set_resume_point!(r, idx, next_idx)
#             end
#             return context
#         end

#         for lidx in next_idx:this_repeat_count
#             if @inline routine_breakcondition(subroutine_lifetime, lifetime, process, context, lidx)
#                 if !(@inline _routine_local_breakcondition(subroutine_lifetime, process, context, lidx))
#                     @inline set_resume_point!(r, idx, lidx)
#                 end
#                 return context
#             end
#             context = @inline _step!(func, context, child_step_wiring, namespace, process, lifetime, typestable)
#             @inline tick!(process)
#         end
#     end
#     return context
# end

# """
# Step each child routine in sequence with explicit loop runtime.

# Each child is run once at its resume point, then repeated until its declared
# repeat count is reached or the lifetime stops.
# """
# Base.@constprop :aggressive @inline @generated function _step!(r::R, context::C, wiring::W, namespace::N, process::P, lifetime::LT, typestable::S = Stable()) where {R <: Routine, C <: AbstractContext, W <: PlanWiring, N <: Namespace, P <: AbstractProcess, LT <: Lifetime, S <: Stability}
#     algo_count = numalgos(R)
#     child_wiring_type = W.parameters[2]
#     repeat_values = R.parameters[2]
#     child_namespace_tuple_type = R.parameters[3]

#     exprs = Any[]
#     sizehint!(exprs, algo_count + 4)
#     push!(exprs, :(local algos = @inline getalgos(r)))

#     for i in 1:algo_count
#         repeat_value = repeat_values[i]
#         child_step_wiring_type = fieldtype(child_wiring_type, i)
#         child_namespace_type = fieldtype(child_namespace_tuple_type, i)
#         push!(exprs, quote
#             local func = @inline getfield(algos, $i)
#             local child_step_wiring = $child_step_wiring_type()
#             local child_namespace = $child_namespace_type()
#             context = @inline _subroutine_step!(context, func, r, process, lifetime, typestable, $i, $repeat_value, child_step_wiring, child_namespace)
#         end)
#     end

#     push!(exprs, :(return context))
#     return Expr(:block, exprs...)
# end
