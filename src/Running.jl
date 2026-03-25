
"""
Indirection for compilation
"""
@inline function spawnloop(p, func::F, context::C, loopdispatch; loopfunction = generated_processloop) where {F, C} 
# function spawnloop(p, func::F, context, loopdispatch; loopfunction = processloop) where F
    Threads.@spawn loopfunction(p, func, context, loopdispatch)
    # Dagger.@spawn loopfunction(p, func, context, loopdispatch)
end

@inline function runloop(p, func::F, context::C, loopdispatch; loopfunction = generated_processloop) where {F, C}
    @inline loopfunction(p, func, context, loopdispatch)
end

# TODO: Directly run a loop?
# @inline function run(f::F, context::C, loopdispatch; loopfunction = generated_processloop) where {F, C}
#     @inline loopfunction(nothing, f, context, loopdispatch)
# end