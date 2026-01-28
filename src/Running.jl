# TODO: Add a loopfunction to taskdata?
function spawntask(p, func::F, args, loopdispatch; loopfunction = generated_processloop) where F
# function spawntask(p, func::F, args, loopdispatch; loopfunction = processloop) where F
    Threads.@spawn loopfunction(p, func, args, loopdispatch)
end

function runloop(p, func::F, args, loopdispatch; loopfunction = processloop) where F
    @inline loopfunction(p, func, args, loopdispatch)
end