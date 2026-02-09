
"""
Indirection for compilation
"""
# function spawnloop(p, func::F, context::C, loopdispatch; loopfunction = generated_processloop) where {F, C} 
function spawnloop(p, func::F, context, loopdispatch; loopfunction = processloop) where F
    Threads.@spawn loopfunction(p, func, context, loopdispatch)
    # Dagger.@spawn loopfunction(p, func, context, loopdispatch)
end

function runloop(p, func::F, context, loopdispatch; loopfunction = generated_processloop) where F
    @inline loopfunction(p, func, context, loopdispatch)
end