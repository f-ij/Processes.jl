getmultiplier(cla::LoopAlgorithm, obj) = getmultiplier(get_registry(cla), obj)
getname(cla::LoopAlgorithm, obj) = getname(get_registry(cla), obj)
getoptions(cla::LoopAlgorithm) = getfield(cla, :options)

get_shares(cla::LoopAlgorithm) = filter(x -> x isa Share, getoptions(cla))
get_routes(cla::LoopAlgorithm) = filter(x -> x isa Route, getoptions(cla))  

# function update_names(cla::LoopAlgorithm, newreg::NameSpaceRegistry)
#     updated_reg, _ = update_names(cla.registry, newreg)
#     # @show updated_reg
#     return setfield(cla, :registry, updated_reg)
# end

function match_cla(claT1::Type{<:LoopAlgorithm}, checkobj)
    if !(checkobj <: LoopAlgorithm)
        return false
    end
    return getid(claT1) == getid(checkobj)
end