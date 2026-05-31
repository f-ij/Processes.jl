"""
We drop all the stability wiring
"""
function generate_process_algorithm_step(thiswiring::W, namespace::N = Namespace{nothing}()) where {W, N<:Namespace}
    available_subcontexts = get_available_subcontext_names(thiswiring, namespace)
    subcontext_args = Any[Expr(:(::), name, Symbol(:T, i)) for (i, name) in enumerate(available_subcontexts)]
    subcontext_pairs = Any[Expr(:(=), name, name) for name in available_subcontexts]
    
    funcbody = quote
        function (
            _algorithm::A,
            _process::P,
            _lifetime::LT,
            _globals::G,
            _inputs::I,
            $(subcontext_args...)
        ) where {A, P<:AbstractProcess, LT<:Lifetime, G, I<:NamedTuple, $(Symbol.(:T, eachindex(available_subcontexts))...)}
        # Construct the on-demand context that replaces the old view for this child step.
        # We inline thiswiring, which is fully typed and says which variables to get from the subcontexts
        # that are supplied here
        # So that the child in the end only sees EXACTLY the VAIRABLES defined in the wiring
        # basically as close to a normal namedtuple as possible
        # OnDemandContext should have a normal @generated constructor that generates the appropriate getindex methods 
        _available_subcontexts = (; $(subcontext_pairs...))
        _this_wiring = @inline $W()
        _this_namespace = @inline $N()
        _available_locations = @inline on_demand_locations(_available_subcontexts, _this_wiring, _algorithm, _this_namespace)
        _available_variables = @inline on_demand_variables(_available_subcontexts, _available_locations, _inputs, _globals)
        on_demand_context = @inline OnDemandContext(_available_variables, _available_locations, _this_wiring, _inputs, _globals, _algorithm, _this_namespace)
        retval = @inline step!(_algorithm, on_demand_context)
        # Merge the returned values into the appropriate subcontexts using the resolved wiring.
        # Line by line, so for each available subcontext here by name, we have a merge line
        # which is a generated function that uses the wiring to figure out which variables to get from retval to merge
        # back into subcontext1
        # It knows which partition to look since SubContext should have a
        # Name type parameter again SubContext{Name,T}
        # e.g.
        # subcontext1 = merge_by_wiring(subcontext1, retval, $thiswiring)
        # subcontext2 = ... 
        # ...
        return @inline merge_by_wiring(on_demand_context, retval)
        end
    end
    return @RuntimeGeneratedFunction(funcbody.args[end])
end
