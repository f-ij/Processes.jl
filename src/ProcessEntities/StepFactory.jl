"""
We drop all the stability wiring
"""
function generate_process_algorithm_step(thiswiring::W)
    available_subcontexts = get_available_subcontext_names(thiswiring)
    
    funcbody = quote function _step!(algorithm::A, process::P, lifetime::LT, $(available_subcontexts...))
        # TODO Implement a ondemandcontext struct that replaces the old view.
        # We inline thiswiring, which is fully typed and says which variables to get from the subcontexts
        # that are supplied here
        # So that the child in the end only sees EXACTLY the VAIRABLES defined in the wiring
        # basically as close to a normal namedtuple as possible
        # OnDemandContext should have a normal @generated constructor that generates the appropriate getindex methods 
        on_demand_context = OnDemandContext(available_subcontexts, $thiswiring)
        retval = @inline step!(algorithm, on_demand_context)
        # TODO generate a code block that merges the returned VALUES into the appropriate subcontexts
        # Line by line, so for each available subcontext here by name, we have a merge line
        # which is a generated function that uses the wiring to figure out which variables to get from retval to merge
        # back into subcontext1
        # It knows which partition to look since SubContext should have a
        # Name type parameter again SubContext{Name,T}
        # e.g.
        # subcontext1 = merge_by_wiring(subcontext1, retval, $thiswiring)
        # subcontext2 = ... 
        # ...
        return (;available_subcontexts...) # return all of them
    end
end